module SeriesInterpolation
  def interpolate_to (frequency, operation, series_to_store_name)
    series_to_store_name.ts= interpolate frequency,operation
  end
  
  def fill_days_interpolation
    daily_data = {}
    raise InterpolationException if frequency != "week" and frequency != "W"
    self.data.each do |date, val|
      (6.downto 0).each { |days_back| daily_data[(Date.parse(date) - days_back).to_s] = val }
    end 
    new_series = new_transformation("Interpolated Days (filled) from #{self.name}", daily_data)
    new_series.frequency = "day"
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
    new_series.frequency = frequency #may not want to do this... probably saving series unintentionally
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