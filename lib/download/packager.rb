class Packager
  
  def definitions
    @definitions
  end
  
  def download_results
    raise "download results have not been set" if @download_results.nil?
    @download_results
  end
  
  def errors
    @errors ||= []
    @errors
  end
  
  def series
    @series ||= {}
    @series
  end
  
  def changed?
    download_results.each do |handle, hash|
      return true if hash[:changed]
    end
    return false
  end
  
  def download_results_string
    results_string = ""
    download_results.each do |handle, hash|
      results_string += "#{handle} was downloaed successfully\n" if hash[:status] == 200
      results_string += "There was an error downloading #{handle} - Status Code: #{hash[:status]}\n" unless hash[:status] == 200
    end
    results_string
  end
  
  def errors_string
    return "" if errors == []
    results_string = "PROBLEMS WITH:"
    errors.each do |error|
      results_string += "#{error[:series]}: #{error[:error]} - (#{error[:definition]})\n"
    end
    results_string
  end
  
  def series_summary_string
    sorted= dates.sort
    date1 = sorted[-1]
    date2 = sorted[-2]
    date3 = sorted[-3]
    
    puts "#{date1}, #{date2}, #{date3}"
    results_string = ""
    @series.each do |series, data|
      puts data.count
      puts data.sort[-1][0]
      puts data[date3]
      #results_string += "#{series.rjust(20," ")}: #{data[date3].rjust(10," ") rescue ""} | #{data[date2].rjust(10," ") rescue ""} | #{data[date1].rjust(10," ") rescue ""}\n"
      results_string += "#{series.rjust(20," ")}: "
      results_string += data[date3].rjust(10," ")
      results_string += "|\n"
    end
    results_string
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

  #should fix this to only write if "changed?" resolves to true
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
  
  #going to do exception handling here. broken series will not be added to hash, and thus will not show up
  #in final spreadsheet. Thus they will have to appear in a log or something
  def get_data_from_definitions
    @errors ||= []
    Series.open_cached_files
    series = {}
    @definitions.each do |series_name, definition|
      puts series_name+": "+definition
      begin
        series[series_name] = eval(definition).data
      rescue RuntimeError => e
        @errors.push({ :series => series_name, :definition => definition, :error => e.message })
      end
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