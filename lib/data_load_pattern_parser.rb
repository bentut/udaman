require 'roo'

class DataLoadPatternParser < Excel
  def initialize(pattern_spreadsheet, default_sheet = nil)
    super pattern_spreadsheet
    self.default_sheet = default_sheet unless default_sheet.nil?
  end
  
  def dates_array
    @dates_array ||= read_dates_array
  end
  
  def paths_array
    @paths_array ||= read_paths_array
  end
  
  def sheets_array
    @sheets_array ||= read_sheets_array
  end
  
  def rows_array
    @rows_array ||= read_rows_array
  end
  
  def cols_array
    @cols_array ||= read_cols_array
  end
  
  def read_string_array_from_col(col)
    array = []
    (3..self.last_row).each { |row| array.push(self.cell(row,col)) }
    array
  end

  def read_int_array_from_col(col)
    array = []
    (3..self.last_row).each { |row| array.push(self.cell(row,col).to_i) }
    array
  end
  
  def read_paths_array
    read_string_array_from_col 2
  end
  
  def read_sheets_array
    read_string_array_from_col 3
  end
  
  def read_rows_array
    read_int_array_from_col 4
  end
  
  def read_cols_array
    read_int_array_from_col 5
  end
  
  def map(date_string)
    index = dates_array.index(date_string) + 3
    {"path" => self.cell(index, 2), "sheet" => self.cell(index, 3), "row" => self.cell(index, 4).to_i, "col" => self.cell(index, 5).to_i}
  end
  
  def read_dates_array
    dates_array = []
    (3..self.last_row).each do |row|
      dates_array.push(Date.parse(self.cell(row,1).to_s).to_s)
    end
    dates_array
  end
  
  def get_first_date
    Date.parse(dates_array[0])
  end
  
  def pattern(map_element)
    array = paths_array if map_element == :paths
    array = sheets_array if map_element == :sheets
    array = rows_array if map_element == :rows
    array = cols_array if map_element == :cols
    return array[0].to_s if constant_pattern(array)
    results = increment_pattern(array)
    results = repeating_numbers_pattern(array) if results.nil?
    results = repeating_number_x_times_pattern(array) if results.nil?
    return results unless results.nil?
  end
  
  def increment_pattern(array)
    start = array[0]
    step = array[1] - array[0]
    count = array.count
    return "Pattern.increment(#{start}, #{step}, #{count})" if Pattern.increment(start, step, count).eql? array
    return nil
  end
  
  def repeating_numbers_pattern(array)
    first = array[0]
    last_pos = array.slice(1..-1).index(first)
    return nil if last_pos.nil?
    last = array[last_pos]
    count = array.count
    return "Pattern.repeating_numbers(#{first}, #{last}, #{count})" if Pattern.repeating_numbers(first, last, count).eql? array
    return nil
  end
  
  def repeating_number_x_times_pattern(array)
    first = array[0]
    first_change = find_first_change(array)
    step = first_change - first
    repeat = array.index(first_change)
    count = array.count
    return "Pattern.repeating_number_x_times(#{first}, #{step}, #{repeat}, #{count})" if Pattern.repeating_number_x_times(first, step, repeat, count).eql? array
  end
  
  def find_first_change(array)
    first = array[0]
    change = array.each do |elem|
      break elem if elem != first
    end
    return nil if change.class == Array
    return change
  end
  
  
  def constant_pattern(array)
    array.each { |elem| return false unless elem == array[0] }
    return true
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
  
  def dates_ok?
    first_date = Date.parse dates_array[0]
    frequency = date_frequency
    dates_array.each_index do |index|
      return false unless (Date.parse(dates_array[index]) == date_at_index(index, first_date, frequency))
    end
    return true
  end
  
end