#MISC DATA DOWNLOADS


###*******************************************************************
###NOTES BOX

#uic_upd works and is complete
#misc_const_upd_q works and is complete
#misc_const_upd_m works and is complete

###*******************************************************************



task :uic_upd => :environment do
  t=  Time.now
	uic = {
		"UICININS@HONO.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 2, :frequency => "W" })/1000|, 
		"UICININS@KANE.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 3, :frequency => "W" })/1000|, 
		"UICININS@WPHU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 4, :frequency => "W" })/1000|, 
		"UICININS@HON.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 5, :frequency => "W" })/1000|, 
		"UICININS@HILO.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 6, :frequency => "W" })/1000|, 
		"UICININS@KONA.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 7, :frequency => "W" })/1000|, 
		"UICININS@HAW.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 8, :frequency => "W" })/1000|, 
		"UICININS@WLKU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 9, :frequency => "W" })/1000|, 
		"UICININS@MOLK.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 10, :frequency => "W" })/1000|, 
		"UICININS@MAU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 11, :frequency => "W" })/1000|, 
		"UICININS@KAU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 12, :frequency => "W" })/1000|, 
		"UICININS@OT.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 13, :frequency => "W" })/1000|, 
		"UICININS@HI.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 14, :frequency => "W" })/1000|, 

		"UICNS@HONO.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 2, :frequency => "W" })/1000|, 
		"UICNS@KANE.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 3, :frequency => "W" })/1000|, 
		"UICNS@WPHU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 4, :frequency => "W" })/1000|, 
		"UICNS@HON.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 5, :frequency => "W" })/1000|, 
		"UICNS@HILO.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 6, :frequency => "W" })/1000|, 
		"UICNS@KONA.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 7, :frequency => "W" })/1000|, 
		"UICNS@HAW.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 8, :frequency => "W" })/1000|, 
		"UICNS@WLKU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 9, :frequency => "W" })/1000|, 
		"UICNS@MOLK.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 10, :frequency => "W" })/1000|, 
		"UICNS@MAU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 11, :frequency => "W" })/1000|, 
		"UICNS@KAU.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 12, :frequency => "W" })/1000|, 
		"UICNS@OT.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 13, :frequency => "W" })/1000|, 
		"UICNS@HI.W" => %Q|Series.load_from_download(  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 14, :frequency => "W" })/1000|
	}
	
	p = Packager.new
	p.add_definitions uic
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/uiclaims/update/UIC_upd_NEW.xls"
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["uic_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :const_upd_q => :environment do
  t = Time.now
	const_q = {
		"KNRSDNS@HON.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-25", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@HAW.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-26", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@MAU.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-27", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@KAU.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-28", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KPGOVNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1998-01-01", :sheet => "E-1", :row => "increment:38:1", :col => 7, :frequency => "Q" }|, 
		"KNRSDNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-3", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDSGFNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-4", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDMLTNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-5", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"PICTSGFNS@HON.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-6", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"PICTCONNS@HON.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-7", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|,
	
	}
	
	p = Packager.new
	p.add_definitions const_q
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_NEW.xls"
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["const_upd_q", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :const_upd_m => :environment do
  t = Time.now
	const_m = {
		"KPPRVNS@HI.M" => %Q|Series.load_from_download(  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:6:1", :col => 41, :frequency => "M" })/1000|, 
		"KPPRVRSDNS@HI.M" => %Q|Series.load_from_download(  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:6:1", :col => 42, :frequency => "M" })/1000|, 
		"KPPRVCOMNS@HI.M" => %Q|Series.load_from_download(  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:6:1", :col => 43, :frequency => "M" })/1000|, 
		"KPPRVADDNS@HI.M" => %Q|Series.load_from_download(  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:6:1", :col => 44, :frequency => "M" })/1000|, 
		"KPPRVNS@HON.M" => %Q|Series.load_from_download(  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" })/1000|, 
		"KPPRVRSDNS@HON.M" => %Q|Series.load_from_download(  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" })/1000|, 
		"KPPRVCOMNS@HON.M" => %Q|Series.load_from_download(  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" })/1000|, 
		"KPPRVADDNS@HON.M" => %Q|Series.load_from_download(  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" })/1000|, 
		"KPPRVNS@HAW.M" => %Q|Series.load_from_download(  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" })/1000|, 
		"KPPRVRSDNS@HAW.M" => %Q|Series.load_from_download(  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" })/1000|, 
		"KPPRVCOMNS@HAW.M" => %Q|Series.load_from_download(  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" })/1000|, 
		"KPPRVADDNS@HAW.M" => %Q|Series.load_from_download(  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" })/1000|, 
		"KPPRVNS@MAU.M" => %Q|Series.load_from_download(  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" })/1000|, 
		"KPPRVRSDNS@MAU.M" => %Q|Series.load_from_download(  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" })/1000|, 
		"KPPRVCOMNS@MAU.M" => %Q|Series.load_from_download(  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" })/1000|, 
		"KPPRVADDNS@MAU.M" => %Q|Series.load_from_download(  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" })/1000|, 
		"KPPRVNS@KAU.M" => %Q|Series.load_from_download(  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" })/1000|, 
		"KPPRVRSDNS@KAU.M" => %Q|Series.load_from_download(  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" })/1000|, 
		"KPPRVCOMNS@KAU.M" => %Q|Series.load_from_download(  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" })/1000|, 
		"KPPRVADDNS@KAU.M" => %Q|Series.load_from_download(  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" })/1000|, 
		"PICTSGFNS@US.M" => %Q|Series.load_from_download(  "CONST_PICT@census.gov", { :file_type => "xls", :start_date => "1964-01-01", :sheet => "fixed", :row => "block:7:1:12", :col => "repeat_with_step:7:29:2", :frequency => "M" })|,
	
	}
	

#move these and remove other	
  # const_m_nowrite = {
  #   "KPPRVNRSDNS@HI.M" => %Q|"KPPRVNS@HI.M".ts - "KPPRVRSDNS@HI.M".ts|,
  #   "KPPRVNRSDNS@HON.M" => %Q|"KPPRVNS@HON.M".ts - "KPPRVRSDNS@HON.M".ts|,
  #   "KPPRVNRSDNS@HAW.M" => %Q|"KPPRVNS@HAW.M".ts - "KPPRVRSDNS@HAW.M".ts|,
  #   "KPPRVNRSDNS@MAU.M" => %Q|"KPPRVNS@MAU.M".ts - "KPPRVRSDNS@MAU.M".ts|,
  #   "KPPRVNRSDNS@KAU.M" => %Q|"KPPRVNS@KAU.M".ts - "KPPRVRSDNS@KAU.M".ts|,  
  #   "KPPRVNS@NBI.M" => %Q|"KPPRVNS@HAW.M".ts + "KPPRVNS@MAU.M".ts + "KPPRVNS@KAU.M".ts|,
  #   "KPPRVRSDNS@NBI.M" => %Q|"KPPRVRSDNS@HAW.M".ts + "KPPRVRSDNS@MAU.M".ts + "KPPRVRSDNS@KAU.M".ts|,
  #   "KPPRVCOMNS@NBI.M" => %Q|"KPPRVCOMNS@HAW.M".ts + "KPPRVCOMNS@MAU.M".ts + "KPPRVCOMNS@KAU.M".ts|,
  #   "KPPRVADDNS@NBI.M" => %Q|"KPPRVADDNS@HAW.M".ts + "KPPRVADDNS@MAU.M".ts + "KPPRVADDNS@KAU.M".ts|,
  #   "KPPRVNRSDNS@NBI.M" => %Q|"KPPRVNRSDNS@HAW.M".ts + "KPPRVNRSDNS@MAU.M".ts + "KPPRVNRSDNS@KAU.M".ts|
  # 
  #   
  # }
		
	p = Packager.new
	p.add_definitions const_m
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"

  # p = Packager.new
  # p.add_definitions const_m_nowrite
  # p.write_definitions_to "/Volumes/UHEROwork/data/rawdata/trash/const_upd_m_ID.xls"

  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["const_upd_m", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :const_identities => :environment do
  t= Time.now
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/census_imp.xls"
  #not sure if these should go in misc or what...
  #Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/AltUnemplStats.xls"
  #Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/AltUnemplStats.xls", "Q"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/AltURA.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/AltURQ.xls"

  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/prud_upd.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/hbr_upd_m.csv"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/hud_upd.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/manual/HAWpermits.xls"

  ["KPPRVNS", "KPPRVRSDNS"].each do |s_name|
    "#{s_name}@HI.M".ts_eval= %Q|("#{s_name}@HAW.M".ts + "#{s_name}@MAU.M".ts + "#{s_name}@KAU.M".ts + "#{s_name}@HON.M".ts).trim("2012-04-01")|
  end
  
  ["KPPRVCOMNS", "KPPRVADDNS"].each do |s_name|
    "#{s_name}@HI.M".ts_eval= %Q|("#{s_name}@HAW.M".ts + "#{s_name}@MAU.M".ts + "#{s_name}@HON.M".ts).trim("2012-04-01")|
  end
  
  "KPPRVNRSDNS@HI.M".ts_eval= %Q|"KPPRVNS@HI.M".ts - "KPPRVRSDNS@HI.M".ts|
  "KPPRVNRSDNS@HON.M".ts_eval= %Q|"KPPRVNS@HON.M".ts - "KPPRVRSDNS@HON.M".ts|
  "KPPRVNRSDNS@HAW.M".ts_eval= %Q|"KPPRVNS@HAW.M".ts - "KPPRVRSDNS@HAW.M".ts|
  "KPPRVNRSDNS@MAU.M".ts_eval= %Q|"KPPRVNS@MAU.M".ts - "KPPRVRSDNS@MAU.M".ts|
  "KPPRVNRSDNS@KAU.M".ts_eval= %Q|"KPPRVNS@KAU.M".ts - "KPPRVRSDNS@KAU.M".ts|  
  "KPPRVNS@NBI.M".ts_eval= %Q|"KPPRVNS@HAW.M".ts + "KPPRVNS@MAU.M".ts + "KPPRVNS@KAU.M".ts|
  "KPPRVRSDNS@NBI.M".ts_eval= %Q|"KPPRVRSDNS@HAW.M".ts + "KPPRVRSDNS@MAU.M".ts + "KPPRVRSDNS@KAU.M".ts|
  "KPPRVCOMNS@NBI.M".ts_eval= %Q|"KPPRVCOMNS@HAW.M".ts + "KPPRVCOMNS@MAU.M".ts + "KPPRVCOMNS@KAU.M".ts|
  "KPPRVADDNS@NBI.M".ts_eval= %Q|"KPPRVADDNS@HAW.M".ts + "KPPRVADDNS@MAU.M".ts + "KPPRVADDNS@KAU.M".ts|
  "KPPRVNRSDNS@NBI.M".ts_eval= %Q|"KPPRVNRSDNS@HAW.M".ts + "KPPRVNRSDNS@MAU.M".ts + "KPPRVNRSDNS@KAU.M".ts|

  
  "NRCNM@HI.A".ts_eval = %Q|"NR@HI.A".ts - "NRM@HI.A".ts - "NRCMD@HI.A".ts| #replaces the census data completely
  "NRC@HI.A".ts_eval = %Q|"NR@HI.A".ts - "NRM@HI.A".ts|
  "NBIRCNM@HI.A".ts_eval = %Q|"NBIR@HI.A".ts - "NBIRCMD@HI.A".ts|
  "NDEACNM@HI.A".ts_eval= %Q|"NDEA@HI.A".ts - "NDEAM@HI.A".ts - "NDEACMD@HI.A".ts|
  "NMIGCNM@HI.A".ts_eval = %Q|"NRCNM@HI.A".ts.absolute_change - "NBIRCNM@HI.A".ts + "NDEACNM@HI.A".ts|
  "NRC@HON.A".ts_eval = %Q|"NR@HON.A".ts - "NRM@HI.A".ts|
  "NRCNM@HON.A".ts_eval = %Q|"NR@HON.A".ts - "NRM@HI.A".ts - "NRCMD@HI.A".ts|
  "NR@NBI.A".ts_eval = %Q|"NR@HI.A".ts - "NR@HON.A".ts| 
  "NRC@NBI.A".ts_eval = %Q|"NRC@HI.A".ts - "NRC@HON.A".ts|
  "NRCNM@NBI.A".ts_eval = %Q|"NRCNM@HI.A".ts - "NRCNM@HON.A".ts|
  "NRBEA@NBI.A".ts_eval = %Q|"NRBEA@HI.A".ts - "NRBEA@HON.A".ts| 

  ["HI", "HON", "HAW", "MAU", "KAU"].each do |cnty|
    "NMIG@#{cnty}.A".ts_eval= %Q|"NR@#{cnty}.A".ts.absolute_change - "NBIR@#{cnty}.A".ts + "NDEA@#{cnty}.A".ts|
    "NBIRR@#{cnty}.A".ts_eval = %Q|"NBIR@#{cnty}.A".ts / "NR@#{cnty}.A".ts * 1000|
    "NDEAR@#{cnty}.A".ts_eval = %Q|"NDEA@#{cnty}.A".ts / "NR@#{cnty}.A".ts * 1000|
    "NMIGR@#{cnty}.A".ts_eval = %Q|"NMIG@#{cnty}.A".ts / "NR@#{cnty}.A".ts * 1000|
  end

  "NBIRRCMD@HI.A".ts_eval = %Q|"NBIRCMD@HI.A".ts / "NRCMD@HI.A".ts * 1000|
  "NBIRRCNM@HI.A".ts_eval = %Q|"NBIRCNM@HI.A".ts / "NRCNM@HI.A".ts * 1000|

  "NDEARCNM@HI.A".ts_eval = %Q|"NDEACNM@HI.A".ts / "NRCNM@HI.A".ts * 1000| 

  "NDEARM@HI.A".ts_eval = %Q|"NDEAM@HI.A".ts / "NRM@HI.A".ts * 1000|
  "NDEARCMD@HI.A".ts_eval = %Q|"NDEACMD@HI.A".ts / "NRCMD@HI.A".ts * 1000|
  "NMIGRCNM@HI.A".ts_eval = %Q|"NMIGCNM@HI.A".ts / "NRCNM@HI.A".ts * 1000|

  ["HI", "HON", "HAW", "MAU", "KAU"].each do |county|
      "NNAT@#{county}.A".ts_eval = %Q|"NBIR@#{county}.A".ts - "NDEA@#{county}.A".ts|
      "NCHG@#{county}.A".ts_eval = %Q|"NNAT@#{county}.A".ts + "NMIG@#{county}.A".ts|
  end
  
  ["NR", "NDF"].each do |pre|
    ("#{pre}@HI.Q".ts_eval= %Q|"#{pre}@HI.A".ts.census_interpolate(:quarter)|) rescue puts "ERROR HI"
    ("#{pre}@HAW.Q".ts_eval= %Q|"#{pre}@HAW.A".ts.census_interpolate(:quarter)|) rescue puts "ERROR HAW"
    ("#{pre}@KAU.Q".ts_eval= %Q|"#{pre}@KAU.A".ts.census_interpolate(:quarter)|) rescue puts "ERROR MAU"
    ("#{pre}@MAU.Q".ts_eval= %Q|"#{pre}@MAU.A".ts.census_interpolate(:quarter)|) rescue puts "ERROR KAU"
  end 

  
  "NR@NBI.Q".ts_eval= %Q|"NR@HI.Q".ts - "NR@HON.Q".ts|
  "NRC@NBI.Q".ts_eval= %Q|"NRC@HI.Q".ts - "NRC@HON.Q".ts|
  "NRCNM@NBI.Q".ts_eval= %Q|"NRCNM@HI.Q".ts - "NRCNM@HON.Q".ts|

  "NRCMD@HI.Q".ts_eval= %Q|"NRCMD@HI.A".ts.census_interpolate(:quarter)|  
  "NRM@HI.Q".ts_eval= %Q|"NRM@HI.A".ts.census_interpolate(:quarter)|  
  "NRM@KAU.Q".ts_eval= %Q|"NRM@KAU.A".ts.census_interpolate(:quarter)|  
  
  "NBIRCMD@HI.Q".ts_eval= %Q|("NBIRCMD@HI.A".ts / 4).census_interpolate(:quarter)|  
  "NDEAM@HI.Q".ts_eval= %Q|("NDEAM@HI.A".ts / 4).census_interpolate(:quarter)|
  "NDEACMD@HI.Q".ts_eval= %Q|("NDEACMD@HI.A".ts / 4).census_interpolate(:quarter)|

  "NBIR@HI.Q".ts_eval= %Q|("NBIR@HI.A".ts / 4).census_interpolate(:quarter)|
  "NBIR@HAW.Q".ts_eval= %Q|("NBIR@HAW.A".ts / 4).census_interpolate(:quarter)|
  "NBIR@KAU.Q".ts_eval= %Q|("NBIR@KAU.A".ts / 4).census_interpolate(:quarter)|
  "NBIR@MAU.Q".ts_eval= %Q|("NBIR@MAU.A".ts / 4).census_interpolate(:quarter)|
  
  "NDEA@HI.Q".ts_eval= %Q|("NDEA@HI.A".ts / 4).census_interpolate(:quarter)|
  "NDEA@HAW.Q".ts_eval= %Q|("NDEA@HAW.A".ts / 4).census_interpolate(:quarter)|
  "NDEA@KAU.Q".ts_eval= %Q|("NDEA@KAU.A".ts / 4).census_interpolate(:quarter)|
  "NDEA@MAU.Q".ts_eval= %Q|("NDEA@MAU.A".ts / 4).census_interpolate(:quarter)|

  "NRBEA@NBI.Q".ts_eval= %Q|("NRBEA@NBI.A".ts / 4).census_interpolate(:quarter)|

  ["NR", "NBIR", "NDEA", "NDF"].each do |pre| 
    "#{pre}@HON.Q".ts_eval = %Q|"#{pre}@HI.Q".ts - ("#{pre}@HAW.Q".ts + "#{pre}@MAU.Q".ts + "#{pre}@KAU.Q".ts)|
  end
  
  "NRCNM@HI.Q".ts_eval = %Q|"NR@HI.Q".ts - "NRM@HI.Q".ts - "NRCMD@HI.Q".ts| #replaces the census data completely
  "NRC@HI.Q".ts_eval = %Q|"NR@HI.Q".ts - "NRM@HI.Q".ts|
  "NBIRCNM@HI.Q".ts_eval = %Q|"NBIR@HI.Q".ts - "NBIRCMD@HI.Q".ts|
  "NDEACNM@HI.Q".ts_eval= %Q|"NDEA@HI.Q".ts - "NDEAM@HI.Q".ts - "NDEACMD@HI.Q".ts|
  "NMIGCNM@HI.Q".ts_eval = %Q|"NRCNM@HI.Q".ts.absolute_change - "NBIRCNM@HI.Q".ts + "NDEACNM@HI.Q".ts|
  "NRC@HON.Q".ts_eval = %Q|"NR@HON.Q".ts - "NRM@HI.Q".ts|
  "NRCNM@HON.Q".ts_eval = %Q|"NR@HON.Q".ts - "NRM@HI.Q".ts - "NRCMD@HI.Q".ts|
  "NR@NBI.Q".ts_eval = %Q|"NR@HI.Q".ts - "NR@HON.Q".ts| 
  "NRC@NBI.Q".ts_eval = %Q|"NRC@HI.Q".ts - "NRC@HON.Q".ts| 
  "NRCNM@NBI.Q".ts_eval = %Q|"NRCNM@HI.Q".ts - "NRCNM@HON.Q".ts| 

  
  
  ["HI", "HON", "HAW", "MAU", "KAU"].each do |cnty|
    "NMIG@#{cnty}.Q".ts_eval= %Q|"NR@#{cnty}.Q".ts.absolute_change - "NBIR@#{cnty}.Q".ts + "NDEA@#{cnty}.Q".ts|
    "NBIRR@#{cnty}.Q".ts_eval = %Q|"NBIR@#{cnty}.Q".ts / "NR@#{cnty}.Q".ts * 1000|
    "NDEAR@#{cnty}.Q".ts_eval = %Q|"NDEA@#{cnty}.Q".ts / "NR@#{cnty}.Q".ts * 1000|
    "NMIGR@#{cnty}.Q".ts_eval = %Q|"NMIG@#{cnty}.Q".ts / "NR@#{cnty}.Q".ts * 1000|
    "NNAT@#{cnty}.Q".ts_eval = %Q|"NBIR@#{cnty}.Q".ts - "NDEA@#{cnty}.Q".ts|
    "NCHG@#{cnty}.Q".ts_eval = %Q|"NNAT@#{cnty}.Q".ts + "NMIG@#{cnty}.Q".ts|
  end

  "NBIRRCMD@HI.Q".ts_eval = %Q|"NBIRCMD@HI.Q".ts / "NRCMD@HI.Q".ts * 1000|
  "NBIRRCNM@HI.Q".ts_eval = %Q|"NBIRCNM@HI.Q".ts / "NRCNM@HI.Q".ts * 1000|

  "NDEARCNM@HI.Q".ts_eval = %Q|"NDEACNM@HI.Q".ts / "NRCNM@HI.Q".ts * 1000| 

  "NDEARM@HI.Q".ts_eval = %Q|"NDEAM@HI.Q".ts / "NRM@HI.Q".ts * 1000|
  "NDEARCMD@HI.Q".ts_eval = %Q|"NDEACMD@HI.Q".ts / "NRCMD@HI.Q".ts * 1000|
  "NMIGRCNM@HI.Q".ts_eval = %Q|"NMIGCNM@HI.Q".ts / "NRCNM@HI.Q".ts * 1000|
  
  #works for HON, but other counties are not defined
  ["HON", "HAW", "MAU", "KAU"].each do |cnty|
    "SH_NR@#{cnty}.A".ts_eval = %Q|"NR@#{cnty}.A".ts / "NR@HI.A".ts|
    "SH_NR@#{cnty}.Q".ts_eval = %Q|"NR@#{cnty}.Q".ts / "NR@HI.Q".ts|
  end
   
  ["HON"].each do |cnty|     
    "SH_NRCNM@#{cnty}.A".ts_eval = %Q|"NRCNM@#{cnty}.A".ts / "NRCNM@HI.A".ts|
    "SH_NRCNM@#{cnty}.Q".ts_eval = %Q|"NRCNM@#{cnty}.Q".ts / "NRCNM@HI.Q".ts|
  end
  
  ["HAW", "MAU", "KAU"].each do |cnty|
    "SH_NRCNM@#{cnty}.A".ts_eval = %Q|"NR@#{cnty}.A".ts / "NRCNM@HI.A".ts|
    "SH_NRCNM@#{cnty}.Q".ts_eval = %Q|"NR@#{cnty}.Q".ts / "NRCNM@HI.Q".ts|
  end


  "SH_MD@HI.A".ts_eval = %Q|"NRCMD@HI.A".ts / "NRM@HI.A".ts|
  "SH_MD@HI.Q".ts_eval= %Q| "NRCMD@HI.Q".ts / "NRM@HI.Q".ts |
    
    
  #PRUD identities included here
		"PAKRCON@HAW.Q".ts_eval= %Q|"PAKRCONNS@HAW.Q".ts|
		"PAKRCON@HON.Q".ts_eval= %Q|"PAKRCONNS@HON.Q".ts|
		"PAKRCON@KAU.Q".ts_eval= %Q|"PAKRCONNS@KAU.Q".ts|
		"PAKRCON@MAU.Q".ts_eval= %Q|"PAKRCONNS@MAU.Q".ts|
		"PAKRSGF@HAW.Q".ts_eval= %Q|"PAKRSGFNS@HAW.Q".ts|
		"PAKRSGF@HON.Q".ts_eval= %Q|"PAKRSGFNS@HON.Q".ts|
		"PAKRSGF@KAU.Q".ts_eval= %Q|"PAKRSGFNS@KAU.Q".ts|
		"PAKRSGF@MAU.Q".ts_eval= %Q|"PAKRSGFNS@MAU.Q".ts|
	
  
  ["KRSGFNS", "KRCONNS"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      "#{s_name}_NMC@#{county}.Q".ts_append_eval %Q|"#{s_name}@#{county}.Q".ts.load_from "/Volumes/UHEROwork/data/rawdata/History/prud_upd.xls"|
#      "#{s_name}_NMC@#{county}.Q".ts_append_eval %Q|"#{s_name}@#{county}.Q".ts.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
    end
  end
  
  ["KRSGFNS", "KRCONNS"].each do |s_name|
    ["HAW", "MAU", "KAU"].each do |county|
      "#{s_name}@#{county}.Q".ts_eval= %Q|"#{s_name}@HI.Q".ts.share_using("#{s_name}_NMC@#{county}.Q".ts, "#{s_name}_NMC@HON.Q".ts + "#{s_name}_NMC@HAW.Q".ts + "#{s_name}_NMC@MAU.Q".ts + "#{s_name}_NMC@KAU.Q".ts).round|
    end
    "#{s_name}_SHARED@HON.Q".ts_eval= %Q|"#{s_name}@HI.Q".ts.share_using("#{s_name}_NMC@HON.Q".ts, "#{s_name}_NMC@HON.Q".ts + "#{s_name}_NMC@HAW.Q".ts + "#{s_name}_NMC@MAU.Q".ts + "#{s_name}_NMC@KAU.Q".ts).round|
  end

  ["KRSGFNS", "KRCONNS"].each do |s_name|
    "#{s_name}_SUM@HI.Q".ts_eval= %Q|"#{s_name}_SHARED@HON.Q".ts + "#{s_name}@MAU.Q".ts + "#{s_name}@KAU.Q".ts + "#{s_name}@HAW.Q".ts|
    "#{s_name}_ERR@HI.Q".ts_eval= %Q|"#{s_name}@HI.Q".ts - "#{s_name}_SUM@HI.Q".ts|
    ["HAW", "MAU", "KAU"].each do |cnty|
      "#{s_name}_TEMP@#{cnty}.Q".ts_eval= %Q|("#{s_name}@#{cnty}.Q".ts + ("#{s_name}@#{cnty}.Q".ts/"#{s_name}_SUM@HI.Q".ts)*"#{s_name}_ERR@HI.Q".ts).round|
    end
    "#{s_name}_TEMP@HON.Q".ts_eval= %Q|("#{s_name}_SHARED@HON.Q".ts + ("#{s_name}_SHARED@HON.Q".ts/"#{s_name}_SUM@HI.Q".ts)*"#{s_name}_ERR@HI.Q".ts).round|
    "#{s_name}_NEWERR@HI.Q".ts_eval= %Q|"#{s_name}@HI.Q".ts - ("#{s_name}_TEMP@HON.Q".ts + "#{s_name}_TEMP@HAW.Q".ts + "#{s_name}_TEMP@MAU.Q".ts + "#{s_name}_TEMP@KAU.Q".ts)|
    "#{s_name}@HON.Q".ts_eval= %Q|"#{s_name}_TEMP@HON.Q".ts + "#{s_name}_NEWERR@HI.Q".ts|
  end
  
  #maybe the line below is already handled in a historical load...
  "KBCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_upd_m.csv" 
  "KBCON@HON.M".ts_eval= %Q|"KBCON@HON.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls"|
  "KBCON@HON.M".ts_eval= %Q|"KBCON@HON.M".ts.apply_seasonal_adjustment :multiplicative|
  
  "KBSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_upd_m.csv" 
  "KBSGF@HON.M".ts_eval= %Q|"KBSGF@HON.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls"|
  "KBSGF@HON.M".ts_eval= %Q|"KBSGF@HON.M".ts.apply_seasonal_adjustment :multiplicative|


  "KBCONNS@MAU.M".ts_eval= %Q|"KBCONNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|
  "KBCON@MAU.M".ts_eval= %Q|"KBCON@MAU.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/mbr_sa.xls"|
  "KBCON@MAU.M".ts_eval= %Q|"KBCON@MAU.M".ts.apply_seasonal_adjustment :multiplicative|
  
  "KBSGFNS@MAU.M".ts_eval= %Q|"KBSGFNS@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|
  "KBSGF@MAU.M".ts_eval= %Q|"KBSGF@MAU.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/mbr_sa.xls"|
  "KBSGF@MAU.M".ts_eval= %Q|"KBSGF@MAU.M".ts.apply_seasonal_adjustment :multiplicative|
  
  
  "KB@HON.M".ts_eval= %Q|Series.add_demetra_series_and_mean_correct("KBSGF@HON.M", "KBCON@HON.M", "KBNS@HON.M", "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls")|
  "KB@MAU.M".ts_eval= %Q|Series.add_demetra_series_and_mean_correct("KBSGF@MAU.M", "KBCON@MAU.M", "KBNS@MAU.M", "/Volumes/UHEROwork/data/misc/hbr/seasadj/mbr_sa.xls")|
  
  "KB@MAU.Q".ts_eval= %Q|"KB@MAU.M".ts.aggregate(:quarter, :sum)|
  "KB@HON.Q".ts_eval= %Q|"KB@HON.M".ts.aggregate(:quarter, :sum)|

  "KB@MAU.A".ts_eval= %Q|"KB@MAU.M".ts.aggregate(:year, :sum)|
  "KB@HON.A".ts_eval= %Q|"KB@HON.M".ts.aggregate(:year, :sum)|
  
  ["HON", "MAU"].each do |cnty|
    ["Q", "M"].each do |f|
      "KBNS@#{cnty}.#{f}".ts_eval = %Q|"KBSGFNS@#{cnty}.#{f}".ts + "KBCONNS@#{cnty}.#{f}".ts|
    end    
  end
  
  "PMKBSGF@HON.M".ts_eval= %Q|"PMKBSGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_upd_m.csv"|
  "PMKBCON@HON.M".ts_eval= %Q|"PMKBCON@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_upd_m.csv"|
  "PMKBSGF@MAU.M".ts_eval= %Q|"PMKBSGF@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|
  "PMKBCON@MAU.M".ts_eval= %Q|"PMKBCON@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|

  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/hbr_histQ.xls"
  
  "PMKBSGF@HON.Q".ts_eval= %Q|"PMKBSGF@HON.M".ts.aggregate(:quarter, :average)|
  "PMKBCON@HON.Q".ts_eval= %Q|"PMKBCON@HON.M".ts.aggregate(:quarter, :average)|
  
  "PMKRCON@HON.Q".ts_eval=%Q|"PMKRCON@HON.Q".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/prud/seasadj/prud_sa.xls", "prud_sa" | 
  "PMKRSGF@HON.Q".ts_eval=%Q|"PMKRSGF@HON.Q".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/prud/seasadj/prud_sa.xls", "prud_sa" |

  ["HI", "HAW", "KAU", "MAU"].each do |cnty|
    "PMKRSGF@#{cnty}.Q".ts_eval= %Q|"PMKRSGF@HON.Q".ts.mc_price_share_for("#{cnty}")|
    "PMKRCON@#{cnty}.Q".ts_eval= %Q|"PMKRCON@HON.Q".ts.mc_price_share_for("#{cnty}") |  
  end
  
  "KRCON@HI.Q".ts_eval=%Q|"KRCON@HI.Q".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/prud/seasadj/prud_sa.xls", "prud_sa" |
  "KRSGF@HI.Q".ts_eval=%Q|"KRSGF@HI.Q".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/misc/prud/seasadj/prud_sa.xls", "prud_sa" |
  
  ["HON", "HAW", "KAU", "MAU"].each do |cnty|
    "KRCON@#{cnty}.Q".ts_eval= %Q|"KRCON@HI.Q".ts.mc_price_share_for("#{cnty}")|
    "KRSGF@#{cnty}.Q".ts_eval= %Q|"KRSGF@HI.Q".ts.mc_price_share_for("#{cnty}")|
  end

  ["HI","HAW", "KAU","HON", "MAU"].each do |cnty|
  	"KRNS@#{cnty}.Q".ts_eval = %Q|"KRSGFNS@#{cnty}.Q".ts + "KRCONNS@#{cnty}.Q".ts|
  	"KR@#{cnty}.Q".ts_eval = %Q|"KRSGF@#{cnty}.Q".ts + "KRCON@#{cnty}.Q".ts|
  	"KR@#{cnty}.A".ts_eval = %Q|"KRSGF@#{cnty}.A".ts + "KRCON@#{cnty}.A".ts|
  end
  
  "PMKRCON@HON.Q".ts_eval= %Q| "PMKRCON@HON.Q".ts.apply_seasonal_adjustment :multiplicative  |
  "KRCON@HI.Q".ts_eval= %Q|  "KRCON@HI.Q".ts.apply_seasonal_adjustment :multiplicative|
  "KRSGF@HI.Q".ts_eval= %Q| "KRSGF@HI.Q".ts.apply_seasonal_adjustment :multiplicative|
  "PMKRSGF@HON.Q".ts_eval= %Q|  "PMKRSGF@HON.Q".ts.apply_seasonal_adjustment :multiplicative |

  #these don't match
   "PAKRSGF@HI.Q".ts_eval= %Q|(("PAKRSGF@HON.Q".ts * "KRSGF@HON.Q".ts) + ("PAKRSGF@HAW.Q".ts * "KRSGF@HAW.Q".ts) + ("PAKRSGF@MAU.Q".ts * "KRSGF@MAU.Q".ts)  + ("PAKRSGF@KAU.Q".ts * "KRSGF@KAU.Q".ts))/ "KRSGF@HI.Q".ts|
   "PAKRCON@HI.Q".ts_eval= %Q|(("PAKRCON@HON.Q".ts * "KRCON@HON.Q".ts) + ("PAKRCON@HAW.Q".ts * "KRCON@HAW.Q".ts) + ("PAKRCON@MAU.Q".ts * "KRCON@MAU.Q".ts)  + ("PAKRCON@KAU.Q".ts * "KRCON@KAU.Q".ts))/ "KRCON@HI.Q".ts|

   #{}"PAKRSGF@HI.Q".ts_eval= %Q|(("PAKRSGF@HON.Q".ts * "KRSGF@HON.Q".ts) + ("PAKRSGF@HAW.Q".ts * "KRSGF@HAW.Q".ts) + ("PAKRSGF@MAU.Q".ts * "KRSGF@MAU.Q".ts)  + ("PAKRSGF@KAU.Q".ts * "KRSGF@KAU.Q".ts))/ "KRSGF@HI.Q".ts|

   #these are ok
   "PAKRSGFNS@HI.Q".ts_eval= %Q|(("PAKRSGFNS@HON.Q".ts * "KRSGFNS@HON.Q".ts) + ("PAKRSGFNS@HAW.Q".ts * "KRSGFNS@HAW.Q".ts) + ("PAKRSGFNS@MAU.Q".ts * "KRSGFNS@MAU.Q".ts)  + ("PAKRSGFNS@KAU.Q".ts * "KRSGFNS@KAU.Q".ts))/ "KRSGFNS@HI.Q".ts|
   "PAKRCONNS@HI.Q".ts_eval= %Q|(("PAKRCONNS@HON.Q".ts * "KRCONNS@HON.Q".ts) + ("PAKRCONNS@HAW.Q".ts * "KRCONNS@HAW.Q".ts) + ("PAKRCONNS@MAU.Q".ts * "KRCONNS@MAU.Q".ts)  + ("PAKRCONNS@KAU.Q".ts * "KRCONNS@KAU.Q".ts))/ "KRCONNS@HI.Q".ts|
  
   ["HI", "HON", "HAW", "KAU", "MAU"].each do |cnty|
    "PMKRSGFNS@#{cnty}.A".ts_eval= %Q|"PMKRSGFNS@#{cnty}.Q".ts.aggregate(:year, :average)|
    "PMKRCONNS@#{cnty}.A".ts_eval= %Q|"PMKRCONNS@#{cnty}.Q".ts.aggregate(:year, :average)|
   end
      
   #these RMORTS are from US, but that's ok
   "RMORT@US.Q".ts_eval= %Q|"RMORT@US.M".ts.aggregate(:quarter, :average)|
   "RMORT@US.A".ts_eval= %Q|"RMORT@US.M".ts.aggregate(:year, :average)|

   #HOUSING AFFORDABILITY INDEX|
   ["HI", "HON", "HAW", "KAU", "MAU"].each do |cnty|
    "PAFSGF@#{cnty}.A".ts_eval= %Q|"YMED@#{cnty}.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
    "HPMT@#{cnty}.A".ts_eval= %Q|"PMKRSGFNS@#{cnty}.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
    "HYQUAL@#{cnty}.A".ts_eval= %Q|"HPMT@#{cnty}.A".ts*10/3*12.0|
    "HAI@#{cnty}.A".ts_eval= %Q|"YMED@#{cnty}.A".ts / "HYQUAL@#{cnty}.A".ts*100.0|
   end

   #CONDO AFFORDABILITY INDEX|
   ["HI", "HON", "HAW", "KAU", "MAU"].each do |cnty|
    "HPMTCON@#{cnty}.A".ts_eval= %Q|"PMKRCONNS@#{cnty}.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
    "HYQUALCON@#{cnty}.A".ts_eval= %Q|"HPMTCON@#{cnty}.A".ts*10/3*12.0|
    "HAICON@#{cnty}.A".ts_eval= %Q|"YMED@#{cnty}.A".ts / "HYQUALCON@#{cnty}.A".ts*100.0|
   end
   
   "HPMTCON@HI.Q".ts_eval= %Q|"PMKRCON@HI.Q".ts * 0.8 * ("RMORT@US.Q".ts/1200.0)/(((("RMORT@US.Q".ts/1200.0)+1)**-360)*-1+1)|
   "HPMTCON@HON.Q".ts_eval= %Q|"PMKRCON@HON.Q".ts * 0.8 * ("RMORT@US.Q".ts/1200.0)/(((("RMORT@US.Q".ts/1200.0)+1)**-360)*-1+1)|
   "HPMT@HI.Q".ts_eval= %Q|"PMKRSGF@HI.Q".ts * 0.8 * ("RMORT@US.Q".ts/1200.0)/(((("RMORT@US.Q".ts/1200.0)+1)**-360)*-1+1)|
   "HPMT@HON.Q".ts_eval= %Q|"PMKRSGF@HON.Q".ts * 0.8 * ("RMORT@US.Q".ts/1200.0)/(((("RMORT@US.Q".ts/1200.0)+1)**-360)*-1+1)|

   "HYQUAL@HI.Q".ts_eval= %Q|"HPMT@HI.Q".ts*10/3*12.0|
   "HYQUAL@HON.Q".ts_eval= %Q|"HPMT@HON.Q".ts*10/3*12.0|
   "HYQUALCON@HI.Q".ts_eval= %Q|"HPMTCON@HI.Q".ts*10/3*12.0|
   "HYQUALCON@HON.Q".ts_eval= %Q|"HPMTCON@HON.Q".ts*10/3*12.0|

   # "HAI@HI.Q".ts_eval=  %Q|"YMED@HI.Q".ts / "HYQUAL@HI.Q".ts*100.0|
   #    HAICON@HI.A =  "YMED@HI.A".ts / "HYQUALCON@HI.A".ts*100.0

   "PICTSGF@HON.Q".ts_eval= %Q|"PICTSGFNS@HON.Q".ts|
   
   #this may work eventually, but KPNS is not defined yet
   
   "KPGOV@HI.Q".ts_eval= %Q|"KPGOVNS@HI.Q".ts|
   "KPGOV_R@HI.A".ts_eval= %Q|"KPGOV@HI.A".ts / "PICTSGF@HON.A".ts * 100|
   "KPGOV_R@HI.Q".ts_eval= %Q|"KPGOV@HI.Q".ts / "PICTSGF@HON.Q".ts * 100| 

   "KPNS@HI.Q".ts_eval= %Q|"KPPRV@HI.Q".ts + "KPGOV@HI.Q".ts|
   "KP@HI.Q".ts_eval= %Q|"KPPRV@HI.Q".ts + "KPGOV@HI.Q".ts|
   "KPNS@HI.A".ts_eval= %Q|"KPPRV@HI.A".ts + "KPGOV@HI.A".ts|
   "KP@HI.A".ts_eval= %Q|"KPPRV@HI.A".ts + "KPGOV@HI.A".ts|   
   "KP_R@HI.A".ts_eval= %Q|"KPNS@HI.A".ts / "PICTSGF@HON.A".ts * 100|
   "KP_R@HI.Q".ts_eval= %Q|"KPNS@HI.Q".ts / "PICTSGF@HON.Q".ts * 100|
   
   #KB, KBNS, KNRSD, #KR, KRNS

  ["HI", "HON", "MAU", "HAW", "KAU"].each do |cnty|         
    "KNRSD@#{cnty}.Q".ts_eval= %Q|"KNRSDNS@#{cnty}.Q".ts|
  end

  "KNRSDMLT@HI.Q".ts_eval= %Q|"KNRSDMLTNS@HI.Q".ts|
  "KNRSDSGF@HI.Q".ts_eval= %Q|"KNRSDSGFNS@HI.Q".ts|
   
   ["KPPRVADD","KPPRVCOM", "KPPRVNRSD", "KPPRVRSD", "KPPRV"].each do |pre|
     ["Q","M"].each do |f|
       ["HI", "HON", "MAU", "HAW", "KAU"].each do |cnty|         
         "#{pre}@#{cnty}.#{f}".ts_eval= %Q|"#{pre}NS@#{cnty}.#{f}".ts|
       end
       #some of these don't work
       "#{pre}@NBI.#{f}".ts_eval= %Q|"#{pre}@HI.#{f}".ts - "#{pre}@HON.#{f}".ts|
     end
   end

   ["KPGOV", "KPPRVADD","KPPRVCOM", "KPPRVNRSD", "KPPRVRSD", "KPPRV", "KP"].each do |pre|
     ["HI", "HON", "MAU", "HAW", "KAU"].each do |cnty|
       ("#{pre}_R@#{cnty}.A".ts_eval= %Q|"#{pre}@#{cnty}.A".ts / "PICTSGF@HON.A".ts * 100|) rescue puts "_R ERROR FORM #{pre}_R@#{cnty} A"
       ("#{pre}_R@#{cnty}.Q".ts_eval= %Q|"#{pre}@#{cnty}.Q".ts / "PICTSGF@HON.Q".ts * 100|) rescue puts "_R ERROR FORM #{pre}_R@#{cnty} Q"
     end
   end
   
   "UICNS@HIONLY.W".ts_eval= %Q|"UICNS@HI.W".ts - "UICNS@OT.W".ts|
   "UICININS@HIONLY.W".ts_eval= %Q|"UICININS@HI.W".ts - "UICININS@OT.W".ts|

   ["UICINI", "UIC"].each do |pre|
     ["HIONLY", "HI", "HON", "HONO", "KANE", "KAU", "HILO", "HAW", "MOLK", "KONA", "WLKU", "OT", "WPHU", "MAU"].each do |cnty|
        ("#{pre}NS@#{cnty}.M".ts_eval= %Q|"#{pre}NS@#{cnty}.W".ts.distribute_days_interpolation.aggregate(:month, :sum)|) rescue puts "ERROR FORM #{pre}@#{cnty} M"
        ("#{pre}NS@#{cnty}.Q".ts_eval= %Q|"#{pre}NS@#{cnty}.W".ts.distribute_days_interpolation.aggregate(:quarter, :sum)|) rescue puts "ERROR FORM #{pre}@#{cnty} Q"
        ("#{pre}@#{cnty}.A".ts_eval= %Q|"#{pre}NS@#{cnty}.W".ts.distribute_days_interpolation.aggregate(:year, :sum)|) rescue puts "ERROR FORM #{pre}@#{cnty} A"        
      end
   end
   
   
   CSV.open("public/rake_time.csv", "a") {|csv| csv << ["const_identities", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end
