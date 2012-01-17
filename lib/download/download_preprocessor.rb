require 'roo'
require 'csv'

class DownloadPreprocessor
  
  def DownloadPreprocessor.xls(desc, handle, sheet, cached_files=nil)
    return desc unless desc.class == String
    p = desc.split ":"
    return desc unless p[0] == "header"
    res = DownloadPreprocessor.find_xls_header_row_in_col(p[2].to_i, p[3], handle, sheet, cached_files) if p[1] == "col"
    res = DownloadPreprocessor.find_xls_header_col_in_row(p[2].to_i, p[3], handle, sheet, cached_files) if p[1] == "row"
#    puts res
    return res
    #return desc
  end  

  def DownloadPreprocessor.csv(desc, handle, cached_files=nil)
    return desc unless desc.class == String
    p = desc.split ":"
    return desc unless p[0] == "header"
    return DownloadPreprocessor.find_csv_header_row_in_col(p[2].to_i, p[3], handle, cached_files) if p[1] == "col"
    return DownloadPreprocessor.find_csv_header_col_in_row(p[2].to_i, p[3], handle, cached_files) if p[1] == "row"
    return desc
  end  
  
  def DownloadPreprocessor.find_xls_header_row_in_col(col_to_search, header_name, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    xls = @cached_files.xls(handle, sheet)
    (1..xls.last_row).each {|row| return row if xls.cell(row, col_to_search).to_s.downcase == header_name.downcase }
    return nil 
  end
  
  def DownloadPreprocessor.find_xls_header_col_in_row(row_to_search, header_name, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    xls = @cached_files.xls(handle, sheet)
    (1..xls.last_column).each {|col| return col if xls.cell(row_to_search, col).to_s == header_name }
    return nil 
  end

  def DownloadPreprocessor.get_xls_start_date(row, col, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    return @cached_files.xls(handle, sheet).cell(row, col).to_s
  end
  
  def DownloadPreprocessor.find_csv_header_row_in_col(col_to_search, header_name, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    csv = @cached_files.csv(handle)
    (1..(csv.length)).each {|row| return row if csv[row-1][col_to_search-1].to_s == header_name }
    return nil 
  end
  
  def DownloadPreprocessor.find_csv_header_col_in_row(row_to_search, header_name, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    csv = @cached_files.csv(handle)
    (1..(csv[0].length)).each {|col| return col if csv[row_to_search-1][col-1].to_s == header_name }
    return nil
  end
  
  def DownloadPreprocessor.get_csv_start_date(row, col, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    return Date.parse(@cached_files.csv(handle)[row-1][col-1]).to_s
  end
  
  
end