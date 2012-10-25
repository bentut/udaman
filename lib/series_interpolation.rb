module SeriesInterpolation
  
  def interpolate_to (frequency, operation, series_to_store_name)
    series_to_store_name.ts= interpolate frequency,operation
  end
  
  def fill_interpolate_to(target_frequency)
    freq = self.frequency.to_s
    new_series_data = {}
    if  freq == "year"
      if target_frequency == :quarter
        month_vals = ["01", "04", "07", "10"]
      elsif target_frequency == :month
        month_vals = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
      else
        raise InterpolationException
      end

      self.data.each do |date_string, val|
        year = date_string.to_date.year
        month_vals.each {|month| new_series_data["#{year}-#{month}-01"] = val }
      end
    else
      raise InterpolationException
    end
     
    new_series = new_transformation("Interpolated by filling #{self.name} to #{target_frequency}", new_series_data)
    new_series.frequency = target_frequency.to_s
    new_series
  end
  
  def fill_days_interpolation
    daily_data = {}
    raise InterpolationException if frequency != "week" and frequency != "W"
    self.data.each do |date, val|
      6.downto(0).each { |days_back| daily_data[(Date.parse(date) - days_back).to_s] = val }
    end 
    new_series = new_transformation("Interpolated Days (filled) from #{self.name}", daily_data)
    new_series.frequency = "day"
    new_series
  end

  def distribute_days_interpolation
    daily_data = {}
    raise InterpolationException if frequency != "week" and frequency != "W"
    self.data.each do |date, val|
      6.downto(0).each { |days_back| daily_data[(Date.parse(date) - days_back).to_s] = val / 7 }
    end 
    new_series = new_transformation("Interpolated Days (distributed) from #{self.name}", daily_data)
    new_series.frequency = "day"
    new_series
  end
  
  def census_interpolate(frequency)
    raise AggregationError if frequency != :quarter and self.frequency != "year"
    quarterly_data = {}
    last = nil
    started_interpolation = false
    data.sort.each do |key, value|
      unless last.nil?
        year = key.to_date.year
        step = (value - last) / 4
        quarterly_data["#{year-1}-10-01"] = value - 3 * step
        quarterly_data["#{year}-01-01"]   = value - 2 * step
        quarterly_data["#{year}-04-01"]   = value - 1 * step
        quarterly_data["#{year}-07-01"]   = value
        unless started_interpolation
          quarterly_data["#{year-1}-01-01"]   = last - 2 * step
          quarterly_data["#{year-1}-04-01"]   = last - 1 * step
          quarterly_data["#{year-1}-07-01"]   = last
          started_interpolation = true
        end
      end
      last = value
    end
    new_series = new_transformation("Interpolated with Census method from #{self.name}", quarterly_data)
    new_series.frequency = frequency 
    new_series
  end
  
  def interpolate(frequency, operation)
   # puts "FREQUENCY: #{frequency} - #{frequency.class}"
   # puts "SELF.FREQUENCY: #{self.frequency} - #{self.frequency.class}"
   # puts "OPERATION: #{operation} - #{operation.class}"
   #also needs to be ok with frequency of annual
    #raise InterpolationException if frequency != :quarter or self.frequency != "semi" or operation != :linear
    raise InterpolationException if data.count < 2
    last = nil
    last_date = nil
    interval = nil
    quarterly_data = {}
    data.sort.each do |key, value|
      next if value.nil?
      unless last.nil?
        d1 = Date.parse key
        d2 = Date.parse last_date
        quarter_diff = ((d1.year - d2.year) * 12 + (d1.month - d2.month))/3
        interval = value - last 
        quarterly_data[last_date] = last - interval/(quarter_diff*2) 
        quarterly_data[(Date.parse(last_date) >> 3).to_s] = last + interval/(quarter_diff*2) 
      end
      last = value
      last_date = key
    end
    #not sure why this one is needed... but using the default 4 for here instead of 2*quarter_diff
    quarterly_data[last_date] = last - interval/4
    quarterly_data[(Date.parse(last_date) >> 3).to_s] = last + interval/4
    #quarterly_data
    new_series = new_transformation("Interpolated from #{self.name}", quarterly_data)
    new_series.frequency = frequency 
    new_series
  end
  
  def interpolate_missing_months_and_aggregate(frequency, operation)
    last_val = nil
    last_date = nil
    monthly_series_data = {}
    data.sort.each do |key, val|
      next if val.nil?
      monthly_series_data[key] = val
      unless last_val.nil?
        val_diff = val - last_val
        d1 = Date.parse key
        d2 = Date.parse last_date
        month_diff = (d1.year - d2.year) * 12 + (d1.month - d2.month)
        #puts "#{key}: #{month_diff}"
        (1..month_diff-1).each { |offset| monthly_series_data[(d2 >> offset).to_s] = last_val + (val_diff / month_diff) * offset }
      end
      last_val = val
      last_date = key
    end
    monthly_series = new_transformation("Interpolated Monthly Series from #{self.name}", monthly_series_data)
    monthly_series.frequency = "month"
    monthly_series.aggregate(frequency, operation)

  end
  
  
end