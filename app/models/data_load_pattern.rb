require 'roo'
require 'csv'
#require 'fastercsv'
class DataLoadPattern < ActiveRecord::Base
  def p
    Series.new.load_from_pattern(self).print
  end
  
  def attach_to(series_name)
    series_name.ts_append_eval %Q|"#{series_name}".ts.load_from_pattern_id "#{self.id}"|
  end
  
  def DataLoadPattern.loaded_csvs
    @csv
  end
  #how to refresh this list of globals?
  # not sure about the @@ vs @. @ makes sense, but not sure if always have to use @@ for class level globals
  def DataLoadPattern.retrieve(path, sheet, row, col)
    return DataLoadPattern.retrieve_csv(path, sheet, row, col) if sheet == "csv"
    return DataLoadPattern.retrieve_xls(path, sheet, row, col)
  end
  

  def DataLoadPattern.retrieve_xls(path, sheet, row, col)
    @workbooks ||= {} if @workbooks.nil?
    #make a separate excel file for each sheet
    @workbooks[path] ||= {}
    
    begin
      @workbooks[path][sheet] = Excel.new(path) if @workbooks[path][sheet].nil? 
    rescue
      return "READ_ERROR:WORKBOOK DOES NOT EXIST"
    end

    sheet_parts = sheet.split(":")
    if sheet_parts.count > 1 and sheet_parts[0] == "sheet_num"
      @workbooks[path][sheet].default_sheet = @workbooks[path][sheet].sheets[sheet_parts[1].to_i - 1] unless @workbooks[path][sheet].default_sheet == @workbooks[path][sheet].sheets[sheet_parts[1].to_i - 1] 
    else
      begin
        @workbooks[path][sheet].default_sheet = sheet unless @workbooks[path][sheet].default_sheet == sheet
      rescue
        return "READ_ERROR:WORKSHEET DOES NOT EXIST"
      end
    end
    @workbooks[path][sheet].cell(row,col)
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
    @csv[path][row-1][col-1]
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
    puts line
    return nil
  end
  
  #available to process patterns if that ever becomes an issue
  def start_date_string
    start_date
  end
  
  def compute(date_string)
    {"path" => compute_path(date_string), "sheet" => compute_sheet(date_string), "row" => compute_row(date_string), "col" => compute_col(date_string) }
  end
  
  def retrieve(date_string)
    mapping = compute(date_string)
    result = DataLoadPattern.retrieve(mapping["path"], mapping["sheet"], mapping["row"], mapping["col"])
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

  def compute_index_for_date(date_string)
    start = start_date_string.to_date
    finish = date_string.to_date
    start_month = start.month + start.year*12
    finish_month = finish.month + finish.year*12
    
    return ((finish_month - start_month) / 12).to_i if frequency == "A"
    return ((finish_month - start_month) / 6).to_i if frequency == "S"
    return ((finish_month - start_month) / 3).to_i if frequency == "Q"
    return finish_month - start_month if frequency == "M"
    return ((finish - start).to_i / 7).to_i if frequency == "W"
    return (finish - start).to_i if frequency == "D"
  end
  
  def compute_date_string_for_index(index)
    Pattern.date_at_index(index, start_date_string.to_date, frequency).to_s
  end
  
  def compute_path(date_string)
    return Pattern.pos_by_date_string(start_date_string, frequency, path, compute_index_for_date(date_string)) unless path.index("%").nil?
    return path.gsub("UHEROwork", "UHEROwork-1") if ENV["JON"] == "true"
    return path
  end
  
  def compute_sheet(date_string)
    return Pattern.pos_by_date_string(start_date_string, frequency, worksheet, compute_index_for_date(date_string)) unless worksheet.index("%").nil?
    return worksheet
  end
  
  def compute_row(date_string)
    compute_integer_pattern(row,date_string)
  end
  
  def compute_col(date_string)
    compute_integer_pattern(col,date_string)
  end

  def compute_integer_pattern(item, date_string)
    return Integer(item)
  rescue
    pattern = item.split ":"
    return Pattern.pos_by_increment(pattern[1].to_i, pattern[2].to_i, compute_index_for_date(date_string)) if pattern[0] == "increment"
    return Pattern.pos_by_repeating_number_x_times(pattern[1].to_i, pattern[2].to_i, pattern[3].to_i, compute_index_for_date(date_string)) if pattern[0] == "block"
    return Pattern.pos_by_repeating_numbers(pattern[1].to_i, pattern[2].to_i, compute_index_for_date(date_string)) if pattern[0] == "repeat"
    return Pattern.pos_by_repeating_numbers_with_step(pattern[1].to_i, pattern[2].to_i, pattern[3].to_i, compute_index_for_date(date_string)) if pattern[0] == "repeat_with_step"
  end
  
  
  
  ####### PROBLEMS ########
  #Problem	Examples
  #New link needs to be updated every month	Tax, Tour, Census
  #Rolling Start date	JP_CPI, US_STKNS
  #PDF Downloads	HBR, Flash Report
  #Text Downloads	St Louis Fed
  #ZIP Downloads	Tax
  
  #should protect for uniqueness of mapping combinations and for uniqueness of
  #date/series combinations.
  #possible ways to handle new datemappings
  #1. prompt with today. the following series do not have a mapping for 
  #the current period. manual select (should contain values for last record)
  #2. update the spreadsheet maps and have it read in again, overwriting changes 
  #and only adding new values
  #3. map a bunch of dates ahead of time. have the system update when dates have 
  #run out. then require a remapping
  #4. do a hybrid system where some dates (that are easy to figure out) can automatically
  #add mappings for themselves when a new date is needed
  #5. manually add in mappings for each date with web form
  #6. all of the above
  #if fields (such as worksheet) are null can we assume default?
  #a lot of redundant information is going to be stored in these fields
  #otherwise. (path and spreadsheet in every record). no reasonable join
  #maybe that's ok. if we ever do a mysql implementation of this database
  #could join and make more tables
end
