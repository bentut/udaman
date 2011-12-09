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
  path_ca_yp    = "/Volumes/UHEROwork/data/rawdata/CA_YP.csv"
  path_US_CAPUMN    = "/Volumes/UHEROwork/data/rawdata/US_CAPUMN_Q.TXT"
  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_q_NEW.xls"

  dsd_5      = DataSourceDownload.get(path_5Q).download_changed? 
  dsd_6      = DataSourceDownload.get(path_6Q).download_changed? 
  dsd_13     = DataSourceDownload.get(path_13Q).download_changed? 
  dsd_43     = DataSourceDownload.get(path_43Q).download_changed? 
  dsd_44     = DataSourceDownload.get(path_44Q).download_changed? 
  dsd_58     = DataSourceDownload.get(path_58Q).download_changed? 
  dsd_66     = DataSourceDownload.get(path_66Q).download_changed? 
  dsd_253    = DataSourceDownload.get(path_253Q).download_changed? 
  dsd_264    = DataSourceDownload.get(path_264Q).download_changed? 
  dsd_us_gdp = DataSourceDownload.get(path_us_gdp).download_changed? 
  dsd_ca_yp  = DataSourceDownload.get(path_ca_yp).download_changed? 
  dsd_US_CAPUMN  = DataSourceDownload.get(path_US_CAPUMN).download_changed? 
   
  
  if dsd_5 || dsd_6 || dsd_13 || dsd_43 || dsd_44 || dsd_58 || dsd_66 || dsd_253 || dsd_264|| dsd_us_gdp || dsd_ca_yp || dsd_US_CAPUMN
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

    sox.add "YP@CA.Q",         Series.load_pattern("1969-01-01", "Q",  path_ca_yp, "csv", 7, "increment:4:1")
  
    #sox.add_data "CAPUMN@US.Q",    "CAPUMN@US.Q".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPUMN_Q.TXT").data
  
    "CAPUMN@US.Q".ts_eval= %Q|"CAPUMN@US.Q".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPUMN_Q.TXT")|
  
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

  dsd_5A     = DataSourceDownload.get(path_5A).download_changed? 
  dsd_6A     = DataSourceDownload.get(path_6A).download_changed? 
  dsd_13A    = DataSourceDownload.get(path_13A).download_changed? 
  dsd_43A    = DataSourceDownload.get(path_43A).download_changed? 
  dsd_44A    = DataSourceDownload.get(path_44A).download_changed? 
  dsd_58A    = DataSourceDownload.get(path_58A).download_changed? 
  dsd_66A    = DataSourceDownload.get(path_66A).download_changed? 
  dsd_253A   = DataSourceDownload.get(path_253A).download_changed? 
  dsd_264A   = DataSourceDownload.get(path_264A).download_changed? 
  dsd_us_gdp = DataSourceDownload.get(path_us_gdp).download_changed? 
  dsd_ca_cpi = DataSourceDownload.get(path_ca_cpi).download_changed? 
  
  if dsd_5A || dsd_6A  || dsd_13A  || dsd_43A  || dsd_44A  || dsd_58A  || dsd_66A  || dsd_253A  || dsd_264A || dsd_us_gdp || dsd_ca_cpi
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
  path_US_STKNS        = "/Volumes/UHEROwork/data/rawdata/US_STKNS.csv"
  path_US_CAPU      = "/Volumes/UHEROwork/data/rawdata/US_CAPU_M.TXT"
  path_US_EXUSEU      = "/Volumes/UHEROwork/data/rawdata/US_EXUSEU_M.TXT"
  path_US_HOUST      = "/Volumes/UHEROwork/data/rawdata/US_HOUST_M.TXT"
  path_US_IP      = "/Volumes/UHEROwork/data/rawdata/US_IP_M.TXT"
  path_US_M2      = "/Volumes/UHEROwork/data/rawdata/US_M2_M.TXT"
  path_US_M2NS      = "/Volumes/UHEROwork/data/rawdata/US_M2NS_M.TXT"
  path_US_N      = "/Volumes/UHEROwork/data/rawdata/US_N_M.TXT"
  path_US_PCE      = "/Volumes/UHEROwork/data/rawdata/US_PCE_M.TXT"
  path_US_PCECORE        = "/Volumes/UHEROwork/data/rawdata/US_PCECORE_M.TXT"
  path_US_POIL      = "/Volumes/UHEROwork/data/rawdata/US_POIL_M.TXT"
  path_US_RAAANS      = "/Volumes/UHEROwork/data/rawdata/US_RAAANS_M.TXT"
  path_US_RFED      = "/Volumes/UHEROwork/data/rawdata/US_RFED_M.TXT"
  path_US_RILGFCY10      = "/Volumes/UHEROwork/data/rawdata/US_RILGFCY10_M.TXT"
  path_US_RMORT      = "/Volumes/UHEROwork/data/rawdata/US_RMORT_M.TXT"
  path_US_UMCSENT      = "/Volumes/UHEROwork/data/rawdata/US_UMCSENT_M.TXT"
 
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_m_NEW.xls"

  dsd_76M    = DataSourceDownload.get(path_76M).download_changed? 
  dsd_83M    = DataSourceDownload.get(path_83M).download_changed?
  dsd_75M    = DataSourceDownload.get(path_75M).download_changed?
  dsd_82M    = DataSourceDownload.get(path_82M).download_changed?
  dsd_US_STKNS       = DataSourceDownload.get(path_US_STKNS).download_changed?
  dsd_US_CAPU       = DataSourceDownload.get(path_US_CAPU).download_changed?
  dsd_US_EXUSEU       = DataSourceDownload.get(path_US_EXUSEU).download_changed?
  dsd_US_HOUST       = DataSourceDownload.get(path_US_HOUST).download_changed?
  dsd_US_IP       = DataSourceDownload.get(path_US_IP).download_changed?
  dsd_US_M2       = DataSourceDownload.get(path_US_M2).download_changed?
  dsd_US_M2NS       = DataSourceDownload.get(path_US_M2NS).download_changed?
  dsd_US_N       = DataSourceDownload.get(path_US_N).download_changed?
  dsd_US_PCE       = DataSourceDownload.get(path_US_PCE).download_changed?
  dsd_US_PCECORE       = DataSourceDownload.get(path_US_PCECORE).download_changed?
  dsd_US_POIL       = DataSourceDownload.get(path_US_POIL).download_changed?
  dsd_US_RAAANS       = DataSourceDownload.get(path_US_RAAANS).download_changed?
  dsd_US_RFED       = DataSourceDownload.get(path_US_RFED).download_changed?
  dsd_US_RILGFCY10       = DataSourceDownload.get(path_US_RILGFCY10).download_changed?
  dsd_US_RMORT       = DataSourceDownload.get(path_US_RMORT).download_changed?
  dsd_US_UMCSENT       = DataSourceDownload.get(path_US_UMCSENT).download_changed?
  
  if dsd_76M || dsd_83M  || dsd_75M  || dsd_82M || dsd_US_STKNS  || dsd_US_CAPU || dsd_US_EXUSEU || dsd_US_HOUST || dsd_US_IP || dsd_US_M2  || dsd_US_M2NS || dsd_US_N || dsd_US_PCE || dsd_US_PCECORE || dsd_US_POIL || dsd_US_RAAANS || dsd_US_RFED || dsd_US_RILGFCY10 || dsd_US_RMORT || dsd_US_UMCSENT
  
  	sox = SeriesOutputXls.new(output_path)#,true)
  
  #sox.add_data "CAPU@US.M",       "CAPU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPU_M.TXT").data
  #sox.add_data "EXUSEU@US.M",     "EXUSEU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_EXUSEU_M.TXT").data
  #sox.add_data "HOUST@US.M",      "HOUST@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_HOUST_M.TXT").data
  #sox.add_data "IP@US.M",         "IP@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_IP_M.TXT").data
  #sox.add_data "M2@US.M",         "M2@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2_M.TXT").data
  #sox.add_data "M2NS@US.M",       "M2NS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2NS_M.TXT").data
  #sox.add_data "N@US.M",          "N@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_N_M.TXT").data
  #sox.add_data "PCE@US.M",        "PCE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCE_M.TXT").data
  #sox.add_data "PCECORE@US.M",    "PCECORE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCECORE_M.TXT").data
  #sox.add_data "POIL@US.M",       "POIL@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_POIL_M.TXT").data
  #sox.add_data "RAAANS@US.M",     "RAAANS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RAAANS_M.TXT").data
  #sox.add_data "RFED@US.M",       "RFED@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RFED_M.TXT").data
  #sox.add_data "RILGFCY10@US.M",  "RILGFCY10@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RILGFCY10_M.TXT").data
  #sox.add_data "RMORT@US.M",      "RMORT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RMORT_M.TXT").data
  #sox.add_data "UMCSENT@US.M",    "UMCSENT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_UMCSENT_M.TXT").data
  
  "CAPU@US.M".ts_eval= %Q|"CAPU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_CAPU_M.TXT")|
  "EXUSEU@US.M".ts_eval= %Q|"EXUSEU@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_EXUSEU_M.TXT")|
  "HOUST@US.M".ts_eval= %Q|"HOUST@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_HOUST_M.TXT")|
  "IP@US.M".ts_eval= %Q|"IP@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_IP_M.TXT")|
  "M2@US.M".ts_eval= %Q|"M2@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2_M.TXT")|
  "M2NS@US.M".ts_eval= %Q|"M2NS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_M2NS_M.TXT")|
  "N@US.M".ts_eval= %Q|"N@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_N_M.TXT")|
  "PCE@US.M".ts_eval= %Q|"PCE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCE_M.TXT")|
  "PCECORE@US.M".ts_eval= %Q|"PCECORE@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_PCECORE_M.TXT")|
  "POIL@US.M".ts_eval= %Q|"POIL@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_POIL_M.TXT")|
  "RAAANS@US.M".ts_eval= %Q|"RAAANS@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RAAANS_M.TXT")|
  "RFED@US.M".ts_eval= %Q|"RFED@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RFED_M.TXT")|
  "RILGFCY10@US.M".ts_eval= %Q|"RILGFCY10@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RILGFCY10_M.TXT")|
  "RMORT@US.M".ts_eval= %Q|"RMORT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_RMORT_M.TXT")|
  "UMCSENT@US.M".ts_eval= %Q|"UMCSENT@US.M".tsn.load_standard_text("/Volumes/UHEROwork/data/rawdata/US_UMCSENT_M.TXT")|

  
  sox.add "Y@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 6,  "increment:3:1")
  sox.add "YDPI@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 32,  "increment:3:1")
  sox.add "YCE@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 34,  "increment:3:1")
  sox.add "YDPI_R@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 42,  "increment:3:1")
  sox.add "YPCDPI@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 43,  "increment:3:1")
  sox.add "YPCDPI_R@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 44,  "increment:3:1")
  sox.add "N@US.M",         Series.load_pattern("1959-01-01", "M",  path_76M, "csv", 45,  "increment:3:1")
  sox.add "YCE_R@US.M",         Series.load_pattern("1995-01-01", "M",  path_83M, "csv", 7,  "increment:3:1")
  
  sox.add_data "E_NF@US.M", DataHtmlParser.new.get_bls_series("CES0000000001", "M")
  sox.add_data "E_NFNS@US.M", DataHtmlParser.new.get_bls_series("CEU0000000001", "M")
  sox.add_data "E_PR@US.M", DataHtmlParser.new.get_bls_series("CES0500000001", "M")
  sox.add_data "E_PRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0500000001", "M")
  sox.add_data "E_GDSPR@US.M", DataHtmlParser.new.get_bls_series("CES0600000001", "M")
  sox.add_data "E_GDSPRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0600000001", "M")
  sox.add_data "E_SVCPR@US.M", DataHtmlParser.new.get_bls_series("CES0700000001", "M")
  sox.add_data "E_SVCPRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0700000001", "M")
  sox.add_data "EMI@US.M", DataHtmlParser.new.get_bls_series("CES1000000001", "M")
  sox.add_data "EMINS@US.M", DataHtmlParser.new.get_bls_series("CEU1000000001", "M")
  sox.add_data "ECT@US.M", DataHtmlParser.new.get_bls_series("CES2000000001", "M")
  sox.add_data "ECTNS@US.M", DataHtmlParser.new.get_bls_series("CEU2000000001", "M")
  sox.add_data "EMN@US.M", DataHtmlParser.new.get_bls_series("CES3000000001", "M")
  sox.add_data "EMNNS@US.M", DataHtmlParser.new.get_bls_series("CEU3000000001", "M")
  sox.add_data "EMNDR@US.M", DataHtmlParser.new.get_bls_series("CES3100000001", "M")
  sox.add_data "EMNDRNS@US.M", DataHtmlParser.new.get_bls_series("CEU3100000001", "M")
  sox.add_data "EMNND@US.M", DataHtmlParser.new.get_bls_series("CES3200000001", "M")
  sox.add_data "EMNNDNS@US.M", DataHtmlParser.new.get_bls_series("CEU3200000001", "M")
  sox.add_data "E_TTU@US.M", DataHtmlParser.new.get_bls_series("CES4000000001", "M")
  sox.add_data "E_TTUNS@US.M", DataHtmlParser.new.get_bls_series("CEU4000000001", "M")
  sox.add_data "EWT@US.M", DataHtmlParser.new.get_bls_series("CES4142000001", "M")
  sox.add_data "EWTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4142000001", "M")
  sox.add_data "ERT@US.M", DataHtmlParser.new.get_bls_series("CES4200000001", "M")
  sox.add_data "ERTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4200000001", "M")
  sox.add_data "ETW@US.M", DataHtmlParser.new.get_bls_series("CES4300000001", "M")
  sox.add_data "ETWNS@US.M", DataHtmlParser.new.get_bls_series("CEU4300000001", "M")
  sox.add_data "EUT@US.M", DataHtmlParser.new.get_bls_series("CES4422000001", "M")
  sox.add_data "EUTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4422000001", "M")
  sox.add_data "EIF@US.M", DataHtmlParser.new.get_bls_series("CES5000000001", "M")
  sox.add_data "EIFNS@US.M", DataHtmlParser.new.get_bls_series("CEU5000000001", "M")
  sox.add_data "E_FIR@US.M", DataHtmlParser.new.get_bls_series("CES5500000001", "M")
  sox.add_data "E_FIRNS@US.M", DataHtmlParser.new.get_bls_series("CEU5500000001", "M")
  sox.add_data "EFI@US.M", DataHtmlParser.new.get_bls_series("CES5552000001", "M")
  sox.add_data "EFINS@US.M", DataHtmlParser.new.get_bls_series("CEU5552000001", "M")
  sox.add_data "ERE@US.M", DataHtmlParser.new.get_bls_series("CES5553000001", "M")
  sox.add_data "ERENS@US.M", DataHtmlParser.new.get_bls_series("CEU5553000001", "M")
  sox.add_data "E_PBS@US.M", DataHtmlParser.new.get_bls_series("CES6000000001", "M")
  sox.add_data "E_PBSNS@US.M", DataHtmlParser.new.get_bls_series("CEU6000000001", "M")
  sox.add_data "EPS@US.M", DataHtmlParser.new.get_bls_series("CES6054000001", "M")
  sox.add_data "EPSNS@US.M", DataHtmlParser.new.get_bls_series("CEU6054000001", "M")
  sox.add_data "EMA@US.M", DataHtmlParser.new.get_bls_series("CES6055000001", "M")
  sox.add_data "EMANS@US.M", DataHtmlParser.new.get_bls_series("CEU6055000001", "M")
  sox.add_data "EAD@US.M", DataHtmlParser.new.get_bls_series("CES6056000001", "M")
  sox.add_data "EADNS@US.M", DataHtmlParser.new.get_bls_series("CEU6056000001", "M")
  sox.add_data "E_EDHC@US.M", DataHtmlParser.new.get_bls_series("CES6500000001", "M")
  sox.add_data "E_EDHCNS@US.M", DataHtmlParser.new.get_bls_series("CEU6500000001", "M")
  sox.add_data "EED@US.M", DataHtmlParser.new.get_bls_series("CES6561000001", "M")
  sox.add_data "EEDNS@US.M", DataHtmlParser.new.get_bls_series("CEU6561000001", "M")
  sox.add_data "EHC@US.M", DataHtmlParser.new.get_bls_series("CES6562000001", "M")
  sox.add_data "EHCNS@US.M", DataHtmlParser.new.get_bls_series("CEU6562000001", "M")
  sox.add_data "E_LH@US.M", DataHtmlParser.new.get_bls_series("CES7000000001", "M")
  sox.add_data "E_LHNS@US.M", DataHtmlParser.new.get_bls_series("CEU7000000001", "M")
  sox.add_data "EAE@US.M", DataHtmlParser.new.get_bls_series("CES7071000001", "M")
  sox.add_data "EAENS@US.M", DataHtmlParser.new.get_bls_series("CEU7071000001", "M")
  sox.add_data "EAF@US.M", DataHtmlParser.new.get_bls_series("CES7072000001", "M")
  sox.add_data "EAFNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072000001", "M")
  sox.add_data "EAFAC@US.M", DataHtmlParser.new.get_bls_series("CES7072100001", "M")
  sox.add_data "EAFACNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072100001", "M")
  sox.add_data "EAFFD@US.M", DataHtmlParser.new.get_bls_series("CES7072200001", "M")
  sox.add_data "EAFFDNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072200001", "M")
  sox.add_data "EOS@US.M", DataHtmlParser.new.get_bls_series("CES8000000001", "M")
  sox.add_data "EOSNS@US.M", DataHtmlParser.new.get_bls_series("CEU8000000001", "M")
  sox.add_data "EGV@US.M", DataHtmlParser.new.get_bls_series("CES9000000001", "M")
  sox.add_data "EGVNS@US.M", DataHtmlParser.new.get_bls_series("CEU9000000001", "M")
  sox.add_data "EGVFD@US.M", DataHtmlParser.new.get_bls_series("CES9091000001", "M")
  sox.add_data "EGVFDNS@US.M", DataHtmlParser.new.get_bls_series("CEU9091000001", "M")
  sox.add_data "EGVST@US.M", DataHtmlParser.new.get_bls_series("CES9092000001", "M")
  sox.add_data "EGVSTNS@US.M", DataHtmlParser.new.get_bls_series("CEU9092000001", "M")
  sox.add_data "EGVLC@US.M", DataHtmlParser.new.get_bls_series("CES9093000001", "M")
  sox.add_data "EGVLCNS@US.M", DataHtmlParser.new.get_bls_series("CEU9093000001", "M")
  
  sox.add_data "LF@US.M", DataHtmlParser.new.get_bls_series("LNS11000000", "M")
  sox.add_data "LFNS@US.M", DataHtmlParser.new.get_bls_series("LNU01000000", "M")
  sox.add_data "EMPL@US.M", DataHtmlParser.new.get_bls_series("LNS12000000", "M")
  sox.add_data "EMPLNS@US.M", DataHtmlParser.new.get_bls_series("LNU02000000", "M")
  sox.add_data "UR@US.M", DataHtmlParser.new.get_bls_series("LNS14000000", "M")
  sox.add_data "URNS@US.M", DataHtmlParser.new.get_bls_series("LNU04000000", "M")
  
  sox.add_data "UR@CA.M", DataHtmlParser.new.get_bls_series("LASST06000003", "M")
  sox.add_data "EMPL@CA.M", DataHtmlParser.new.get_bls_series("LASST06000005", "M")
  sox.add_data "LF@CA.M", DataHtmlParser.new.get_bls_series("LASST06000006", "M")
  sox.add_data "URNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000003", "M")
  sox.add_data "EMPLNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000005", "M")
  sox.add_data "LFNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000006", "M")
  sox.add_data "ENF@CA.M", DataHtmlParser.new.get_bls_series("SMS06000000000000001", "M")
  sox.add_data "ENFNS@CA.M", DataHtmlParser.new.get_bls_series("SMU06000000000000001", "M")
  
  sox.add_data "CPI@US.M", DataHtmlParser.new.get_bls_series("CUSR0000SA0", "M")
  sox.add_data "CPINS@US.M", DataHtmlParser.new.get_bls_series("CUUR0000SA0", "M")
  sox.add_data "CPICORE@US.M", DataHtmlParser.new.get_bls_series("CUSR0000SA0L1E", "M")
  sox.add_data "CPICORENS@US.M", DataHtmlParser.new.get_bls_series("CUUR0000SA0L1E", "M")
 
  sox.add "STKNS@US.M",         Series.load_pattern("row2:col1:rev", "M", path_US_STKNS, "csv", "increment:2:1", 7)


    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Monthly US (rake US_upd_m)", sox.output_summary
  end
end



