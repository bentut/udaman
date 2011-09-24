#MISC DATA DOWNLOADS


###*******************************************************************
###NOTES BOX

#uic_upd works and is complete
#misc_const_upd_q works and is complete
#misc_const_upd_m works and is complete

###*******************************************************************




task :uic_upd => :environment do
  require "Spreadsheet"
  path_UIC       = "/Volumes/UHEROwork/data/rawdata/UIC.xls"
    
  output_path   = "/Volumes/UHEROwork/data/misc/uiclaims/update/UIC_upd_NEW.xls"

  dsd_uic     = DataSourceDownload.get path_UIC 
    
    
  if dsd_uic.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "UICINS@HONO.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 2)
  sox.add "UICINS@KANE.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 3)
  sox.add "UICINS@WPHU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 4)
  sox.add "UICINS@HON.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 5)
  sox.add "UICINS@HILO.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 6)
  sox.add "UICINS@KONA.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 7)
  sox.add "UICINS@HAW.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 8)
  sox.add "UICINS@WLKU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 9)
  sox.add "UICINS@MOLK.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 10)
  sox.add "UICINS@MAU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 11)
  sox.add "UICINS@KAU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 12)
  sox.add "UICINS@OT.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 13)
  sox.add "UICINS@HI.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "icweekly", "increment:7:1", 14)
  sox.add "UICNS@HONO.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 2)
  sox.add "UICNS@KANE.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 3)
  sox.add "UICNS@WPHU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 4)
  sox.add "UICNS@HON.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 5)
  sox.add "UICNS@HILO.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 6)
  sox.add "UICNS@KONA.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 7)
  sox.add "UICNS@HAW.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 8)
  sox.add "UICNS@WLKU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 9)
  sox.add "UICNS@MOLK.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 10)
  sox.add "UICNS@MAU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 11)
  sox.add "UICNS@KAU.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 12)
  sox.add "UICNS@OT.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 13)
  sox.add "UICNS@HI.W",         Series.load_pattern("2000-08-19", "W",  path_UIC, "iwcweekly", "increment:7:1", 14)
   
    sox.write_xls
#    NotificationMailer.deliver_new_download_notification "Weekly UIC (rake UIC_upd)", sox.output_summary
  end
end


###*******************************************************************


task :const_upd_q => :environment do
  require "Spreadsheet"
  path_QSER_E        = "/Volumes/UHEROwork/data/rawdata/Const_QSER_E.xls"
  path_QSER_G        = "/Volumes/UHEROwork/data/rawdata/Const_QSER_G.xls"
  
  output_path   = "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_NEW.xls"

  dsd_QSER_E   = DataSourceDownload.get path_QSER_E
  dsd_QSER_G   = DataSourceDownload.get path_QSER_G
  
  if dsd_QSER_E.download_changed? || dsd_QSER_G.download_changed?
    sox = SeriesOutputXls.new(output_path)#,true)
  
  sox.add "KNRSDNS@HON.Q",         Series.load_pattern("1993-01-01", "Q",  path_QSER_G, "G-25", "block:6:1:4", "repeat:2:5")
  sox.add "KNRSDNS@HAW.Q",         Series.load_pattern("1993-01-01", "Q",  path_QSER_G, "G-26", "block:5:1:4", "repeat:2:5")
  sox.add "KNRSDNS@MAU.Q",         Series.load_pattern("1993-01-01", "Q",  path_QSER_G, "G-27", "block:5:1:4", "repeat:2:5")
  sox.add "KNRSDNS@KAU.Q",         Series.load_pattern("1993-01-01", "Q",  path_QSER_G, "G-28", "block:5:1:4", "repeat:2:5")

  sox.add "KPGOVNS@HI.Q",         Series.load_pattern("1998-01-01", "Q",  path_QSER_E, "E-1", "increment:37:1", 7)
  sox.add "KNRSDNS@HI.Q",         Series.load_pattern("1982-01-01", "Q",  path_QSER_E, "E-3", "block:5:1:4", "repeat:2:5")
  sox.add "KNRSDSGFNS@HI.Q",         Series.load_pattern("1982-01-01", "Q",  path_QSER_E, "E-4", "block:5:1:4", "repeat:2:5")
  sox.add "KNRSDMLTNS@HI.Q",         Series.load_pattern("1982-01-01", "Q",  path_QSER_E, "E-5", "block:5:1:4", "repeat:2:5")
  sox.add "PICTSGFNS@HON.Q",         Series.load_pattern("1982-01-01", "Q",  path_QSER_E, "E-6", "block:6:1:4", "repeat:2:5")
  sox.add "PICTCONNS@HON.Q",         Series.load_pattern("1982-01-01", "Q",  path_QSER_E, "E-7", "block:6:1:4", "repeat:2:5")

   
    sox.write_xls
#    NotificationMailer.deliver_new_download_notification "Quarterly Construction (rake const_upd_q)", sox.output_summary
  end
end

###*******************************************************************



task :const_upd_m => :environment do
  require "Spreadsheet"
  path_CONST_HI           = "/Volumes/UHEROwork/data/rawdata/Const_MEI_HI.xls"
  path_CONST_HAW          = "/Volumes/UHEROwork/data/rawdata/Const_MEI_HAW.xls"
  path_CONST_HON          = "/Volumes/UHEROwork/data/rawdata/Const_MEI_HON.xls"
  path_CONST_MAU          = "/Volumes/UHEROwork/data/rawdata/Const_MEI_MAU.xls"
  path_CONST_KAU          = "/Volumes/UHEROwork/data/rawdata/Const_MEI_KAU.xls"
  path_CONST_PICT         = "/Volumes/UHEROwork/data/rawdata/PICT.xls"   
  
  output_path      = "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"

  dsd_CONST_HI   = DataSourceDownload.get path_CONST_HI
  dsd_CONST_HAW  = DataSourceDownload.get path_CONST_HAW
  dsd_CONST_HON  = DataSourceDownload.get path_CONST_HON
  dsd_CONST_MAU  = DataSourceDownload.get path_CONST_MAU
  dsd_CONST_KAU  = DataSourceDownload.get path_CONST_KAU
  dsd_CONST_PICT = DataSourceDownload.get path_CONST_PICT
  
  if dsd_CONST_HI.download_changed? || dsd_CONST_HAW.download_changed? || dsd_CONST_HON.download_changed? || dsd_CONST_MAU.download_changed?  || dsd_CONST_KAU.download_changed? || dsd_CONST_PICT.download_changed? 
    sox = SeriesOutputXls.new(output_path)  

  sox.add "KPPRVNS@HI.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HI, "sheet_num:1", "increment:5:1", 41)
  sox.add "KPPRVRSDNS@HI.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HI, "sheet_num:1", "increment:5:1", 42)
  sox.add "KPPRVCOMNS@HI.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HI, "sheet_num:1", "increment:5:1", 43)
  sox.add "KPPRVADDNS@HI.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HI, "sheet_num:1", "increment:5:1", 44)
  sox.add "KPPRVNS@HON.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HON, "sheet_num:1", "increment:5:1", 41)
  sox.add "KPPRVRSDNS@HON.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HON, "sheet_num:1", "increment:5:1", 42)
  sox.add "KPPRVCOMNS@HON.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HON, "sheet_num:1", "increment:5:1", 43)
  sox.add "KPPRVADDNS@HON.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HON, "sheet_num:1", "increment:5:1", 44)
  sox.add "KPPRVNS@HAW.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HAW, "sheet_num:1", "increment:5:1", 41)
  sox.add "KPPRVRSDNS@HAW.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HAW, "sheet_num:1", "increment:5:1", 42)
  sox.add "KPPRVCOMNS@HAW.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HAW, "sheet_num:1", "increment:5:1", 43)
  sox.add "KPPRVADDNS@HAW.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_HAW, "sheet_num:1", "increment:5:1", 44)
  sox.add "KPPRVNS@MAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_MAU, "sheet_num:1", "increment:5:1", 41)
  sox.add "KPPRVRSDNS@MAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_MAU, "sheet_num:1", "increment:5:1", 42)
  sox.add "KPPRVCOMNS@MAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_MAU, "sheet_num:1", "increment:5:1", 43)
  sox.add "KPPRVADDNS@MAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_MAU, "sheet_num:1", "increment:5:1", 44)
  sox.add "KPPRVNS@KAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_KAU, "sheet_num:1", "increment:5:1", 41)
  sox.add "KPPRVRSDNS@KAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_KAU, "sheet_num:1", "increment:5:1", 42)
  sox.add "KPPRVCOMNS@KAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_KAU, "sheet_num:1", "increment:5:1", 43)
  sox.add "KPPRVADDNS@KAU.M",         Series.load_pattern("1990-01-01", "M",  path_CONST_KAU, "sheet_num:1", "increment:5:1", 44)

  sox.add "PICTSGFNS@US.M",         Series.load_pattern("1964-01-01", "M",  path_CONST_PICT, "fixed", "block:9:1:12", "repeat_with_step:7:29:2")

     sox.write_xls
#    NotificationMailer.deliver_new_download_notification "Monthly Construction (rake const_upd_m)", sox.output_summary
  end
end


###*******************************************************************