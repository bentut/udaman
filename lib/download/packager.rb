class Packager
  
  def Packager.temp
    const_q = {
  		"KNRSDNS@HON.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-25", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
  		"KNRSDNS@HAW.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-26", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
  		"PICTCONNS@HON.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-7", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|
  	}

  	p = Packager.new
  	p.add_definitions const_q
  	p.write_definitions_to "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_NEW.xls"
  	nil
  end
  
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
  
  def download_problem?
    download_results.each do |handle, hash|
      return true if hash[:status] != 200
    end
    return false
  end
  
  def changed?
    download_results.each do |handle, hash|
      return true if hash[:changed]
    end
    return false
  end
  
  def download_results_string
    results_string = "DOWNLOAD RESULTS:\n-------------------\n"
    download_results.each do |handle, hash|
      results_string += "#{handle.rjust(30," ")} | #{hash[:changed] ? "c" : " "} | Success\n" if hash[:status] == 200
      results_string += "#{handle.rjust(30," ")} |   | Error (#{hash[:status]})\n" unless hash[:status] == 200
      # results_string += "#{handle} was downloaded successfully\n" if hash[:status] == 200
      # results_string += "There was an error downloading #{handle} - Status Code: #{hash[:status]}\n" unless hash[:status] == 200
    end
    results_string += "\nFile Written: #{@output_path}\n\n"
    results_string
  end
  
  def errors_string
    return "" if errors == []
    results_string = "BROKEN SERIES:\n-------------------\n"
    errors.each do |error|
      results_string += "#{error[:series]}: \n"
      results_string += "#{error[:error]} \n"
      results_string += "[#{error[:definition]})]\n\n"
    end
    results_string
  end
  
  def series_summary_string
    sorted= dates.sort
    date3 = sorted[-1]
    date2 = sorted[-2]
    date1 = sorted[-3]
    results_string = "DOWNLOADED SERIES:\n-------------------\n"
    results_string += "#{"".rjust(20," ")} | #{date1.rjust(10," ")} | #{date2.rjust(10," ")} | #{date3.rjust(10," ")}\n"
    @series.each do |series, data|
      d3 = data[date3].nil? ? "" : data[date3].round(3).to_s
      d2 = data[date2].nil? ? "" : data[date2].round(3).to_s
      d1 = data[date1].nil? ? "" : data[date1].round(3).to_s
      results_string += "#{series.rjust(20," ")} | #{d1.rjust(10," ")} | #{d2.rjust(10," ")} | #{d3.rjust(10," ")}\n"
    end
    results_string
  end
  
  def add_definitions (definitions_hash)
    @definitions ||= {}
    @definitions.merge! definitions_hash
  end

  def write_definitions_to(output_path = "udaman")
    begin
      return write_to_db if output_path == "udaman"
      @output_path = ENV["JON"] == "true" ? output_path.gsub("UHEROwork", "UHEROwork-1") : output_path
      @output_filename = @output_path.split("/")[-1]
      write_xls  
    rescue Exception => e
      PackagerMailer.rake_error(e, output_path).deliver
      raise e
    end
  end

  def write_to_db
    #Series.open_cached_files
    @definitions.each do |series_name, series_definition|
      series_name.ts_append_eval series_definition
    end
    #@download_results hash: key-handle name value-hash[:time,:url,:location,:type,:status,:changed]
    @download_results = Series.get_cached_files.download_results
    #Series.close_cached_files
  end

  #this change functionality is not tested, but should be
  def write_xls
    require 'iconv'
    return if @definitions.nil?
  
    @series = get_data_from_definitions
    
    old_file = File::exists?(@output_path) ? open(@output_path, "rb").read : nil
    old_file_xls = Excel.new(@output_path) if File::exists?(@output_path)
    
    xls = Spreadsheet::Workbook.new @output_path
    sheet1 = xls.create_worksheet
    write_dates(sheet1)
    col = 1
    @series.sort.each do |name, data|
      write_series(name, data, sheet1, col)
      col += 1
    end
    puts download_results_string
    puts errors_string
    puts series_summary_string
    xls.write @output_path

    po = PackagerOutput.where(:path => @output_path).first
    if po.nil?
      po = PackagerOutput.create(:path => @output_path) 
    else
      po.touch
    end
    
    new_file_xls = Excel.new(@output_path)
    
    po.update_attributes(:last_new_data => Time.now) if new_file_xls.to_s != old_file_xls.to_s
    
    if new_file_xls.to_s != old_file_xls.to_s or errors != [] or download_problem?
      puts new_file_xls.to_s != old_file_xls.to_s
      puts errors != []
      puts download_problem?
      backup(old_file) unless old_file.nil?
      puts "SENDING EMAIL"
      job_name = @output_path.split("/")[-1].split(".")[0]
      PackagerMailer.rake_notification(job_name, download_results, errors, @series, @output_path, dates, (errors != [] or download_problem?)).deliver
    end
    
  end

  def backup(old_file)
    Dir.mkdir @output_path+"_vintages" unless File::directory?(@output_path+"_vintages")
    open(@output_path+"_vintages/#{Date.today}_"+@output_filename, "wb") { |file| file.write old_file }
  end

  def eval(definition)
    Kernel::eval definition
  end
  
  def get_data_from_definitions
    @errors ||= []
    @run_again = {}
    series = {}

    @definitions.each do |series_name, definition|
      #puts series_name+": "+definition
      begin
        if definition.class == Array
          definition.each { |def_item| series_name.ts_append_eval def_item }
        else
          series_name.ts_append_eval definition
        end
        def_data = series_name.ts.data
        series[series_name] = def_data.nil? ? {} : def_data
      rescue Exception => e
        puts "THERE WAS AN ERROR FOR #{series_name}: #{definition}"
        @errors.push({ :series => series_name, :definition => definition, :error => e.message })
      end
    end
    
    #@download_results hash: key-handle name value-hash[:time,:url,:location,:type,:status,:changed]
    @download_results = Series.get_cached_files.download_results
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
      #puts series_name
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