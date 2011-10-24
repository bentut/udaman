class Pattern

  def Pattern.increment(start, step, count)
    array = []
    (0..count-1).each do |index|
      array.push(pos_by_increment(start,step,index))
    end
    array
  end
  
  def Pattern.pos_by_increment(start,step,index)
    start + (step * index)
  end

  def Pattern.repeating_numbers_with_step(first, last, step, count)
    array = []
    (0..count-1).each do |index|
      array.push(pos_by_repeating_numbers_with_step(first, last, step, index))
    end
    array
  end
  
  def Pattern.pos_by_repeating_numbers_with_step(first, last, step, index)
    range = (last-first)/step+1
    (index % range)*step + first
  end
  
  def Pattern.repeating_numbers(first, last, count)
    array = []
    (0..count-1).each do |index|
      array.push(pos_by_repeating_numbers(first, last, index))
    end
    array
  end

  def Pattern.pos_by_repeating_numbers(first, last, index)
    range = last-first+1
    (index % range) + first
  end
  
  def Pattern.repeating_number_x_times(start, step, repeat, count)
    array = []
    (0..count-1).each do |index|
      array.push(pos_by_repeating_number_x_times(start, step, repeat, index))
    end
    array
  end
  
  def Pattern.pos_by_repeating_number_x_times(start, step, repeat, index)
    start + (index/repeat).truncate
  end
  
  def Pattern.date_string(start_date_string, frequency, format, count)
    array = []
    (0..count-1).each do |index|
      array.push(pos_by_date_string(start_date_string, frequency, format, index))
    end
    array
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
    weekends_between_dates = ((first_date.cwday + index + 1) / 7).truncate
    weekends_between_dates = ((((5-first_date.cwday)*-1) + index ) / 5).truncate if index < 0
    puts "index #{index}"
    puts "start day of week #{first_date.cwday}"
    puts "weekends between dates #{weekends_between_dates}"
    first_date + index + (weekends_between_dates * 2)
  end
  
  
end

######## PATTERNS #######
# I:\data\rawdata\PICT.XLS row_start_9_12x_plus_1_col_1_to_12
# I:\data\rawdata\BLS_HIWI1990.XLS path_start_1990_12x_plus_1_name_sub_col_2_to_13
# I:\data\rawdata\Tour_mar11.XLS path_with_month_name_sub

# The three examples above have the following, individual field patterns
# path: increment and substitute month
# path: repeat year 12x and substitute year
# col: iterate through limited sequence of numbers (two use this one)
# row: repeat a number 12x and substitute year

  
# patterns it can recognize
# constant (STORE start value. All values are equal to the start value)
# basic_increment (STORE start value. STORE diff between steps. New value should always be exactly one STEP higher than previous value -- or index x step)
# repeating numbers (STORE array of first x values before a repeat. values after repeat should always track the array)
# repeated number x times (STORE start value, STORE diff between steps, STORE number of times number is repeated. (index / number of times repeated).truncate x step)
# date elements substituted into strings (STORE common prefix, STORE common suffix, STORE date pieces, STORE copy of strings, STORE date sub -- below)
  #check each date piece for a match at beginning of string
    #if found check for same date piece match in every string in the array
      #if gets to end, add to piece array. remove from strings. find a new common prefix. Add common prefix to same element of array as date formatted piece
  # (string = common prefix + all pieces of array[date format + suffix] + common suffix)
      

# I:\data\rawdata\Const_QSER_E.XLS row_start_37_plus_1
# I:\data\rawdata\Const_MEI_HON.XLS row_start_5_plus_1
# I:\data\rawdata\UIC.XLS row_start_7_plus_1
# I:\data\rawdata\Census_2009_1.XLS row_start_11_plus_1
# I:\data\rawdata\US_STKNS.CSV row_start_?_plus_?
# 
# I:\data\rawdata\BEA_SQ5N.CSV col_start_4_plus_1
# I:\data\rawdata\BEA_GSP.CSV col_start_7_plus_1
# I:\data\rawdata\JP_CPI.CSV col_start_6_plus_1
# I:\data\rawdata\CA_YP.CSV col_start_4_plus_1
# 
# I:\data\rawdata\Tax_jan11\01collec.XLS unknown
