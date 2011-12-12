def compute_path(date_string)
  subbed_path = path
  subbed_path = path.gsub("UHEROwork", "UHEROwork-1") if ENV["JON"] == "true"
  return subbed_path if date_string.nil?
  return Pattern.pos_by_date_string(start_date_string, frequency, subbed_path, compute_index_for_date(date_string)) unless path.index("%").nil?
  return subbed_path
  #return path
end

def compute_sheet(date_string)
  return Pattern.pos_by_date_string(start_date_string, frequency, worksheet, compute_index_for_date(date_string)) unless worksheet.index("%").nil?
  return worksheet
end
