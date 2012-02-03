class IntegerPatternProcessor
  def initialize(integer_pattern, cached_files = nil)
    
    @integer_pattern = integer_pattern
  end

  def compute(index, cached_files = nil, handle = nil, sheet = nil)
    
    return Integer(@integer_pattern)
  rescue
    p = @integer_pattern.split ":"
    return pos_by_increment(p[1].to_i, p[2].to_i, index) if p[0] == "increment"
    return pos_by_repeating_number_x_times(p[1].to_i, p[2].to_i, p[3].to_i, index) if p[0] == "block"
    return pos_by_repeating_numbers(p[1].to_i, p[2].to_i, index) if p[0] == "repeat"
    return pos_by_repeating_numbers_with_step(p[1].to_i, p[2].to_i, p[3].to_i, index) if p[0] == "repeat_with_step"  
    # currently when processing headers. Has to search for every data point. Really only needs one search for file. This will probably be significantly 
    # less efficient than the original process until we find a way to cache the header position
    return DownloadPreprocessor.find_header({:header_name => p[3], :header_in => p[1], :search_main => p[2].to_i, :match_type => p[4], :handle => handle, :sheet => sheet, :cached_files => cached_files}) if p[0] == "header"
    return DownloadPreprocessor.find_header({:header_name => p[3], :header_in => p[1], :search_main => p[2].to_i, :match_type => p[6], :search_start => p[4].to_i, :search_end => p[5].to_i, :handle => handle, :sheet => sheet, :cached_files => cached_files}) if p[0] == "header_range"

    # return pos_by_header_search(p[1], p[2].to_i, p[3], cached_files, handle) if p[0] == "header" and sheet.nil?
    # return pos_by_header_search(p[1], p[2].to_i, p[3], cached_files, handle, sheet) if p[0] == "header"
    # return pos_by_header_search(p[1], p[2].to_i, p[3], p[4], p[5], cached_files, handle) if p[0] == "header_range" and sheet.nil?
    # return pos_by_header_search(p[1], p[2].to_i, p[3], p[4], p[5], cached_files, handle, sheet) if p[0] == "header_range"
  end

  def pos_by_increment(start,step,index)
    start + (step * index)
  end

  def pos_by_repeating_numbers_with_step(first, last, step, index)
    range = (last-first)/step+1
    (index % range)*step + first
  end

  def pos_by_repeating_numbers(first, last, index)
    range = last-first+1
    (index % range) + first
  end

  def pos_by_repeating_number_x_times(start, step, repeat, index)
    start + (index/repeat).truncate
  end
  
  # def pos_by_header_search(search_by, search_index, header_name, cached_files, handle, sheet)
  #   #cached_files = cached_files.nil? ? DownloadsCache.new : cached_files 
  #   if sheet.nil?
  #     return DownloadPreprocessor.find_csv_header_row_in_col(search_index, header_name, handle, cached_files) if search_by == "col"
  #     return DownloadPreprocessor.find_csv_header_col_in_row(search_index, header_name, handle, cached_files) if search_by == "row"
  #   else
  #     return DownloadPreprocessor.find_xls_header_row_in_col(search_index, header_name, handle, sheet, cached_files) if search_by == "col"
  #     return DownloadPreprocessor.find_xls_header_col_in_row(search_index, header_name, handle, sheet, cached_files) if search_by == "row"
  #   end
  # end
  
  
end