module SeriesAggregation
  def aggregate(frequency, operation)
    new_series = new_transformation("Aggregated from #{self.name}", aggregate_data_by(frequency, operation))
    new_series.update_attributes(:frequency=>frequency)
    new_series
  end
  
  def aggregate_to(frequency, operation, series_to_store_name)
    series_to_store_name.ts= aggregate frequency, operation
  end
  
  def aggregate_data_by(frequency,operation)
    validate_aggregation(frequency)
    
    grouped_data = group_data_by frequency
    aggregated_data = Hash.new
    grouped_data.keys.each do |date_string|
      aggregated_data[date_string] = grouped_data[date_string].send(operation)
    end
    return aggregated_data
  end
  
  def aggregate_by(frequency,operation)
    Series.new(:data=>aggregate_data_by(frequency, operation), :frequency=>frequency)
  end
  
  # Only returns complete groups
  def group_data_by(frequency)
    validate_aggregation(frequency)
    
    aggregated_data = Hash.new
    frequency_method = frequency.to_s+"_s"
    
    self.data.keys.each do |date_string|
      date = Date.parse date_string
      aggregated_data[date.send(frequency_method)] ||= AggregatingArray.new
      aggregated_data[date.send(frequency_method)].push self.at(date_string) unless self.at(date_string).nil?
    end
    
    # Prune out any incomplete aggregated groups
    aggregated_data.delete_if {|key,value| value.count != 6} if frequency == :semi and self.frequency == "month"
    aggregated_data.delete_if {|key,value| value.count != 3} if frequency == :quarter and self.frequency == "month"
    aggregated_data.delete_if {|key,value| value.count != 12} if frequency == :year and self.frequency == "month"
    aggregated_data.delete_if {|key,value| value.count != 4} if frequency == :year and self.frequency == "quarter"
    aggregated_data.delete_if {|key,value| value.count != 2} if frequency == :semi and self.frequency == "quarter"    
    aggregated_data.delete_if {|key,value| value.count != 2} if frequency == :year and self.frequency == "semi"

    
    return aggregated_data
  end
  
  def validate_aggregation(frequency)
    # The following represent invalid aggregation transitions
    raise AggregationException.new if self.frequency == "year"
    raise AggregationException.new if self.frequency == "semi"  and (frequency == :month or frequency == :quarter or frequency == :semi)
    raise AggregationException.new if self.frequency == "quarter" and (frequency == :month or frequency == :quarter)
    raise AggregationException.new if self.frequency == "month" and frequency == :month
  end
  
end