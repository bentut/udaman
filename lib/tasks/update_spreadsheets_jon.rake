task :tour_PC_upd_w => :environment do
  require "Spreadsheet"
  path_tour_PC       = "/Volumes/UHEROwork/data/rawdata/Tour_PC.xls"
  
  output_path   = "/Volumes/UHEROwork/data/tour/update/tour_PC_upd_NEW.xls"

  dsd_tour_PC     = DataSourceDownload.get path_tour_PC
    
    
  if dsd_tour_PC.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
    sox.add "PCDMNS@HAW",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Domestic", "increment:5:1", 6)
    sox.add "PCDMNS@HI",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Domestic", "increment:5:1", 3)
    sox.add "PCDMNS@HON",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Domestic", "increment:5:1", 4)
    sox.add "PCDMNS@KAU",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Domestic", "increment:5:1", 7)
    sox.add "PCDMNS@MAU",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Domestic", "increment:5:1", 5)
    sox.add "PCITJPNS@HI",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "International", "increment:6:1", 4)
    sox.add "PCITNS@HI",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "International", "increment:6:1", 3)
    sox.add "PCITOTNS@HI",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "International", "increment:6:1", 5)
    sox.add "PCNS@HI",         Series.load_pattern("2009-08-31", "D",  "Tour_PC.xls" , "Total"," increment:5:1", 4)

   
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "Tour PC (rake const_upd_q)", sox.output_summary
  end
end

