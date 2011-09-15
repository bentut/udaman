#JAPAN SERIES DOWNLOADS

###*******************************************************************
###NOTES BOX


###*******************************************************************



task :jp_upd_a => :environment do
  require "Spreadsheet"
  path_JP_GDP_A          = "/Volumes/UHEROwork-1/data/rawdata/path_JP_GDP_A"
  path_JP_GDP_R_A        = "/Volumes/UHEROwork-1/data/rawdata/path_JP_GDP_R_A"
  path_JP_GDPDEF_A       = "/Volumes/UHEROwork-1/data/rawdata/GDPDEF@JP.A.CSV"

  output_path   = "/Volumes/UHEROwork/data/jp/update/jp_upd_a_NEW.xls"

  dsd_JP_GDP_A         = DataSourceDownload.get path_JP_GDP_A  
  dsd_JP_GDP_R_A       = DataSourceDownload.get path_JP_GDP_R_A  
  dsd_JP_GDPDEF_A      = DataSourceDownload.get path_JP_GDPDEF_A  

  if dsd_JP_GDP_A.download_changed? || dsd_JP_GDP_R_A.download_changed? || dsd_JP_GDPDEF_A.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "GDP@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 2)
  sox.add "GDP_CP@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSP@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 6)
  sox.add "GDP_INRP@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVP@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 8)
  sox.add "GDP_CG@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXG@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVG@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 11)
  sox.add "GDP_NX@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 12)
  sox.add "GDP_EX@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 13)
  sox.add "GDP_IM@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 14)
  sox.add "GNI@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 19)
  sox.add "GDP_IFX@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_A", "GDP@JP.A", "INCREMENT:8:1", 25)

  sox.add "GDP_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 2)
  sox.add "GDP_CP_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSP_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 6)
  sox.add "GDP_INRP_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVP_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 8)
  sox.add "GDP_CG_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXG_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVG_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 11)
  sox.add "GDP_NX_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 12)
  sox.add "GDP_EX_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 13)
  sox.add "GDP_IM_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 14)
  sox.add "GNI_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 22)
  sox.add "GDP_IFX_R@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDP_R_A", "GDP_R@JP.A", "INCREMENT:8:1", 28)

  sox.add "GDPDEF@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDPDEF_A", "GDPDEF@JP.A", "INCREMENT:8:1", 2)
  sox.add "GNIDEF@JP",         Series.load_pattern("1980-01-01", "A", "path_JP_GDPDEF_A", "GDPDEF@JP.A", "INCREMENT:8:1", 19)
  
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "ANNUAL JAPAN (rake jp_upd_a)", sox.output_summary
  end
end

###*******************************************************************




task :jp_upd_q => :environment do
  require "Spreadsheet"
  path_JP_GDP_Q       = "/Volumes/UHEROwork/data/rawdata/GDP@JP.Q.CSV"
  path_JP_GDPNS_Q     = "/Volumes/UHEROwork/data/rawdata/GDPNS@JP.Q.CSV"
  path_JP_GDP_R_Q     = "/Volumes/UHEROwork/data/rawdata/GDP_R@JP.Q.CSV"
  path_JP_GDP_RNS_Q   = "/Volumes/UHEROwork/data/rawdata/GDP_RNS@JP.Q.CSV"
  path_JP_GDPDEF_Q    = "/Volumes/UHEROwork/data/rawdata/GDPDEF@JP.Q.CSV"
  path_JP_CSCFNS      = "/Volumes/UHEROwork/data/rawdata/JP_CSCFNS.XLS"
  path_JP_CSCF        = "/Volumes/UHEROwork/data/rawdata/JP_CSCF.XLS"

  output_path   = "/Volumes/UHEROwork/data/jp/update/jp_upd_q_NEW.xls"

  dsd_JP_GDP_Q        = DataSourceDownload.get path_JP_GDP_Q
  dsd_JP_GDPNS_Q      = DataSourceDownload.get path_JP_GDPNS_Q 
  dsd_JP_GDP_R_Q      = DataSourceDownload.get path_JP_GDP_R_Q
  dsd_JP_GDP_RNS_Q    = DataSourceDownload.get path_JP_GDP_RNS_Q 
  dsd_JP_GDPDEF_Q     = DataSourceDownload.get path_JP_GDPDEF_Q 
  dsd_JP_CSCFNS       = DataSourceDownload.get path_JP_CSCFNS
  dsd_JP_CSCF         = DataSourceDownload.get path_JP_CSCF

  if dsd_JP_GDP_Q.download_changed? || dsd_JP_GDPNS_Q.download_changed? || dsd_JP_GDP_R_Q.download_changed? || dsd_JP_GDP_RNS_Q.download_changed? || dsd_JP_GDPDEF_Q.download_changed? || dsd_JP_CSCFNS.download_changed? || dsd_JP_CSCF.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "GDP@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 2)
  sox.add "GDP_CP@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSP@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 6)
  sox.add "GDP_INRP@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVP@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 8)
  sox.add "GDP_CG@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXG@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVG@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 11)
  sox.add "GDP_NX@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 12)
  sox.add "GDP_EX@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 13)
  sox.add "GDP_IM@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 14)
  sox.add "GNI@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 19)
  sox.add "GDP_IFX@JP",         Series.load_pattern("1980-01-01", "Q", "GDP@JP.Q.CSV", "GDP@JP.Q", "INCREMENT:8:1", 25)

  sox.add "GDPNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 2)
  sox.add "GDP_CPNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSPNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 6)
  sox.add "GDP_INRPNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVPNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 8)
  sox.add "GDP_CGNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXGNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVGNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 11)
  sox.add "GDP_NXNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 12)
  sox.add "GDP_EXNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 13)
  sox.add "GDP_IMNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 14)
  sox.add "GNINS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 19)
  sox.add "GDP_IFXNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDPNS@JP.Q.CSV", "GDPNS@JP.Q", "INCREMENT:8:1", 25)

  sox.add "GDP_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 2)
  sox.add "GDP_CP_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSP_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 6)
  sox.add "GDP_INRP_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVP_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 8)
  sox.add "GDP_CG_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXG_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVG_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 11)
  sox.add "GDP_NX_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 12)
  sox.add "GDP_EX_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 13)
  sox.add "GDP_IM_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 14)
  sox.add "GNI_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 22)
  sox.add "GDP_IFX_R@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_R@JP.Q.CSV", "GDP_R@JP.Q", "INCREMENT:8:1", 28)

  sox.add "GDP_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 2)
  sox.add "GDP_CP_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 3)
  sox.add "GDP_IRSP_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 6)
  sox.add "GDP_INRP_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 7)
  sox.add "GDP_IIVP_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 8)
  sox.add "GDP_CG_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 9)
  sox.add "GDP_IFXG_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 10)
  sox.add "GDP_IIVG_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 11)
  sox.add "GDP_NX_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 12)
  sox.add "GDP_EX_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 13)
  sox.add "GDP_IM_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 14)
  sox.add "GNI_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 22)
  sox.add "GDP_IFX_RNS@JP",         Series.load_pattern("1980-01-01", "Q", "GDP_RNS@JP.Q.CSV", "GDP_RNS@JP.Q", "INCREMENT:8:1", 28)

  sox.add "GDPDEF@JP",         Series.load_pattern("1980-01-01", "Q", "GDPDEF@JP.Q.CSV", "GDPDEF@JP.Q", "INCREMENT:8:1", 2)
  sox.add "GNIDEF@JP",         Series.load_pattern("1980-01-01", "Q", "GDPDEF@JP.Q.CSV", "GDPDEF@JP.Q", "INCREMENT:8:1", 19)

  sox.add "CSCFNS@JP",         Series.load_pattern("1982-07-01", "Q", "JP_CSCFNS.XLS", "JP_CSCFNS", "INCREMENT:7:1", 2)
  sox.add "CSCF@JP",         Series.load_pattern("1982-07-01", "Q", "JP_CSCF.XLS", "JP_CSCF", "INCREMENT:7:1", 2)
 
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "QUARTERLY JAPAN (rake jp_upd_q)", sox.output_summary
  end
end

###*******************************************************************



task :jp_upd_m => :environment do
  require "Spreadsheet"
  path_JP_R            = "/Volumes/UHEROwork/data/rawdata/JP_R.CSV"
  path_JP_STKNS        = "/Volumes/UHEROwork/data/rawdata/JP_STKNS.CSV"
  path_JP_LF           = "/Volumes/UHEROwork/data/rawdata/JP_LF.XLS"
  path_JP_CPI          = "/Volumes/UHEROwork/data/rawdata/JP_CPI.XLS"
  path_JP_IP           = "/Volumes/UHEROwork/data/rawdata/JP_IP.CSV"
  path_JP_IPNS         = "/Volumes/UHEROwork/data/rawdata/JP_IPNS.CSV"
  path_JP_IP_hist      = "/Volumes/UHEROwork/data/rawdata/JP_IP_hist.CSV"
  path_JP_IPNS_hist    = "/Volumes/UHEROwork/data/rawdata/JP_IPNS_hist.CSV"
  path_JP_CSCFNS       = "/Volumes/UHEROwork/data/rawdata/JP_CSCFNS.XLS"

  output_path   = "/Volumes/UHEROwork/data/jp/update/jp_upd_m_NEW.xls"

  dsd_JP_R           = DataSourceDownload.get path_JP_R
  dsd_JP_STKNS       = DataSourceDownload.get path_JP_STKNS
  dsd_JP_LF          = DataSourceDownload.get path_JP_LF
  dsd_JP_CPI         = DataSourceDownload.get path_JP_CPI
  dsd_JP_IP          = DataSourceDownload.get path_JP_IP
  dsd_JP_IPNS        = DataSourceDownload.get path_JP_IPNS
  dsd_JP_IP_hist     = DataSourceDownload.get path_JP_IP_hist
  dsd_JP_IPNS_hist   = DataSourceDownload.get path_JP_IPNS_hist
  dsd_JP_CSCFNS      = DataSourceDownload.get path_JP_CSCFNS

  if dsd_JP_R.download_changed? || dsd_JP_STKNS.download_changed? || dsd_JP_LF.download_changed? || dsd_JP_CPI.download_changed? || dsd_JP_IP.download_changed? || dsd_JP_IPNS.download_changed? || dsd_JP_IP_hist.download_changed? || dsd_JP_IPNS_hist.download_changed? || dsd_JP_CSCFNS.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "R@JP",         Series.load_pattern("1960-01-01", "M", "JP_R.CSV", "JP_R", "INCREMENT:4:1", 3)
  sox.add "STKNS@JP",         Series.load_pattern("2011-08-01", "M", "JP_STKNS.CSV", "JP_STKNS", "INCREMENT:2:1", 5)

  sox.add "LF@JP",         Series.load_pattern("2009-01-01", "M", "JP_LF.XLS", "TABLE 18", "INCREMENT:11:1", 4)
  sox.add "EMPL@JP",         Series.load_pattern("2009-01-01", "M", "JP_LF.XLS", "TABLE 18", "INCREMENT:11:1", 7)
  sox.add "E_NF@JP",         Series.load_pattern("2009-01-01", "M", "JP_LF.XLS", "TABLE 18", "INCREMENT:11:1", 14)
  sox.add "UR@JP",         Series.load_pattern("2009-01-01", "M", "JP_LF.XLS", "TABLE 18", "INCREMENT:11:1", 31)

  sox.add "CPINS@JP",         Series.load_pattern("2009-04-01", "M", "JP_CPI.XLS", "TABLE1", "INCREMENT:16:1", 6)
  sox.add "CPICORENS@JP",         Series.load_pattern("2009-04-01", "M", "JP_CPI.XLS", "TABLE1", "INCREMENT:16:1", 7)
  sox.add "CPI@JP",         Series.load_pattern("2009-04-01", "M", "JP_CPI.XLS", "TABLE1", "INCREMENT:16:1", 21)
  sox.add "CPICORE@JP",         Series.load_pattern("2009-04-01", "M", "JP_CPI.XLS", "TABLE1", "INCREMENT:16:1", 22)

  sox.add "IP@JP",         Series.load_pattern("2003-01-01", "M", "JP_IP.CSV", "JP_IP", "4", "INCREMENT:4:1")
  sox.add "IPNS@JP",         Series.load_pattern("2003-01-01", "M", "JP_IPNS.CSV", "JP_IPNS", "4", "INCREMENT:4:1")
  sox.add "IPMN@JP",         Series.load_pattern("2003-01-01", "M", "JP_IP.CSV", "JP_IP", "5", "INCREMENT:4:1")
  sox.add "IPMNNS@JP",         Series.load_pattern("2003-01-01", "M", "JP_IPNS.CSV", "JP_IPNS", "5", "INCREMENT:4:1")
  sox.add "IP@JP",         Series.load_pattern("1978-01-01", "M", "JP_IP_hist.CSV", "JP_IP_hist", "INCREMENT:6:1", 2)
  sox.add "IPNS@JP",         Series.load_pattern("1978-01-01", "M", "JP_IPNS_hist.CSV", "JP_IPNS_hist", "INCREMENT:6:1", 2)
  sox.add "IPMN@JP",         Series.load_pattern("1978-01-01", "M", "JP_IP_hist.CSV", "JP_IP_hist", "INCREMENT:6:1", 3)
  sox.add "IPMNNS@JP",         Series.load_pattern("1978-01-01", "M", "JP_IPNS_hist.CSV", "JP_IPNS_hist", "INCREMENT:6:1", 3)

  sox.add "CSCFNS@JP",         Series.load_pattern("2004-03-01", "M", "JP_CSCFNS.XLS", "JP_CSCFNS", "INCREMENT:94:1", 2)
  
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "MONTHLY JAPAN (rake jp_upd_m)", sox.output_summary
  end
end

###*******************************************************************
