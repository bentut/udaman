#US DATA


###*******************************************************************
###NOTES BOX

#be sure to use lower case for "increment" command
#when there are non-number things in the CSV, move the location up to avoid them

###*******************************************************************



task :us_upd_q => :environment do
  require "Spreadsheet"
  path_5Q       = "/Volumes/UHEROwork/data/rawdata/US_BEA5QTR.csv"
  path_6Q       = "/Volumes/UHEROwork/data/rawdata/US_BEA6QTR.csv"
  path_13Q      = "/Volumes/UHEROwork/data/rawdata/US_BEA13QTR.csv"
  path_43Q      = "/Volumes/UHEROwork/data/rawdata/US_BEA43QTR.csv"
  path_44Q      = "/Volumes/UHEROwork/data/rawdata/US_BEA44QTR.csv"
  path_58Q      = "/Volumes/UHEROwork/data/rawdata/US_BEA58QTR.csv"
  path_66Q      = "/Volumes/UHEROwork/data/rawdata/US_BEA66QTR.csv"
  path_253Q     = "/Volumes/UHEROwork/data/rawdata/US_BEA253QTR.csv"
  path_264Q     = "/Volumes/UHEROwork/data/rawdata/US_BEA264QTR.csv"

  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_q_NEW.xls"

  dsd_5     = DataSourceDownload.get path_5Q 
  dsd_6     = DataSourceDownload.get path_6Q 
  dsd_13    = DataSourceDownload.get path_13Q 
  dsd_43    = DataSourceDownload.get path_43Q 
  dsd_44    = DataSourceDownload.get path_44Q 
  dsd_58    = DataSourceDownload.get path_58Q 
  dsd_66    = DataSourceDownload.get path_66Q 
  dsd_253   = DataSourceDownload.get path_253Q 
  dsd_264   = DataSourceDownload.get path_264Q 

  
  if dsd_5.download_changed? || dsd_6.download_changed?  || dsd_13.download_changed?  || dsd_43.download_changed?  || dsd_44.download_changed?  || dsd_58.download_changed?  || dsd_66.download_changed?  || dsd_253.download_changed?  || dsd_264.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  
  ###COPY NEW STUFF INTO HERE FROM THE MAPPING TOOL###
  
  
  sox.add "GDPDEF@US",         Series.load_pattern("1947-01-01", "Q",  path_13Q, "csv", 7,  "increment:3:1")
  sox.add "YPC@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 11,  "increment:3:1")
  sox.add "YPCDPI@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 12,  "increment:3:1")
  sox.add "YPCCE@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 13,  "increment:3:1")
  sox.add "GDPPC@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 9,  "increment:3:1")
  sox.add "GNPPC@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 10,  "increment:3:1")
  sox.add "YPCDPI_R@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 20,  "increment:3:1")
  sox.add "YPCCE_R@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 21,  "increment:3:1")
  sox.add "GDPPC_R@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 18,  "increment:3:1")
  sox.add "GNPPC_R@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 19,  "increment:3:1")
  sox.add "N@US",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 26,  "increment:3:1")
  sox.add "GNP@US",         Series.load_pattern("1947-01-01", "Q",  path_43Q, "csv", 10,  "increment:3:1")
  sox.add "GNP_R@US",         Series.load_pattern("1947-01-01", "Q",  path_44Q, "csv", 11,  "increment:3:1")
  sox.add "Y@US",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 7,  "increment:3:1")
  sox.add "YDPI@US",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 33,  "increment:3:1")
  sox.add "YCE@US",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 35,  "increment:3:1")
  sox.add "YDPI_R@US",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 43,  "increment:3:1")
  sox.add "GDP_C@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 8,  "increment:3:1")
  sox.add "GDP_CD@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 10,  "increment:3:1")
  sox.add "GDP_CN@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 11,  "increment:3:1")
  sox.add "GDP_CS@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 12,  "increment:3:1")
  sox.add "GDP_I@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 13,  "increment:3:1")
  sox.add "GDP_IFX@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 14,  "increment:3:1")
  sox.add "GDP_INR@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 15,  "increment:3:1")
  sox.add "GDP_IRS@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 18,  "increment:3:1")
  sox.add "GDP_IIV@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 19,  "increment:3:1")
  sox.add "GDP_NX@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 20,  "increment:3:1")
  sox.add "GDP_EX@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 21,  "increment:3:1")
  sox.add "GDP_IM@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 24,  "increment:3:1")
  sox.add "GDP_G@US",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 27,  "increment:3:1")
  sox.add "YCE_R@US",         Series.load_pattern("1995-01-01", "Q",  path_66Q, "csv", 8,  "increment:3:1")
  sox.add "GDP_C_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 9,  "increment:3:1")
  sox.add "GDP_CD_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 11,  "increment:3:1")
  sox.add "GDP_CN_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 12,  "increment:3:1")
  sox.add "GDP_CS_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 13,  "increment:3:1")
  sox.add "GDP_I_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 14,  "increment:3:1")
  sox.add "GDP_IFX_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 15,  "increment:3:1")
  sox.add "GDP_INR_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 16,  "increment:3:1")
  sox.add "GDP_IRS_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 19,  "increment:3:1")
  sox.add "GDP_IIV_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 20,  "increment:3:1")
  sox.add "GDP_NX_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 21,  "increment:3:1")
  sox.add "GDP_EX_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 22,  "increment:3:1")
  sox.add "GDP_IM_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 25,  "increment:3:1")
  sox.add "GDP_G_R@US",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 28,  "increment:3:1")
  
    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Quarterly US (rake US_upd_q)", sox.output_summary
  end
end


###*******************************************************************



task :us_upd_a => :environment do
  require "Spreadsheet"
  path_5A       = "/Volumes/UHEROwork/data/rawdata/US_BEA5YEAR.csv"
  path_6A       = "/Volumes/UHEROwork/data/rawdata/US_BEA6YEAR.csv"
  path_13A      = "/Volumes/UHEROwork/data/rawdata/US_BEA13YEAR.csv"
  path_43A      = "/Volumes/UHEROwork/data/rawdata/US_BEA43YEAR.csv"
  path_44A      = "/Volumes/UHEROwork/data/rawdata/US_BEA44YEAR.csv"
  path_58A      = "/Volumes/UHEROwork/data/rawdata/US_BEA58YEAR.csv"
  path_66A      = "/Volumes/UHEROwork/data/rawdata/US_BEA66YEAR.csv"
  path_253A     = "/Volumes/UHEROwork/data/rawdata/US_BEA253YEAR.csv"
  path_264A     = "/Volumes/UHEROwork/data/rawdata/US_BEA264YEAR.csv"

  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_a_NEW.xls"

  dsd_5A     = DataSourceDownload.get path_5A 
  dsd_6A     = DataSourceDownload.get path_6A 
  dsd_13A    = DataSourceDownload.get path_13A 
  dsd_43A    = DataSourceDownload.get path_43A 
  dsd_44A    = DataSourceDownload.get path_44A 
  dsd_58A    = DataSourceDownload.get path_58A 
  dsd_66A    = DataSourceDownload.get path_66A 
  dsd_253A   = DataSourceDownload.get path_253A 
  dsd_264A   = DataSourceDownload.get path_264A 

  
  if dsd_5A.download_changed? || dsd_6A.download_changed?  || dsd_13A.download_changed?  || dsd_43A.download_changed?  || dsd_44A.download_changed?  || dsd_58A.download_changed?  || dsd_66A.download_changed?  || dsd_253A.download_changed?  || dsd_264A.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  

     sox.add "GDPDEF@US",         Series.load_pattern("1929-01-01", "A",  path_13A, "csv", 6,  "increment:3:1")
     sox.add "YPC@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 10,  "increment:3:1")
     sox.add "YPCDPI@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 11,  "increment:3:1")
     sox.add "YPCCE@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 12,  "increment:3:1")
     sox.add "GDPPC@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 8,  "increment:3:1")
     sox.add "GNPPC@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 9,  "increment:3:1")
     sox.add "YPCDPI_R@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 19,  "increment:3:1")
     sox.add "YPCCE_R@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 20,  "increment:3:1")
     sox.add "GDPPC_R@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 17,  "increment:3:1")
     sox.add "GNPPC_R@US",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 18,  "increment:3:1")
     sox.add "GNP@US",         Series.load_pattern("1929-01-01", "A",  path_43A, "csv", 9,  "increment:3:1")
     sox.add "GNP_R@US",         Series.load_pattern("1929-01-01", "A",  path_44A, "csv", 10,  "increment:3:1")
     sox.add "Y@US",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 6,  "increment:3:1")
     sox.add "YDPI@US",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 32,  "increment:3:1")
     sox.add "YCE@US",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 34,  "increment:3:1")
     sox.add "YDPI_R@US",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 42,  "increment:3:1")
     sox.add "GDP_C@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 7,  "increment:3:1")
     sox.add "GDP_CD@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 9,  "increment:3:1")
     sox.add "GDP_CN@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 10,  "increment:3:1")
     sox.add "GDP_CS@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 11,  "increment:3:1")
     sox.add "GDP_I@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 12,  "increment:3:1")
     sox.add "GDP_IFX@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 13,  "increment:3:1")
     sox.add "GDP_INR@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 14,  "increment:3:1")
     sox.add "GDP_IRS@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 17,  "increment:3:1")
     sox.add "GDP_IIV@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 18,  "increment:3:1")
     sox.add "GDP_NX@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 19,  "increment:3:1")
     sox.add "GDP_EX@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 20,  "increment:3:1")
     sox.add "GDP_IM@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 23,  "increment:3:1")
     sox.add "GDP_G@US",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 26,  "increment:3:1")
     sox.add "YCE_R@US",         Series.load_pattern("1995-01-01", "A",  path_66A, "csv", 7,  "increment:3:1")
     sox.add "GDP_C_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 8,  "increment:3:1")
     sox.add "GDP_CD_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 10,  "increment:3:1")
     sox.add "GDP_CN_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 11,  "increment:3:1")
     sox.add "GDP_CS_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 12,  "increment:3:1")
     sox.add "GDP_I_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 13,  "increment:3:1")
     sox.add "GDP_IFX_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 14,  "increment:3:1")
     sox.add "GDP_INR_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 15,  "increment:3:1")
     sox.add "GDP_IRS_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 18,  "increment:3:1")
     sox.add "GDP_IIV_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 19,  "increment:3:1")
     sox.add "GDP_NX_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 20,  "increment:3:1")
     sox.add "GDP_EX_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 21,  "increment:3:1")
     sox.add "GDP_IM_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 24,  "increment:3:1")
     sox.add "GDP_G_R@US",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 27,  "increment:3:1")

   
    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Annual US (rake US_upd_a)", sox.output_summary
  end
end



###*******************************************************************


task :us_upd_m => :environment do
  require "Spreadsheet"
  path_76M      = "/Volumes/UHEROwork/data/rawdata/US_BEA76MONTH.csv"
  path_83M      = "/Volumes/UHEROwork/data/rawdata/US_BEA83MONTH.csv"
  path_75M      = "/Volumes/UHEROwork/data/rawdata/US_BEA75MONTH.csv"
  path_82M      = "/Volumes/UHEROwork/data/rawdata/US_BEA82MONTH.csv"
  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_m_NEW.xls"

  dsd_76M    = DataSourceDownload.get path_76M 
  dsd_83M    = DataSourceDownload.get path_83M
  dsd_75M    = DataSourceDownload.get path_75M
  dsd_82M    = DataSourceDownload.get path_82M 
  
  if dsd_76M.download_changed? || dsd_83M.download_changed?  || dsd_75M.download_changed?  || dsd_82M.download_changed?
  	sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "Y@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 6,  "increment:3:1")
  sox.add "YDPI@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 32,  "increment:3:1")
  sox.add "YCE@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 34,  "increment:3:1")
  sox.add "YDPI_R@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 42,  "increment:3:1")
  sox.add "YPCDPI@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 43,  "increment:3:1")
  sox.add "YPCDPI_R@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 44,  "increment:3:1")
  sox.add "N@US",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 45,  "increment:3:1")
  sox.add "YCE_R@US",         Series.load_pattern("1995-01-01", "M",  path_83M, "csv", 7,  "increment:3:1")
   
    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Monthly US (rake US_upd_m)", sox.output_summary
  end
end
