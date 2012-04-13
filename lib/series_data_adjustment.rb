module SeriesDataAdjustment
  def first_value_date
    self.data.sort.each do |datestring, value|
      return datestring unless value.nil?
    end
  end
        
  def trim(start_date = get_last_complete_december_datestring, end_date = Time.now.to_date.to_s)
    new_series_data = get_values_after_including(start_date, end_date)
    new_transformation("Trimmed #{name} starting at #{start_date}", new_series_data)
  end

  def get_last_complete_december_datestring
    last_date = self.data.keys.sort[-1]
    return last_date[5..6] == "12" ? last_date : "#{last_date[0..3].to_i-1}-12-01"
  end
  
  def get_last_incomplete_year
    last_date = self.data.keys.sort[-1]
    if last_date[5..6] == "12"
      new_series_data = {} 
      return new_transformation("No Data since no incomplete year", new_series_data)
    else
      start_date = "#{last_date[0..3].to_i-1}-12-01" 
      end_date = Time.now.to_date.to_s
      return trim(start_date, end_date)
    end
  end
  
  def get_values_after(startdatestring, enddatestring = Time.now.to_date.to_s)
    data.reject {|datestring, value| datestring <= startdatestring or value.nil? or datestring > enddatestring}
  end
  
  def get_values_after_including(startdatestring, enddatestring = Time.now.to_date.to_s)
    data.reject {|datestring, value| datestring < startdatestring or value.nil? or datestring > enddatestring}
  end
end