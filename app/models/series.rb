class Series < ActiveRecord::Base
  include SeriesArithmetic
  include SeriesAggregation
  include SeriesComparison
  include SeriesSeasonalAdjustment
  include SeriesSharing
  include SeriesDataAdjustment
  include SeriesInterpolation
  include SeriesExternalRelationship
  include SeriesRelationship
  include SeriesSpecCreation
  
  serialize :data, Hash
  serialize :factors, Hash
  
  has_many :data_points
  has_many :data_sources
  
  def as_json(options = {})
    {
      data: self.data,
      frequency: self.frequency,
      units: self.units,
      description: AremosSeries.get(self.name).description,
      source: self.original_url
    }
  end
  
  def last_observation
    return nil if data.nil?
    return data.keys.sort[-1]
  end
  
  def Series.handle_buckets(series_array, handle_hash)
    series_array_buckets = {}
    series_array.each do |s|
      handle = handle_hash[s.id]
      #next if handle.nil?
      series_array_buckets[handle] ||= []
      series_array_buckets[handle].push(s)
    end
    return series_array_buckets
  end
  
  #takes about 8 seconds to run for month, but not bad
  #chart both last updated and last observed (rebucket?)
  def Series.last_observation_buckets(frequency)
    obs_buckets = {}
    mod_buckets = {}
    results = Series.where(:frequency => frequency).select("data, updated_at")
    results.each do |s|
      last_date = s.last_observation.nil? ? "no data" : s.last_observation[0..6]
      last_update = s.updated_at.nil? ? "never" : s.updated_at.to_date.to_s[0..6] #.last_updated.nil?
      obs_buckets[last_date] ||= 0
      obs_buckets[last_date] += 1
      mod_buckets[last_update] ||= 0
      mod_buckets[last_update] += 1      
    end
    {:last_observations => obs_buckets, :last_modifications => mod_buckets}
  end
  
  def Series.all_names
    all_names_array = []
    all_names = Series.select(:name).all
    all_names.each {|s| all_names_array.push(s.name)}
    all_names_array
  end
  
  def Series.region_hash
    region_hash = {}
    all_names = Series.all_names
    all_names.each do |name|
      next if name.nil?
      suffix = name.split("@")[1]
      region = suffix.nil? ? "" : suffix.split(".")[0]
      region_hash[region] ||= []
      region_hash[region].push(name)
    end
    region_hash
  end
  
  def Series.frequency_hash
    frequency_hash = {}
    all_names = Series.select("name, frequency")
    all_names.each do |s|
      frequency_hash[s.frequency] ||= []
      frequency_hash[s.frequency].push(s.name)
    end
    frequency_hash
  end
  
  def Series.frequency_counts
    frequency_counts = Series.frequency_hash
    frequency_counts.each {|key,value| frequency_counts[key] = value.count}
    frequency_counts
  end
  
  def Series.region_counts
    region_counts = Series.region_hash
    region_counts.each {|key,value| region_counts[key] = value.count}
    region_counts
  end
  
  
  def Series.code_from_frequency(frequency)
    return 'A' if frequency == :year || frequency == "year" || frequency == :annual || frequency == "annual" || frequency == "annually"
    return 'Q' if frequency == :quarter || frequency == "quarter" || frequency == "quarterly"
    return 'M' if frequency == :month || frequency == "month" || frequency == "monthly"
    return 'S' if frequency == :semi || frequency == "semi" || frequency == "semi-annually"
    return 'W' if frequency == :week || frequency == "week" || frequency == "weekly"
    return 'D' if frequency == :day || frequency == "day" || frequency == "daily"
    
    return ""
  end
  
  #There are duplicates of these in other file... non series version 
  def Series.frequency_from_code(code)
    return :year if code == 'A' || code =="a"
    return :quarter if code == 'Q' || code =="q"
    return :month if code == 'M' || code == "m"
    return :semi if code == 'S' || code == "s"
    return :week if code == 'W' || code == "w"
    return :day if code == 'D' || code == "d"
    return nil
  end
  
  def Series.each_spreadsheet_header(update_spreadsheet_path, sheet_to_load = nil, sa = false)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    return {:message => "The spreadsheet could not be found", :headers => []} if update_spreadsheet.load_error?

    default_sheet = sa ? "sadata" : update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? default_sheet : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    return {:message=>"The spreadsheet was not formatted properly", :headers=>[]} unless update_spreadsheet.update_formatted?

    header_names = Array.new    
     
    update_spreadsheet_headers = sa ? update_spreadsheet.headers.keys : update_spreadsheet.headers_with_frequency_code 
    update_spreadsheet_headers.each do |series_name|
      header_names.push(yield series_name, update_spreadsheet)
    end
    
    sheets = update_spreadsheet.class == UpdateCSV ? [] : update_spreadsheet.sheets
    return {:message=>"success", :headers=>header_names, :sheets => sheets}
  end
  
  def Series.load_all_sa_series_from(update_spreadsheet_path, sheet_to_load = nil)  
    each_spreadsheet_header(update_spreadsheet_path, sheet_to_load, true) do |series_name, update_spreadsheet|
      frequency_code = code_from_frequency update_spreadsheet.frequency  
      sa_base_name = series_name.sub("NS@","@")
      sa_series_name = sa_base_name+"."+frequency_code
      Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil? 
      Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil?
      #sa_series_name.ts.update_attributes(:seasonally_adjusted => true, :last_demetra_datestring => update_spreadsheet.dates.keys.sort.last)
      
      sa_series_name
    end
  end

  def Series.load_all_mean_corrected_sa_series_from(update_spreadsheet_path, sheet_to_load = nil)  
    each_spreadsheet_header(update_spreadsheet_path, sheet_to_load, true) do |series_name, update_spreadsheet|
      frequency_code = code_from_frequency update_spreadsheet.frequency  
      sa_base_name = series_name.sub("NS@","@")
      sa_series_name = sa_base_name+"."+frequency_code
      ns_series_name = series_name+"."+frequency_code
      
      demetra_series = new_transformation("demetra series", update_spreadsheet.series(series_name), frequency_code)
      
      Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => demetra_series.data), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil? 
      Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => demetra_series.data), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil?

      unless ns_series_name.ts.nil?
        mean_corrected_demetra_series = demetra_series / demetra_series.annual_sum * ns_series_name.ts.annual_sum 
        Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => mean_corrected_demetra_series.data), "mean corrected against #{ns_series_name} and loaded from #{update_spreadsheet_path}", %Q^"#{sa_series_name}".tsn.load_mean_corrected_sa_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil? 
        Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => mean_corrected_demetra_series.data), "mean corrected against #{ns_series_name} and loaded from #{update_spreadsheet_path}", %Q^"#{sa_series_name}".tsn.load_mean_corrected_sa_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil?
      end
      # sa_series_name.ts_eval=(%Q^"#{sa_series_name}".tsn.load_mean_corrected_sa_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil? 
      # sa_series_name.ts_eval=(%Q^"#{sa_series_name}".tsn.load_mean_corrected_sa_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil? 
      #Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}"^)
      #sa_series_name.ts.update_attributes(:seasonally_adjusted => true, :last_demetra_datestring => update_spreadsheet.dates.keys.sort.last)
      sa_series_name
      
      
            
      
      # demetra_series.frequency = update_spreadsheet.frequency
      # self.frequency = update_spreadsheet.frequency
      # mean_corrected_demetra_series = demetra_series / demetra_series.annual_sum * ns_name.ts.annual_sum
      # new_transformation("mean corrected against #{ns_name} and loaded from #{update_spreadsheet_path}", mean_corrected_demetra_series.data)
      
      
    end
  end
  
  def Series.load_all_series_from(update_spreadsheet_path, sheet_to_load = nil)
    each_spreadsheet_header(update_spreadsheet_path, sheet_to_load, false) do |series_name, update_spreadsheet|
      Series.store(series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{series_name}".tsn.load_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil?
      Series.store(series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{series_name}".tsn.load_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil?      
      series_name
    end
  end
  
  def Series.get(series_name)  
    headerparts = series_name.split(".")
    if (headerparts.count == 2)
      name_match = Series.first :conditions => {:name=>series_name} #exact name_match
      return name_match #unless name_match.nil?
      #return Series.first :conditions => {:name=>headerparts[0], :frequency=>frequency_from_code(headerparts[1])} #same base name and correct frequency
    else
      raise SeriesNameException
    end    
  end
  
  def Series.get_or_new(series_name)
    series_to_store = Series.get series_name
    series_to_store = Series.new(:name => series_name) if series_to_store.nil?
    return series_to_store
  end

  def Series.store(series_name, series, desc=nil, eval_statement=nil)
    puts series.frequency
    desc = series.name if desc.nil?
    desc = "Source Series Name is blank" if desc.nil? or desc == ""
    series_to_set = Series.get_or_new series_name
    series_to_set.update_attributes(
      :frequency => series.frequency
#      :units => series.units, #this units issue is overwriting the calculated units. Don't think any
#       situation would require units to be transferred BT 2012-01-19
#      :last_updated => Time.now
    )
    source = series_name.ts.save_source(desc, eval_statement, series.data)
    source
  end

  def Series.eval(series_name, eval_statement)
    t = Time.now
    new_series = Kernel::eval eval_statement
    source = Series.store series_name, new_series, new_series.name, eval_statement
    source.update_attributes(:runtime => (Time.now - t))
    puts "#{"%.2f" % (Time.now - t)} | #{source.data.count} | #{series_name} | #{eval_statement}" 
  # rescue Exception 
  #     puts "ERROR | #{series_name} | #{eval_statement}"
  end
  
  def save_source(source_desc, source_eval_statement, data, last_run = Time.now)
    source = nil
    # ss_time = Time.now          #timer
    # data_count = data.count     #timer
    data_sources.each do |ds|
      if !source_eval_statement.nil? and !ds.eval.nil? and source_eval_statement.strip == ds.eval.strip
        ds.update_attributes(:data => data, :last_run => Time.now) 
        source = ds 
      end
    end
       
    if source.nil?
      data_sources.create(
        :description => source_desc, 
        :eval => source_eval_statement, 
        :data => data,
        :last_run => last_run
      )
    
      source = data_sources_by_last_run[-1]
      source.setup
    end

    update_data(data, source)
    source
    #puts "#{"%.2f" % (Time.now - ss_time)} : #{data.count} : #{self.name} : #{data_count} original data points SAVING SOURCE #{source_eval_statement}\n"
  end
  
  #probably going to want tests

  def update_data(data, source)
    #removing nil dates because they incur a cost but no benefit.
    #have to do this here because there are some direct calls to update data that could include nils
    #instead of calling in save_source
    data.delete_if {|key,value| value.nil?}
    
    observation_dates = data.keys
    
    #cdp_time = Time.now         #timer
    current_data_points.each do |dp|
      dp.upd(data[dp.date_string], source)
      observation_dates.delete dp.date_string
    end
    #puts "#{"%.2f" % (Time.now - cdp_time)} : #{current_data_points.count} : #{self.name} : UPDATING CURRENT DATAPOINTS"

    #od_time = Time.now             #timer
    observation_dates.each do |date_string|
      data_points.create(
        :date_string => date_string,
        :value => data[date_string],
        :current => true,
        :data_source_id => source.id
      )
    end
    #puts "#{"%.2f" % (Time.now - od_time)} : #{observation_dates.count} : #{self.name} : CREATING MISSING OBSERVATION DATES"
    
    #mh_time = Time.now
    #skip this... should just use the update time information in datapoints
    #source.mark_history
    #puts "#{"%.2f" % (Time.now - mh_time)} : #{data_points.count} : #{self.name} : MARKING HISTORY FOR SERIES (ALL DATA POINTS)"
    
    update_data_hash
    aremos_comparison
  end
  
  def update_data_hash
    data_hash = {}
    # I have no idea why, but data_points
    # requires the sort to get anything to happen
    # both data_points and data_points.sort evaluate
    # to arrays with the same count, but for some reason
    # They're not being created. Definitely an issue

    #dh_time = Time.now            #timer
    data_points.each do |dp|
      #puts "#{dp.date_string}: #{dp.value} (#{dp.current})"
      data_hash[dp.date_string] = dp.value if dp.current
    end
    #puts "#{"%.2f" % (Time.now - dh_time)} : #{data_points.count} : #{self.name} : UPDATING DATA HASH FROM (ALL DATA POINTS)"
    self.data = data_hash
    
    #s_time = Time.now
    self.save
    #puts "#{"%.2f" % (Time.now - s_time)} : #{data_hash.count} : #{self.name} : SAVING SERIES"    
  end
  
  def Series.new_transformation(name, data, frequency)
    Series.new(
      :name => name,
      :frequency => frequency,
      :data => data
    )
  end
  
  def new_transformation(name, data)
    frequency = (self.frequency.nil? and name.split(".").count == 2 and name.split("@") == 2 and name.split(".")[1].length == 1) ? Series.frequency_from_code(name[-1]) : self.frequency
    #puts "NEW TRANFORMATION: #{name} - frequency: #{frequency}"  
    Series.new(
      :name => name,
      :frequency => frequency,
      :data => data
    )
  end
  
  #need to spec out tests for this
  #this would benefit from some caching scheme
  def load_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    raise SeriesReloadException if update_spreadsheet.load_error?

    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? default_sheet : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    raise SeriesReloadException unless update_spreadsheet.update_formatted?
    
    self.frequency = update_spreadsheet.frequency
    new_transformation(update_spreadsheet_path, update_spreadsheet.series(self.name))
  end
    
  
  def load_sa_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    raise SeriesReloadException if update_spreadsheet.load_error?

    ns_name = self.name.sub("@", "NS@")
#    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? "sadata" : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    raise SeriesReloadException unless update_spreadsheet.update_formatted?
    self.frequency = update_spreadsheet.frequency 
    new_transformation(update_spreadsheet_path, update_spreadsheet.series(ns_name))
  end
    
  def load_mean_corrected_sa_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    raise SeriesReloadException if update_spreadsheet.load_error?

    ns_name = self.name.sub("@", "NS@")
    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? "sadata" : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    raise SeriesReloadException unless update_spreadsheet.update_formatted?
    demetra_series = new_transformation("demetra series", update_spreadsheet.series(ns_name))
    demetra_series.frequency = update_spreadsheet.frequency.to_s
    self.frequency = update_spreadsheet.frequency
    mean_corrected_demetra_series = demetra_series / demetra_series.annual_sum * ns_name.ts.annual_sum
    new_transformation("mean corrected against #{ns_name} and loaded from #{update_spreadsheet_path}", mean_corrected_demetra_series.data)
  end
  
  #if smart update or other process sets a global cache object for a session, use that. Otherwise
  #download fresh
  def Series.load_from_download(handle, options, cached_files = nil)
    # @@cached_files ||= nil #is this ok? will it break others?
    # cached_files = @@cached_files if cached_files.nil? and !@@cached_files.nil?
    Rails.cache.write("last_row", options[:row], :time_to_live => 600.seconds)
    cached_files = Series.get_cached_files if cached_files.nil?
    dp = DownloadProcessor.new(handle, options, cached_files)
    series_data = dp.get_data
    Series.write_cached_files cached_files
    #puts dp.end_conditions
    #puts options[:frequency]
    #puts "hi!"
    #puts Series.frequency_from_code(options[:frequency])
    Series.new_transformation("loaded from download #{handle} with options:#{options}", series_data, Series.frequency_from_code(options[:frequency]))
  end
  
  #the other problem with these "SERIES" style transformations is that they overwrite the units calculations. Can also build that into the 
  #series definition as necessary
  
  def Series.load_from_file(file, options, cached_files = nil)
    cached_files = Series.get_cached_files if cached_files.nil?
    dp = DownloadProcessor.new("manual", options.merge({ :path => file }), cached_files)
    series_data = dp.get_data
    Series.write_cached_files cached_files
    Series.new_transformation("loaded from file #{file} with options:#{options}", series_data, Series.frequency_from_code(options[:frequency]))
  end
  
  def load_from_pattern_id(id)
    new_transformation("loaded from pattern id #{id}", {})
  end
  
  def load_from_download(handle, options, cached_files = nil)
    cached_files = Series.get_cached_files if cached_files.nil?
    dp = DownloadProcessor.new(handle, options, cached_files)
    series_data = dp.get_data
    Series.write_cached_files cached_files
    new_transformation("loaded from download #{handle} with options:#{options}", series_data)
  end
  
  def Series.load_from_bls(code, frequency)
    series_data = DataHtmlParser.new.get_bls_series(code,frequency)
    Series.new_transformation("loaded series code: #{code} from bls website", series_data, Series.frequency_from_code(frequency))
  end
  
  def load_from_bls(code, frequency = nil)
    series_data = DataHtmlParser.new.get_bls_series(code,frequency)
    new_transformation("loaded series code: #{code} from bls website", series_data)
  end
  
  #it seems like these should need frequencies...
  def load_from_fred(code)
    series_data = DataHtmlParser.new.get_fred_series(code)
    new_transformation("loaded series : #{code} from FRED website", series_data)
  end
  
  def Series.load_from_fred(code, frequency)
    series_data = DataHtmlParser.new.get_fred_series(code)
    Series.new_transformation("loaded series : #{code} from FRED website", series_data, Series.frequency_from_code(frequency))
  end
  
  
  def Series.where_ds_like(string)
    ds_array = DataSource.where("eval LIKE '%#{string}%'").all
    series_array = []
    ds_array.each do |ds|
      series_array.push ds.series
    end 
    series_array
  end
  
  def ds_like?(string)
    self.data_sources.each do |ds|
      return true unless ds.eval.index(string).nil?
    end
    return false
  end
  
  def handle
    self.data_sources.each do |ds|
      if !ds.eval.index("load_from_download").nil?
        return ds.eval.split("load_from_download")[1].split("\"")[1]
      end
    end
    return nil
  end

  def original_url
    self.data_sources.each do |ds|
      if !ds.eval.index("load_from_download").nil?
        return DataSourceDownload.get(ds.eval.split("load_from_download")[1].split("\"")[1]).url
      end
    end
    return nil
  end
  
  def Series.write_cached_files(cached_files)
    t = Time.now
    Rails.cache.write("downloads", Marshal.dump(cached_files), :time_to_live => 600.seconds)
    puts "#{Time.now - t} | Wrote downloads to cache"
    #Rails.cache.write("downloads", cached_files, :time_to_live => 600.seconds)
    
  end
  
  def Series.get_cached_files
    #won't need these two series invocations in productions
    DownloadsCache
    DataSourceDownload
    t = Time.now
    #this is pretty good for now. Will eventually want to redo cache strategy to write directly to cache with individual keys
    #the larger file sizes really slow the system down, even though this is still a performance boost
    #may also be able to dump directly now that Marshal knows about the classes? 
    #also that class logic will work by itself. 
    cache = Rails.cache.read("downloads")
    puts "#{Time.now - t} | Got Downloads from Cache " unless cache.nil?
    return DownloadsCache.new if cache.nil?
    return Marshal.load(cache)
  end
    
  def at(date)
    data[date]
  end
  
  def units_at(date)
    self.units ||= 1
    data[date] / self.units
  end
  
  def new_at(date)
    dp = DataPoint.first
    DataPoint.first(:conditions => {:date_string => date, :current => true, :series_id => self.id})
  end

  def observation_count
    observations = 0
    data.each do |key,value|
      observations += 1 unless value.nil?
    end
    return observations
  end

  # def get_source_colors
  #   colors = {}
  #   color_order = ["FFCC99", "CCFFFF", "99CCFF", "CC99FF", "FFFF99", "CCFFCC", "FF99CC", "CCCCFF", "9999FF", "99FFCC"]
  #   colors
  # end
  
  def print
    data.sort.each do |datestring, value|
      puts "#{datestring}: #{value}"
    end
    puts name
  end
  
  def Series.show_post_creator
    PostCreatorController.new.show
  end
  
  #used to use app.get trick
  def create_blog_post(bar = nil, start_date = nil, end_date = nil)
    start_date = start_date.nil? ? (Time.now.to_date << (15)).to_s : start_date.to_s
    end_date = end_date.nil? ? Time.now.to_date.to_s : end_date.to_s
    plot_data = self.get_values_after(start_date,end_date)
    chart_id = self.id.to_s+"_"+Date.today.to_s
    a_series = AremosSeries.get(self.name)
    view = ActionView::Base.new(ActionController::Base.view_paths, {}) 
    
    
    if bar == "yoy"
      bar_data = self.annualized_percentage_change.data
      bar_id_label = "yoy"
      bar_color = "#AAAAAA"
      bar_label = "YOY % Change"
      template_path = "app/views/series/_blog_chart_line_bar"
      post_body = '' + view.render(:file=> "#{template_path}.html.erb", :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id, :bar_id_label=>bar_id_label, :bar_label => bar_label, :bar_color => bar_color, :bar_data => bar_data })
    elsif bar == "ytd"
      bar_data = self.ytd_percentage_change.data 
      bar_id_label = "ytd"
      bar_color = "#AAAAAA"
      bar_label = "YTD % Change"
      template_path = "app/views/series/_blog_chart_line_bar"
      post_body = '' + view.render(:file=> "#{template_path}.html.erb", :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id, :bar_id_label=>bar_id_label, :bar_label => bar_label, :bar_color => bar_color, :bar_data => bar_data })
    else
      template_path = "app/views/series/_blog_chart_line"
      post_body = '' + view.render(:file=> "#{template_path}.html.erb", :locals => {:plot_data => plot_data, :a_series => a_series, :chart_id => chart_id})
    end



    require 'mechanize'
    agent = Mechanize.new
    login_page = agent.get('http://www.uhero.hawaii.edu/admin/login')
    
    dashboard = login_page.form_with(:action => '/admin/login') do |f|
    	f.send("data[User][login]=", "mechanize")
    	f.send("data[User][pass]=", "uher0")
    end.click_button
    
    new_product_page = agent.get('http://www.uhero.hawaii.edu/admin/news/add')
    
    conf_page = new_product_page.form_with(:action => '/admin/news/add') do |f|
      
    	f.send("data[NewsPost][title]=", "#{a_series.description} (#{self.name})")
    	f.send("data[NewsPost][content]=", post_body)
    	#f.checkbox_with(:value => '2').check
      
    end.click_button

    product_posts = Array.new
    conf_page.links.each do |link|
    	product_posts.push link.href unless link.href['admin/news/edit'].nil?
    end
    product_posts.sort.reverse[0]
    
  end
  
  def print_data_points
    data_hash = {}
    source_array = []
    
    data_sources.each { |ds| source_array.push ds.id }  
    source_array.each_index {|index| puts "(#{index}) #{DataSource.find(source_array[index]).eval}"}
    data_points.each do |dp|  
      data_hash[dp.date_string] ||= []
      data_hash[dp.date_string].push("#{"H" unless dp.history.nil?}#{"|" unless dp.current} #{dp.value} (#{source_array.index(dp.data_source_id)})".rjust(10," "))
    end
  
    data_hash.sort.each do |datestring, value_array|
      puts "#{datestring}: #{value_array.sort.join}"
    end
    puts name
  end
  
  
  #["ERE", "EGVLC", "EGVST", "EGVFD", "EAFFD", "EAFAC", "EAE", "EHC", "EED", "EPS", "EAD", "EMA","E_TU","EWT","ERT","ECT","EMN","EIF", "EOS", "E_TTU", "E_TRADE", "E_FIR", "E_PBS","E_EDHC", "E_LH", "EAF", "EGV", "E_GVSL", "E_NF"].each do |pre|
  
  def refresh_all_datapoints
    unique_ds = {} #this is actually used ds
    current_data_points.each {|dp| unique_ds[dp.data_source_id] = 1}
    puts unique_ds
    eval_statements = []
    self.data_sources_by_last_run.each do |ds| 
      eval_statements.push(ds.get_eval_statement) unless unique_ds.keys.index(ds.id).nil?
      ds.delete
    end
    eval_statements.each {|es| eval(es)}
  end
  
  def Series.smart_update(series_names_finished = [], series_to_finish = Series.all, depth = 0 )
    return series_to_finish if series_to_finish.count == 0 or depth == 25
    series_to_finish_new = []
    series_to_finish.each do |series|
      if series.open_dependencies(series_names_finished).count == 0
        series_names_finished.push series.name
        series.reload_sources      
      else
        series_to_finish_new.push series
      end
    end
    puts "# Series To finish: #{series_to_finish_new.count}"
    #puts series_names_finished.count
    puts "# -----end------"
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n"
    if (series_to_finish.count == series_to_finish_new.count)
      # series_to_finish.each do |stuck|
      #   puts stuck.name
      # end
      return series_to_finish_new
    end
    return Series.smart_update(series_names_finished, series_to_finish_new, depth+1)
  end
  
  def Series.output_database_rebuild_statements(series_names_finished = [], series_to_finish = Series.all, depth = 0 )
    return series_to_finish if series_to_finish.count == 0 or depth == 25
    series_to_finish_new = []
    series_to_finish.each do |series|
      if series.open_dependencies(series_names_finished).count == 0
        series_names_finished.push series.name
        #puts "# #{series.name}"
        series.print_source_eval_statements
      else
        series_to_finish_new.push series
      end
    end
    puts "# Series To finish: #{series_to_finish_new.count}"
    #puts series_names_finished.count
    puts "# -----end------"
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n"
    if (series_to_finish.count == series_to_finish_new.count)
      # series_to_finish.each do |stuck|
      #   puts stuck.name
      # end
      return series_to_finish_new
    end
    return Series.output_database_rebuild_statements(series_names_finished, series_to_finish_new, depth+1)
  end
  
end
