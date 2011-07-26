class Date
  def quarter
    return "#{self.year}-Q1" if [1,2,3].include?(self.mon)
    return "#{self.year}-Q2" if [4,5,6].include?(self.mon)
    return "#{self.year}-Q3" if [7,8,9].include?(self.mon)
    return "#{self.year}-Q4" if [10,11,12].include?(self.mon)
  end
  
  def quarter_i
    return "#{self.year}01".to_i if [1,2,3].include?(self.mon)
    return "#{self.year}02".to_i if [4,5,6].include?(self.mon)
    return "#{self.year}03".to_i if [7,8,9].include?(self.mon)
    return "#{self.year}04".to_i if [10,11,12].include?(self.mon)
  end
  
  def quarter_s
    return "#{self.year}-01-01" if [1,2,3].include?(self.mon)
    return "#{self.year}-04-01" if [4,5,6].include?(self.mon)
    return "#{self.year}-07-01" if [7,8,9].include?(self.mon)
    return "#{self.year}-10-01" if [10,11,12].include?(self.mon)
  end
  
  def year_s
    return year.to_s+"-01-01"
  end
  
  def month_i
    return strftime('%Y%m').to_i
  end
  
  def semi_s
    return "#{self.year}-01-01" if [1,2,3,4,5,6].include?(self.mon)
    return "#{self.year}-07-01" if [7,8,9,10,11,12].include?(self.mon)
  end
end

