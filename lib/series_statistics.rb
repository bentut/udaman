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
      outlier_hash = {}
      moving_average = self.backward_looking_moving_average
      std_dev = moving_average.standard_deviation
      mult = 2.5
      self.data.each do |date_string, val|
        next if moving_average.data[date_string].nil?
        upper = moving_average.data[date_string] + mult * std_dev 
        lower = moving_average.data[date_string] - mult * std_dev
        outlier_hash[date_string] = val unless (lower..upper).include? val
      end
      outlier_hash
    rescue
      puts "--------error: #{self.name}---------"
      return {}
    end
  end
    
end
