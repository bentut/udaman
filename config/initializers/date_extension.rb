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

  def month_s
    return strftime('%Y-%m-01')
  end
  
  def semi_s
    return "#{self.year}-01-01" if [1,2,3,4,5,6].include?(self.mon)
    return "#{self.year}-07-01" if [7,8,9,10,11,12].include?(self.mon)
  end
  
  def days_in_month
    Time.days_in_month(self.month, self.year)
  end
  
  def Date.last_7_days
    last_7 = []
    (0..6).each { |index| last_7[index] = (today - index).to_s }
    last_7.reverse
  end
  
  def Date.last_4_weeks
    last_sunday = today - today.cwday
    last_4 = []
    (0..3).each { |index| last_4[index] = (last_sunday - 7 * index).to_s }
    last_4.reverse
  end
  
  def Date.last_12_months
    last_12 = []
    (0..11).each { |index| last_12[index] = (today << index).month_s }
    last_12.reverse
  end
  
  def Date.last_10_years
    this_year = today.year
    last_10 = []
    (0..9).each { |index| last_10[index] = "#{this_year - index}-01-01" }
    last_10.reverse
  end
  
  def Date.last_10_decades
    this_decade = today.year / 10 * 10
    last_10 = []
    (0..9).each { |index| last_10[index] = "#{this_decade - index*10}-01-01" }
    last_10.reverse
  end
  
  def Date.compressed_date_range
    (last_7_days + last_4_weeks + last_12_months + last_10_years + last_10_decades).uniq.sort
  end
  
end

