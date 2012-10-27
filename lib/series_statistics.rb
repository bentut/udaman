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

    
end
