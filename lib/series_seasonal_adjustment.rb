module SeriesSeasonalAdjustment
  #may need to spec a test for this in terms of adding the correct source
  def apply_seasonal_adjustment(factor_application)
    ns_series_name = name.sub("@","NS@")
    ns_series = Series.get ns_series_name
    raise SeasonalAdjustmentException.new if ns_series.nil?
    set_factors factor_application 
    new_ns_values = ns_series.get_values_after last_demetra_datestring
    adjusted_data = {}
    new_ns_values.each do |datestring, value|
      factor_month = Date.parse(datestring).month
      adjusted_data[datestring] = value - factors[factor_month.to_s] if factor_application == :additive
      adjusted_data[datestring] = value / factors[factor_month.to_s] if factor_application == :multiplicative
    end
    #still valuable to run as the current series because it sets the seasonal factors
    new_transformation("Applied #{factor_application} Seasonal Adjustment against #{ns_series_name}", adjusted_data)  
  end
  
  def apply_ns_growth_rate_sa
    ns_series_name = name.sub("@","NS@")
    ns_series = Series.get ns_series_name
    new_data = (self.shift_forward_years(1) + self.shift_forward_years(1) * ((ns_series_name.ts.annualized_percentage_change)/100)).trim.data 
    new_transformation("Applied Growth Rate Based Seasonal Adjustment against #{ns_series_name}", new_data)  
  end
  
  def set_factors(factor_application)
    self.factor_application = factor_application
    #should throw in some exception handling if this happens for a non sa series
    ns_series = get_ns_series
    self.factors ||= {}
    
    self.last_demetra_datestring = (self.frequency == "quarter" or self.frequency == "Q") ? self.get_last_complete_4th_quarter_datestring : self.get_last_complete_december_datestring
    last_demetra_date = Date.parse self.last_demetra_datestring
    factor_comparison_start_date = last_demetra_date << 12
    last_year_of_sa_values = get_values_after(factor_comparison_start_date.to_s, self.last_demetra_datestring)
    last_year_of_sa_values.sort.each do |datestring,sa_value|
      ns_value = ns_series.at(datestring)
      #puts "#{datestring} - ns:#{ns_value} sa:#{sa_value}"
      #think can just use months for both months and quarters to keep things simple
      factor_month = Date.parse(datestring).month
      self.factors[factor_month.to_s] = ns_value - sa_value if factor_application == :additive
      self.factors[factor_month.to_s] = ns_value / sa_value if factor_application == :multiplicative
    end
    self.save
  end
end
