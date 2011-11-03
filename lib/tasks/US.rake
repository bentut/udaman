#US DATA


###*******************************************************************
###NOTES BOX

#be sure to use lower case for "increment" command
#when there are non-number things in the CSV, move the location up to avoid them
#some of the month download files seem to be downloading inconsistent time periods
#some of the GPP series are pulling blanks, and this is unexplained

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
  path_us_gdp   = "/Volumes/UHEROwork/data/rawdata/US_GDP.xls"

  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_q_NEW.xls"

  dsd_5      = DataSourceDownload.get path_5Q 
  dsd_6      = DataSourceDownload.get path_6Q 
  dsd_13     = DataSourceDownload.get path_13Q 
  dsd_43     = DataSourceDownload.get path_43Q 
  dsd_44     = DataSourceDownload.get path_44Q 
  dsd_58     = DataSourceDownload.get path_58Q 
  dsd_66     = DataSourceDownload.get path_66Q 
  dsd_253    = DataSourceDownload.get path_253Q 
  dsd_264    = DataSourceDownload.get path_264Q 
  dsd_us_gdp = DataSourceDownload.get path_us_gdp 
  
  if dsd_5.download_changed? || dsd_6.download_changed?  || dsd_13.download_changed?  || dsd_43.download_changed?  || dsd_44.download_changed?  || dsd_58.download_changed?  || dsd_66.download_changed?  || dsd_253.download_changed?  || dsd_264.download_changed? || dsd_us_gdp.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  
    sox.add "GDPDEF@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_13Q, "csv", 7,  "increment:3:1")
    sox.add "YPC@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 11,  "increment:3:1")
    sox.add "YPCDPI@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 12,  "increment:3:1")
    sox.add "YPCCE@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 13,  "increment:3:1")
    sox.add "GDPPC@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 9,  "increment:3:1")
    sox.add "GNPPC@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 10,  "increment:3:1")
    sox.add "YPCDPI_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 20,  "increment:3:1")
    sox.add "YPCCE_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 21,  "increment:3:1")
    sox.add "GDPPC_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 18,  "increment:3:1")
    sox.add "GNPPC_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 19,  "increment:3:1")
    sox.add "N@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_264Q, "csv", 26,  "increment:3:1")
    sox.add "GNP@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_43Q, "csv", 10,  "increment:3:1")
    sox.add "GNP_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_44Q, "csv", 11,  "increment:3:1")
    sox.add "Y@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 7,  "increment:3:1")
    sox.add "YDPI@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 33,  "increment:3:1")
    sox.add "YCE@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 35,  "increment:3:1")
    sox.add "YDPI_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_58Q, "csv", 43,  "increment:3:1")
    sox.add "GDP_C@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 8,  "increment:3:1")
    sox.add "GDP_CD@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 10,  "increment:3:1")
    sox.add "GDP_CN@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 11,  "increment:3:1")
    sox.add "GDP_CS@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 12,  "increment:3:1")
    sox.add "GDP_I@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 13,  "increment:3:1")
    sox.add "GDP_IFX@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 14,  "increment:3:1")
    sox.add "GDP_INR@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 15,  "increment:3:1")
    sox.add "GDP_IRS@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 18,  "increment:3:1")
    sox.add "GDP_IIV@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 19,  "increment:3:1")
    sox.add "GDP_NX@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 20,  "increment:3:1")
    sox.add "GDP_EX@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 21,  "increment:3:1")
    sox.add "GDP_IM@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 24,  "increment:3:1")
    sox.add "GDP_G@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_5Q, "csv", 27,  "increment:3:1")
    sox.add "YCE_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_66Q, "csv", 8,  "increment:3:1")
    sox.add "GDP_C_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 9,  "increment:3:1")
    sox.add "GDP_CD_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 11,  "increment:195:1")
    sox.add "GDP_CN_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 12,  "increment:195:1")
    sox.add "GDP_CS_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 13,  "increment:195:1")
    sox.add "GDP_I_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 14,  "increment:3:1")
    sox.add "GDP_IFX_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 15,  "increment:195:1")
    sox.add "GDP_INR_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 16,  "increment:195:1")
    sox.add "GDP_IRS_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 19,  "increment:195:1")
    sox.add "GDP_IIV_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 20,  "increment:195:1")
    sox.add "GDP_NX_R@US.Q",         Series.load_pattern("1995-01-01", "Q",  path_6Q, "csv", 21,  "increment:195:1")
    sox.add "GDP_EX_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 22,  "increment:3:1")
    sox.add "GDP_IM_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 25,  "increment:3:1")
    sox.add "GDP_G_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_6Q, "csv", 28,  "increment:3:1")
    sox.add "GDP@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_us_gdp, "sheet_num:1", "increment:9:1", 6)
    sox.add "GDP_R@US.Q",         Series.load_pattern("1947-01-01", "Q",  path_us_gdp, "sheet_num:1", "increment:9:1", 7)

  
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
  path_us_gdp   = "/Volumes/UHEROwork/data/rawdata/US_GDP.xls"
  path_ca_cpi   = "/Volumes/UHEROwork/data/rawdata/CA_CPI.xls"
  
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
  dsd_us_gdp = DataSourceDownload.get path_us_gdp 
  dsd_ca_cpi = DataSourceDownload.get path_ca_cpi 
  
  if dsd_5A.download_changed? || dsd_6A.download_changed?  || dsd_13A.download_changed?  || dsd_43A.download_changed?  || dsd_44A.download_changed?  || dsd_58A.download_changed?  || dsd_66A.download_changed?  || dsd_253A.download_changed?  || dsd_264A.download_changed? || dsd_us_gdp.download_changed? || dsd_ca_cpi.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  

     sox.add "GDPDEF@US.A",         Series.load_pattern("1929-01-01", "A",  path_13A, "csv", 6,  "increment:3:1")
     sox.add "YPC@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 10,  "increment:3:1")
     sox.add "YPCDPI@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 11,  "increment:3:1")
     sox.add "YPCCE@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 12,  "increment:3:1")
     sox.add "GDPPC@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 8,  "increment:3:1")
     sox.add "GNPPC@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 9,  "increment:3:1")
     sox.add "YPCDPI_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 19,  "increment:3:1")
     sox.add "YPCCE_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 20,  "increment:3:1")
     sox.add "GDPPC_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 17,  "increment:3:1")
     sox.add "GNPPC_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_264A, "csv", 18,  "increment:3:1")
     sox.add "GNP@US.A",         Series.load_pattern("1929-01-01", "A",  path_43A, "csv", 9,  "increment:3:1")
     sox.add "GNP_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_44A, "csv", 10,  "increment:3:1")
     sox.add "Y@US.A",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 6,  "increment:3:1")
     sox.add "YDPI@US.A",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 32,  "increment:3:1")
     sox.add "YCE@US.A",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 34,  "increment:3:1")
     sox.add "YDPI_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_58A, "csv", 42,  "increment:3:1")
     sox.add "GDP_C@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 7,  "increment:3:1")
     sox.add "GDP_CD@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 9,  "increment:3:1")
     sox.add "GDP_CN@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 10,  "increment:3:1")
     sox.add "GDP_CS@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 11,  "increment:3:1")
     sox.add "GDP_I@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 12,  "increment:3:1")
     sox.add "GDP_IFX@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 13,  "increment:3:1")
     sox.add "GDP_INR@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 14,  "increment:3:1")
     sox.add "GDP_IRS@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 17,  "increment:3:1")
     sox.add "GDP_IIV@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 18,  "increment:3:1")
     sox.add "GDP_NX@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 19,  "increment:3:1")
     sox.add "GDP_EX@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 20,  "increment:3:1")
     sox.add "GDP_IM@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 23,  "increment:3:1")
     sox.add "GDP_G@US.A",         Series.load_pattern("1929-01-01", "A",  path_5A, "csv", 26,  "increment:3:1")
     sox.add "YCE_R@US.A",         Series.load_pattern("1995-01-01", "A",  path_66A, "csv", 7,  "increment:3:1")
     sox.add "GDP_C_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 8,  "increment:3:1")
     sox.add "GDP_CD_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 10,  "increment:3:1")
     sox.add "GDP_CN_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 11,  "increment:3:1")
     sox.add "GDP_CS_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 12,  "increment:3:1")
     sox.add "GDP_I_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 13,  "increment:3:1")
     sox.add "GDP_IFX_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 14,  "increment:3:1")
     sox.add "GDP_INR_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 15,  "increment:3:1")
     sox.add "GDP_IRS_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 18,  "increment:3:1")
     sox.add "GDP_IIV_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 19,  "increment:3:1")
     sox.add "GDP_NX_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 20,  "increment:3:1")
     sox.add "GDP_EX_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 21,  "increment:3:1")
     sox.add "GDP_IM_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 24,  "increment:3:1")
     sox.add "GDP_G_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_6A, "csv", 27,  "increment:3:1")
     sox.add "GDP@US.A",         Series.load_pattern("1929-01-01", "A",  path_us_gdp, "sheet_num:1", "increment:9:1", 2)
     sox.add "GDP_R@US.A",         Series.load_pattern("1929-01-01", "A",  path_us_gdp, "sheet_num:1", "increment:9:1", 3)
     sox.add "CPI@CA.A",         Series.load_pattern("1970-01-01", "A",  path_ca_cpi, "sheet_num:1", "increment:7:1", 9)

   
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
  path_US_STKNS        = "/Volumes/UHEROwork/data/rawdata/US_STKNS.CSV"
  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_m_NEW.xls"

  dsd_76M    = DataSourceDownload.get path_76M 
  dsd_83M    = DataSourceDownload.get path_83M
  dsd_75M    = DataSourceDownload.get path_75M
  dsd_82M    = DataSourceDownload.get path_82M 
  dsd_US_STKNS       = DataSourceDownload.get path_US_STKNS
  
  if dsd_76M.download_changed? || dsd_83M.download_changed?  || dsd_75M.download_changed?  || dsd_82M.download_changed?
  	sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "Y@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 6,  "increment:3:1")
  sox.add "YDPI@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 32,  "increment:3:1")
  sox.add "YCE@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 34,  "increment:3:1")
  sox.add "YDPI_R@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 42,  "increment:3:1")
  sox.add "YPCDPI@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 43,  "increment:3:1")
  sox.add "YPCDPI_R@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 44,  "increment:3:1")
  sox.add "N@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 45,  "increment:3:1")
  sox.add "YCE_R@US.M",         Series.load_pattern("1995-01-01", "M",  path_83M, "csv", 7,  "increment:3:1")
  
  "CAPU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPU_M.TXT")
  "EXUSEU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_EXUSEU_M.TXT")
  "HOUST@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_HOUST_M.TXT")
  "IP@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_IP_M.TXT")
  "M2@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2_M.TXT")
  "M2NS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2NS_M.TXT")
  "N@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_N_M.TXT")
  "PCE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCE_M.TXT")
  "PCECORE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCECORE_M.TXT")
  "POIL@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_POIL_M.TXT")
  "RAAANS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RAAANS_M.TXT")
  "RFED@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RFED_M.TXT")
  "RILGFCY10@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RILGFCY10_M.TXT")
  "RMORT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RMORT_M.TXT")
  "UMCSENT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_UMCSENT_M.TXT")
  "YXR@JP.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/JP_YXR.TXT")  
  
  "E_NF@US.M".ts_eval=%Q|"E_NF@US.M".tsn.load_from_bls("CES0000000001", "M")|
  "E_NFNS@US.M".ts_eval=%Q|"E_NFNS@US.M".tsn.load_from_bls("CEU0000000001", "M")|
  "E_PR@US.M".ts_eval=%Q|"E_PR@US.M".tsn.load_from_bls("CES0500000001", "M")|
  "E_PRNS@US.M".ts_eval=%Q|"E_PRNS@US.M".tsn.load_from_bls("CEU0500000001", "M")|
  "E_GDSPR@US.M".ts_eval=%Q|"E_GDSPR@US.M".tsn.load_from_bls("CES0600000001", "M")|
  "E_GDSPRNS@US.M".ts_eval=%Q|"E_GDSPRNS@US.M".tsn.load_from_bls("CEU0600000001", "M")|
  "E_SVCPR@US.M".ts_eval=%Q|"E_SVCPR@US.M".tsn.load_from_bls("CES0700000001", "M")|
  "E_SVCPRNS@US.M".ts_eval=%Q|"E_SVCPRNS@US.M".tsn.load_from_bls("CEU0700000001", "M")|
  "EMI@US.M".ts_eval=%Q|"EMI@US.M".tsn.load_from_bls("CES1000000001", "M")|
  "EMINS@US.M".ts_eval=%Q|"EMINS@US.M".tsn.load_from_bls("CEU1000000001", "M")|
  "ECT@US.M".ts_eval=%Q|"ECT@US.M".tsn.load_from_bls("CES2000000001", "M")|
  "ECTNS@US.M".ts_eval=%Q|"ECTNS@US.M".tsn.load_from_bls("CEU2000000001", "M")|
  "EMN@US.M".ts_eval=%Q|"EMN@US.M".tsn.load_from_bls("CES3000000001", "M")|
  "EMNNS@US.M".ts_eval=%Q|"EMNNS@US.M".tsn.load_from_bls("CEU3000000001", "M")|
  "EMNDR@US.M".ts_eval=%Q|"EMNDR@US.M".tsn.load_from_bls("CES3100000001", "M")|
  "EMNDRNS@US.M".ts_eval=%Q|"EMNDRNS@US.M".tsn.load_from_bls("CEU3100000001", "M")|
  "EMNND@US.M".ts_eval=%Q|"EMNND@US.M".tsn.load_from_bls("CES3200000001", "M")|
  "EMNNDNS@US.M".ts_eval=%Q|"EMNNDNS@US.M".tsn.load_from_bls("CEU3200000001", "M")|
  "E_TTU@US.M".ts_eval=%Q|"E_TTU@US.M".tsn.load_from_bls("CES4000000001", "M")|
  "E_TTUNS@US.M".ts_eval=%Q|"E_TTUNS@US.M".tsn.load_from_bls("CEU4000000001", "M")|
  "EWT@US.M".ts_eval=%Q|"EWT@US.M".tsn.load_from_bls("CES4142000001", "M")|
  "EWTNS@US.M".ts_eval=%Q|"EWTNS@US.M".tsn.load_from_bls("CEU4142000001", "M")|
  "ERT@US.M".ts_eval=%Q|"ERT@US.M".tsn.load_from_bls("CES4200000001", "M")|
  "ERTNS@US.M".ts_eval=%Q|"ERTNS@US.M".tsn.load_from_bls("CEU4200000001", "M")|
  "ETW@US.M".ts_eval=%Q|"ETW@US.M".tsn.load_from_bls("CES4300000001", "M")|
  "ETWNS@US.M".ts_eval=%Q|"ETWNS@US.M".tsn.load_from_bls("CEU4300000001", "M")|
  "EUT@US.M".ts_eval=%Q|"EUT@US.M".tsn.load_from_bls("CES4422000001", "M")|
  "EUTNS@US.M".ts_eval=%Q|"EUTNS@US.M".tsn.load_from_bls("CEU4422000001", "M")|
  "EIF@US.M".ts_eval=%Q|"EIF@US.M".tsn.load_from_bls("CES5000000001", "M")|
  "EIFNS@US.M".ts_eval=%Q|"EIFNS@US.M".tsn.load_from_bls("CEU5000000001", "M")|
  "E_FIR@US.M".ts_eval=%Q|"E_FIR@US.M".tsn.load_from_bls("CES5500000001", "M")|
  "E_FIRNS@US.M".ts_eval=%Q|"E_FIRNS@US.M".tsn.load_from_bls("CEU5500000001", "M")|
  "EFI@US.M".ts_eval=%Q|"EFI@US.M".tsn.load_from_bls("CES5552000001", "M")|
  "EFINS@US.M".ts_eval=%Q|"EFINS@US.M".tsn.load_from_bls("CEU5552000001", "M")|
  "ERE@US.M".ts_eval=%Q|"ERE@US.M".tsn.load_from_bls("CES5553000001", "M")|
  "ERENS@US.M".ts_eval=%Q|"ERENS@US.M".tsn.load_from_bls("CEU5553000001", "M")|
  "E_PBS@US.M".ts_eval=%Q|"E_PBS@US.M".tsn.load_from_bls("CES6000000001", "M")|
  "E_PBSNS@US.M".ts_eval=%Q|"E_PBSNS@US.M".tsn.load_from_bls("CEU6000000001", "M")|
  "EPS@US.M".ts_eval=%Q|"EPS@US.M".tsn.load_from_bls("CES6054000001", "M")|
  "EPSNS@US.M".ts_eval=%Q|"EPSNS@US.M".tsn.load_from_bls("CEU6054000001", "M")|
  "EMA@US.M".ts_eval=%Q|"EMA@US.M".tsn.load_from_bls("CES6055000001", "M")|
  "EMANS@US.M".ts_eval=%Q|"EMANS@US.M".tsn.load_from_bls("CEU6055000001", "M")|
  "EAD@US.M".ts_eval=%Q|"EAD@US.M".tsn.load_from_bls("CES6056000001", "M")|
  "EADNS@US.M".ts_eval=%Q|"EADNS@US.M".tsn.load_from_bls("CEU6056000001", "M")|
  "E_EDHC@US.M".ts_eval=%Q|"E_EDHC@US.M".tsn.load_from_bls("CES6500000001", "M")|
  "E_EDHCNS@US.M".ts_eval=%Q|"E_EDHCNS@US.M".tsn.load_from_bls("CEU6500000001", "M")|
  "EED@US.M".ts_eval=%Q|"EED@US.M".tsn.load_from_bls("CES6561000001", "M")|
  "EEDNS@US.M".ts_eval=%Q|"EEDNS@US.M".tsn.load_from_bls("CEU6561000001", "M")|
  "EHC@US.M".ts_eval=%Q|"EHC@US.M".tsn.load_from_bls("CES6562000001", "M")|
  "EHCNS@US.M".ts_eval=%Q|"EHCNS@US.M".tsn.load_from_bls("CEU6562000001", "M")|
  "E_LH@US.M".ts_eval=%Q|"E_LH@US.M".tsn.load_from_bls("CES7000000001", "M")|
  "E_LHNS@US.M".ts_eval=%Q|"E_LHNS@US.M".tsn.load_from_bls("CEU7000000001", "M")|
  "EAE@US.M".ts_eval=%Q|"EAE@US.M".tsn.load_from_bls("CES7071000001", "M")|
  "EAENS@US.M".ts_eval=%Q|"EAENS@US.M".tsn.load_from_bls("CEU7071000001", "M")|
  "EAF@US.M".ts_eval=%Q|"EAF@US.M".tsn.load_from_bls("CES7072000001", "M")|
  "EAFNS@US.M".ts_eval=%Q|"EAFNS@US.M".tsn.load_from_bls("CEU7072000001", "M")|
  "EAFAC@US.M".ts_eval=%Q|"EAFAC@US.M".tsn.load_from_bls("CES7072100001", "M")|
  "EAFACNS@US.M".ts_eval=%Q|"EAFACNS@US.M".tsn.load_from_bls("CEU7072100001", "M")|
  "EAFFD@US.M".ts_eval=%Q|"EAFFD@US.M".tsn.load_from_bls("CES7072200001", "M")|
  "EAFFDNS@US.M".ts_eval=%Q|"EAFFDNS@US.M".tsn.load_from_bls("CEU7072200001", "M")|
  "EOS@US.M".ts_eval=%Q|"EOS@US.M".tsn.load_from_bls("CES8000000001", "M")|
  "EOSNS@US.M".ts_eval=%Q|"EOSNS@US.M".tsn.load_from_bls("CEU8000000001", "M")|
  "EGV@US.M".ts_eval=%Q|"EGV@US.M".tsn.load_from_bls("CES9000000001", "M")|
  "EGVNS@US.M".ts_eval=%Q|"EGVNS@US.M".tsn.load_from_bls("CEU9000000001", "M")|
  "EGVFD@US.M".ts_eval=%Q|"EGVFD@US.M".tsn.load_from_bls("CES9091000001", "M")|
  "EGVFDNS@US.M".ts_eval=%Q|"EGVFDNS@US.M".tsn.load_from_bls("CEU9091000001", "M")|
  "EGVST@US.M".ts_eval=%Q|"EGVST@US.M".tsn.load_from_bls("CES9092000001", "M")|
  "EGVSTNS@US.M".ts_eval=%Q|"EGVSTNS@US.M".tsn.load_from_bls("CEU9092000001", "M")|
  "EGVLC@US.M".ts_eval=%Q|"EGVLC@US.M".tsn.load_from_bls("CES9093000001", "M")|
  "EGVLCNS@US.M".ts_eval=%Q|"EGVLCNS@US.M".tsn.load_from_bls("CEU9093000001", "M")|
  
  "LF@US.M".ts_eval=%Q|"LF@US.M".tsn.load_from_bls("LNS11000000", "M")|
  "LFNS@US.M".ts_eval=%Q|"LFNS@US.M".tsn.load_from_bls("LNU01000000", "M")|
  "EMPL@US.M".ts_eval=%Q|"EMPL@US.M".tsn.load_from_bls("LNS12000000", "M")|
  "EMPLNS@US.M".ts_eval=%Q|"EMPLNS@US.M".tsn.load_from_bls("LNU02000000", "M")|
  "UR@US.M".ts_eval=%Q|"UR@US.M".tsn.load_from_bls("LNS14000000", "M")|
  "URNS@US.M".ts_eval=%Q|"URNS@US.M".tsn.load_from_bls("LNU04000000", "M")|
  
  "UR@CA.M".ts_eval=%Q|"UR@CA.M".tsn.load_from_bls("LASST06000003", "M")|
  "EMPL@CA.M".ts_eval=%Q|"EMPL@CA.M".tsn.load_from_bls("LASST06000005", "M")|
  "LF@CA.M".ts_eval=%Q|"LF@CA.M".tsn.load_from_bls("LASST06000006", "M")|
  "URNS@CA.M".ts_eval=%Q|"URNS@CA.M".tsn.load_from_bls("LAUST06000003", "M")|
  "EMPLNS@CA.M".ts_eval=%Q|"EMPLNS@CA.M".tsn.load_from_bls("LAUST06000005", "M")|
  "LFNS@CA.M".ts_eval=%Q|"LFNS@CA.M".tsn.load_from_bls("LAUST06000006", "M")|
  "ENF@CA.M".ts_eval=%Q|"ENF@CA.M".tsn.load_from_bls("SMS06000000000000001", "M")|
  "ENFNS@CA.M".ts_eval=%Q|"ENFNS@CA.M".tsn.load_from_bls("SMU06000000000000001", "M")|
  
  "CPI@US.M".ts_eval=%Q|"CPI@US.M".tsn.load_from_bls("CUSR0000SA0", "M")|
  "CPINS@US.M".ts_eval=%Q|"CPINS@US.M".tsn.load_from_bls("CUUR0000SA0", "M")|
  "CPICORE@US.M".ts_eval=%Q|"CPICORE@US.M".tsn.load_from_bls("CUSR0000SA0L1E", "M")|
  "CPICORENS@US.M".ts_eval=%Q|"CPICORENS@US.M".tsn.load_from_bls("CUUR0000SA0L1E", "M")|

  sox.add "STKNS@US.D",         Series.load_pattern("row2:col1:rev", "WD", path_US_STKNS, "csv", "increment:2:1", 7)

    dlp = DataLoadPattern.new(
      :start_date => "row2:col1:rev", 
      :frequency => "WD" , 
      :path => "/Volumes/UHEROwork/data/rawdata/US_STKNS.CSV" , 
      :worksheet => "csv", 
      :row => "increment:2:1", 
      :col => 7
    )

  
    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Monthly US (rake US_upd_m)", sox.output_summary
  end
end





#task :us_upd_q => :environment do
#  require "Spreadsheet"
#  path_76M      = "/Volumes/UHEROwork/data/rawdata/US_BEA76MONTH.csv"
#  
#  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_m_NEW.xls"
#
#  dsd_76M    = DataSourceDownload.get path_76M 
#  
#  "CAPUMN@US.Q".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPUMN_Q.TXT")
#  
#  
#    sox.write_xls
#   # NotificationMailer.deliver_new_download_notification "Monthly US (rake US_upd_m)", sox.output_summary
#  end
#end