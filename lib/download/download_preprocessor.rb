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

  
  
  def DownloadPreprocessor.match(value, header, no_okina = false)
    
    return false if value.class != String
    #puts "looking for [#{header}] in cell with value: [#{value}]"
    #assuming BLS format with "(" for now
    value = value.split("(")[0] unless value == ""
    puts value.strip.downcase.to_ascii_iconv
    return value.strip.downcase.to_ascii_iconv.no_okina == header.strip.downcase if no_okina
    return value.strip.downcase.to_ascii_iconv == header.strip.downcase 
  end
  
  def DownloadPreprocessor.match_prefix(value, header, no_okina = false)
    #puts "looking for prefix [#{header}] in cell with value: [#{value}]"
    return false if value.class != String
    #puts value.strip.downcase.to_ascii_iconv
    return value.strip.downcase.to_ascii_iconv.no_okina.index(header.strip.downcase) == 0 if no_okina
    return value.strip.downcase.to_ascii_iconv.index(header.strip.downcase) == 0
  end
    
  def DownloadPreprocessor.match_sub(value, header, no_okina = false)
    #puts "looking for prefix [#{header}] in cell with value: [#{value}]"
    return false if value.class != String
    #puts value.strip.downcase.to_ascii_iconv
    return value.strip.downcase.to_ascii_iconv.no_okina.index(header.strip.downcase) != nil if no_okina
    return value.strip.downcase.to_ascii_iconv.index(header.strip.downcase) != nil
  end
  
  def DownloadPreprocessor.match_trim_elipsis(value, header)    
    return false if value.class != String
    #puts "looking for [#{header}] in cell with value: [#{value}]"
    #value needs to have first character be letter or have elipsis trimmed
    value.strip.downcase == header.strip.downcase
  end  
  
  def DownloadPreprocessor.find_header(options)
    raise "Request to find header requires a header name" if options[:header_name].nil? 
    raise "Request to find header requires a handle" if options[:handle].nil?
    
    header_in = options[:header_in].nil? ? "col" : options[:header_in]
    match_type = options[:match_type].nil? ? :hiwi : options[:match_type].parameterize.underscore.to_sym
    search_main = options[:search_main].nil? ? 1 : options[:search_main]
    cached_files = options[:cached_files].nil? ? DownloadsCache : options[:cached_files]
    
    spreadsheet = options[:sheet].nil? ? cached_files.csv(options[:handle]) : cached_files.xls(options[:handle], options[:sheet])
    
    search_start = options[:search_start].nil? ? 1 : options[:search_start]
    search_end = compute_search_end(spreadsheet, options, header_in)

    (search_start..search_end).each {|elem| return elem if match?(elem, spreadsheet, match_type, header_in, search_main, options)}
    raise "could not find header: '#{options[:header_name]}'" #return nil
  end
  
  def DownloadPreprocessor.compute_search_end(spreadsheet, options, header_in)
    return options[:search_end] unless options[:search_end].nil?

    #might not actually need this logic with the new way this is being cached...
    if options[:sheet].nil?
      return spreadsheet.length if header_in == "col"        #search the column return a row number
      return spreadsheet[0].length if header_in == "row"     #search the row and return a column number
    else
      return spreadsheet.last_row if header_in == "col"      #search the column return a row number
      return spreadsheet.last_column if header_in == "row"   #search the row and return a column number
    end
    raise "could not calculate the end of the search range"
  end
  
  def DownloadPreprocessor.match?(elem, spreadsheet, match_type, header_in, search_main, options)
    row = header_in == "col" ? elem : search_main
    col = header_in == "col" ? search_main : elem
    
    puts "Searching for #{options[:header_name]} in row:#{row} col:#{col}"
    #might not actually need this logic with the new way this is being cached...
    cell_value = spreadsheet[row-1][col-1].to_s if options[:sheet].nil?
    cell_value = spreadsheet.cell(row,col).to_s unless options[:sheet].nil?
    
    return match(cell_value, options[:header_name]) if match_type == :hiwi
    return match_prefix(cell_value, options[:header_name]) if match_type == :prefix
    return match_trim_elipsis(cell_value,options[:header_name]) if match_type == :trim_elipsis
    return match(cell_value, options[:header_name], true) if match_type == :no_okina
    return match_prefix(cell_value, options[:header_name], true) if match_type == :prefix_no_okina
    return match_sub(cell_value, options[:header_name]) if match_type == :sub
    return match_sub(cell_value, options[:header_name], true) if match_type == :sub_no_okina
  end
  
  # --------XLS --------- #
  def DownloadPreprocessor.find_xls_header_row_in_col(col_to_search, header_name, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    xls = @cached_files.xls(handle, sheet)
    (1..xls.last_row).each {|row| return row if match(xls.cell(row, col_to_search).to_s, header_name) }
    raise "could not find header: '#{header_name}'" #return nil 
  end
  
  def DownloadPreprocessor.find_xls_header_col_in_row(row_to_search, header_name, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    xls = @cached_files.xls(handle, sheet)
    (1..xls.last_column).each {|col| return col if match(xls.cell(row_to_search, col).to_s, header_name) }
    raise "could not find header: '#{header_name}'" #return nil 
  end

  def DownloadPreprocessor.get_xls_start_date(row, col, handle, sheet, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    return @cached_files.xls(handle, sheet).cell(row, col).to_s
  end
  
  # -------- CSV ----------- #
  def DownloadPreprocessor.find_csv_header_row_in_col(col_to_search, header_name, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    csv = @cached_files.csv(handle)
    (1..(csv.length)).each {|row| return row if match(csv[row-1][col_to_search-1].to_s, header_name) }
    raise "could not find header: '#{header_name}'" #return nil 
  end
  
  def DownloadPreprocessor.find_csv_header_col_in_row(row_to_search, header_name, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    csv = @cached_files.csv(handle)
    (1..(csv[0].length)).each {|col| return col if match(csv[row_to_search-1][col-1].to_s, header_name) }
    raise "could not find header: '#{header_name}'" #return nil
  end
  
  def DownloadPreprocessor.get_csv_start_date(row, col, handle, cached_files = nil)
    @cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
    return Date.parse(@cached_files.csv(handle)[row-1][col-1]).to_s
  end
  
  
end