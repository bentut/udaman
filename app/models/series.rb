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
  include SeriesDataLists
  include SeriesStatistics
  
  #serialize :data, Hash
  serialize :factors, Hash
  
  has_many :data_points
  has_many :data_sources
  
  def as_json(options = {})
    as = AremosSeries.get(self.name)
    desc = as.nil? ? "" : as.description
    {
      data: self.data,
      frequency: self.frequency,
      units: self.units,
      description: desc,
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
    t = Time.now
    each_spreadsheet_header(update_spreadsheet_path, sheet_to_load, false) do |series_name, update_spreadsheet|
      Series.store(series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{series_name}".tsn.load_from "#{update_spreadsheet_path}", "#{sheet_to_load}"^) unless sheet_to_load.nil?
      Series.store(series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{series_name}".tsn.load_from "#{update_spreadsheet_path}"^) if sheet_to_load.nil?      
      #puts series_name
      series_name
    end
    puts "#{"%.2f" % (Time.now - t)} : #{update_spreadsheet_path}"
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
    series_to_store = Series.create(:name => series_name) if series_to_store.nil?
    return series_to_store
  end

  def Series.store(series_name, series, desc=nil, eval_statement=nil)
    #t = Time.now
    #puts series.frequency
    desc = series.name if desc.nil?
    desc = "Source Series Name is blank" if desc.nil? or desc == ""
    # series_to_set = Series.get_or_new series_name
    # series_to_set.update_attributes(
    #   :frequency => series.frequency
    # )
    series_to_set = series_name.tsn
    series_to_set.frequency = series.frequency
    #puts "#{"%.2f" % (Time.now - t)} :  : #{self.name} : SETTING UP STORE"
    source = series_to_set.save_source(desc, eval_statement, series.data)
    #puts "#{"%.2f" % (Time.now - t)} :  : #{self.name} : DURATION OF STORE"
    source
  end

  def Series.eval(series_name, eval_statement)
    t = Time.now
    new_series = Kernel::eval eval_statement
    #puts "#{"%.2f" % (Time.now - t)} :  : #{self.name} : EVAL TIME"
    source = Series.store series_name, new_series, new_series.name, eval_statement
    #taking this out as well... not worth it to run
    #source.update_attributes(:runtime => (Time.now - t))
    puts "#{"%.2f" % (Time.now - t)} | #{series_name} | #{eval_statement}" 
  # rescue Exception 
  #     puts "ERROR | #{series_name} | #{eval_statement}"
  end
  
  def save_source(source_desc, source_eval_statement, data, last_run = Time.now)
    source = nil
    #ss_time = Time.now          #timer
    data_count = data.count     #timer
    data_sources.each do |ds|
      if !source_eval_statement.nil? and !ds.eval.nil? and source_eval_statement.strip == ds.eval.strip
        #ds.update_attributes(:data => data, :last_run => Time.now) 
        ds.update_attributes(:last_run => Time.now) 
        source = ds 
      end
    end
       
    if source.nil?
      data_sources.create(
        :description => source_desc, 
        :eval => source_eval_statement, 
        #:data => data,
        :last_run => last_run
      )
    
      source = data_sources_by_last_run[-1]
      source.setup
    end
    #puts "#{"%.2f" % (Time.now - ss_time)} : #{data.count} : #{self.name} : EVERYTHING BEFORE UPDATE DATA\n"

    update_data(data, source)
    #puts "#{"%.2f" % (Time.now - ss_time)} : #{data.count} : #{self.name} : #{data_count} original data points SAVING SOURCE #{source_eval_statement}\n"
    
    source
  end
  
  #probably going to want tests

  def update_data(data, source)
    #removing nil dates because they incur a cost but no benefit.
    #have to do this here because there are some direct calls to update data that could include nils
    #instead of calling in save_source
    #p_time = Time.now
    data.delete_if {|key,value| value.nil?}
    
    observation_dates = data.keys
    #puts "#{"%.2f" % (Time.now - p_time)} : #{current_data_points.count} : #{self.name} : PRUNING DATAPOINTS"
    
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
        
    #update_data_hash

    #a_time = Time.now
    aremos_comparison #if we can take out this save, might speed things up a little
    #puts "#{"%.2f" % (Time.now - a_time)} : #{observation_dates.count} : #{self.name} : AREMOS COMPARISON"
  end
  
  def update_data_hash
    data_hash = {}
    #dh_time = Time.now            #timer
    data_points.each do |dp|
      #puts "#{dp.date_string}: #{dp.value} (#{dp.current})"
      data_hash[dp.date_string] = dp.value if dp.current
    end
    #puts "#{"%.2f" % (Time.now - dh_time)} : #{data_points.count} : #{self.name} : UPDATING DATA HASH FROM (ALL DATA POINTS)"    
    #s_time = Time.now
    self.save
    #puts "#{"%.2f" % (Time.now - s_time)} : #{data_hash.count} : #{self.name} : SAVING SERIES"    
  end
  
  def data
    @data ||= data_from_datapoints
  end
  
  def data=(data_hash)
    @data = data_hash
  end
  
  #doesn't scale data yet
  def data_from_datapoints
    data_hash = {}
    data_points.each do |dp|
      data_hash[dp.date_string] = dp.value if dp.current
    end
    data_hash
  end
  
  def scaled_data_no_pseudo_history(round_to = 3)
    data_hash = {}
    self.units ||= 1
    self.units = 1000 if name[0..2] == "TGB" #hack for the tax scaling. Should not save units
    data_points.each do |dp|
      data_hash[dp.date_string] = (dp.value / self.units).round(round_to) if dp.current and !dp.pseudo_history
    end
    data_hash
  end
  
  def scaled_data(round_to = 3)
    data_hash = {}
    self.units ||= 1
    self.units = 1000 if name[0..2] == "TGB" #hack for the tax scaling. Should not save units
    data_points.each do |dp|
      data_hash[dp.date_string] = (dp.value / self.units).round(round_to) if dp.current
    end
    data_hash
  end
  
  def Series.new_from_data(frequency, data)
    Series.new_transformation("One off data", data, frequency)
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
      :data => data.reject {|k,v| v.nil?}
    )
  end
  
  #need to spec out tests for this
  #this would benefit from some caching scheme
  
  #SeriesReloadExceptions
  #until we can figure out a solid for sources ordering, this error is particularly costly
  #just keeping data the same if there's a problem to preserve the order.
  
  def load_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    raise SeriesReloadException if update_spreadsheet.load_error?
    #return self if update_spreadsheet.load_error?

    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? default_sheet : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    raise SeriesReloadException unless update_spreadsheet.update_formatted?
    #return self unless update_spreadsheet.update_formatted?
    
    self.frequency = update_spreadsheet.frequency
    new_transformation(update_spreadsheet_path, update_spreadsheet.series(self.name))
  end
    
  
  def load_sa_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    #raise SeriesReloadException if update_spreadsheet.load_error?
    return self if update_spreadsheet.load_error?

    ns_name = self.name.sub("@", "NS@")
#    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? "sadata" : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    #raise SeriesReloadException unless update_spreadsheet.update_formatted?
    return self unless update_spreadsheet.update_formatted?
    
    self.frequency = update_spreadsheet.frequency 
    new_transformation(update_spreadsheet_path, update_spreadsheet.series(ns_name))
  end
    
  
  def load_mean_corrected_sa_from(update_spreadsheet_path, sheet_to_load = nil)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)

    #raise SeriesReloadException if update_spreadsheet.load_error?
    return self if update_spreadsheet.load_error?

    ns_name = self.name.sub("@", "NS@")
    default_sheet = update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? "sadata" : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    #raise SeriesReloadException unless update_spreadsheet.update_formatted?
    return self unless update_spreadsheet.update_formatted?
    
    demetra_series = new_transformation("demetra series", update_spreadsheet.series(ns_name))
    demetra_series.frequency = update_spreadsheet.frequency.to_s
    self.frequency = update_spreadsheet.frequency
    mean_corrected_demetra_series = demetra_series / demetra_series.annual_sum * ns_name.ts.annual_sum
    new_transformation("mean corrected against #{ns_name} and loaded from #{update_spreadsheet_path}", mean_corrected_demetra_series.data)
  end
  
  #if smart update or other process sets a global cache object for a session, use that. Otherwise
  #download fresh
  def Series.load_from_download(handle, options, cached_files = nil)
    begin
      cached_files = Series.get_cached_files if cached_files.nil?
      dp = DownloadProcessor.new(handle, options, cached_files)
      series_data = dp.get_data
    rescue => e
      Series.write_cached_files cached_files if cached_files.new_data?
      raise e
    end
    Series.write_cached_files cached_files if cached_files.new_data?

    Series.new_transformation("loaded from download #{handle} with options:#{options}", series_data, Series.frequency_from_code(options[:frequency]))
  end
  
  #the other problem with these "SERIES" style transformations is that they overwrite the units calculations. Can also build that into the 
  #series definition as necessary
  
  def Series.load_from_file(file, options, cached_files = nil)
    begin
      cached_files = Series.get_cached_files if cached_files.nil?
      dp = DownloadProcessor.new("manual", options.merge({ :path => file }), cached_files)
      series_data = dp.get_data
    rescue => e
      Series.write_cached_files cached_files if cached_files.new_data?
      raise e
    end
      Series.write_cached_files cached_files if cached_files.new_data?
      Series.new_transformation("loaded from file #{file} with options:#{options}", series_data, Series.frequency_from_code(options[:frequency]))
  end
  
  def load_from_pattern_id(id)
    new_transformation("loaded from pattern id #{id}", {})
  end
  
  def load_from_download(handle, options, cached_files = nil)
    begin
      cached_files = Series.get_cached_files if cached_files.nil?
      dp = DownloadProcessor.new(handle, options, cached_files)
      series_data = dp.get_data
    rescue => e
      Series.write_cached_files cached_files if cached_files.new_data?
      raise e
    end
    Series.write_cached_files cached_files if cached_files.new_data?
    new_transformation("loaded from download #{handle} with options:#{options}", series_data)
  end
  
  def Series.load_from_bea(code, region, frequency)
    series_data = DataHtmlParser.new.get_bea_series(code, region)
    Series.new_transformation("loaded series code: #{code} for region #{region} from bea website", series_data, Series.frequency_from_code(frequency))
  end
  
  def load_from_bea(code, region)
    frequency = Series.frequency_from_code(self.name.split(".")[1])
    series_data = DataHtmlParser.new.get_bea_series(code, region)
    Series.new_transformation("loaded series code: #{code} for region #{region} from bea website", series_data, frequency)
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
  
  def days_in_period
    series_data = {}
    data.each {|date_string, val| series_data[date_string] = date_string.to_date.days_in_period(self.frequency) }
    Series.new_transformation("days in time periods", series_data, self.frequency)
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
    cached_files.reset_new_data
    puts "#{Time.now - t} | Wrote downloads to cache"
    Rails.cache.write("downloads", Marshal.dump(cached_files), :time_to_live => 600.seconds)
    #Rails.cache.write("downloads", cached_files, :time_to_live => 600.seconds)
    
  end
  
  def Series.get_cached_files
    #won't need these three module invocations in productions
    DownloadsCache
    DataSourceDownload
    DsdLogEntry
#    t = Time.now
    #this is pretty good for now. Will eventually want to redo cache strategy to write directly to cache with individual keys
    #the larger file sizes really slow the system down, even though this is still a performance boost
    #may also be able to dump directly now that Marshal knows about the classes? 
    #also that class logic will work by itself. 
    cache = Rails.cache.read("downloads")
#    puts "#{Time.now - t} | Got Downloads from Cache " unless cache.nil?
    return DownloadsCache.new if cache.nil?
    return Marshal.load(cache)
  end
    
  def at(date)
    data[date]
  end
  
  def units_at(date)
    dd = data[date]
    return nil if dd.nil?
    self.units ||= 1
    dd / self.units
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
  
  def new_data?
    data_points.where("created_at > FROM_DAYS(TO_DAYS(NOW()))").count > 0
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
    
    raise "config/site.yml needs to be set up with 'cms_user'/'cms_pass'" if SITE['cms_user'].nil? or SITE['cms_pass'].nil?
    
    dashboard = login_page.form_with(:action => '/admin/login') do |f|
    	f.send("data[User][login]=", SITE['cms_user'])
    	f.send("data[User][pass]=", SITE['cms_pass'])
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
  
  
  def month_mult
    return 1 if frequency == "month"
    return 3 if frequency == "quarter"
    return 6 if frequency == "semi"
    return 12 if frequency == "year"
  end
  
  def date_range
    
    #return self.data.keys.sort 
      
    data_dates = self.data.keys.sort
    start_date = Date.parse data_dates[0]
    end_date = Date.parse data_dates[-1]
    curr_date = start_date
    
    dates = []
    offset = 0
    
    if frequency == "day" or frequency == "week"
      day_multiplier = frequency == "day" ? 1 : 7
      begin
        curr_date = start_date + offset * day_multiplier
        dates.push(curr_date.to_s)
        offset += 1
      end while curr_date < end_date
    else
      month_multiplier = month_mult
      begin
        curr_date = start_date>>offset*month_multiplier
        dates.push(curr_date.to_s)
        offset += 1
      end while curr_date < end_date
    end
    
    
    dates
  end

  def Series.new_from_tsd_data(tsd_data)
    return Series.new_transformation(tsd_data["name"]+"."+tsd_data["frequency"],  tsd_data["data"], Series.frequency_from_code(tsd_data["frequency"]))
  end
  
  def get_tsd_series_data(tsd_file)      
    url = URI.parse("http://readtsd.herokuapp.com/open/#{tsd_file}/search/#{name.split(".")[0].gsub("%","%25")}/json")
    res = Net::HTTP.new(url.host, url.port).request_get(url.path)
    tsd_data = res.code == "500" ? nil : JSON.parse(res.body)  
    
    return nil if tsd_data.nil?
    return Series.new_from_tsd_data(tsd_data)
  end
  
  def tsd_string
    data_string = ""
    lm = data_points.order(:updated_at).last.updated_at

    as = AremosSeries.get name
    as_description = as.nil? ? "" : as.description

    dps = data
    dates = dps.keys.sort
    
    #this could stand to be much more sophisticated and actually look at the dates. I think this will suffice, though - BT
    day_switches = "0                "
    day_switches = "0         0000000"                if frequency == "week"
    day_switches[10 + dates[0].to_date.wday] = '1'    if frequency == "week"
    day_switches = "0         1111111"                if frequency == "day"
    
    data_string+= "#{name.split(".")[0].to_s.ljust(16," ")}#{as_description.ljust(64, " ")}\r\n"
    data_string+= "#{lm.month.to_s.rjust(34," ")}/#{lm.day.to_s.rjust(2," ")}/#{lm.year.to_s[2..4]}0800#{dates[0].to_date.tsd_start(frequency)}#{dates[-1].to_date.tsd_end(frequency)}#{Series.code_from_frequency frequency}  #{day_switches}\r\n"
    sci_data = {}
    
    dps.each do |date_string, val|
      sci_data[date_string] = ("%.6E" % units_at(date_string)).insert(-3,"00")
    end
    
    
    dates = date_range
    dates.each_index do |i|
    # sci_data.each_index do |i|
      date = dates[i]
      dp_string = sci_data[date].nil? ? "1.000000E+0015".rjust(15, " ") : sci_data[date].rjust(15, " ")
      data_string += dp_string
      data_string += "     \r\n" if (i+1)%5==0
    end    
    space_padding = 80 - data_string.split("\r\n")[-1].length
    return space_padding == 0 ? data_string : data_string + " " * space_padding + "\r\n"
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
  
  def delete_with_data
    puts "deleting #{name}"
    data_sources.each do |ds|
      puts "deleting: #{ds.id}" + ds.eval 
      ds.delete
    end
    self.delete
  end
    
  def last_data_added
    self.data_points.order(:created_at).last.created_at
  end
  
  def last_data_added_string
    last_data_added.strftime("%B %e, %Y")
  end
  
  def Series.get_all_series_from_website(url_string)
    series_from_website = (DataSource.where("eval LIKE '%#{url_string}%'").all.map {|ds| ds.series}).uniq
    all_series_from_website = series_from_website.map {|s| s.name }

    series_from_website.each do |s|
      puts s.name
      all_series_from_website.concat(s.recursive_dependents)
    end

    return all_series_from_website.uniq
  end
  
  #currently runs in 3 hrs (for all series..if concurrent series could go first, that might be nice)
  #could do everything with no dependencies first and do all of those in concurrent fashion...
  #to find errors, or broken series, maybe update the ds with number of data points loaded on last run?
  
  def Series.run_all_dependencies(series_list, already_run, errors, eval_statements)
    series_list.each do |s_name|
      next unless already_run[s_name].nil?
      s = s_name.ts
      begin
        Series.run_all_dependencies(s.new_dependencies, already_run, errors, eval_statements)
      rescue
        puts "-------------------THIS IS THE ONE THAT BROKE--------------------"
        puts s.id
        puts s.name
      end
      errors.concat s.reload_sources
      eval_statements.concat(s.data_sources_by_last_run.map {|ds| ds.get_eval_statement})
      already_run[s_name] = true
    end
  end
    
  def Series.missing_from_aremos
    name_buckets = {}
    (AremosSeries.all_names - Series.all_names).each {|name| name_buckets[name[0]] ||= []; name_buckets[name[0]].push(name)}
    name_buckets.each {|letter, names| puts "#{letter}: #{names.count}"}
    name_buckets
  end
  
  
  def Series.web_search(search_string, num_results = 10)
    regex = /"([^"]*)"/
    search_parts = (search_string.scan(regex).map {|s| s[0] }) + search_string.gsub(regex, "").split(" ")
    name_where = (search_parts.map {|s| "name LIKE '%#{s}%'"}).join (" AND ")
    name_results = Series.where(name_where).limit(num_results)
    
    desc_where = (search_parts.map {|s| "description LIKE '%#{s}%'"}).join (" AND ")
    desc_results = AremosSeries.where(desc_where).limit(num_results)
    
    results = []
  
    name_results.each do |s| 
      as = AremosSeries.get(s.name)
      results.push({ :name => s.name, :series_id => s.id, :description => as.nil? ? "no aremos series" : as.description})
      #puts "#{s.id} : #{s.name} - #{as.nil? ? "no aremos series" : as.description}"
    end
    
    desc_results.each do |as|
      s = as.name.ts
      results.push({:name => as.name, :series_id => s.nil? ? "no series" : s.id, :description => as.description})
      #puts "#{s.nil? ? "no series" : s.id}  : #{as.name} - #{as.description}"
    end
    
    results
    
  end
  
end
