
def code_from_frequency(frequency)
    return 'A' if frequency == :year || frequency == "year" || frequency == :annual || frequency == "annual" || frequency == "annualy"
    return 'Q' if frequency == :quarter || frequency == "quarter" || frequency == "quarterly"
    return 'M' if frequency == :month || frequency == "month" || frequency == "monthly"
    return 'S' if frequency == :semi || frequency == "semi" || frequency == "semi-annually"
    return ""
  end


def data_hash_string(update_spreadsheet_path, sheet_to_load = nil, sa = false)
  dh_string = ""
  update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_path)
  return {:message => "The spreadsheet could not be found", :headers => []} if update_spreadsheet.load_error?

  default_sheet = sa ? "Demetra_Results_fa" : update_spreadsheet.sheets.first unless update_spreadsheet.class == UpdateCSV
  update_spreadsheet.default_sheet = sheet_to_load.nil? ? default_sheet : sheet_to_load unless update_spreadsheet.class == UpdateCSV
  return {:message=>"The spreadsheet was not formatted properly", :headers=>[]} unless update_spreadsheet.update_formatted?

  header_names = Array.new    
   
  update_spreadsheet_headers = sa ? update_spreadsheet.headers.keys : update_spreadsheet.headers_with_frequency_code 
  update_spreadsheet_headers.each do |series_name|
    
    frequency_code = code_from_frequency update_spreadsheet.frequency  
    base_name = sa ? series_name.sub("NS@","@") : series_name
    series_name = base_name+"."+frequency_code if sa
    all_data = ""
    update_spreadsheet.series(series_name).each do |date_string, value|
      all_data += %Q|"#{date_string}" => #{value},| unless value.nil? or value.to_s == "" or value.to_s == " "
      all_data += %Q|"#{date_string}" => nil,| if value.nil? or value.to_s == "" or value.to_s == " "
    end
    all_data.chop!
    dh_string += %Q|"#{series_name}" => {#{all_data}}, |
    #{update_spreadsheet.series(series_name).to_s}|
  end 
  dh_string
end


# maybe syntax difference? Not working in current version of rails
# task :create_spec_data => :environment do 
#   dh_string = ""
#   path = "#{ENV["DATAFILES_PATH"]}/datafiles/"
# 
#   dh_string += data_hash_string(path+"sa_update.xls", "sadata", "true")
#   dh_string += data_hash_string(path+"ns_update.xls")
#   dh_string += data_hash_string(path+"horizontal_update_spreadsheet.xls")
#   dh_string += data_hash_string(path+"tour_upd1.xls")
#   dh_string += data_hash_string(path+"specs/quarter.xls")
#   dh_string += data_hash_string(path+"specs/month.xls")
#   dh_string += data_hash_string(path+"specs/quarter_load_merge.xls")
#   dh_string += data_hash_string(path+"specs/semi.xls")
#   #dh_string += data_hash_string("#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls")
#   dh_string = "@data_hash = {#{dh_string.chop.chop}}"
#   
#   File.open ("#{ENV["DATAFILES_PATH"]}/spec_data_hash.rb", "w+") do |data_hash_file|
#     data_hash_file.syswrite "def get_data_hash\n"
#     data_hash_file.syswrite "  "+dh_string+"\n"
#     data_hash_file.syswrite "end"
#   end
# end