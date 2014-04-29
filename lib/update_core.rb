module UpdateCore
  def load_error?
    @load_error ||= false
  end
  
  def header_location
    @header_location ||= determine_header_location
  end
  
  def headers
    @headers ||= read_headers
  end
   # test that ordeer corresponds to col headings  
  def headers_with_frequency_code
    return self.headers.keys if self.headers.keys[0].split(".").count == 2
    return_array = Array.new
    frequency_code = ".A" if self.frequency == :year
    frequency_code = ".M" if self.frequency == :month
    frequency_code = ".Q" if self.frequency == :quarter
    frequency_code = ".S" if self.frequency == :semi
    frequency_code = ".W" if self.frequency == :week
    
    arr = self.headers.sort {|a,b| a[1]<=>b[1]}
    arr.each do |elem|
      header_name = elem[0]
      return_array.push(header_name+frequency_code) unless header_name.nil?
    end
    
    return_array
  end
  
  def frequency
    @frequency ||= date_frequency
  end
  
  def dates
    @dates ||= read_dates
  end
  
  def date_interval
    sorted_dates = self.dates.keys.sort
    date1 = Date.parse sorted_dates[0]
    date2 = Date.parse sorted_dates[1]
    (date2-date1).to_i
  end
  
  def date_frequency
    return :year if (365..366) === date_interval
    return :semi if (168..183) === date_interval
    return :quarter if (84..93) === date_interval
    return :month if (28..31) === date_interval
    return :week if date_interval == 7
  end
  
  def metadata_header(cell_data)
    metadata_headers =  ["LineCode","LineTitle","Industry Code","Industry","Definitions", "UNIT", "Year Month", "Value"]
    return false unless cell_data.class == String
    return true if metadata_headers.include?(cell_data)
  end

  def date_parse(cell_data)
    Date.parse cell_data.to_s
  end
  
  def cell_to_date(row,col)
    cell_data = cell(row,col)
    cell_data = Float cell_data rescue cell_data
    #puts "#{cell_data.class}: #{cell_data} row - #{row}"
    return nil if cell_data.nil? or metadata_header(cell_data)
    if cell_data.class == Float
      return Date.parse cell_data.to_s.split(".")[0]+"-01-01" if cell_data < 2100 and cell_data > 1900 and cell_data.to_s.split(".")[1] == 0
      return Date.parse cell_data.to_s[0..3]+"-"+cell_data.to_s[4..5]+"-01" if cell_data > 9999
      
      quarter_info = (cell_data - cell_data.to_i).round 1
      return Date.parse "Jan #{cell_data.to_i}" if quarter_info == 0 or quarter_info == 0.1
      return Date.parse "Apr #{cell_data.to_i}" if quarter_info == 0.2 
      return Date.parse "Jul #{cell_data.to_i}" if quarter_info == 0.3
      return Date.parse "Oct #{cell_data.to_i}" if quarter_info == 0.4
    end
    
    if cell_data.is_a? String and cell_data.match(/^S\d\d/) 
      semi_date = cell_data.split(" ")[0] == "S01" ? "-01-01" : "-07-01"
      return Date.parse cell_data.split(" ")[1] + semi_date
    end
    
    return date_parse cell_data
  end
  
  #this needs to be speced and tested      
  def convert_if_quarters(dates)
    quarter_dates = {}
    dates.each do |date,index|
      middle = date[5..6]
      return dates if middle.to_i > 4
      quarter_dates[date] = index if middle == "01"
      quarter_dates[date.gsub("-02-","-04-")] = index if middle == "02"
      quarter_dates[date.gsub("-03-","-07-")] = index if middle == "03"
      quarter_dates[date.gsub("-04-","-10-")] = index if middle == "04"
    end
    return quarter_dates
  end
  
  def nil_if_blank(value)
    if value.class == String and value.strip == ""
      return nil
    else
      return value
    end
  end
  def series(series_name)
    #puts "series name: " + series_name
    series_name = series_name.split(".")[0] if series_name.split(".").count > headers.keys[0].split(".").count
    series_hash = Hash.new
    
    if self.header_location == "columns"
      col = headers[series_name]
      dates.each do |date,row|
        series_hash[date] = nil_if_blank(self.cell(row,col))
      end
    end
    
    if self.header_location == "rows"
      row = headers[series_name]
      dates.each do |date,col|
        series_hash[date] = nil_if_blank(self.cell(row,col))
      end
    end
    
    return series_hash
  end
      
  def read_dates
    @dates = Hash.new

    if self.header_location == "columns"
      2.upto(self.last_row) do |row|
        # date_string = self.cell(row,1).to_s
        # date = Date.parse date_string
        date = self.cell_to_date(row,1)
        @dates[date.to_formatted_s] = row unless date.nil?
      end
    end

    if self.header_location == "rows"
      2.upto(self.last_column) do |col|
        date = self.cell_to_date(1,col)
        @dates[date.to_formatted_s] = col unless date.nil?
      end
    end
    @dates = convert_if_quarters @dates 
    return @dates
  end
    
  def read_headers
    @headers = Hash.new

    if self.header_location == "columns"
      2.upto(self.last_column) do |col|
        header_string = self.cell(1,col)
        @headers[header_string] = col unless header_string.nil? or header_string.nil? or header_string.is_a?(Numeric) or header_string["@"] != "@"
      end
    end
    
    if self.header_location == "rows"
      2.upto(self.last_row) do |row|
        header_string = self.cell(row,1)
        @headers[header_string] = row unless header_string.nil? or header_string.nil? or header_string.is_a?(Numeric) or header_string["@"] != "@"
      end
    end
    
    return @headers
  end
  
  def determine_header_location
    return "columns" if columns_have_series? 
    return "rows" if rows_have_series?
  end
  
  def update_formatted?
    # puts "columns have series: #{columns_have_series?}"
    # puts "rows have dates: #{rows_have_dates?}"
    # puts "rows have series: #{rows_have_series?}"
    # puts "columns have dates: #{columns_have_dates?}"
    return true if columns_have_series? and rows_have_dates?
    return true if columns_have_dates? and rows_have_series?
    return false
  end
  
  def columns_have_series?
    2.upto(self.last_column) do |col|
      header_string = self.cell(1,col)
      next if header_string == "Year Month" #applies to CSV only
      return false unless header_string.nil? or header_string.class != String or header_string["@"] == "@"
    end
    return true
  end
  
  def rows_have_series?
    2.upto(self.last_row) do |row|
      header_string = self.cell(row,1)
      return false unless header_string.nil? or header_string.class != String or header_string["@"] == "@"
    end
    return true
  end
  
  def rows_have_dates?
    2.upto(self.last_row) do |row|
      begin
        cell_to_date(row,1)
      rescue ArgumentError
        #puts "returning false for row #{row}"
        return false
      rescue TypeError
      end
    end
    return true
  end
  
  def columns_have_dates?
    2.upto(self.last_column) do |col|
      begin
        cell_to_date(1,col)
      rescue ArgumentError
        return false 
      rescue TypeError
      end
      
      return true
    end
  end
  
end