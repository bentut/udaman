class AggregatingArray < Array
  def sum
    returnvalue = 0
    self.each do |value|
      returnvalue += value
    end
    returnvalue
  end
  def average
     return self.sum / self.count.to_f
  end  
end

