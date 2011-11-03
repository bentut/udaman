#JAPAN SERIES DOWNLOADS

###*******************************************************************
###NOTES BOX

#jp_upd_a works
#jp_upd_q works
#jp_upd_m has a variety of problems, problem series have been commented out
#jp_cpi has link that changes monthly, recently, they have stopped reporting seasonally adjusted numbers

###*******************************************************************



task :jp_upd_a => :environment do
  require "Spreadsheet"
  path_JP_GDP_A          = "/Volumes/UHEROwork/data/rawdata/JP_GDP_A.CSV"
  path_JP_GDP_R_A        = "/Volumes/UHEROwork/data/rawdata/JP_GDP_R_A.CSV"
  path_JP_GDPDEF_A       = "/Volumes/UHEROwork/data/rawdata/JP_GDPDEF_A.CSV"
  path_JP_POP            = "/Volumes/UHEROwork/data/rawdata/JP_POP.xls"


  output_path   = "/Volumes/UHEROwork/data/japan/update/jp_upd_a_NEW.xls"

  dsd_JP_GDP_A         = DataSourceDownload.get path_JP_GDP_A  
  dsd_JP_GDP_R_A       = DataSourceDownload.get path_JP_GDP_R_A  
  dsd_JP_GDPDEF_A      = DataSourceDownload.get path_JP_GDPDEF_A  
  dsd_JP_POP           = DataSourceDownload.get path_JP_POP  

  if dsd_JP_GDP_A.download_changed? || dsd_JP_GDP_R_A.download_changed? || dsd_JP_GDPDEF_A.download_changed? || dsd_JP_POP.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  

  sox.add "GDP@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 2)
  sox.add "GDP_CP@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSP@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 6)
  sox.add "GDP_INRP@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVP@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 8)
  sox.add "GDP_CG@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXG@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVG@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 11)
  sox.add "GDP_NX@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 12)
  sox.add "GDP_EX@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 13)
  sox.add "GDP_IM@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 14)
  sox.add "GNI@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 19)
  sox.add "GDP_IFX@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_A, "csv", "increment:8:1", 25)

  sox.add "GDP_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 2)
  sox.add "GDP_CP_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSP_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 6)
  sox.add "GDP_INRP_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVP_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 8)
  sox.add "GDP_CG_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXG_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVG_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 11)
  sox.add "GDP_NX_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 12)
  sox.add "GDP_EX_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 13)
  sox.add "GDP_IM_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 14)
  sox.add "GNI_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 22)
  sox.add "GDP_IFX_R@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDP_R_A, "csv", "increment:8:1", 28)

  sox.add "GDPDEF@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDPDEF_A, "csv", "increment:8:1", 2)
  sox.add "GNIDEF@JP.A",         Series.load_pattern("1980-01-01", "A", path_JP_GDPDEF_A, "csv", "increment:8:1", 19)
  
  sox.add "N@JP",         Series.load_pattern("1950-01-01", "A", path_JP_POP, "sheet_num:1", 94, "increment:6:1")

  
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "ANNUAL JAPAN (rake jp_upd_a)", sox.output_summary
  end
end

###*******************************************************************




task :jp_upd_q => :environment do
  require "Spreadsheet"
  path_JP_GDP_Q       = "/Volumes/UHEROwork/data/rawdata/JP_GDP_Q.CSV"
  path_JP_GDPNS_Q     = "/Volumes/UHEROwork/data/rawdata/JP_GDPNS_Q.CSV"
  path_JP_GDP_R_Q     = "/Volumes/UHEROwork/data/rawdata/JP_GDP_R_Q.CSV"
  path_JP_GDP_RNS_Q   = "/Volumes/UHEROwork/data/rawdata/JP_GDP_RNS_Q.CSV"
  path_JP_GDPDEF_Q    = "/Volumes/UHEROwork/data/rawdata/JP_GDPDEF_Q.CSV"
  path_JP_CSCFNS      = "/Volumes/UHEROwork/data/rawdata/JP_CSCFNS.XLS"
  path_JP_CSCF        = "/Volumes/UHEROwork/data/rawdata/JP_CSCF.XLS"

  output_path   = "/Volumes/UHEROwork/data/japan/update/jp_upd_q_NEW.xls"

  dsd_JP_GDP_Q        = DataSourceDownload.get path_JP_GDP_Q
  dsd_JP_GDPNS_Q      = DataSourceDownload.get path_JP_GDPNS_Q 
  dsd_JP_GDP_R_Q      = DataSourceDownload.get path_JP_GDP_R_Q
  dsd_JP_GDP_RNS_Q    = DataSourceDownload.get path_JP_GDP_RNS_Q 
  dsd_JP_GDPDEF_Q     = DataSourceDownload.get path_JP_GDPDEF_Q 
  dsd_JP_CSCFNS       = DataSourceDownload.get path_JP_CSCFNS
  dsd_JP_CSCF         = DataSourceDownload.get path_JP_CSCF

  if dsd_JP_GDP_Q.download_changed? || dsd_JP_GDPNS_Q.download_changed? || dsd_JP_GDP_R_Q.download_changed? || dsd_JP_GDP_RNS_Q.download_changed? || dsd_JP_GDPDEF_Q.download_changed? || dsd_JP_CSCFNS.download_changed? || dsd_JP_CSCF.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "GDP@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 2)
  sox.add "GDP_CP@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSP@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 6)
  sox.add "GDP_INRP@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVP@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 8)
  sox.add "GDP_CG@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXG@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVG@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 11)
  sox.add "GDP_NX@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 12)
  sox.add "GDP_EX@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 13)
  sox.add "GDP_IM@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 14)
  sox.add "GNI@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 19)
  sox.add "GDP_IFX@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_Q, "csv", "increment:8:1", 25)

  sox.add "GDPNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 2)
  sox.add "GDP_CPNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSPNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 6)
  sox.add "GDP_INRPNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVPNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 8)
  sox.add "GDP_CGNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXGNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVGNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 11)
  sox.add "GDP_NXNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 12)
  sox.add "GDP_EXNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 13)
  sox.add "GDP_IMNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 14)
  sox.add "GNINS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 19)
  sox.add "GDP_IFXNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPNS_Q, "csv", "increment:8:1", 25)

  sox.add "GDP_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 2)
  sox.add "GDP_CP_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSP_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 6)
  sox.add "GDP_INRP_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVP_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 8)
  sox.add "GDP_CG_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXG_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVG_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 11)
  sox.add "GDP_NX_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 12)
  sox.add "GDP_EX_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 13)
  sox.add "GDP_IM_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 14)
  sox.add "GNI_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 22)
  sox.add "GDP_IFX_R@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_R_Q, "csv", "increment:8:1", 28)

  sox.add "GDP_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 2)
  sox.add "GDP_CP_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 3)
  sox.add "GDP_IRSP_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 6)
  sox.add "GDP_INRP_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 7)
  sox.add "GDP_IIVP_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 8)
  sox.add "GDP_CG_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 9)
  sox.add "GDP_IFXG_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 10)
  sox.add "GDP_IIVG_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 11)
  sox.add "GDP_NX_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 12)
  sox.add "GDP_EX_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 13)
  sox.add "GDP_IM_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 14)
  sox.add "GNI_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 22)
  sox.add "GDP_IFX_RNS@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDP_RNS_Q, "csv", "increment:8:1", 28)

  sox.add "GDPDEF@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPDEF_Q, "csv", "increment:8:1", 2)
  sox.add "GNIDEF@JP.Q",         Series.load_pattern("1980-01-01", "Q", path_JP_GDPDEF_Q, "csv", "increment:8:1", 19)

  sox.add "CSCFNS@JP.Q",         Series.load_pattern("1982-07-01", "Q", path_JP_CSCFNS, "original series", "increment:7:1", 2)
  sox.add "CSCF@JP.Q",           Series.load_pattern("1982-07-01", "Q", path_JP_CSCF, "seasonally adjusted series", "increment:7:1", 2)
 
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "QUARTERLY JAPAN (rake jp_upd_q)", sox.output_summary
  end
end

###*******************************************************************



task :jp_upd_m => :environment do
  require "Spreadsheet"
# path_JP_R            = "/Volumes/UHEROwork/data/rawdata/JP_R.CSV"
  path_JP_STKNS        = "/Volumes/UHEROwork/data/rawdata/JP_STKNS.CSV"
  path_JP_LF           = "/Volumes/UHEROwork/data/rawdata/JP_LF.XLS"
  path_JP_CPI          = "/Volumes/UHEROwork/data/rawdata/JP_CPI.XLS"
  path_JP_IP           = "/Volumes/UHEROwork/data/rawdata/JP_IP.CSV"
  path_JP_IPNS         = "/Volumes/UHEROwork/data/rawdata/JP_IPNS.CSV"
  path_JP_IP_hist      = "/Volumes/UHEROwork/data/rawdata/JP_IP_hist.CSV"
  path_JP_IPNS_hist    = "/Volumes/UHEROwork/data/rawdata/JP_IPNS_hist.CSV"
  path_JP_CSCFNS       = "/Volumes/UHEROwork/data/rawdata/JP_CSCFNS.XLS"

  output_path   = "/Volumes/UHEROwork/data/japan/update/jp_upd_m_NEW.xls"

# dsd_JP_R           = DataSourceDownload.get path_JP_R
  dsd_JP_STKNS       = DataSourceDownload.get path_JP_STKNS
  dsd_JP_LF          = DataSourceDownload.get path_JP_LF
  dsd_JP_CPI         = DataSourceDownload.get path_JP_CPI
  dsd_JP_IP          = DataSourceDownload.get path_JP_IP
  dsd_JP_IPNS        = DataSourceDownload.get path_JP_IPNS
  dsd_JP_IP_hist     = DataSourceDownload.get path_JP_IP_hist
  dsd_JP_IPNS_hist   = DataSourceDownload.get path_JP_IPNS_hist
  dsd_JP_CSCFNS      = DataSourceDownload.get path_JP_CSCFNS

  if dsd_JP_LF.download_changed? || dsd_JP_CPI.download_changed? || dsd_JP_IP.download_changed? || dsd_JP_IPNS.download_changed? || dsd_JP_IP_hist.download_changed? || dsd_JP_IPNS_hist.download_changed? || dsd_JP_CSCFNS.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
 # sox.add "R@JP.M",         Series.load_pattern("1960-01-01", "M", path_JP_R, "csv", "increment:4:1", 3)

  sox.add "LF@JP.M",         Series.load_pattern("2009-01-01", "M", path_JP_LF, "Table 18", "increment:11:1", 4)
  sox.add "EMPL@JP.M",         Series.load_pattern("2009-01-01", "M", path_JP_LF, "Table 18", "increment:11:1", 7)
  sox.add "E_NF@JP.M",         Series.load_pattern("2009-01-01", "M", path_JP_LF, "Table 18", "increment:11:1", 14)
  sox.add "UR@JP.M",         Series.load_pattern("2009-01-01", "M", path_JP_LF, "Table 18", "increment:11:1", 31)

  sox.add "CPINS@JP.M",         Series.load_pattern("2009-04-01", "M", path_JP_CPI, "TABLE1", "increment:16:1", 3)
  sox.add "CPICORENS@JP.M",         Series.load_pattern("2009-04-01", "M", path_JP_CPI, "TABLE1", "increment:16:1", 4)
#  sox.add "CPI@JP.M",         Series.load_pattern("2009-04-01", "M", path_JP_CPI, "TABLE1", "increment:16:1", 21)
#  sox.add "CPICORE@JP.M",         Series.load_pattern("2009-04-01", "M", path_JP_CPI, "TABLE1", "increment:16:1", 22)

  sox.add "IP@JP.M",         Series.load_pattern("2003-01-01", "M", path_JP_IP, "csv", "4", "increment:4:1")
  sox.add "IPNS@JP.M",         Series.load_pattern("2003-01-01", "M", path_JP_IPNS, "csv", "4", "increment:4:1")
  sox.add "IPMN@JP.M",         Series.load_pattern("2003-01-01", "M", path_JP_IP, "csv", "5", "increment:4:1")
  sox.add "IPMNNS@JP.M",         Series.load_pattern("2003-01-01", "M", path_JP_IPNS, "csv", "5", "increment:4:1")
#  sox.add "IP@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IP_hist, "csv", "increment:6:1", 2)
#  sox.add "IPNS@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IPNS_hist, "csv", "increment:6:1", 2)
#  sox.add "IPMN@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IP_hist, "csv", "increment:6:1", 3)
#  sox.add "IPMNNS@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IPNS_hist, "csv", "increment:6:1", 3)

#  sox.add "CSCFNS@JP.M",         Series.load_pattern("2004-03-01", "M", path_JP_CSCFNS, "original series", "increment:94:1", 2)
  
  sox.add "STKNS@JP.D",         Series.load_pattern("row2:col1:rev", "WD", path_JP_STKNS, "csv", "increment:2:1", 7)
  # This thing doesn't work?
   
    sox.write_xls
    #NotificationMailer.deliver_new_download_notification "MONTHLY JAPAN (rake jp_upd_m)", sox.output_summary
  end
end

###*******************************************************************
