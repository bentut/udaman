class CsvFileProcessor
  def initialize(handle, options, date_info, cached_files)
    @cached_files = cached_files
    @handle = handle
    @options = options
    @row_processor = IntegerPatternProcessor.new options[:row]
    @col_processor = IntegerPatternProcessor.new options[:col]
    @handle_processor = StringWithDatePatternProcessor.new handle
    @date_processor = DatePatternProcessor.new date_info[:start], options[:frequency], date_info[:rev]
  end

  def observation_at(index)
    row = @row_processor.compute(index)
    col = @col_processor.compute(index)
    handle = @handle_processor.compute(index)
  
    csv_2d_array = @cached_files.csv(handle)
    date = @date_processor.compute(index)
  
    observation_value = parse_cell(csv_2d_array[row-1][col-1])
    return "END" if observation_value == "BREAK IN DATA"
    {date => observation_value}
  
  end

  def parse_cell(cell_value)
    begin
      return Float cell_value.gsub(",","") if cell_value.class == String
      return Float cell_value
    rescue    
      #known data values that should be suppressed as nils... may need to separate these by file being read in
      #return nil if ["(D) ", "(L) ", "(N) ", "(T) "].include? cell_value
      return "BREAK IN DATA"
    end
  end

end