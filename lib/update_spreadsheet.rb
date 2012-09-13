require 'iconv'
require 'roo'

class UpdateSpreadsheet < Excel
  include UpdateCore
  
  def UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
    name = update_spreadsheet_name.strip
    return UpdateCSV.new name if name[-3..-1] == "csv"
    return UpdateSpreadsheet.new name
  end
  
  def initialize(update_spreadsheet_name)
    begin
      super update_spreadsheet_name 
    rescue => e
      puts e.message
      @load_error = true
    end
  end  
end