module SeriesSpecCreation
  #may consolidate the insides of these into a standard creation method later 
  #leaving old methods intact until the rest of the tests are refactored
  def Series.new_from_data_hash(name, data_hash)
    frequency = frequency_from_code(name.split(".")[1])
    new_series = Series.new(
      :name => name,
      :data => data_hash[name],
      :frequency => frequency
      )
    
  end
  
  def Series.create_from_data_hash(name, data_hash)
    frequency = frequency_from_code(name.split(".")[1])
    new_series = Series.new(
      :name => name,
      :data => data_hash[name],
      :frequency => frequency
      )
    Series.store(name, new_series, "direct load (desc)", "direct_load (eval)") #passing in the "" so as not to trigger the default source creation
    # name.ts.save_source("direct load (desc)", "direct_load (eval)", :set, new_series.data)
    name.ts
  end
  
  #for testing in Cucumber and rspec
  def Series.create_dummy(series_name, frequency, start_date_string,start_offset = 1, end_offset = 12)
    headerparts = series_name.split(".")
    base_series_name = headerparts[0]
    
    month_multiplier = 1 if frequency == :month
    month_multiplier = 3 if frequency == :quarter
    month_multiplier = 6 if frequency == :semi
    month_multiplier = 12 if frequency == :year
    dataseries = Hash.new
    date = Date.parse start_date_string
    (start_offset..end_offset).each do |offset|
      dataseries[(date>>offset*month_multiplier).to_s] = offset
    end
    return Series.create(
      :name => series_name,
      :frequency => frequency,
      :data => dataseries
      )
  end
end