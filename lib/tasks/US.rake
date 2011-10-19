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
  
  output_path   = "/Volumes/UHEROwork/data/us/update/us_upd_m_NEW.xls"

  dsd_76M    = DataSourceDownload.get path_76M 
  dsd_83M    = DataSourceDownload.get path_83M
  dsd_75M    = DataSourceDownload.get path_75M
  dsd_82M    = DataSourceDownload.get path_82M 
  
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

  
    sox.write_xls
   # NotificationMailer.deliver_new_download_notification "Monthly US (rake US_upd_m)", sox.output_summary
  end
end
