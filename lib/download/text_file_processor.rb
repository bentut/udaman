def Series.load_from_basic_text(path, rows_to_skip, delimiter, date_col, value_col)
  f = open path, "r"
  rows_skipped = 0
  while (rows_to_skip > rows_skipped)
    f.gets
    rows_skipped += 1
  end
  load_from_queued_up_file(f, delimiter, date_col, value_col)
end

def Series.load_standard_text(path)
  f = open path, "r"
  while line = f.gets
    break if line.starts_with "DATE"
  end
  load_from_queued_up_file(f, " ", 0, 1)
end

def Series.load_from_queued_up_file(f, delimiter, date_col, value_col)
  series_data = {}
  while data_row = f.gets
    data = data_row.split(delimiter)
    begin
      date = Date.parse(data[date_col])
    rescue
      break
    end
    series_data[date.to_s] = data[value_col].to_f
  end
  Series.new.new_transformation("loaded from textfile #{f.path}", series_data)
end

def load_standard_text(path)
  Series.load_standard_text(path)
end