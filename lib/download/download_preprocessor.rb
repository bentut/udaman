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
    #puts value.strip.downcase.to_ascii_iconv
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
    #temporary hack to get this to work
    return 1000 if options[:header_name] == "AGRICULTURE"
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
    
    #puts "Searching for #{options[:header_name]} in row:#{row} col:#{col}"
    #might not actually need this logic with the new way this is being cached...
    cell_value = spreadsheet[row-1][col-1].to_s if options[:sheet].nil?
    cell_value = spreadsheet.cell(row,col).to_s unless options[:sheet].nil?
    options[:header_name].split("[or]").each do |header|
      #puts "Searching for #{header} in row:#{row} col:#{col}"
      result = match(cell_value, header) if match_type == :hiwi
      result = match_prefix(cell_value, header) if match_type == :prefix
      result = match_trim_elipsis(cell_value,header) if match_type == :trim_elipsis
      result = match(cell_value, header, true) if match_type == :no_okina
      result = match_prefix(cell_value, header, true) if match_type == :prefix_no_okina
      result = match_sub(cell_value, header) if match_type == :sub
      result = match_sub(cell_value, header, true) if match_type == :sub_no_okina
      return true if result
    end
    return false
  end  
  
end