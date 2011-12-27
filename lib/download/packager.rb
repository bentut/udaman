class Packager
  
  def definitions
    @definitions
  end
  
  def download_results
    raise "download results have not been set" if @download_results.nil?
    @download_results
  end
  
  def add_definitions (definitions_hash)
    @definitions ||= {}
    @definitions.merge! definitions_hash
  end

  def write_definitions_to(output_path = "udaman")
    return write_to_db if output_path == "udaman"
    @output_path = ENV["JON"] == "true" ? output_path.gsub("UHEROwork", "UHEROwork-1") : output_path
    @output_filename = @output_path.split("/")[-1]
    write_xls  
  end

  def write_to_db
    Series.open_cached_files
    @definitions.each do |series_name, series_definition|
      series_name.ts_append_eval series_definition
    end
    #@download_results hash: key-handle name value-hash[:time,:url,:location,:type,:status,:changed]
    @download_results = Series.get_cached_files.download_results
    Series.close_cached_files
  end

  def write_xls
    return if @definitions.nil?
  
    @series = get_data_from_definitions
  
    old_file = open(@output_path, "r").read if File::exists?(@output_path)
    backup(old_file)
  
    xls = Spreadsheet::Workbook.new @output_path
    sheet1 = xls.create_worksheet
    write_dates(sheet1)
    col = 1
    @series.sort.each do |name, data|
      #puts name
      write_series(name, data, sheet1, col)
      col += 1
    end
    xls.write @output_path
  end

  def backup(old_file)
    Dir.mkdir @output_path+"_vintages" unless File::directory?(@output_path+"_vintages")
    open(@output_path+"_vintages/#{Date.today}_"+@output_filename, "wb") { |file| file.write old_file }
  end

  def eval(definition)
    Kernel::eval definition
  end
  
  def get_data_from_definitions
    Series.open_cached_files
    series = {}
    @definitions.each do |series_name, definition|
      series[series_name] = eval(definition).data
    end
    #@download_results hash: key-handle name value-hash[:time,:url,:location,:type,:status,:changed]
    @download_results = Series.get_cached_files.download_results
    Series.close_cached_files
    series
  end

  def write_dates(sheet)
    count=1
    dates.each do |date|
      sheet[count,0] = date.dup
      count += 1
    end
  end

  def dates
    dates_array = []
    return [] if @series.nil?
    @series.each do |series_name, data|
      dates_array |= data.keys
    end
    dates_array.sort
  end

  def write_series(series_name, data, sheet, col)
    sheet[0,col] = series_name.dup
    count = 1
    dates.each do |date|
      sheet[count,col] = data[date] unless data[date].nil?
      count += 1
    end
  end
end