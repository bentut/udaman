module SeriesArithmetic
  def round
    new_series_data = {}
    data.each do |date_string, value|
      new_series_data[date_string] = value.round.to_f
    end
    new_transformation("Rounded #{name}", new_series_data)
  end
  
  def perform_arithmetic_operation(operator,other_series)
    validate_arithmetic(other_series)
    longest_series = self.data.length > other_series.data.length ? self : other_series
    new_series_data = Hash.new
    longest_series.data.keys.each do |date_string|
      new_series_data[date_string] = (self.at(date_string).nil? or other_series.at(date_string).nil?) ? nil : self.at(date_string).send(operator,other_series.at(date_string))
      new_series_data[date_string] = nil if !new_series_data[date_string].nil? and (new_series_data[date_string].nan? or new_series_data[date_string].infinite?)
    end
    new_transformation("#{self.name} #{operator} #{other_series.name}",new_series_data)
  end

  def perform_constant_arithmetic_operation(operator,constant)
    new_series_data = Hash.new
    self.data.keys.each do |date_string|
      new_series_data[date_string] = self.at(date_string).nil? ? nil : self.at(date_string).send(operator,constant)
    end
    new_transformation("#{self.name} #{operator} #{constant}", new_series_data)
  end    
  
  def zero_add(other_series)
    validate_arithmetic(other_series)
    longest_series = self.data.length > other_series.data.length ? self : other_series
    new_series_data = Hash.new
    longest_series.data.keys.each do |date_string|
      elem1 = elem2 = 0
      elem1 = self.at(date_string).nil? ? 0 : self.at(date_string)
      elem2 = other_series.at(date_string).nil? ? 0 : other_series.at(date_string)
      new_series_data[date_string] = elem1 + elem2
    end
    new_transformation("#{self.name} zero_add #{other_series.name}",new_series_data)
  end
  
  def +(other_series)
    if other_series.class == Series
      validate_additive_arithmetic(other_series)
      new_series = perform_arithmetic_operation('+',other_series)
    else
      new_series = perform_constant_arithmetic_operation('+',other_series)
    end
    new_series.units = self.units
    return new_series
  end
  
  def -(other_series)
    if other_series.class == Series
      validate_additive_arithmetic(other_series)
      new_series = perform_arithmetic_operation('-',other_series)
    else
      new_series = perform_constant_arithmetic_operation('-',other_series)
    end    
    new_series.units = self.units
    return new_series
  end

  def **(other_series)
    #not definint units for now... will add if becomes an issue
    return perform_constant_arithmetic_operation('**',other_series) unless other_series.class == Series
    return perform_arithmetic_operation('**',other_series)
  end
  
  def *(other_series)
    #not definint units for now... will add if becomes an issue
    return perform_constant_arithmetic_operation('*',other_series) unless other_series.class == Series
    return perform_arithmetic_operation('*',other_series)
  end
  
  def /(other_series)
    #not definint units for now... will add if becomes an issue
    #also not converting the to float. Tests are passing, so looks ok. May need to change later
    return perform_constant_arithmetic_operation('/',other_series) unless other_series.class == Series
    return perform_arithmetic_operation('/',other_series)
  end

  #need to figure out the best way to validate these now... For now assume the right division
  
  def validate_additive_arithmetic(other_series)
    #raise SeriesArithmeticException if self.units != other_series.units
  end
  
  def validate_arithmetic(other_series)
    #puts "#{self.name}: #{self.frequency}, other - #{other_series.name}: #{other_series.frequency}"
    #raise SeriesArithmeticException if self.frequency.to_s != other_series.frequency.to_s
    #raise SeriesArithmeticException if self.frequency.nil? or other_series.frequency.nil?
  end
  
  def rebase(date_string)
    new_series_data = {}
    
    if frequency != "year" or frequency != :year
      annual_series = (self.name.split(".")[0]+".A").ts
      new_base = annual_series.at(date_string).to_f
    else
      new_base = self.at(date_string).to_f
    end
    data.sort.each do |date_string, value|
      new_series_data[date_string] = value / new_base * 100
    end
    new_transformation("Rebased #{name} to #{date_string}", new_series_data)
  end
  
  def percentage_change
    new_series_data = {}
    last = nil
    data.sort.each do |date_string, value|
      new_series_data[date_string] = (value-last)/last*100 unless last.nil?
      last = value
    end
    new_transformation("Percentage Change of #{name}", new_series_data)
  end
  
  def absolute_change
    new_series_data = {}
    last = nil
    data.sort.each do |date_string, value|
      new_series_data[date_string] = value - last unless last.nil?
      last = value
    end
    new_transformation("Absolute Change of #{name}", new_series_data)
  end

  def all_nil
    new_series_data = {}
    data.each do |date_string, value|
      new_series_data[date_string] = nil
    end
    new_transformation("All nil for dates in #{name}", new_series_data)
  end
  
  def yoy
    annualized_percentage_change
  end
  
  def annualized_percentage_change
    day_based_yoy
  end
  
  def old_annualized_percentage_change
    return all_nil unless ["day","week"].index(frequency).nil?
    new_series_data = {}
    last = {}
    data.sort.each do |date_string, value|
      month = Date.parse(date_string).month
      new_series_data[date_string] = (value-last[month])/last[month]*100 unless last[month].nil?
      last[Date.parse(date_string).month] = value
    end
    new_transformation("Annualized Percentage Change of #{name}", new_series_data)
  end
  
  #just going to leave out the 29th on leap years for now
  def day_based_yoy
    return all_nil unless ["week"].index(frequency).nil?
    new_series_data = {}
    data.sort.each do |date_string, value|
      date = Date.parse(date_string)
      last_year = date.year - 1
      last_year_date = last_year.to_s + date_string[4..10]
      new_series_data[date_string] = (value-data[last_year_date])/data[last_year_date]*100 unless data[last_year_date].nil?
    end
    new_transformation("Annualized Percentage Change of #{name}", new_series_data)
  end
  
  #should unify these a bit
  def mtd_sum
    return all_nil unless frequency == "day"
    new_series_data = {}
    mtd_sum = 0
    mtd_month = nil
    data.sort.each do |date_string, value|
      month = Date.parse(date_string).month
      if month == mtd_month
        mtd_sum += value
      else
        mtd_sum = value
        mtd_month = month
      end
      new_series_data[date_string] = mtd_sum
    end
    new_transformation("Month to Date sum of #{name}", new_series_data)    
  end
  
  def mtd
    mtd_sum.yoy
  end
  
  def ytd_sum
    return all_nil unless ["day", "week"].index(frequency).nil?
    new_series_data = {}
    ytd_sum = 0
    ytd_year = nil
    data.sort.each do |date_string, value|
      year = Date.parse(date_string).year
      if year == ytd_year
        ytd_sum += value
      else
        ytd_sum = value
        ytd_year = year
      end
      new_series_data[date_string] = ytd_sum
    end
    new_transformation("Year to Date sum of #{name}", new_series_data)
  end
  
  def ytd
    ytd_percentage_change
  end
  
  def ytd_percentage_change
    return all_nil unless ["day", "week"].index(frequency).nil?
    new_series_data = {}
    ytd_sum = 0
    ytd_year = nil
    data.sort.each do |date_string, value|
      year = Date.parse(date_string).year
      if year == ytd_year
        ytd_sum += value
      else
        ytd_sum = value
        ytd_year = year
      end
      new_series_data[date_string] = ytd_sum
    end
    new_transformation("Year to Date Percentage Change of #{name}", new_series_data).annualized_percentage_change
  end
  
  def yoy_diff
    annual_diff
  end
  
  def scaled_yoy_diff
    new_series_data = {}
    last = {}
    scaled_data.sort.each do |date_string, value|
      month = Date.parse(date_string).month
      new_series_data[date_string] = (value-last[month]) unless last[month].nil?
      last[Date.parse(date_string).month] = value
    end
    new_transformation("Scaled year over year diff of #{name}", new_series_data)
  end
  
  def annual_diff
    new_series_data = {}
    last = {}
    data.sort.each do |date_string, value|
      month = Date.parse(date_string).month
      new_series_data[date_string] = (value-last[month]) unless last[month].nil?
      last[Date.parse(date_string).month] = value
    end
    new_transformation("Year over year diff of #{name}", new_series_data)
  end
  
  def annual_sum
    #puts "#{self.name}: FREQUENCY: #{self.frequency} - #{self.frequency.class}"    
    #raise AnnualAverageException if self.frequency != :month and self.frequency != :quarter and self.frequency != "month" and self.frequency != "quarter"
    new_series_data = {}
    annual_values = aggregate_data_by :year, :sum
    self.data.each do |key, value|
      new_series_data[key] = annual_values["#{Date.parse(key).year}-01-01"]
    end
    new_transformation("Annual Sum of #{name}", new_series_data)
  end
  
  def annual_average
    #raise AnnualAverageException if self.frequency != :month and self.frequency != :quarter and self.frequency != "month" and self.frequency != "quarter"
    new_series_data = {}
    annual_values = aggregate_data_by :year, :average
    self.data.each do |key, value|
      new_series_data[key] = annual_values["#{Date.parse(key).year}-01-01"]
    end
    new_transformation("Annual Average of #{name}", new_series_data)
  end
end
