def read_start_date_from_file(row_i,col_i)
  DataLoadPattern.retrieve(compute_path(nil), worksheet, row_i, col_i).to_s
end

#available to process patterns if that ever becomes an issue
#also normalize dates to month if specified start date and frequency is month (some of the rolling start dates don't use day 1)
#one potential issue is that reverse doesn't get set until this gets called.
def start_date_string
  @start_date ||= process_start_date_pattern
end

def process_start_date_pattern
  return start_date if start_date.index(":").nil?
  date_parts = start_date.split(":")
  self.update_attributes(:reverse => true) if date_parts[-1] == "rev"
  return read_start_date_from_file(date_parts[0][3..-1].to_i,date_parts[1][3..-1].to_i) if date_parts[0].starts_with("row")
  return date_parts[0]
end

#start_date_string must have been called previously for the reversing to work
def compute_date_string_for_index(index)
  start_date_string
  index = index * (-1) if self.reverse
  Pattern.date_at_index(index, start_date_string.to_date, frequency).to_s
end

def Pattern.pos_by_date_string(start_date_string, frequency, format, index)
  start_date = Date.parse(start_date_string)
  date_at_index(index, start_date, frequency).strftime(format)
end

def Pattern.date_at_index(index, first_date, frequency)
  return first_date >> (12*index) if frequency == "A"
  return first_date >> (6*index) if frequency == "S"
  return first_date >> (3*index) if frequency == "Q"
  return first_date >> (index) if frequency == "M"
  return first_date + (7*index) if frequency == "W"
  return first_date + (index) if frequency == "D"
  return Pattern.week_date_at_index(index, first_date) if frequency == "WD"
end

def Pattern.week_date_at_index(index, first_date)
  #should be 5?
  weekends_between_dates = ((first_date.cwday + index - 1) / 5.0).truncate
  weekends_between_dates = ((((5-first_date.cwday)*-1) + index ) / 5.0).truncate if index < 0
  # puts "index #{index}"
  # puts "start day of week #{first_date.cwday}"
  # puts "weekends between dates #{weekends_between_dates}"
  first_date + index + (weekends_between_dates * 2)
end

def date_interval
  date1 = Date.parse dates_array[0]
  date2 = Date.parse dates_array[1]
  (date2-date1).to_i
end

def date_frequency
  return "A" if (365..366) === date_interval
  return "S" if (168..183) === date_interval
  return "Q" if (84..93) === date_interval
  return "M" if (28..31) === date_interval
  return "W" if date_interval == 7
  return "D" if date_interval == 1
end

def date_at_index(index, first_date, frequency)
  return first_date >> (12*index) if frequency == "A"
  return first_date >> (6*index) if frequency == "S"
  return first_date >> (3*index) if frequency == "Q"
  return first_date >> (index) if frequency == "M"
  return first_date + (7*index) if frequency == "W"
  return first_date + (index) if frequency == "D"
end

#this behavior seems odd. Not sure why it needs to reverse
def compute_index_for_date(date_string)
  start_date_string
  start        = self.reverse ? date_string.to_date : start_date_string.to_date
  finish       = self.reverse ? start_date_string.to_date : date_string.to_date
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