#MISC DATA DOWNLOADS


###*******************************************************************
###NOTES BOX

#uic_upd works and is complete
#misc_const_upd_q works and is complete
#misc_const_upd_m works and is complete

###*******************************************************************



task :uic_upd => :environment do

	uic = {
		"UICINS@HONO.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 2, :frequency => "W" }|, 
		"UICINS@KANE.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 3, :frequency => "W" }|, 
		"UICINS@WPHU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 4, :frequency => "W" }|, 
		"UICINS@HON.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 5, :frequency => "W" }|, 
		"UICINS@HILO.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 6, :frequency => "W" }|, 
		"UICINS@KONA.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 7, :frequency => "W" }|, 
		"UICINS@HAW.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 8, :frequency => "W" }|, 
		"UICINS@WLKU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 9, :frequency => "W" }|, 
		"UICINS@MOLK.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 10, :frequency => "W" }|, 
		"UICINS@MAU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 11, :frequency => "W" }|, 
		"UICINS@KAU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 12, :frequency => "W" }|, 
		"UICINS@OT.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 13, :frequency => "W" }|, 
		"UICINS@HI.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "icweekly", :row => "increment:7:1", :col => 14, :frequency => "W" }|, 
		"UICNS@HONO.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 2, :frequency => "W" }|, 
		"UICNS@KANE.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 3, :frequency => "W" }|, 
		"UICNS@WPHU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 4, :frequency => "W" }|, 
		"UICNS@HON.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 5, :frequency => "W" }|, 
		"UICNS@HILO.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 6, :frequency => "W" }|, 
		"UICNS@KONA.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 7, :frequency => "W" }|, 
		"UICNS@HAW.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 8, :frequency => "W" }|, 
		"UICNS@WLKU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 9, :frequency => "W" }|, 
		"UICNS@MOLK.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 10, :frequency => "W" }|, 
		"UICNS@MAU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 11, :frequency => "W" }|, 
		"UICNS@KAU.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 12, :frequency => "W" }|, 
		"UICNS@OT.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 13, :frequency => "W" }|, 
		"UICNS@HI.W" => %Q|Series.load_from_download  "UIC@hawaii.gov", { :file_type => "xls", :start_date => "2000-08-19", :sheet => "iwcweekly", :row => "increment:7:1", :col => 14, :frequency => "W" }|
	}
	
	p = Packager.new
	p.add_definitions uic
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/uiclaims/update/UIC_upd_NEW.xls"
end

task :const_upd_q => :environment do
	const_q = {
		"KNRSDNS@HON.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-25", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@HAW.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-26", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@MAU.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-27", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDNS@KAU.Q" => %Q|Series.load_from_download  "QSER_G@hawaii.gov", { :file_type => "xls", :start_date => "1993-01-01", :sheet => "G-28", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KPGOVNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1998-01-01", :sheet => "E-1", :row => "increment:37:1", :col => 7, :frequency => "Q" }|, 
		"KNRSDNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-3", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDSGFNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-4", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"KNRSDMLTNS@HI.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-5", :row => "block:5:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"PICTSGFNS@HON.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-6", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|, 
		"PICTCONNS@HON.Q" => %Q|Series.load_from_download  "QSER_E@hawaii.gov", { :file_type => "xls", :start_date => "1982-01-01", :sheet => "E-7", :row => "block:6:1:4", :col => "repeat:2:5", :frequency => "Q" }|
	}
	
	p = Packager.new
	p.add_definitions const_q
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_NEW.xls"
end

task :const_upd_m => :environment do
	const_m = {
		"KPPRVNS@HI.M" => %Q|Series.load_from_download  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" }|, 
		"KPPRVRSDNS@HI.M" => %Q|Series.load_from_download  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" }|, 
		"KPPRVCOMNS@HI.M" => %Q|Series.load_from_download  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" }|, 
		"KPPRVADDNS@HI.M" => %Q|Series.load_from_download  "CONST_HI@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" }|, 
		"KPPRVNS@HON.M" => %Q|Series.load_from_download  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" }|, 
		"KPPRVRSDNS@HON.M" => %Q|Series.load_from_download  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" }|, 
		"KPPRVCOMNS@HON.M" => %Q|Series.load_from_download  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" }|, 
		"KPPRVADDNS@HON.M" => %Q|Series.load_from_download  "CONST_HON@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" }|, 
		"KPPRVNS@HAW.M" => %Q|Series.load_from_download  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" }|, 
		"KPPRVRSDNS@HAW.M" => %Q|Series.load_from_download  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" }|, 
		"KPPRVCOMNS@HAW.M" => %Q|Series.load_from_download  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" }|, 
		"KPPRVADDNS@HAW.M" => %Q|Series.load_from_download  "CONST_HAW@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" }|, 
		"KPPRVNS@MAU.M" => %Q|Series.load_from_download  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" }|, 
		"KPPRVRSDNS@MAU.M" => %Q|Series.load_from_download  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" }|, 
		"KPPRVCOMNS@MAU.M" => %Q|Series.load_from_download  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" }|, 
		"KPPRVADDNS@MAU.M" => %Q|Series.load_from_download  "CONST_MAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" }|, 
		"KPPRVNS@KAU.M" => %Q|Series.load_from_download  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 41, :frequency => "M" }|, 
		"KPPRVRSDNS@KAU.M" => %Q|Series.load_from_download  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 42, :frequency => "M" }|, 
		"KPPRVCOMNS@KAU.M" => %Q|Series.load_from_download  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 43, :frequency => "M" }|, 
		"KPPRVADDNS@KAU.M" => %Q|Series.load_from_download  "CONST_KAU@hawaii.gov", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "sheet_num:1", :row => "increment:5:1", :col => 44, :frequency => "M" }|, 
		"PICTSGFNS@US.M" => %Q|Series.load_from_download  "CONST_PICT@census.gov", { :file_type => "xls", :start_date => "1964-01-01", :sheet => "fixed", :row => "block:9:1:12", :col => "repeat_with_step:7:29:2", :frequency => "M" }|
	}
	
	p = Packager.new
	p.add_definitions const_m
	p.write_definitions_to "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"
end
