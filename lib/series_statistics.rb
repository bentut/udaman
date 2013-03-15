module SeriesStatistics

  def sum
    num_array = (self.data.sort.reject{|a| a[1].nil?}).map { |a| a[1]}
    return num_array.inject(0, :+){ | sum, x | sum + x }
  end
  
  def average
    return sum / self.observation_count
  end 

  def variance
    # m = self.mean
    num_array = self.data.sort.map { |a| a[1]}
    sum_var = num_array.inject(0){ | sum, x | sum + (x - average) ** 2 }
    return sum_var / (self.observation_count - 1 )
  end
  
  def standard_deviation
    return Math.sqrt(self.variance)
  end

  def outlier
    begin
      return {} if self.data.count == 0
      a_residuals = self.average_residuals
      ma_residuals_sigma = self.standard_deviation_residuals
      actual_residual = self.residuals
      outlier_hash = {}
      a_residuals.each do |date_string, residual|
        std_dev = ma_residuals_sigma
        upper_limit = (2.5 * std_dev) + residual
        lower_limit = residual - (2.5 * std_dev) 
        outlier_hash[date_string] = self.data[date_string] if actual_residual[date_string] > upper_limit or actual_residual[date_string] < lower_limit
      end
      return outlier_hash
    rescue
      puts "--------error: #{self.name}---------"
      return {}
    end
  end
  
  def residuals
    moving_average_data = self.backward_looking_moving_average.data
    start_date_string = self.data.keys.sort[3] if self.frequency == "quarter" or self.frequency == "year" 
    start_date_string = self.data.keys.sort[11] if self.frequency == "month"
    end_date_string = self.data.keys.sort[-1]
    residual_data = {}
    trimmed_data = self.get_values_after_including(start_date_string, end_date_string)
    residual_data = trimmed_data.merge(moving_average_data) { |date_string, value, value2| value - value2 } 
    return residual_data
  end     
     
  def average_residuals
    residual_data = self.residuals
    num_array = residual_data.sort.map { |a| a[1]}
    sum = num_array.inject(0, :+){ | sum, x | sum + x }
    average_residual_data = {}
    average_calc = sum / num_array.count
    keys = self.backward_looking_moving_average.data.keys
    number = keys.count
    n = [average_calc] * number
    final_array = keys.zip(n).flatten.compact
    average_residual_data = Hash[*final_array]
    return average_residual_data
  end
  
  def standard_deviation_residuals
    residual_data = self.residuals
    num_array = residual_data.sort.map { |a| a[1]}
    sum = num_array.inject(0, :+){ | sum, x | sum + x }
    average = sum / num_array.count
    sum_var = num_array.inject(0){ | sum, x | sum + (x - average) ** 2 }
    var = sum_var / (residual_data.count - 1 )
    std_deviation = Math.sqrt(var)
  end
    
end
