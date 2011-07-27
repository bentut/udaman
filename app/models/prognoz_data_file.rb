class PrognozDataFile < ActiveRecord::Base
  serialize :series_loaded, Hash
  # serialize :series_validated, Array
  # serialize :output_series, Hash
  # serialize :series_covered, Hash
  
  def PrognozDataFile.change_all_export_folders_to(new_folder_name)
    pdfs = PrognozDataFile.all
    pdfs.each do |pdf|
      pdf.change_export_folder_to(new_folder_name)
    end
  end
  
  def load
    @output_spreadsheet = UpdateSpreadsheet.new filename
    return {:notice=>"problem loading spreadsheet", :headers=>[]} if @output_spreadsheet.load_error?    
    @output_spreadsheet.default_sheet = @output_spreadsheet.sheets.first

    self.frequency = @output_spreadsheet.frequency
    self.output_start_date = @output_spreadsheet.dates.keys.sort[0]
    self.series_loaded ||= {}
    @output_spreadsheet.headers_with_frequency_code.each do |series|
      self.series_loaded[series] = @output_spreadsheet.series series.split(".")[0] 
    end
    self.save

    return {:notice=>"success", :headers => @output_spreadsheet.headers_with_frequency_code, :frequency => @output_spreadsheet.frequency}
  end
  
  def parse_series_name(series_name)
    series_name_parts = series_name.split(".")
    raise SeriesNameException.new unless series_name_parts.count == 2
    return {:base_name => series_name_parts[0], :frequency_code => series_name_parts[1]}
  end
  
  def get_data_for(series_name, output_spreadsheet = nil)    
    output_spreadsheet = UpdateSpreadsheet.new filename if output_spreadsheet.nil?
    s = parse_series_name series_name
    raise PrognozDataFindException unless s[:frequency_code] == Series.code_from_frequency(self.frequency)
    raise PrognozDataFindException unless series_loaded.include? series_name
    raise PrognozDataFindException unless output_spreadsheet.headers.include? s[:base_name]
    return output_spreadsheet.series s[:base_name]
  end
  
  #this is extremely implementation specific. Generalized version can still be accessed from front end, but unless path is same, this is useless
  def change_export_folder_to(new_export_folder)
    puts "changing #{self.filename} to #{new_export_folder}"
    self.filename = "/Volumes/UHEROwork/eis/data/#{new_export_folder}/#{self.filename.split("/")[-1]}" 
    self.save
    self.load
  rescue 
    puts "there seems to be a problem with your folder or folder name. Make sure it is an existing folder WITHOUT leading or trailing /"
  end
  
  def output_folder_name_for_date(date)
    "#{date.to_s[2..3]}M#{date.to_s[5..6]}"
  end
  
  def prognoz_output_path
    "/Users/btrevino/Documents/Dev/uhero_db/spec/datafiles/test_output/"
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
