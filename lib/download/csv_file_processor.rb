def initialize(handle, options, date_info, cached_files)
  @cached_files = cached_files
  @handle = handle
  @options = options
  @row_processor = IntegerPatternProcessor.new options["row"]
  @col_processor = IntegerPatternProcessor.new options["col"]
  @handle_processor = StringWithDatePatternProcessor.new handle
  @date_processor = DatePatternProcessor.new date_info["start"], options["frequency"], date_info["rev"]
end

def observation_at(index)
  row = @row_processor.compute(index)
  col = @col_processor.compute(index)
  handle = @handle_processor.compute(index)
  csv_2d_array = @cached_files.csv(handle)
  date = @date_processor.compute(index)
  {date => csv_2d_array[row][col]}
end


def DataLoadPattern.alternate_fastercsv_read(path)
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

def DataLoadPattern.retrieve_csv(path, sheet, row, col)
  @csv ||= {}
  begin
    @csv[path] = CSV.read(path) if @csv[path].nil?
  rescue
    #resolve one ugly known file formatting problem with faster csv
    alternate_csv_load = DataLoadPattern.alternate_fastercsv_read(path)
    return "READ_ERROR:CSV FORMAT OR FILE PROBLEM" if alternate_csv_load.nil? 

    @csv[path] = alternate_csv_load if @csv[path].nil?
  end
  val = @csv[path][row-1][col-1]
  if val.class == String
    val = Float val.gsub(",","") rescue val
  end
  return val
  
end