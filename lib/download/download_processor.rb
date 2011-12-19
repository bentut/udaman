require 'roo'
require 'csv'

def initialize(handle, options, cached_files = nil)
  @cached_files = CachedFiles.new if cached_files.nil?
  @handle = handle
  @options = options
  @file_type == options["file_type"]
  
  @spreadsheet = CsvFileProcessor.new handle, options, parse_date_options, cached_files if @file_type == "csv"
  @spreadsheet = XlsFileProcessor.new handle, options, parse_date_options, cached_files if @file_type == "xls"  
end

def get_data
  return TextFileProcessor.new(@handle,@options, @cached_files).get_data if @file_type == "text"
  return get_data_spreadsheet
end

def get_data_spreadsheet
  index = 0
  data = {}
  begin
    data_point = @spreadsheet.observation_at index 
    data.merge!(data_point) if data_point.class == Hash
    index += 1
  end until data_point.class == String
  data
end

# these two processes are a little weird because they require the handle and other parts of the 
# pattern that the date processor itself would not generally need. might not be the best object
# design...
def parse_date_options
  date_info = {}
  date_info["start"] = @options["start_date"] unless @options["start_date"].nil?
  date_info["start"] = read_date_from_file(@options["start_row"], @options["start_col"]) if @options["start_date"].nil?
  date_info["rev"] = @options["reverse_dates"] == true ? true : false
end

def read_date_from_file(start_row, start_col)
  #assumption is that these will not be files with dates to process. just static file and sheet strings
  spreadsheet_2d_array = @cached_files.csv(@handle) if @file_type == "csv"
  spreadsheet_2d_array = @cached_files.xls(@handle, @options["sheet"]) if @file_type == "xls"
  spreadsheet_2d_array[start_row, start_col].to_s #assuming that date is a recognizable format to ruby
end



