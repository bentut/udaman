#handle the jonathan "UHEROWork-1" type stuff in here
def xls(handle, sheet)
  @handle = handle
  @sheet = sheet
  @xls ||= {}

  download_handle if @xls[handle].nil? #if handle in cache, it was downloaded recently
  set_xls_sheet if @xls[handle][sheet].nil? #if sheet not present, only other sheets were used so far
  @xls[handle][sheet]
end

def set_xls_sheet
  dsd = DataSourceDownload.get(@handle) #rescue condition if no handle
  excel = Excel.new(dsd.path) #rescue condition if file does not exist
  sheet_parts = @sheet.split(":")
  excel.default_sheet = excel.sheets[sheet_part[1].to_i - 1] if sheet_parts[0] == "sheet_num" and excel.default_sheet != excel.sheets[sheet_part[1].to_i - 1]
  excel.default_sheet = @sheet unless excel.default_sheet == @sheet #rescue condition if sheet does not exist
  @xls[@handle] ||= {}
  @xls[@handle][@sheet] = excel
end

def download_handle
  DataSourceDownload.get(@handle).downlaod
end


def csv(handle)
  @handle = handle
  @csv ||= {}
  if @csv[handle].nil? 
    download_handle 
    begin
      dsd = DataSourceDownload.get(@handle) #rescue condition if no handle
      @csv[handle] = CSV.read(dsd.path)
    rescue
      #resolve one ugly known file formatting problem with faster csv
      alternate_csv_load = DataLoadPattern.alternate_fastercsv_read(path) #rescue condition if this fails
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
