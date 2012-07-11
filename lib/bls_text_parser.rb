class BlsTextParser
  def initialize(filename, rows_to_skip = 1)
    file = open filename, "r"

    rows_skipped = 0
    while (rows_to_skip > rows_skipped)
      file.gets
      rows_skipped += 1
    end
    @data_hash = {}
    while data_row = file.gets
      data = data_row.split(" ")
      
      frequency = "M" if data[2][0] == "M" and data[2] != "M13"
      frequency = "A" if data[2] == "M13"
      frequency = "Q" if data[2][0] == "Q"
      dateyear = data[1]
      if frequency == "Q"
        datemonth = "01" if data[2] = "Q1"
        datemonth = "04" if data[2] = "Q2"
        datemonth = "07" if data[2] = "Q3"
        datemonth = "10" if data[2] = "Q4"
      else
        datemonth = data[2] == "M13" ? "01" : data[2][1..2]
      end
      
      @data_hash[data[0]] ||= {}
      @data_hash[data[0]][frequency] ||= {}
      @data_hash[data[0]][frequency]["#{dateyear}-#{datemonth}-01"] = data[3]
    end
  end
  
  def get_data_hash
    @data_hash
  end
  
  def get_data(code,frequency)
    @data_hash[code][frequency]
  end
end
  
  
#need a fred_parser
#FRED API KEY: 1030292ef115ba08c1778a606eb7a6cc
  
  
# def Series.load_from_basic_text(path, rows_to_skip, delimiter, date_col, value_col)
#   f = open path, "r"
#   rows_skipped = 0
#   while (rows_to_skip > rows_skipped)
#     f.gets
#     rows_skipped += 1
#   end
#   load_from_queued_up_file(f, delimiter, date_col, value_col)
# end
# 
# def Series.load_standard_text(path)
#   f = open path, "r"
#   while line = f.gets
#     break if line.starts_with "DATE"
#   end
#   load_from_queued_up_file(f, " ", 0, 1)
# end
# 
# def Series.load_from_queued_up_file(f, delimiter, date_col, value_col)
#   series_data = {}
#   while data_row = f.gets
#     data = data_row.split(delimiter)
#     begin
#       date = Date.parse(data[date_col])
#     rescue
#       break
#     end
#     series_data[date.to_s] = data[value_col].to_f
#   end
#   Series.new.new_transformation("loaded from textfile #{f.path}", series_data)
# end