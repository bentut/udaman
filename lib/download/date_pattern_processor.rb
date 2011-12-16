def initialize(start_date, frequency, reverse)
  @start_date_string = start_date
  @frequency = frequency
  @reverse = reverse
end

#start_date_string must have been called previously for the reversing to work
def compute(index)
  index = index * (-1) if @reverse
  date_at_index(index).to_s
end

def date_at_index(index)
  first_date = @start_date_string.to_date
  return first_date >> (12*index) if @frequency == "A"
  return first_date >> (6*index) if @frequency == "S"
  return first_date >> (3*index) if @frequency == "Q"
  return first_date >> (index) if @frequency == "M"
  return first_date + (7*index) if @frequency == "W"
  return first_date + (index) if @frequency == "D"
  return week_date_at_index(index, first_date) if @frequency == "WD"
end

def week_date_at_index(index, first_date)
  #should be 5?
  weekends_between_dates = ((first_date.cwday + index - 1) / 5.0).truncate
  weekends_between_dates = ((((5-first_date.cwday)*-1) + index ) / 5.0).truncate if index < 0
  # puts "index #{index}"
  # puts "start day of week #{first_date.cwday}"
  # puts "weekends between dates #{weekends_between_dates}"
  first_date + index + (weekends_between_dates * 2)
end

#this behavior seems odd. Not sure why it needs to reverse
def compute_index_for_date(date_string)
  start        = @reverse ? date_string.to_date : @start_date_string.to_date
  finish       = @reverse ? @start_date_string.to_date : date_string.to_date
  start_month  = start.month + start.year*12
  finish_month = finish.month + finish.year*12

  return ((finish_month - start_month) / 12).to_i if frequency == "A"
  return ((finish_month - start_month) / 6).to_i if frequency == "S"
  return ((finish_month - start_month) / 3).to_i if frequency == "Q"
  return finish_month - start_month if frequency == "M"
  return ((finish - start).to_i / 7).to_i if frequency == "W"
  return (finish - start).to_i if frequency == "D"
  return weekday_index(finish, start) if frequency == "WD"
end

def weekday_index(finish, start)
  diff = (finish-start).to_i
  #adding start.cwday (day of week) extends the week as if that day was the monday of that week. so
  #that the division by 7 will always accurately count the number of weeks spanned by the diff
  weekends_passed = ((diff + (start.cwday - 1)) / 7).round
  diff - (2 * weekends_passed)
end