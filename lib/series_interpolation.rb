module SeriesInterpolation
  def interpolate_to (frequency, operation, series_to_store_name)
    series_to_store_name.ts= interpolate frequency,operation
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
      interval = value - last unless last.nil?
      quarterly_data[last_date] = last - interval/4.0 unless last.nil?
      quarterly_data[(Date.parse(last_date) >> 3).to_s] = last + interval/4.0 unless last.nil?
      last = value
      last_date = key
    end
    quarterly_data[last_date] = last - interval/4.0
    quarterly_data[(Date.parse(last_date) >> 3).to_s] = last + interval/4.0
    quarterly_data
    new_series = new_transformation("Interpolated from #{self.name}", quarterly_data)
    new_series.update_attributes(:frequency=>frequency)
    new_series
  end
end