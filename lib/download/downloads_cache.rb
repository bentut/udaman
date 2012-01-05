#CSV STUFF IS WEIRD... TRY TO CLEAN UP

class DownloadsCache
  def xls(handle, sheet)
    @dsd = DataSourceDownload.get(handle)
    raise "handle '#{handle}' does not exist" if @dsd.nil?

    @handle = handle    
    @sheet = sheet
    @xls ||= {}
    download_handle if @xls[handle].nil? #if handle in cache, it was downloaded recently
    @xls[handle] ||= {}
    set_xls_sheet if @xls[handle][sheet].nil? #if sheet not present, only other sheets were used so far
    
    @xls[handle][sheet]
  end

  def set_xls_sheet
    excel = Excel.new(@dsd.save_path_flex) 
    sheet_parts = @sheet.split(":")
    if sheet_parts[0] == "sheet_num" and excel.default_sheet != excel.sheets[sheet_parts[1].to_i - 1]
      excel.default_sheet = excel.sheets[sheet_parts[1].to_i - 1] 
    else
      begin
        excel.default_sheet = @sheet unless excel.default_sheet == @sheet 
      rescue RangeError
        raise "sheet '#{@sheet}' does not exist in workbook '#{@dsd.save_path_flex}' [Handle: #{@handle}]"
      end
    end
    @xls[@handle] ||= {}
    @xls[@handle][@sheet] = excel
  end

  def download_results
    @download_results
  end

  def download_handle
    @download_results ||= {}
    @download_results[@handle] = @dsd.download 
    raise "the download for handle '#{@handle} failed with status code #{@download_results[@handle][:status]} when attempt to reach #{@dsd.url}" if @download_results[@handle] and @download_results[@handle][:status] != 200
  end

  def csv(handle)
    @dsd = DataSourceDownload.get(handle)
    raise "handle '#{handle}' does not exist" if @dsd.nil?
    
    @handle = handle
    @csv ||= {}
    if @csv[handle].nil? 
      download_handle 
      begin
        @csv[handle] = CSV.read(@dsd.save_path_flex)
      rescue
        #resolve one ugly known file formatting problem with faster csv
        alternate_csv_load = alternate_fastercsv_read(@dsd.save_path_flex) #rescue condition if this fails
        #return "READ_ERROR:CSV FORMAT OR FILE PROBLEM" if alternate_csv_load.nil? 
        @csv[handle] = alternate_csv_load
      end
    end
    @csv[handle]
  end


  def alternate_fastercsv_read(path)
    csv_data = []
    csv_file = open path, "r"
    while line = csv_file.gets
      next unless line.index("HYPERLINK").nil?
      csv_data.push(CSV.parse_line(line.strip))
    end
    csv_file.close
    return csv_data 
  rescue
    puts "CSV is having a problem with the following line"
    puts line
    return nil
  end

  def text(handle)
    @dsd = DataSourceDownload.get(handle)
    raise "handle '#{handle}' does not exist" if @dsd.nil?
    
    @handle = handle
    @text ||= {}
    if @text[handle].nil?
      download_handle
      @text[handle] = get_text_rows
    end
    @text[handle]
  end

  def get_text_rows
    f = open @dsd.save_path_flex, "r"
    text_rows = []
    while row = f.gets
      text_rows.push row 
    end
    text_rows
  end
end