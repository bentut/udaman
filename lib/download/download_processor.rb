require 'iconv'
require 'roo'
require 'csv'

# Error handling in download processor calls
# --------------------------------------------
# line level calls should always raise descriptive errors. 
# Errors can be rescued by Packager or Front End
# as necessary

class DownloadProcessor
  def initialize(handle, options, cached_files = nil)
    raise "File type must be specified when initializing a Download Processor" if options[:file_type].nil?
    raise "File path must be specified when initializing a manual Download Processor" if handle == "manual" and options[:path].nil?
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    @handle = handle
    @options = options
    @file_type = options[:file_type]
    raise "not a valid file type option" if ["txt", "csv", "xls", "xlsx"].index(@file_type).nil?
    @spreadsheet = CsvFileProcessor.new(handle, options, parse_date_options, @cached_files) if @file_type == "csv" and validate_csv
    @spreadsheet = XlsFileProcessor.new(handle, options, parse_date_options, @cached_files) if (@file_type == "xls" or @file_type == "xlsx") and validate_xls
  end

  def get_data
    return TextFileProcessor.new(@handle,@options, @cached_files).get_data if @file_type == "txt" #and validate_text
    return get_data_spreadsheet
  end

  def get_data_spreadsheet
    raise "spreadhseet was never set" if @spreadsheet.nil?
    index = 0
    data = {}
    begin
      data_point = @spreadsheet.observation_at index 
      data.merge!(data_point) if data_point.class == Hash
      index += 1
    end until data_point.class == String or (!@options[:end_date].nil? and data_point.keys[0] == @options[:end_date])
    data
  end

  # these two processes are a little weird because they require the handle and other parts of the 
  # pattern that the date processor itself would not generally need. might not be the best object
  # design...
  def parse_date_options
    date_info = {}
    date_info[:start] = @options[:start_date] unless @options[:start_date].nil?
    date_info[:start] = read_date_from_file(@options[:start_row], @options[:start_col]) if @options[:start_date].nil?
    date_info[:start] = adjust_for_frequency(date_info[:start])
    date_info[:rev] = @options[:rev] == true ? true : false
    date_info
  end

  def adjust_for_frequency(date_string)
    date_parts = date_string.split("-")
    #need cases for annual and quarterly too. For now just doing monthly
    #this should be written in as tests
    return "#{date_parts[0]}-#{date_parts[1]}-01" if @options[:frequency] == "M"
    return date_string
  end
  
  def read_date_from_file(start_row, start_col)
    #assumption is that these will not be files with dates to process. just static file and sheet strings
    #assuming that date is a recognizable format to ruby
    puts @cached_files.csv(@handle)[start_row-1][start_col-1].to_s + "is csv" if @file_type == "csv"
    date_cell = @cached_files.csv(@handle)[start_row-1][start_col-1] if @file_type == "csv"
    date_cell = @cached_files.xls(@handle, @options[:sheet]).cell(start_row, start_col) if @file_type == "xls"
    return date_cell.to_s if date_cell.class == Date
    return Date.new(date_cell.split(".")[0].to_i, date_cell.split(".")[1].to_i,1).to_s if date_cell.class == String and !date_cell.index(".").nil?
    return Date.new(date_cell.to_s.split(".")[0].to_i, date_cell.to_s.split(".")[1].to_i,1).to_s if date_cell.class == Float
    return Date.parse(date_cell).to_s
  end
  
  def validate_csv
    return true unless !date_ok or @options[:row].nil? or @options[:col].nil? or @options[:frequency].nil?
    error_string = ""
    error_string += "start date information, " if !date_ok
    error_string += "row specification, " if @options[:row].nil?
    error_string += "column specification, " if @options[:col].nil?
    error_string += "frequency specification, " if @options[:frequency].nil?
    raise "incomplete Download Processor specification because the following information is missing: " + error_string.chop.chop
  end
  
  def date_ok
    return false if @options[:start_date].nil? and (@options[:start_row].nil? or @options[:start_col].nil?)
    return true
  end
  
  def validate_xls
    return true unless !date_ok or @options[:row].nil? or @options[:col].nil? or @options[:sheet].nil? or @options[:frequency].nil?
    error_string = ""
    error_string += "start date information, " if !date_ok
    error_string += "row specification, " if @options[:row].nil?
    error_string += "column specification, " if @options[:col].nil?
    error_string += "sheet specification, " if @options[:sheet].nil?
    error_string += "frequency specification, " if @options[:frequency].nil?
    raise "incomplete Download Processor specification because the following information is missing: " + error_string.chop.chop
  end
end


