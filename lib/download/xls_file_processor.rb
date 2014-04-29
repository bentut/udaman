#can use allow_blanks as an option for handling blanks
class XlsFileProcessor
  #job of this object is to coordinate all of the other processor objects for the mapping
  def initialize(handle, options, date_info, cached_files)
    @cached_files = cached_files
    @handle = handle
    @options = options
    @row_processor = IntegerPatternProcessor.new(options[:row]) 
    @col_processor = IntegerPatternProcessor.new(options[:col]) 
    @handle_processor = StringWithDatePatternProcessor.new handle
    @path_processor = options[:path].nil? ? nil : StringWithDatePatternProcessor.new(options[:path])
    @sheet_processor = StringWithDatePatternProcessor.new options[:sheet]
    @date_processor = DatePatternProcessor.new date_info[:start], options[:frequency], date_info[:rev]
  end

  def observation_at(index)
    
    date = @date_processor.compute(index)
  
    handle = @handle_processor.compute(date)
    sheet = @sheet_processor.compute(date)
    path = @path_processor.nil? ? nil : @path_processor.compute(date)
    
    # puts index
    # puts path
    # puts sheet
    begin
      row = @row_processor.compute(index, @cached_files, handle, sheet)      
      col = @col_processor.compute(index, @cached_files, handle, sheet)
      
      #puts "trying: h:#{handle}, s:#{sheet}, r:#{row}, c:#{col}, p:#{path}"

      worksheet = @cached_files.xls(handle, sheet, path)
    rescue RuntimeError => e
      puts e.message unless @handle_processor.date_sensitive?
      #date sensitive means it might look for handles that don't exist
      #not sure if this is the right thing to do. Will get an indication from the daily download checks, but not sure if will see if you just 
      #load the data other than missing some values... not gonna do this just yet because it was rake that errored out not the series. might try to
      #do a rake trace next time it breaks to check better
      #return "END" if (e.message[0..5] == "handle" or e.message[0..22] == "the download for handle") and @handle_processor.date_sensitive?
      return "END" if e.message[0..5] == "handle" and @handle_processor.date_sensitive?
      return {} if e.message[0..20] == "could not find header" and ["Condo only"].include? e.message.split(": ")[1][1..-2]
      raise e
    rescue IOError => e
      puts e.message
      return "END" if e.message[0..3] == "file" and @path_processor.date_sensitive?
      raise e
    end
  
    observation_value = parse_cell(worksheet.cell(row,col))
    
    return "END" if observation_value == "BREAK IN DATA" unless @handle_processor.date_sensitive?
    return {} if observation_value == "BREAK IN DATA" if @handle_processor.date_sensitive?
    {date => observation_value}
  end

  def parse_cell(cell_value)
    begin
      return Float cell_value
    rescue
      #puts cell_value    
      #known data values that should be suppressed as nils... may need to separate these by file being read in
      return nil if ["(D) ", "(L) ", "(N) ", "(T) ", "no data"].include? cell_value
      return "BREAK IN DATA"
    end
  end

end