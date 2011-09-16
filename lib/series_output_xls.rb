class SeriesOutputXls < Spreadsheet::Workbook
  def initialize(output_path)
    output_path = output_path.gsub("UHEROwork", "UHEROwork-1") if ENV["JON"] == "true"
    super output_path
    @output_path = output_path
    @output_filename = @output_path.split("/")[-1]
    #@folder_path = prognoz_output_path+output_folder_name_for_date(Date.today)+"/"
    @add_to_db = ENV["LOAD_UPDATE_SPREADSHEET_PATTERNS_TO_DB"] == "true" ? true : false #add_to_db
  end
  
  def output_path
    @output_path
  end

  def add(series_name, pattern)
    if @add_to_db
      pattern.save
      pattern.attach_to series_name
    else
      @series ||= {}
      @series[series_name] = Series.new.load_from_pattern(pattern).data
    end
  end
  
  def add_data(series_name, data)
    @series ||= {}
    @series[series_name] = data
  end
  #original version of this function that used a series
  # def add(series_name, series)  
  #   @series ||= {}
  #   @series[series_name] = series.data
  # end
  
  def series
    @series
  end
  
  def dates
    dates_array = []
    return [] if series.nil?
    series.each do |series, data|
      dates_array |= data.keys
    end
    dates_array.sort
  end

  def write_dates(sheet)
    count=1
    dates.each do |date|
      sheet[count,0] = date.dup
      count += 1
    end
  end
  
  def write_series(series_name, data, sheet, col)
    sheet[0,col] = series_name.dup
    count = 1
    dates.each do |date|
      sheet[count,col] = data[date] unless data[date].nil?
      count += 1
    end
  end

  # this style of file output seems to create different files for the same data
  # so no way to tell if they are different
  # will always backup in stead
  
  def write_xls
    return if series.nil?
    old_file = open(@output_path, "r").read if File::exists?(@output_path)
    backup(old_file)
    
    sheet1 = create_worksheet
    #dates = output_dates
    write_dates(sheet1)
    col = 1
    @series.sort.each do |name, data|
      #puts name
      write_series(name, data, sheet1, col)
      col += 1
    end
    write @output_path
  end
  
  def output_summary
    return "wrote to db only" if @add_to_db
    return_text = ""
    @series.sort.each do |name, data|
      return_text += "#{name} ---- #{data.keys.sort[-1]}\n"
    end
    return_text
  end
  
  def backup(old_file)
    Dir.mkdir @output_path+"_vintages" unless File::directory?(@output_path+"_vintages")
    open(@output_path+"_vintages/#{Date.today}_"+@output_filename, "wb") { |file| file.write old_file }
  end
  
end