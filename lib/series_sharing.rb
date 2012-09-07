module SeriesSharing
  def moving_average_for_sa(start_date_string = self.data.keys.sort[0])
    self.moving_average(start_date_string,"#{(Time.now.to_date << 12).year}-12-01")
  end
  
  def ma_series_data(ma_type_string = "ma", start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    new_series_data = {}
    position = 0
    trimmed_data.sort.each do |date_string, value|
      periods = window_size
      start_pos = window_start(position, trimmed_data.length-1, periods, ma_type_string)
      end_pos = window_end(position, trimmed_data.length-1, periods, ma_type_string)
      new_series_data[date_string] = moving_window_average(start_pos, end_pos, periods, trimmed_data) unless start_pos.nil? or end_pos.nil?
      position += 1
    end
    new_series_data
    #new_transformation("Moving Average of #{name}", new_series_data)
  end
  
  def ma_series(ma_type_string = "ma", start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation "Moving Average of #{name}", ma_series_data(ma_type_string, start_date_string, end_date_string)
  end
  
  
  def window_size
    return 12 if self.frequency == "month"
    return 4 if self.frequency == "quarter"
  end
  
  
  def window_start(position, last, periods, ma_type_string)
    half_window = periods / 2
    return position                 if ma_type_string == "ma" and position < half_window #forward looking moving average
    return position - half_window   if ma_type_string == "ma" and position >= half_window and position <= last - half_window #centered moving average
    return position - periods + 1   if ma_type_string == "ma" and position > last - half_window #backward looking moving average
    return position                 if ma_type_string == "forward_ma" #forward looking moving average
    return position - periods + 1   if ma_type_string == "backward_ma" and position - periods + 1 >= 0 #backward looking moving average
    return position + 1             if ma_type_string == "offset_forward_ma" #offset forward looking moving average
    return position + 1             if ma_type_string == "offset_ma" and position < half_window #offset forward looking moving average
    return position - half_window   if ma_type_string == "offset_ma" and position >= half_window and position <= last - half_window #centered moving average
    return position - periods + 1   if ma_type_string == "offset_ma" and position > last - half_window #backward looking moving average
    
  end
  
  def window_end(position, last, periods, ma_type_string)
    half_window = periods / 2
    return position + periods - 1   if ma_type_string == "ma" and position < half_window #forward looking moving average
    return position + half_window   if ma_type_string == "ma" and position >= half_window and position <= last - half_window #centered moving average
    return position                 if ma_type_string == "ma" and position > last-half_window #backward looking moving average
    return position + periods - 1   if ma_type_string == "forward_ma" and position + periods - 1 <= last #forward looking moving average
    return position                 if ma_type_string == "backward_ma" #backward looking moving average
    return position + periods       if ma_type_string == "offset_forward_ma" and position + periods <= last #offset forward looking moving average
    return position + periods       if ma_type_string == "offset_ma" and position < half_window and position + periods <= last #offset forward looking moving average
    return position + half_window   if ma_type_string == "offset_ma" and position >= half_window and position <= last - half_window #centered moving average
    return position                 if ma_type_string == "offset_ma" and position > last-half_window #backward looking moving average
  end
  
  def moving_window_average(start_pos, end_pos, periods, trimmed_data)
    #puts "#{start_pos}, #{end_pos}, #{trimmed_data.length}"
    sorted_data = trimmed_data.sort
    sum = 0
    (start_pos..end_pos).each do |i|
      val = ( ( i == start_pos or i == end_pos ) and ( end_pos - start_pos ) == periods ) ? sorted_data[i][1] / 2.0 : sorted_data[i][1]
      sum += val
    end
    sum / periods.to_f
  end
  
  def moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation("Moving Average of #{name}", ma_series_data("ma", start_date_string, end_date_string))
  end
  
  def moving_average_offset_early(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation("Moving Average of #{name}", ma_series_data("offset_ma", start_date_string, end_date_string))
  end
  
  def backward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation("Backward Looking Moving Average of #{name}", ma_series_data("backward_ma", start_date_string, end_date_string))
  end
  
  def forward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation("Forward Looking Moving Average of #{name}", ma_series_data("forward_ma", start_date_string, end_date_string))
  end
  
  def offset_forward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    new_transformation("Offset Forward Looking Moving Average of #{name}", ma_series_data("offset_forward_ma", start_date_string, end_date_string))
  end
  
  
  def aa_county_share_for(county_abbrev)
    series_prefix = self.name.split("@")[0]
    county_sum = "#{series_prefix}NS@HON.M".ts + "#{series_prefix}NS@HAW.M".ts + "#{series_prefix}NS@MAU.M".ts + "#{series_prefix}NS@KAU.M".ts
    historical = "#{series_prefix}NS@#{county_abbrev}.M".ts.annual_average / county_sum.annual_average * self
    current_year = "#{series_prefix}NS@#{county_abbrev}.M".ts.backward_looking_moving_average.get_last_incomplete_year / county_sum.backward_looking_moving_average.get_last_incomplete_year * self
    new_transformation("Share of #{name} using ratio of #{series_prefix}NS@#{county_abbrev}.M over sum of #{series_prefix}NS@HON.M , #{series_prefix}NS@HAW.M , #{series_prefix}NS@MAU.M , #{series_prefix}NS@KAU.M using annual averages where available and a backward looking moving average for the current year",
      historical.data.series_merge(current_year.data))
  end
  
  def aa_state_based_county_share_for(county_abbrev)
    series_prefix = self.name.split("@")[0]
    county_sum = "#{series_prefix}NS@HON.M".ts + "#{series_prefix}NS@HAW.M".ts + "#{series_prefix}NS@MAU.M".ts + "#{series_prefix}NS@KAU.M".ts
#    county_sum.print
    state = "#{series_prefix}NS@HI.M".ts 
#    state.print
    historical = "#{series_prefix}NS@#{county_abbrev}.M".ts.annual_average / state.annual_average * self
    current_year = "#{series_prefix}NS@#{county_abbrev}.M".ts.backward_looking_moving_average.get_last_incomplete_year / state.backward_looking_moving_average.get_last_incomplete_year * self
    new_transformation("Share of #{name} using ratio of #{series_prefix}NS@#{county_abbrev}.M over #{series_prefix}NS@HI.M , using annual averages where available and a backward looking moving average for the current year",
    historical.data.series_merge(current_year.data))
  end

  def mc_ma_county_share_for(county_abbrev, series_prefix = self.name.split("@")[0])
    #series_prefix = self.name.split("@")[0]
    f = self.name.split(".")[1]
    start_date = "#{series_prefix}NS@#{county_abbrev}.#{f}".ts.first_value_date
    end_date = "#{series_prefix}NS@#{county_abbrev}.#{f}".ts.get_last_complete_december_datestring     
    historical = "#{series_prefix}NS@#{county_abbrev}.#{f}".ts.moving_average_offset_early(start_date,end_date) /  "#{series_prefix}NS@HI.#{f}".ts.moving_average_offset_early(start_date,end_date) * self
    historical.print
    mean_corrected_historical = historical / historical.annual_sum * "#{series_prefix}NS@#{county_abbrev}.#{f}".ts.annual_sum
    mean_corrected_historical.print
    current_year = "#{series_prefix}NS@#{county_abbrev}.#{f}".ts.backward_looking_moving_average.get_last_incomplete_year / "#{series_prefix}NS@HI.#{f}".ts.backward_looking_moving_average.get_last_incomplete_year * self
    new_transformation("Share of #{name} using ratio of #{series_prefix}NS@#{county_abbrev}.#{f} over #{series_prefix}NS@HI.#{f} using a mean corrected moving average (offset early) and a backward looking moving average for the current year",
        mean_corrected_historical.data.series_merge(current_year.data))
  end
  
  def mc_price_share_for(county_abbrev)
    series_prefix = self.name.split("@")[0]
    self_region = self.name.split("@")[1].split(".")[0]
    start_date = "#{series_prefix}NS@#{county_abbrev}.Q".ts.first_value_date
    shared_series = "#{name}".ts.share_using("#{series_prefix}NS@#{county_abbrev}.Q".ts.trim(start_date,get_last_complete_4th_quarter_datestring).moving_average, "#{series_prefix}NS@#{self_region}.Q".ts.trim(start_date,get_last_complete_4th_quarter_datestring).moving_average)
    mean_corrected_series = shared_series.share_using("#{series_prefix}NS@#{county_abbrev}.Q".ts.annual_average, shared_series.annual_average)
    current_year = "#{series_prefix}NS@#{county_abbrev}.Q".ts.backward_looking_moving_average.get_last_incomplete_year / "#{series_prefix}NS@#{self_region}.Q".ts.backward_looking_moving_average.get_last_incomplete_year * self
    
    new_transformation("Share of #{name} using ratio of the moving average #{series_prefix}NS@#{county_abbrev}.Q over the moving average of #{series_prefix}NS@#{self_region}.Q , mean corrected for the year",
        mean_corrected_series.data.series_merge(current_year.data))
  end
  
  # def mc_offset_price_share_for(county_abbrev)
  #   series_prefix = self.name.split("@")[0]
  #   self_region = self.name.split("@")[1].split(".")[0]
  #   start_date = "#{series_prefix}NS@#{county_abbrev}.Q".ts.first_value_date
  #   shared_series = "#{name}".ts.share_using("#{series_prefix}NS@#{county_abbrev}.Q".ts.moving_average_offset_early, "#{series_prefix}NS@#{self_region}.Q".ts.trim(start_date).moving_average_offset_early)
  #   mean_corrected_series = shared_series.share_using("#{series_prefix}NS@#{county_abbrev}.Q".ts.annual_average, shared_series.annual_average)
  #   new_transformation("Share of #{name} using ratio of the moving average #{series_prefix}NS@#{county_abbrev}.Q over the moving average of #{series_prefix}NS@#{self_region}.Q , mean corrected for the year",
  #       mean_corrected_series.data)
  # end
  
  def share_using(ratio_top, ratio_bottom)
    new_series = ratio_top / ratio_bottom * self
    new_transformation("Share of #{name} using ratio of #{ratio_top.name} over #{ratio_bottom.name}", new_series.data)
  end
end