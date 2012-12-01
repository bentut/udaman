module SeriesInterpolation
  
  def interpolate_to (frequency, operation, series_to_store_name)
    series_to_store_name.ts= interpolate frequency,operation
  end
  
  def extend_first_data_point_back_to(date)
    new_data = {}
    first_data_point_date = self.first_value_date
    first_data_point_val = data[first_data_point_date]

    offset = 1 if self.frequency == "month"
    offset = 3 if self.frequency == "quarter"
    offset = 6 if self.frequency == "semi"
    offset = 12 if self.frequency == "year"
    new_date = Date.parse(first_data_point_date) << offset

    while new_date.to_s >= date
      new_data[new_date.to_s] = first_data_point_val
      new_date = new_date << offset
    end
    new_series = new_transformation("Extended the first value back to #{date}", new_data)
    new_series.frequency = self.frequency
    new_series
  end
  
  def extend_last_date_to_match(series_name)
    new_data = {}
    last_data_point_date = series_name.ts.last_value_date
    current_last_data_point = self.last_value_date
    
    last_data_point_val = data[current_last_data_point]
    
    offset = 1 if self.frequency == "month"
    offset = 3 if self.frequency == "quarter"
    offset = 6 if self.frequency == "semi"
    offset = 12 if self.frequency == "year"
    new_date = Date.parse(current_last_data_point) >> offset

    while new_date.to_s <= last_data_point_date
      new_data[new_date.to_s] = last_data_point_val
      new_date = new_date >> offset
    end
    new_series = new_transformation("Extended the value value out to the last date of #{series_name}", new_data)
    new_series.frequency = self.frequency
    new_series
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
  
  def pseudo_centered_spline_interpolation(frequency)
    raise AggregationError unless (frequency == :quarter and self.frequency == "year") or 
                                  (frequency == :month and self.frequency == "quarter") or 
                                  (frequency == :day and self.frequency == "month")

    divisor = 4 if frequency == :quarter and self.frequency == "year"
    divisor = 3 if frequency == :month and self.frequency == "quarter"
    divisor = 30.4375 if frequency == :day and self.frequency == "month"
    
    temp_series_data = {}
    #last_temp_val = nil
    last_date = nil
    first_val = nil
    # self.data.sort.each do |date, val|
    #   if last_date.nil?
    #     last_date = date
    #     last_temp_val = val
    #     next
    #   end
    #   if temp_series_data[last_date].nil?
    #     temp_series_data[last_date] = last_temp_val + ((val-last_temp_val) / divisor) * ((divisor-1) / 2.to_f)
    #   end
    #   
    #   temp_series_data[date] = val + ((val - temp_series_data[last_date]) / divisor ) * ((divisor - 1) / 2.to_f)
    #   last_temp_val = temp_series_data[date]
    #   last_date = date
    # end
    
    self.data.sort.each do |date, val|
      #first period only
      if last_date.nil?
        last_date = date
        temp_series_data[date] = val
        first_val = val
        next
      end
      
      temp_series_data[date] = val + (val - temp_series_data[last_date]) * ((divisor - 1) / (divisor + 1).to_f)
      
      last_date = date
    end
    
    temp_series = new_transformation("Temp series from #{self.name}", temp_series_data)
    temp_series.frequency = self.frequency
    
    series_data = temp_series.linear_interpolate(frequency).data

    new_series = new_transformation("Pseudo Centered Spline Interpolation of #{self.name}", series_data)
    new_series.frequency = frequency
    new_series
  end

  #first period is just first value
  def linear_interpolate(frequency)
    raise AggregationError unless (frequency == :quarter and self.frequency == "year") or 
                                  (frequency == :month and self.frequency == "quarter") or 
                                  (frequency == :day and self.frequency == "month")
    data_copy = self.data.sort
    last_val = data_copy[0][1]
    last_date = data_copy[0][0]
    first = data_copy.shift
    
    new_series_data = nil
    data_copy.each do |date_string, val|
      diff = val - last_val
      new_series_data = last_date.linear_path_to_previous_period(last_val, 0, self.frequency, frequency) if new_series_data.nil?
      new_series_data.merge! date_string.linear_path_to_previous_period(val, diff, self.frequency, frequency)
      last_val = val
      last_date = date_string
    end
    
    new_series = new_transformation("Interpolated (linear match last) from #{self.name}", new_series_data)
    new_series.frequency = frequency 
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
          quarterly_data["#{year-2}-10-01"] = last - 3 * step
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
  
  
  #this always interpolates to quarterly
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
  
  def trms_interpolate_to_quarterly
    raise InterpolationException if frequency != "year"
    new_series_data = {}
    previous_data_val = nil
    previous_year = nil
    last_diff = nil
    self.data.sort.each do |key,val|
      if previous_data_val.nil?
        previous_data_val = val
        previous_year = key
        next
      end
      year = previous_year.to_date.year
      new_series_data["#{year}-01-01"] = previous_data_val - (val - previous_data_val) / 4 * 1.5
      new_series_data["#{year}-04-01"] = previous_data_val - (val - previous_data_val) / 4 * 0.5
      new_series_data["#{year}-07-01"] = previous_data_val + (val - previous_data_val) / 4 * 0.5
      new_series_data["#{year}-10-01"] = previous_data_val + (val - previous_data_val) / 4 * 1.5
      last_diff = val - previous_data_val
      previous_data_val = val
      previous_year = key  
    end
    
    year = previous_year.to_date.year
    new_series_data["#{year}-01-01"] = previous_data_val - last_diff / 4 * 1.5
    new_series_data["#{year}-04-01"] = previous_data_val - last_diff / 4 * 0.5
    new_series_data["#{year}-07-01"] = previous_data_val + last_diff / 4 * 0.5
    new_series_data["#{year}-10-01"] = previous_data_val + last_diff / 4 * 1.5
    
    blma_new_series_data = {}
    prev_val = nil
    prev_date = nil
    new_series_data.sort.each do |key,val|
      if prev_val.nil?
        prev_val = val
        prev_date = key
        next
      end
      blma_new_series_data[key] = (val + prev_val) / 2
      prev_val = val
      prev_date = key
    end
    
    new_series = new_transformation("TRMS style interpolation of #{self.name}", blma_new_series_data)
    new_series.frequency = "quarter"
    new_series
    
  end
  
end