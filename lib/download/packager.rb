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
    dates = Series.get_all_dates_from_data(@series)
    sorted= dates.sort
    date3 = sorted[-1]
    date2 = sorted[-2]
    date1 = sorted[-3]
    return "Not enough data to display" if date1.nil? or date2.nil? or date3.nil?
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

  def write_definitions_to(output_path)# = "udaman")
    begin
      @output_path = output_path
      @series = get_data_from_definitions #this runs all definitions
  
      write_console_output
      send_output_email if errors != [] or download_problem?
      
      changed = Series.write_data_list @series.keys, @output_path unless @definitions.nil?        
      packager_output.update_attributes(:last_new_data => Time.now) if changed
      
    rescue Exception => e
      PackagerMailer.rake_error(e, output_path).deliver
      raise e
    end
  end

  
  def write_console_output
    puts download_results_string
    puts errors_string
    puts series_summary_string
  end
  
  def send_output_email
    puts "SENDING EMAIL"
    job_name = @output_path.split("/")[-1].split(".")[0]
    PackagerMailer.rake_notification(job_name, download_results, errors, @series, @output_path, (errors != [] or download_problem?)).deliver
  end
  
  
  def packager_output
    po = PackagerOutput.where(:path => @output_path).first
    if po.nil?
      po = PackagerOutput.create(:path => @output_path) 
    else
      po.touch
    end
    return po
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
        series[series_name] = {}
        @errors.push({ :series => series_name, :definition => definition, :error => e.message })
      end
    end
    
    #@download_results hash: key-handle name value-hash[:time,:url,:location,:type,:status,:changed]
    @download_results = Series.get_cached_files.download_results
    series
  end

end
