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
  
  def last_observation
    return nil if data.nil?
    return data.keys.sort[-1]
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
    return ""
  end
  
  def Series.frequency_from_code(code)
    return :year if code == 'A' || code =="a"
    return :quarter if code == 'Q' || code =="q"
    return :month if code == 'M' || code == "m"
    return :semi if code == 'S' || code == "s"
    return nil
  end
  
  def Series.each_spreadsheet_header(update_spreadsheet_path, sheet_to_load = nil, sa = false)
    update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
    return {:message => "The spreadsheet could not be found", :headers => []} if update_spreadsheet.load_error?

    default_sheet = sa ? "Demetra_Results_fa" : update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
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
  
  def Series.load_all_sa_series_from(update_spreadsheet_path, output_worksheet = nil)  
    each_spreadsheet_header(update_spreadsheet_path, output_worksheet, true) do |series_name, update_spreadsheet|
      frequency_code = code_from_frequency update_spreadsheet.frequency  
      sa_base_name = series_name.sub("NS@","@")
      sa_series_name = sa_base_name+"."+frequency_code
      Series.store(sa_series_name, Series.new(:frequency => update_spreadsheet.frequency, :data => update_spreadsheet.series(series_name)), update_spreadsheet_path, %Q^"#{sa_series_name}".tsn.load_sa_from "#{update_spreadsheet_path}"^)
      sa_series_name.ts.update_attributes(:seasonally_adjusted => true, :last_demetra_datestring => update_spreadsheet.dates.keys.sort.last)
      sa_series_name
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
    desc = series.name if desc.nil?
    desc = "Source Series Name is blank" if desc.nil? or desc == ""
    series_to_set = Series.get_or_new series_name
    series_to_set.update_attributes(
      :frequency => series.frequency,
      :units => series.units,
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
  rescue Exception 
      puts "ERROR | #{series_name} | #{eval_statement}"
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
    source.mark_history
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
    update_spreadsheet.default_sheet = sheet_to_load.nil? ? "Demetra_Results_fa" : sheet_to_load unless update_spreadsheet.class == UpdateCSV
    raise SeriesReloadException unless update_spreadsheet.update_formatted?
    demetra_series = new_transformation("demetra series", update_spreadsheet.series(ns_name))
    demetra_series.frequency = update_spreadsheet.frequency
    self.frequency = update_spreadsheet.frequency
    mean_corrected_demetra_series = demetra_series / demetra_series.annual_sum * ns_name.ts.annual_sum
    new_transformation("mean corrected against #{ns_name} and loaded from #{update_spreadsheet_path}", mean_corrected_demetra_series.data)
  end
  
  def Series.load_from_basic_text(path, rows_to_skip, delimiter, date_col, value_col)
    f = open path, "r"
    rows_skipped = 0
    while (rows_to_skip > rows_skipped)
      f.gets
      rows_skipped += 1
    end
    load_from_queued_up_file(f, delimiter, date_col, value_col)
  end
  
  def Series.load_standard_text(path)
    f = open path, "r"
    while line = f.gets
      break if line.starts_with "DATE"
    end
    load_from_queued_up_file(f, " ", 0, 1)
  end
  
  def Series.load_from_queued_up_file(f, delimiter, date_col, value_col)
    series_data = {}
    while data_row = f.gets
      data = data_row.split(delimiter)
      begin
        date = Date.parse(data[date_col])
      rescue
        break
      end
      series_data[date.to_s] = data[value_col].to_f
    end
    Series.new.new_transformation("loaded from textfile #{f.path}", series_data)
  end
  
  #original version of this function returned data. Then it returned a series. now returns a pattern for later manipulation
  def Series.load_pattern(start, freq, path, sheet, row, col)
    DataLoadPattern.new(:col=>col, :start_date=>start, :frequency=>freq , :worksheet=>sheet, :row=>row, :path=>path)
    #can also attempt to find duplicate of pattern.
  end
  
  def load_standard_text(path)
    Series.load_standard_text(path)
  end
  
  def load_from_pattern_id(pattern_id)
    p = DataLoadPattern.find pattern_id
    s = load_from_pattern(p)
    p.save
    return s
  end
  
  def load_from_pattern(p)
    last_condition = nil
    series_data = {}
    index = 0
    #t = Time.now
    while last_condition.nil?
      #puts index.to_s+": "+(Time.now-t).to_s
      date_string = p.compute_date_string_for_index index
      data_value = p.retrieve(date_string)
      #puts p.last_read_status if data_value == "END"
      break if data_value == "END"
      series_data[date_string] = data_value
      index += 1
    end
    new_transformation("loaded from pattern id #{p.id}", series_data)
  end

  def load_from_bls(code, frequency = nil)
    series_data = DataHtmlParser.new.get_bls_series(code,frequency)
    new_transformation("loaded series code: #{code} from bls website", series_data)
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
