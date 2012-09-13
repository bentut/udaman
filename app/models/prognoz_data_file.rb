class PrognozDataFile < ActiveRecord::Base
  serialize :series_loaded, Hash
  
  def load
    @output_spreadsheet = UpdateSpreadsheet.new filename
    return {:notice=>"problem loading spreadsheet", :headers=>[]} if @output_spreadsheet.load_error?    
    @output_spreadsheet.default_sheet = @output_spreadsheet.sheets.first

    self.frequency = @output_spreadsheet.frequency
    self.output_start_date = @output_spreadsheet.dates.keys.sort[0]
    # self.series_loaded ||= {}
    # @output_spreadsheet.headers_with_frequency_code.each do |series|
    #   self.series_loaded[series] = @output_spreadsheet.series series.split(".")[0] 
    # end
    self.save

    return {:notice=>"success", :headers => @output_spreadsheet.headers_with_frequency_code, :frequency => @output_spreadsheet.frequency}
  end

  def udaman_diffs
    os = UpdateSpreadsheet.new filename
    return {:notice=>"problem loading spreadsheet", :headers=>[]} if os.load_error?
    diffs = {}
    os.headers_with_frequency_code.each do |header|
      if header.ts.nil?
        diffs[header] = nil
        next
      end
      diff_hash = header.ts.data_diff(os.series(header.split(".")[0]), 3)
      diffs[header] = diff_hash if diff_hash.count > 0
    end
    diffs
  end
    
  def get_data_for(series_name, output_spreadsheet = nil)    
    output_spreadsheet = UpdateSpreadsheet.new filename if output_spreadsheet.nil?
    s = parse_series_name series_name
    raise PrognozDataFindException unless s[:frequency_code] == Series.code_from_frequency(self.frequency)
    raise PrognozDataFindException unless series_loaded.include? series_name
    raise PrognozDataFindException unless output_spreadsheet.headers.include? s[:base_name]
    return output_spreadsheet.series s[:base_name]
  end
    
  def output_folder_name_for_date(date)
    "#{date.to_s[2..3]}M#{date.to_s[5..6]}"
  end
  
  def prognoz_output_path
    "#{ENV["DATAFILES_PATH"]}/datafiles/test_output/"
  end
  
  def create_output_folder
    Dir.mkdir prognoz_output_path+output_folder_name_for_date(Date.today) rescue return 0
  end
  
  def output_dates
    dates = Array.new
    offset = 1 if self.frequency == :month
    offset = 3 if self.frequency == :quarter
    offset = 6 if self.frequency == :semi
    offset = 12 if self.frequency == :year
    date = Date.parse self.output_start_date
    while date < Date.today
      dates.push date.to_s
      date = date >> offset
    end
    return dates
  end
  
  def write_dates(sheet,dates = output_dates)
    count=1
    dates.sort.each do |date|
#      sheet[count,0] = ""
      sheet[count,0] = date
      count += 1
    end
  end
  
  def write_series(series_name, multiplier, sheet, dates = output_dates)
    col = series_loaded.keys.sort.index(series_name)+1
    sheet[0,col] = series_name.dup
    series = Series.get series_name
    count = 1
    dates.sort.each do |date|
      sheet[count,col] = series.at(date) / multiplier.to_f unless series.at(date).nil? or series.at(date).class == String
      count += 1
    end
  end
  
  def write_xls
    #require 'Spreadsheet'
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    dates = output_dates
    write_dates(sheet1, dates)
    series_loaded.keys.sort.each do |name|
#      puts name
      write_series(name,1,sheet1,dates)
    end
    output_filename = filename.split("/")[-1]
    folder_path = prognoz_output_path+output_folder_name_for_date(Date.today)+"/"
    book.write "#{folder_path}#{output_filename}"
  end
  
end
