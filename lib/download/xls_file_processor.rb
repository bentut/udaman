#can use allow_blanks as an option for handling blanks
def initialize(handle, options, cached_files, date_info)
  @cached_files = cached_files
  @handle = handle
  @options = options
  @row_processor = IntegerPatternProcessor.new options["row"]
  @col_processor = IntegerPatternProcessor.new options["col"]
  @handle_processor = StringWithDatePatternProcessor.new handle
  @sheet_processor = StringWithDatePatternProcessor.new options["sheet"]
  @date_processor = DatePatternProcessor.new date_info["start"], options["frequency"], date_info["rev"]
end

def observation_at(index)
  row = @row_processor.compute(index)
  col = @col_processor.compute(index)
  handle = @handle_processor.compute(index)
  sheet = @sheet_processor.compute(index)
  worksheet_2d_array = @cached_files.xls(handle, sheet)
  date = @date_processor.compute(index)
  {date => worksheet_2d_array[row][col]}
end



def retrieve(date_string)
  mapping = compute(date_string)
  result = DataLoadPattern.retrieve(mapping["path"], mapping["sheet"], mapping["row"], mapping["col"])
  #puts result
  begin
    return Float result
  rescue
    if !result.nil? and result.split(":").count > 1
      self.last_read_status = result.split(":")[1]
      return "END"
    end
    
    #known data values that should be suppressed as nils... may need to separate these by file being read in
    return nil if ["(D) ", "(L) ", "(N) ", "(T) "].include? result
    
    #invalid data value
    self.last_read_status = "BREAK IN VALID DATA"
    return "END"
  end
end


def DataLoadPattern.retrieve_xls(path, sheet, row, col)
  @workbooks ||= {} if @workbooks.nil?
  #make a separate excel file for each sheet
  @workbooks[path] ||= {}
  
  begin
    @workbooks[path][sheet] = Excel.new(path) if @workbooks[path][sheet].nil? 
  rescue
    #puts "WORKBOOK CAN'T BE FOUND"
    return "READ_ERROR:WORKBOOK DOES NOT EXIST"
  end

  sheet_parts = sheet.split(":")
  if sheet_parts.count > 1 and sheet_parts[0] == "sheet_num"
    @workbooks[path][sheet].default_sheet = @workbooks[path][sheet].sheets[sheet_parts[1].to_i - 1] unless @workbooks[path][sheet].default_sheet == @workbooks[path][sheet].sheets[sheet_parts[1].to_i - 1] 
  else
    begin
      @workbooks[path][sheet].default_sheet = sheet unless @workbooks[path][sheet].default_sheet == sheet
    rescue
      #puts "WORKSHEET CAN'T BE FOUND"
      return "READ_ERROR:WORKSHEET DOES NOT EXIST"
    end
  end
  # puts path
  # puts sheet
  # puts row
  # puts col
  # puts @workbooks[path][sheet]
  # puts @workbooks[path][sheet].cell(row,col)
  @workbooks[path][sheet].cell(row,col)
end
