class TextFileProcessor
  def initialize(handle, options, cached_files)
    @cached_files = cached_files
    @handle = handle
    @options = options
  end

  def get_data
    @file_lines_array = @cached_files.text(@handle)
    load_from_basic_text unless @options[:rows_to_skip].nil?
    load_standard_text if @options[:rows_to_skip].nil?
  end

  def load_from_basic_text
    rows_skipped = 0
    while (@options[:rows_to_skip] > rows_skipped)
      @file_lines_array.slice!(0)
      rows_skipped += 1
    end
    load_from_queued_up_file(@options[:delimiter], @options[:date_col], @options[:value_col])
  end

  def load_standard_text
    while line = @file_lines_array.slice!(0)
      break if line.start_with? "DATE"
    end
    load_from_queued_up_file(" ", 0, 1)
  end

  def load_from_queued_up_file(delimiter, date_col, value_col)
    series_data = {}
    while data_row = @file_lines_array.slice!(0)
      data = data_row.split(delimiter)
      begin
        date = Date.parse(data[date_col])
      rescue
        break
      end
      series_data[date.to_s] = data[value_col].to_f
    end
    series_data
  end
end