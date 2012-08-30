module SeriesDataLists
  #may consolidate the insides of these into a standard creation method later 
  #leaving old methods intact until the rest of the tests are refactored
  # def Series.new_from_data_hash(name, data_hash)
  #   frequency = frequency_from_code(name.split(".")[1])
  #   new_series = Series.new(
  #     :name => name,
  #     :data => data_hash[name].clone,
  #     :frequency => frequency
  #     )
  #   
  # end
  
  def Series.grab_data(list, start_date = "1900-01-01")
    series_data = {}
    list.each do |s| 
      series = s.ts
      series_data[s] = series.nil? ? {} : series.get_values_after_including(start_date)
    end
    series_data
  end
  
  def Series.get_all_dates_from_data(data)
    dates_array = []
    data.each {|series_name, data| dates_array |= data.keys}
    dates_array.sort
  end
  
  def Series.write_data_list(list, output_path, start_date = "1900-01-01")
    require 'iconv'
    series_data = grab_data(list, start_date)
    xls = prep_xls series_data, output_path
    write_xls_text(series_data, output_path)
    return write_xls xls, output_path
  end

  private

  def Series.prep_xls(series_data, output_path)
    xls = Spreadsheet::Workbook.new output_path
    sheet1 = xls.create_worksheet
    dates = get_all_dates_from_data(series_data)
    write_dates dates, sheet1
    col = 1
    series_data.sort.each do |name, data|
      write_series(name, data, sheet1, col, dates)
      col += 1
    end
    return xls
  end
  
  def Series.write_series(series_name, data, sheet, col, dates)
    sheet[0,col] = series_name.dup
    count = 1
    dates.each do |date|
      sheet[count,col] = data[date] unless data[date].nil?
      count += 1
    end
  end
  
  def Series.write_dates(dates, sheet)
    count=1
    dates.each do |date|
      sheet[count,0] = date.dup
      count += 1
    end
  end
  
  def Series.write_xls(xls, output_path)
    old_file = File::exists?(output_path) ? open(output_path, "rb").read : nil
    old_file_xls = Excel.new(output_path) if File::exists?(output_path)
    xls.write output_path
    new_file_xls = Excel.new(output_path)
    changed = new_file_xls.to_s != old_file_xls.to_s
    backup_xls(old_file, output_path) if changed unless old_file.nil?
    return changed
  end
  
  def Series.write_xls_text(series_data, output_path)
    File.open(output_path + ".txt", 'w') do |f|
      series_data.keys.sort.each {|s| f.print(s.split(".")[0] + "\r\n") }
    end
  end
  
  def Series.backup_xls(old_file, output_path)
    output_filename = output_path.split("/")[-1]
    Dir.mkdir output_path+"_vintages" unless File::directory?(output_path+"_vintages")
    open(output_path+"_vintages/#{Date.today}_"+output_filename, "wb") { |file| file.write old_file }
  end
  
end

