#require 'fastercsv'
class UpdateCSV 
  include UpdateCore
  def initialize(update_spreadsheet_name)
    begin
      @data = CSV.read(update_spreadsheet_name)
    rescue
      @load_error = true
    end
  end
  
  def cell (row, col)
    Float(@data[row-1][col-1]) rescue @data[row-1][col-1]
  end
  
  def last_column
    @data[0].count
  end
  
  def last_row
    @data.count
  end
  
  
  def rows_have_dates?
    return true
  end
  
  def columns_have_dates?
    return false
  end
  
  def read_dates
    @dates = Hash.new

    if self.header_location == "columns"
      date_col = cell(1,2) == "Year Month" ? 2 : 1
      2.upto(self.last_row) do |row|
        date = self.cell_to_date(row,date_col)
        @dates[date.to_formatted_s] = row unless date.nil?
      end
    end
    
    return @dates
  end
  
  def date_parse(cell_data)
    Date.parse cell_data.to_s.split(" ").join("/")
  end
end