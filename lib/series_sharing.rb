module SeriesSharing
  def moving_average_for_sa(start_date_string = self.data.keys.sort[0])
    self.moving_average(start_date_string,"#{(Time.now.to_date << 12).year}-12-01")
  end
  
  def moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    #trimmed_data.sort.each {|date, value| puts "#{date}: #{value}" }
    new_series_data = {}
    last_thirteen = []
    dates = trimmed_data.keys.sort
    position = 0
    trimmed_data.sort.each do |date_string, value|
      position += 1 if value.nil? #have to advance position even if loop is skipped. Need to write test for this
      next if value.nil?
      last_thirteen.shift if last_thirteen.length == 13
      last_thirteen.push value
      if last_thirteen.length == 13
        sum = 0
        sum_with_half_ends = 0
        lt_pos = 0
        last_thirteen.each do |lt_value|
          sum += lt_value
          if (lt_pos == 0 or lt_pos == 12)
            sum_with_half_ends += (lt_value/2.0)
          else
            sum_with_half_ends += lt_value
          end
          lt_pos += 1
        end
        new_series_data[dates[position]] = (sum - last_thirteen[0]) / 12.0 #gets overwritten except for last 6
        new_series_data[dates[position-12]] = (sum - last_thirteen[12]) / 12.0 if new_series_data[dates[position-12]].nil? #writes first 6 values
        new_series_data[dates[position-6]] = sum_with_half_ends / 12.0 #generalized moving average
        #puts "#{dates[position]} = #{(sum - last_thirteen[0]) / 12.0} ::" + "#{dates[position-12]} = #{(sum - last_thirteen[12]) / 12.0} ::" + "#{dates[position-6]} = #{(sum - last_thirteen[0]) / 12.0} ::"
      end
      position += 1
    end
    new_transformation("Moving Average of #{name}", new_series_data)
  end
  
  def moving_average_offset_early(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    #trimmed_data.sort.each {|date, value| puts "#{date}: #{value}" }
    new_series_data = {}
    last_thirteen = []
    dates = trimmed_data.keys.sort
    position = 0
    trimmed_data.sort.each do |date_string, value|
      position += 1 if value.nil? #have to advance position even if loop is skipped. Need to write test for this
      next if value.nil?
      last_thirteen.shift if last_thirteen.length == 13
      last_thirteen.push value
      if last_thirteen.length == 13
        sum = 0
        sum_with_half_ends = 0
        lt_pos = 0
        last_thirteen.each do |lt_value|
          sum += lt_value
          if (lt_pos == 0 or lt_pos == 12)
            sum_with_half_ends += (lt_value/2.0)
          else
            sum_with_half_ends += lt_value
          end
          lt_pos += 1
        end
        new_series_data[dates[position]] = (sum - last_thirteen[0]) / 12.0 #gets overwritten except for last 6
        new_series_data[dates[position-13]] = (sum - last_thirteen[12]) / 12.0 if new_series_data[dates[position-13]].nil? #writes first 6 values
        new_series_data[dates[position-6]] = sum_with_half_ends / 12.0 #generalized moving average
        #puts "#{dates[position]} = #{(sum - last_thirteen[0]) / 12.0} ::" + "#{dates[position-12]} = #{(sum - last_thirteen[12]) / 12.0} ::" + "#{dates[position-6]} = #{(sum - last_thirteen[0]) / 12.0} ::"
      end
      position += 1
    end
    new_transformation("Moving Average of #{name}", new_series_data)
  end
  
  def backward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    #puts trimmed_data
    new_series_data = {}
    last_twelve = AggregatingArray.new
    dates = trimmed_data.keys.sort
    position = 0
    trimmed_data.sort.each do |date_string, value|
      position += 1 if value.nil?
      next if value.nil?
      last_twelve.shift if last_twelve.length == 12
      last_twelve.push value 
      if last_twelve.length == 12 
        new_series_data[dates[position]] = last_twelve.sum / 12.to_f
        #puts "#{dates[position]}: #{last_twelve.sum / 12.to_f}"
      end
      position += 1
    end

    new_transformation("Backward Looking Moving Average of #{name}", new_series_data)
  end
  
  def forward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    #puts trimmed_data
    new_series_data = {}
    last_twelve = AggregatingArray.new
    dates = trimmed_data.keys.sort
    position = 0
    trimmed_data.sort.each do |date_string, value|
      position += 1 if value.nil?
      next if value.nil?
      last_twelve.shift if last_twelve.length == 12
      last_twelve.push value 
      if last_twelve.length == 12 
        new_series_data[dates[position-11]] = last_twelve.sum / 12.to_f
        #puts "#{dates[position-11]}: #{last_twelve.sum / 12.to_f}"
      end
      position += 1
    end

    new_transformation("Forward Looking Moving Average of #{name}", new_series_data)
  end
  
  def offset_forward_looking_moving_average(start_date_string = self.data.keys.sort[0], end_date_string = Time.now.to_date.to_s)
    trimmed_data = get_values_after((Date.parse(start_date_string) << 1).to_s, end_date_string)
    #puts trimmed_data
    new_series_data = {}
    last_twelve = AggregatingArray.new
    dates = trimmed_data.keys.sort
    position = 0
    trimmed_data.sort.each do |date_string, value|
      position += 1 if value.nil?
      next if value.nil?
      last_twelve.shift if last_twelve.length == 12
      last_twelve.push value 
      if last_twelve.length == 12 
        new_series_data[dates[position-12]] = last_twelve.sum / 12.to_f if position-12 >= 0
        #puts "#{dates[position-12]}: #{last_twelve.sum / 12.to_f}"
      end
      position += 1
    end

    new_transformation("Offset Forward Looking Moving Average of #{name}", new_series_data)
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
    start_date = "#{series_prefix}NS@#{county_abbrev}.M".ts.first_value_date
    end_date = "#{series_prefix}NS@#{county_abbrev}.M".ts.get_last_complete_december_datestring     
    historical = "#{series_prefix}NS@#{county_abbrev}.M".ts.moving_average_offset_early(start_date,end_date) /  "#{series_prefix}NS@HI.M".ts.moving_average_offset_early(start_date,end_date) * self
    mean_corrected_historical = historical / historical.annual_sum * "#{series_prefix}NS@#{county_abbrev}.M".ts.annual_sum
    current_year = "#{series_prefix}NS@#{county_abbrev}.M".ts.backward_looking_moving_average.get_last_incomplete_year / "#{series_prefix}NS@HI.M".ts.backward_looking_moving_average.get_last_incomplete_year * self
    new_transformation("Share of #{name} using ratio of #{series_prefix}NS@#{county_abbrev}.M over #{series_prefix}NS@HI.M using a mean corrected moving average (offset early) and a backward looking moving average for the current year",
      mean_corrected_historical.data.series_merge(current_year.data))
  end
  
  def share_using(ratio_top, ratio_bottom)
    new_series = ratio_top / ratio_bottom * self
    new_transformation("Share of #{name} using ratio of #{ratio_top.name} over #{ratio_bottom.name}", new_series.data)
  end
end