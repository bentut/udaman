#TAX SERIES DOWNLOADS

###*******************************************************************
###NOTES BOX

#need to also define error handling in packager (or some other high level location)

#With the download being to a zip file, there seems to be a problem in unzipping the data to a usable form.

###*******************************************************************


task :tax_upd => :environment do
  t = Time.now
	collec = {
		"TRFINS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 5, :col => 6, :frequency => "M" })/1000|, 
		"TRCVNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 6, :col => 6, :frequency => "M" })/1000|, 
		"TREMNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 7, :col => 6, :frequency => "M" })/1000|, 
		"TRFUNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 8, :col => 6, :frequency => "M" })/1000|, 
		"TRGLNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 9, :col => 6, :frequency => "M" })/1000|, 
		"TRGTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 10, :col => 6, :frequency => "M" })/1000|, 
		"TRHSNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 11, :col => 6, :frequency => "M" })/1000|, 
		"TRCOESNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 13, :col => 6, :frequency => "M" })/1000|, 
		"TRCOPRNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 14, :col => 6, :frequency => "M" })/1000|, 
		"TRCORFNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 15, :col => 6, :frequency => "M" })/1000|, 
		"TRINESNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 17, :col => 6, :frequency => "M" })/1000|, 
		"TRINPRNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 18, :col => 6, :frequency => "M" })/1000|, 
		"TRINWHNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 19, :col => 6, :frequency => "M" })/1000|, 
		"TRINRFNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 20, :col => 6, :frequency => "M" })/1000|, 
		"TRIHNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 21, :col => 6, :frequency => "M" })/1000|, 
		"TRISNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 23, :col => 6, :frequency => "M" })/1000|, 
		"TRLINS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 24, :col => 6, :frequency => "M" })/1000|, 
		"TRMTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 25, :col => 6, :frequency => "M" })/1000|, 
		"TRPSNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 26, :col => 6, :frequency => "M" })/1000|, 
		"TRTBNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 27, :col => 6, :frequency => "M" })/1000|, 
		"TRTFNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 28, :col => 6, :frequency => "M" })/1000|, 
		"TRTTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 29, :col => 6, :frequency => "M" })/1000|, 
		"TROTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 30, :col => 6, :frequency => "M" })/1000|, 
		"TRNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 31, :col => 6, :frequency => "M" })/1000|, 
		"TRFINS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 5, :col => 2, :frequency => "M" })/1000|, 
		"TRCVNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 6, :col => 2, :frequency => "M" })/1000|, 
		"TREMNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 7, :col => 2, :frequency => "M" })/1000|, 
		"TRFUNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 8, :col => 2, :frequency => "M" })/1000|, 
		"TRGLNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 9, :col => 2, :frequency => "M" })/1000|, 
		"TRGTNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 10, :col => 2, :frequency => "M" })/1000|, 
		"TRHSNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 11, :col => 2, :frequency => "M" })/1000|, 
		"TRCOESNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 13, :col => 2, :frequency => "M" })/1000|, 
		"TRCOPRNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 14, :col => 2, :frequency => "M" })/1000|, 
		"TRCORFNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 15, :col => 2, :frequency => "M" })/1000|, 
		"TRINESNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 17, :col => 2, :frequency => "M" })/1000|, 
		"TRINPRNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 18, :col => 2, :frequency => "M" })/1000|, 
		"TRINWHNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 19, :col => 2, :frequency => "M" })/1000|, 
		"TRINRFNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 20, :col => 2, :frequency => "M" })/1000|, 
		"TRIHNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 21, :col => 2, :frequency => "M" })/1000|, 
		"TRISNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 23, :col => 2, :frequency => "M" })/1000|, 
		"TRLINS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 24, :col => 2, :frequency => "M" })/1000|, 
		"TRMTNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 25, :col => 2, :frequency => "M" })/1000|, 
		"TRPSNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 26, :col => 2, :frequency => "M" })/1000|, 
		"TRTBNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 27, :col => 2, :frequency => "M" })/1000|, 
		"TRTFNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 28, :col => 2, :frequency => "M" })/1000|, 
		"TRTTNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 29, :col => 2, :frequency => "M" })/1000|, 
		"TROTNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 30, :col => 2, :frequency => "M" })/1000|, 
		"TRNS@HON.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 31, :col => 2, :frequency => "M" })/1000|, 
		"TRFINS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 5, :col => 3, :frequency => "M" })/1000|, 
		"TRCVNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 6, :col => 3, :frequency => "M" })/1000|, 
		"TREMNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 7, :col => 3, :frequency => "M" })/1000|, 
		"TRFUNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 8, :col => 3, :frequency => "M" })/1000|, 
		"TRGLNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 9, :col => 3, :frequency => "M" })/1000|, 
		"TRGTNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 10, :col => 3, :frequency => "M" })/1000|, 
		"TRHSNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 11, :col => 3, :frequency => "M" })/1000|, 
		"TRCOESNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 13, :col => 3, :frequency => "M" })/1000|, 
		"TRCOPRNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 14, :col => 3, :frequency => "M" })/1000|, 
		"TRCORFNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 15, :col => 3, :frequency => "M" })/1000|, 
		"TRINESNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 17, :col => 3, :frequency => "M" })/1000|, 
		"TRINPRNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 18, :col => 3, :frequency => "M" })/1000|, 
		"TRINWHNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 19, :col => 3, :frequency => "M" })/1000|, 
		"TRINRFNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 20, :col => 3, :frequency => "M" })/1000|, 
		"TRIHNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 21, :col => 3, :frequency => "M" })/1000|, 
		"TRISNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 23, :col => 3, :frequency => "M" })/1000|, 
		"TRLINS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 24, :col => 3, :frequency => "M" })/1000|, 
		"TRMTNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 25, :col => 3, :frequency => "M" })/1000|, 
		"TRPSNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 26, :col => 3, :frequency => "M" })/1000|, 
		"TRTBNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 27, :col => 3, :frequency => "M" })/1000|, 
		"TRTFNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 28, :col => 3, :frequency => "M" })/1000|, 
		"TRTTNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 29, :col => 3, :frequency => "M" })/1000|, 
		"TROTNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 30, :col => 3, :frequency => "M" })/1000|, 
		"TRNS@MAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 31, :col => 3, :frequency => "M" })/1000|, 
		"TRFINS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 5, :col => 4, :frequency => "M" })/1000|, 
		"TRCVNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 6, :col => 4, :frequency => "M" })/1000|, 
		"TREMNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 7, :col => 4, :frequency => "M" })/1000|, 
		"TRFUNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 8, :col => 4, :frequency => "M" })/1000|, 
		"TRGLNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 9, :col => 4, :frequency => "M" })/1000|, 
		"TRGTNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 10, :col => 4, :frequency => "M" })/1000|, 
		"TRHSNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 11, :col => 4, :frequency => "M" })/1000|, 
		"TRCOESNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 13, :col => 4, :frequency => "M" })/1000|, 
		"TRCOPRNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 14, :col => 4, :frequency => "M" })/1000|, 
		"TRCORFNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 15, :col => 4, :frequency => "M" })/1000|, 
		"TRINESNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 17, :col => 4, :frequency => "M" })/1000|, 
		"TRINPRNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 18, :col => 4, :frequency => "M" })/1000|, 
		"TRINWHNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 19, :col => 4, :frequency => "M" })/1000|, 
		"TRINRFNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 20, :col => 4, :frequency => "M" })/1000|, 
		"TRIHNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 21, :col => 4, :frequency => "M" })/1000|, 
		"TRISNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 23, :col => 4, :frequency => "M" })/1000|, 
		"TRLINS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 24, :col => 4, :frequency => "M" })/1000|, 
		"TRMTNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 25, :col => 4, :frequency => "M" })/1000|, 
		"TRPSNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 26, :col => 4, :frequency => "M" })/1000|, 
		"TRTBNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 27, :col => 4, :frequency => "M" })/1000|, 
		"TRTFNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 28, :col => 4, :frequency => "M" })/1000|, 
		"TRTTNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 29, :col => 4, :frequency => "M" })/1000|, 
		"TROTNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 30, :col => 4, :frequency => "M" })/1000|, 
		"TRNS@HAW.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 31, :col => 4, :frequency => "M" })/1000|, 
		"TRFINS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 5, :col => 5, :frequency => "M" })/1000|, 
		"TRCVNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 6, :col => 5, :frequency => "M" })/1000|, 
		"TREMNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 7, :col => 5, :frequency => "M" })/1000|, 
		"TRFUNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 8, :col => 5, :frequency => "M" })/1000|, 
		"TRGLNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 9, :col => 5, :frequency => "M" })/1000|, 
		"TRGTNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 10, :col => 5, :frequency => "M" })/1000|, 
		"TRHSNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 11, :col => 5, :frequency => "M" })/1000|, 
		"TRCOESNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 13, :col => 5, :frequency => "M" })/1000|, 
		"TRCOPRNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 14, :col => 5, :frequency => "M" })/1000|, 
		"TRCORFNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 15, :col => 5, :frequency => "M" })/1000|, 
		"TRINESNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 17, :col => 5, :frequency => "M" })/1000|, 
		"TRINPRNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 18, :col => 5, :frequency => "M" })/1000|, 
		"TRINWHNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 19, :col => 5, :frequency => "M" })/1000|, 
		"TRINRFNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 20, :col => 5, :frequency => "M" })/1000|, 
		"TRIHNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 21, :col => 5, :frequency => "M" })/1000|, 
		"TRISNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 23, :col => 5, :frequency => "M" })/1000|, 
		"TRLINS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 24, :col => 5, :frequency => "M" })/1000|, 
		"TRMTNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 25, :col => 5, :frequency => "M" })/1000|, 
		"TRPSNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 26, :col => 5, :frequency => "M" })/1000|, 
		"TRTBNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 27, :col => 5, :frequency => "M" })/1000|, 
		"TRTFNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 28, :col => 5, :frequency => "M" })/1000|, 
		"TRTTNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 29, :col => 5, :frequency => "M" })/1000|, 
		"TROTNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 30, :col => 5, :frequency => "M" })/1000|, 
		"TRNS@KAU.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 31, :col => 5, :frequency => "M" })/1000|, 
		"TDGFNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 36, :col => 6, :frequency => "M" })/1000|, 
		"TDHWNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 37, :col => 6, :frequency => "M" })/1000|, 
		"TDAPNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 38, :col => 6, :frequency => "M" })/1000|, 
		"TDBONS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 39, :col => 6, :frequency => "M" })/1000|, 
		"TDEVNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 40, :col => 6, :frequency => "M" })/1000|, 
		"TDCANS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 41, :col => 6, :frequency => "M" })/1000|, 
		"TDCENS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 42, :col => 6, :frequency => "M" })/1000|, 
		"TDEMNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 45, :col => 6, :frequency => "M" })/1000|, 
		"TDRHNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 46, :col => 6, :frequency => "M" })/1000|, 
		"TDNANS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 47, :col => 6, :frequency => "M" })/1000|, 
		"TDCVNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 48, :col => 6, :frequency => "M" })/1000|, 
		"TDTTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 49, :col => 4, :frequency => "M" })/1000|, 
		"TDTSNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 51, :col => 6, :frequency => "M" })/1000|, 
		"TDCTFUNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 66, :col => 6, :frequency => "M" })/1000|, 
		"TDCTTTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 67, :col => 6, :frequency => "M" })/1000|, 
		"TDCTNS@HI.M" => %Q|Series.load_from_download(  "tax_collec%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-01-01", :sheet => "sheet_num:1", :row => 68, :col => 6, :frequency => "M" })/1000|
	}
	
	ge = {
		"TGBRTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 38, :col => 6, :frequency => "M" })/1000|, 
		"TGBSVNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 39, :col => 6, :frequency => "M" })/1000|, 
		"TGBCTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 40, :col => 6, :frequency => "M" })/1000|, 
		"TGBTHNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 41, :col => 6, :frequency => "M" })/1000|, 
		"TGBITNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 42, :col => 6, :frequency => "M" })/1000|, 
		"TGBCMNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 43, :col => 6, :frequency => "M" })/1000|, 
		"TGBHTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 44, :col => 6, :frequency => "M" })/1000|, 
		"TGBORNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 45, :col => 6, :frequency => "M" })/1000|, 
		"TGBU4NS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 46, :col => 6, :frequency => "M" })/1000|, 
		"TGBOTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 47, :col => 6, :frequency => "M" })/1000|, 
		"TGBISNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 50, :col => 6, :frequency => "M" })/1000|, 
		"TGBSUNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 51, :col => 6, :frequency => "M" })/1000|, 
		"TGBPINS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 52, :col => 6, :frequency => "M" })/1000|, 
		"TGBPDNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 53, :col => 6, :frequency => "M" })/1000|, 
		"TGBMNNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 54, :col => 6, :frequency => "M" })/1000|, 
		"TGBWTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 55, :col => 6, :frequency => "M" })/1000|, 
		"TGBSINS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 56, :col => 6, :frequency => "M" })/1000|, 
		"TGBU5NS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 57, :col => 6, :frequency => "M" })/1000|, 
		"TGBNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 60, :col => 6, :frequency => "M" })/1000|, 
		"TGBRTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 38, :col => 2, :frequency => "M" })/1000|, 
		"TGBSVNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 39, :col => 2, :frequency => "M" })/1000|, 
		"TGBCTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 40, :col => 2, :frequency => "M" })/1000|, 
		"TGBTHNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 41, :col => 2, :frequency => "M" })/1000|, 
		"TGBITNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 42, :col => 2, :frequency => "M" })/1000|, 
		"TGBCMNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 43, :col => 2, :frequency => "M" })/1000|, 
		"TGBHTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 44, :col => 2, :frequency => "M" })/1000|, 
		"TGBORNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 45, :col => 2, :frequency => "M" })/1000|, 
		"TGBU4NS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 46, :col => 2, :frequency => "M" })/1000|, 
		"TGBOTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 47, :col => 2, :frequency => "M" })/1000|, 
		"TGBISNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 50, :col => 2, :frequency => "M" })/1000|, 
		"TGBSUNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 51, :col => 2, :frequency => "M" })/1000|, 
		"TGBPINS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 52, :col => 2, :frequency => "M" })/1000|, 
		"TGBPDNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 53, :col => 2, :frequency => "M" })/1000|, 
		"TGBMNNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 54, :col => 2, :frequency => "M" })/1000|, 
		"TGBWTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 55, :col => 2, :frequency => "M" })/1000|, 
		"TGBSINS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 56, :col => 2, :frequency => "M" })/1000|, 
		"TGBU5NS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 57, :col => 2, :frequency => "M" })/1000|, 
		"TGBNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 60, :col => 2, :frequency => "M" })/1000|, 
		"TGBRTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 38, :col => 3, :frequency => "M" })/1000|, 
		"TGBSVNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 39, :col => 3, :frequency => "M" })/1000|, 
		"TGBCTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 40, :col => 3, :frequency => "M" })/1000|, 
		"TGBTHNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 41, :col => 3, :frequency => "M" })/1000|, 
		"TGBITNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 42, :col => 3, :frequency => "M" })/1000|, 
		"TGBCMNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 43, :col => 3, :frequency => "M" })/1000|, 
		"TGBHTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 44, :col => 3, :frequency => "M" })/1000|, 
		"TGBORNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 45, :col => 3, :frequency => "M" })/1000|, 
		"TGBU4NS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 46, :col => 3, :frequency => "M" })/1000|, 
		"TGBOTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 47, :col => 3, :frequency => "M" })/1000|, 
		"TGBISNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 50, :col => 3, :frequency => "M" })/1000|, 
		"TGBSUNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 51, :col => 3, :frequency => "M" })/1000|, 
		"TGBPINS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 52, :col => 3, :frequency => "M" })/1000|, 
		"TGBPDNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 53, :col => 3, :frequency => "M" })/1000|, 
		"TGBMNNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 54, :col => 3, :frequency => "M" })/1000|, 
		"TGBWTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 55, :col => 3, :frequency => "M" })/1000|, 
		"TGBSINS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 56, :col => 3, :frequency => "M" })/1000|, 
		"TGBU5NS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 57, :col => 3, :frequency => "M" })/1000|, 
		"TGBNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 60, :col => 3, :frequency => "M" })/1000|, 
		"TGBRTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 38, :col => 4, :frequency => "M" })/1000|, 
		"TGBSVNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 39, :col => 4, :frequency => "M" })/1000|, 
		"TGBCTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 40, :col => 4, :frequency => "M" })/1000|, 
		"TGBTHNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 41, :col => 4, :frequency => "M" })/1000|, 
		"TGBITNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 42, :col => 4, :frequency => "M" })/1000|, 
		"TGBCMNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 43, :col => 4, :frequency => "M" })/1000|, 
		"TGBHTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 44, :col => 4, :frequency => "M" })/1000|, 
		"TGBORNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 45, :col => 4, :frequency => "M" })/1000|, 
		"TGBU4NS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 46, :col => 4, :frequency => "M" })/1000|, 
		"TGBOTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 47, :col => 4, :frequency => "M" })/1000|, 
		"TGBISNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 50, :col => 4, :frequency => "M" })/1000|, 
		"TGBSUNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 51, :col => 4, :frequency => "M" })/1000|, 
		"TGBPINS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 52, :col => 4, :frequency => "M" })/1000|, 
		"TGBPDNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 53, :col => 4, :frequency => "M" })/1000|, 
		"TGBMNNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 54, :col => 4, :frequency => "M" })/1000|, 
		"TGBWTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 55, :col => 4, :frequency => "M" })/1000|, 
		"TGBSINS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 56, :col => 4, :frequency => "M" })/1000|, 
		"TGBU5NS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 57, :col => 4, :frequency => "M" })/1000|, 
		"TGBNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 60, :col => 4, :frequency => "M" })/1000|, 
		"TGBRTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 38, :col => 5, :frequency => "M" })/1000|, 
		"TGBSVNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 39, :col => 5, :frequency => "M" })/1000|, 
		"TGBCTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 40, :col => 5, :frequency => "M" })/1000|, 
		"TGBTHNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 41, :col => 5, :frequency => "M" })/1000|, 
		"TGBITNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 42, :col => 5, :frequency => "M" })/1000|, 
		"TGBCMNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 43, :col => 5, :frequency => "M" })/1000|, 
		"TGBHTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 44, :col => 5, :frequency => "M" })/1000|, 
		"TGBORNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 45, :col => 5, :frequency => "M" })/1000|, 
		"TGBU4NS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 46, :col => 5, :frequency => "M" })/1000|, 
		"TGBOTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 47, :col => 5, :frequency => "M" })/1000|, 
		"TGBISNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 50, :col => 5, :frequency => "M" })/1000|, 
		"TGBSUNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 51, :col => 5, :frequency => "M" })/1000|, 
		"TGBPINS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 52, :col => 5, :frequency => "M" })/1000|, 
		"TGBPDNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 53, :col => 5, :frequency => "M" })/1000|, 
		"TGBMNNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 54, :col => 5, :frequency => "M" })/1000|, 
		"TGBWTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 55, :col => 5, :frequency => "M" })/1000|, 
		"TGBSINS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 56, :col => 5, :frequency => "M" })/1000|, 
		"TGBU5NS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 57, :col => 5, :frequency => "M" })/1000|, 
		"TGBNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 60, :col => 5, :frequency => "M" })/1000|, 
		"TGRRTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 6, :col => 6, :frequency => "M" })/1000|, 
		"TGRSVNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 7, :col => 6, :frequency => "M" })/1000|, 
		"TGRCTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 8, :col => 6, :frequency => "M" })/1000|, 
		"TGRTHNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 9, :col => 6, :frequency => "M" })/1000|, 
		"TGRITNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 10, :col => 6, :frequency => "M" })/1000|, 
		"TGRCMNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 11, :col => 6, :frequency => "M" })/1000|, 
		"TGRHTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 12, :col => 6, :frequency => "M" })/1000|, 
		"TGRORNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 13, :col => 6, :frequency => "M" })/1000|, 
		"TGRU4NS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 14, :col => 6, :frequency => "M" })/1000|, 
		"TGROTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 15, :col => 6, :frequency => "M" })/1000|, 
		"TGRISNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 18, :col => 6, :frequency => "M" })/1000|, 
		"TGRSUNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 19, :col => 6, :frequency => "M" })/1000|, 
		"TGRPINS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 20, :col => 6, :frequency => "M" })/1000|, 
		"TGRPDNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 21, :col => 6, :frequency => "M" })/1000|, 
		"TGRMNNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 22, :col => 6, :frequency => "M" })/1000|, 
		"TGRWTNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 23, :col => 6, :frequency => "M" })/1000|, 
		"TGRSINS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 24, :col => 6, :frequency => "M" })/1000|, 
		"TGRU5NS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 25, :col => 6, :frequency => "M" })/1000|, 
		"TGRALNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 28, :col => 6, :frequency => "M" })/1000|, 
		"TGRUANS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 30, :col => 6, :frequency => "M" })/1000|, 
		"TGRNS@HI.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 32, :col => 6, :frequency => "M" })/1000|, 
		"TGRRTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 6, :col => 2, :frequency => "M" })/1000|, 
		"TGRSVNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 7, :col => 2, :frequency => "M" })/1000|, 
		"TGRCTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 8, :col => 2, :frequency => "M" })/1000|, 
		"TGRTHNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 9, :col => 2, :frequency => "M" })/1000|, 
		"TGRITNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 10, :col => 2, :frequency => "M" })/1000|, 
		"TGRCMNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 11, :col => 2, :frequency => "M" })/1000|, 
		"TGRHTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 12, :col => 2, :frequency => "M" })/1000|, 
		"TGRORNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 13, :col => 2, :frequency => "M" })/1000|, 
		"TGRU4NS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 14, :col => 2, :frequency => "M" })/1000|, 
		"TGROTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 15, :col => 2, :frequency => "M" })/1000|, 
		"TGRISNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 18, :col => 2, :frequency => "M" })/1000|, 
		"TGRSUNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 19, :col => 2, :frequency => "M" })/1000|, 
		"TGRPINS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 20, :col => 2, :frequency => "M" })/1000|, 
		"TGRPDNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 21, :col => 2, :frequency => "M" })/1000|, 
		"TGRMNNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 22, :col => 2, :frequency => "M" })/1000|, 
		"TGRWTNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 23, :col => 2, :frequency => "M" })/1000|, 
		"TGRSINS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 24, :col => 2, :frequency => "M" })/1000|, 
		"TGRU5NS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 25, :col => 2, :frequency => "M" })/1000|, 
		"TGRALNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 28, :col => 2, :frequency => "M" })/1000|, 
		"TGRUANS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 30, :col => 2, :frequency => "M" })/1000|, 
		"TGRNS@HON.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 32, :col => 2, :frequency => "M" })/1000|, 
		"TGRRTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 6, :col => 3, :frequency => "M" })/1000|, 
		"TGRSVNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 7, :col => 3, :frequency => "M" })/1000|, 
		"TGRCTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 8, :col => 3, :frequency => "M" })/1000|, 
		"TGRTHNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 9, :col => 3, :frequency => "M" })/1000|, 
		"TGRITNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 10, :col => 3, :frequency => "M" })/1000|, 
		"TGRCMNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 11, :col => 3, :frequency => "M" })/1000|, 
		"TGRHTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 12, :col => 3, :frequency => "M" })/1000|, 
		"TGRORNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 13, :col => 3, :frequency => "M" })/1000|, 
		"TGRU4NS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 14, :col => 3, :frequency => "M" })/1000|, 
		"TGROTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 15, :col => 3, :frequency => "M" })/1000|, 
		"TGRISNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 18, :col => 3, :frequency => "M" })/1000|, 
		"TGRSUNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 19, :col => 3, :frequency => "M" })/1000|, 
		"TGRPINS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 20, :col => 3, :frequency => "M" })/1000|, 
		"TGRPDNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 21, :col => 3, :frequency => "M" })/1000|, 
		"TGRMNNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 22, :col => 3, :frequency => "M" })/1000|, 
		"TGRWTNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 23, :col => 3, :frequency => "M" })/1000|, 
		"TGRSINS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 24, :col => 3, :frequency => "M" })/1000|, 
		"TGRU5NS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 25, :col => 3, :frequency => "M" })/1000|, 
		"TGRALNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 28, :col => 3, :frequency => "M" })/1000|, 
		"TGRUANS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 30, :col => 3, :frequency => "M" })/1000|, 
		"TGRNS@MAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 32, :col => 3, :frequency => "M" })/1000|, 
		"TGRRTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 6, :col => 4, :frequency => "M" })/1000|, 
		"TGRSVNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 7, :col => 4, :frequency => "M" })/1000|, 
		"TGRCTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 8, :col => 4, :frequency => "M" })/1000|, 
		"TGRTHNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 9, :col => 4, :frequency => "M" })/1000|, 
		"TGRITNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 10, :col => 4, :frequency => "M" })/1000|, 
		"TGRCMNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 11, :col => 4, :frequency => "M" })/1000|, 
		"TGRHTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 12, :col => 4, :frequency => "M" })/1000|, 
		"TGRORNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 13, :col => 4, :frequency => "M" })/1000|, 
		"TGRU4NS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 14, :col => 4, :frequency => "M" })/1000|, 
		"TGROTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 15, :col => 4, :frequency => "M" })/1000|, 
		"TGRISNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 18, :col => 4, :frequency => "M" })/1000|, 
		"TGRSUNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 19, :col => 4, :frequency => "M" })/1000|, 
		"TGRPINS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 20, :col => 4, :frequency => "M" })/1000|, 
		"TGRPDNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 21, :col => 4, :frequency => "M" })/1000|, 
		"TGRMNNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 22, :col => 4, :frequency => "M" })/1000|, 
		"TGRWTNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 23, :col => 4, :frequency => "M" })/1000|, 
		"TGRSINS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 24, :col => 4, :frequency => "M" })/1000|, 
		"TGRU5NS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 25, :col => 4, :frequency => "M" })/1000|, 
		"TGRALNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 28, :col => 4, :frequency => "M" })/1000|, 
		"TGRUANS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 30, :col => 4, :frequency => "M" })/1000|, 
		"TGRNS@HAW.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 32, :col => 4, :frequency => "M" })/1000|, 
		"TGRRTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 6, :col => 5, :frequency => "M" })/1000|, 
		"TGRSVNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 7, :col => 5, :frequency => "M" })/1000|, 
		"TGRCTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 8, :col => 5, :frequency => "M" })/1000|, 
		"TGRTHNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 9, :col => 5, :frequency => "M" })/1000|, 
		"TGRITNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 10, :col => 5, :frequency => "M" })/1000|, 
		"TGRCMNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 11, :col => 5, :frequency => "M" })/1000|, 
		"TGRHTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 12, :col => 5, :frequency => "M" })/1000|, 
		"TGRORNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 13, :col => 5, :frequency => "M" })/1000|, 
		"TGRU4NS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 14, :col => 5, :frequency => "M" })/1000|, 
		"TGROTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 15, :col => 5, :frequency => "M" })/1000|, 
		"TGRISNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 18, :col => 5, :frequency => "M" })/1000|, 
		"TGRSUNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 19, :col => 5, :frequency => "M" })/1000|, 
		"TGRPINS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 20, :col => 5, :frequency => "M" })/1000|, 
		"TGRPDNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 21, :col => 5, :frequency => "M" })/1000|, 
		"TGRMNNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 22, :col => 5, :frequency => "M" })/1000|, 
		"TGRWTNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 23, :col => 5, :frequency => "M" })/1000|, 
		"TGRSINS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 24, :col => 5, :frequency => "M" })/1000|, 
		"TGRU5NS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 25, :col => 5, :frequency => "M" })/1000|, 
		"TGRALNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 28, :col => 5, :frequency => "M" })/1000|, 
		"TGRUANS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 30, :col => 5, :frequency => "M" })/1000|, 
		"TGRNS@KAU.M" => %Q|Series.load_from_download(  "tax_GE%Y_%m@hawaii.gov", { :file_type => "xls", :start_date => "2011-03-01", :sheet => "sheet_num:1", :row => 32, :col => 5, :frequency => "M" })/1000|
	}
	
	#to load in preliminary data. This is a manual file that must be manually updated... may eventually want to take this out and run manually as well
	Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/dotax_preliminary_data.xls"
	
	p = Packager.new
	p.add_definitions collec
	p.write_definitions_to "/Volumes/UHEROwork/data/tax/update/collec_upd_NEW.xls"

  p = Packager.new
  p.add_definitions ge
  p.write_definitions_to "/Volumes/UHEROwork/data/tax/update/ge_upd_NEW.xls"
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tax_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :tax_identities => :environment do
  t = Time.now
  #3/21/12 Ben: try to replace all of these with individual calls since they change and should go in the loads in the other jobs
  #Series.load_all_mean_corrected_sa_series_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata" 
  #Series.load_all_sa_series_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls", "sadata" 
  #Series.load_all_sa_series_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls", "sadata"
  # replacing this load with individual calls
  # Series.load_all_sa_series_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"
  # Series.load_all_mean_corrected_sa_series_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"
  #maybe should put this in tax section? (but these need to run AFTER all the tax are read in)

  #9/28/12
  #would be nice if this load could be made more efficient. Not sure why the grouped call isn't working well right now...

  ["HI", "HON", "MAU", "KAU", "HAW"].each do |cnty|
    begin
      "TRINNS@#{cnty}.M".ts_eval= %Q|"TRINESNS@#{cnty}.M".ts + "TRINPRNS@#{cnty}.M".ts + "TRINWHNS@#{cnty}.M".ts + "TRINRFNS@#{cnty}.M".ts|
      "TRCONS@#{cnty}.M".ts_eval= %Q|"TRCOESNS@#{cnty}.M".ts + "TRCOPRNS@#{cnty}.M".ts + "TRCORFNS@#{cnty}.M".ts|
    
      "TRCONS@#{cnty}.Q".ts_eval= %Q|"TRCONS@#{cnty}.M".ts.aggregate_by(:quarter, :sum)|
      "TRINNS@#{cnty}.Q".ts_eval= %Q|"TRINNS@#{cnty}.M".ts.aggregate_by(:quarter, :sum)|
    rescue
      puts "problem with #{cnty}. 4 series skipped"
    end
  end
  "TR@HI.M".ts_eval=%Q|"TR@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TR@HI.M".ts_eval=%Q|"TR@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRFU@HI.M".ts_eval=%Q|"TRFU@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRFU@HI.M".ts_eval=%Q|"TRFU@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRGT@HI.M".ts_eval=%Q|"TRGT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRGT@HI.M".ts_eval=%Q|"TRGT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRCOES@HI.M".ts_eval=%Q|"TRCOES@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRCOES@HI.M".ts_eval=%Q|"TRCOES@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRCOPR@HI.M".ts_eval=%Q|"TRCOPR@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRCOPR@HI.M".ts_eval=%Q|"TRCOPR@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRCORF@HI.M".ts_eval=%Q|"TRCORF@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRCORF@HI.M".ts_eval=%Q|"TRCORF@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRINES@HI.M".ts_eval=%Q|"TRINES@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRINES@HI.M".ts_eval=%Q|"TRINES@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRINPR@HI.M".ts_eval=%Q|"TRINPR@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRINPR@HI.M".ts_eval=%Q|"TRINPR@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRINWH@HI.M".ts_eval=%Q|"TRINWH@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRINWH@HI.M".ts_eval=%Q|"TRINWH@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRINRF@HI.M".ts_eval=%Q|"TRINRF@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRINRF@HI.M".ts_eval=%Q|"TRINRF@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRTT@HI.M".ts_eval=%Q|"TRTT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRTT@HI.M".ts_eval=%Q|"TRTT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim("1987-02-01","1987-12-01")|
  "TRTT@HI.M".ts_eval=%Q|"TRTT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGR@HI.M".ts_eval=%Q|"TGR@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGR@HI.M".ts_eval=%Q|"TGR@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGRRT@HI.M".ts_eval=%Q|"TGRRT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGRRT@HI.M".ts_eval=%Q|"TGRRT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGRCT@HI.M".ts_eval=%Q|"TGRCT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGRCT@HI.M".ts_eval=%Q|"TGRCT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGRHT@HI.M".ts_eval=%Q|"TGRHT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGRHT@HI.M".ts_eval=%Q|"TGRHT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGB@HI.M".ts_eval=%Q|"TGB@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGB@HI.M".ts_eval=%Q| "TGB@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGBRT@HI.M".ts_eval=%Q|"TGBRT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGBRT@HI.M".ts_eval=%Q|"TGBRT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGBSV@HI.M".ts_eval=%Q|"TGBSV@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGBSV@HI.M".ts_eval=%Q|"TGBSV@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGBCT@HI.M".ts_eval=%Q|"TGBCT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGBCT@HI.M".ts_eval=%Q|"TGBCT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  
  "TGBCTNS@HI.Q".ts_eval= %Q|"TGBCTNS@HI.M".ts.aggregate_by(:quarter, :sum)|
  "TGBCT@HI.Q".ts_eval= %Q|"TGBCT@HI.M".ts.aggregate_by(:quarter, :sum)|  
  
  "TGBHT@HI.M".ts_eval=%Q|"TGBHT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGBHT@HI.M".ts_eval=%Q|"TGBHT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDGF@HI.M".ts_eval=%Q|"TDGF@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDGF@HI.M".ts_eval=%Q|"TDGF@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDHW@HI.M".ts_eval=%Q|"TDHW@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDHW@HI.M".ts_eval=%Q|"TDHW@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDAP@HI.M".ts_eval=%Q|"TDAP@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDAP@HI.M".ts_eval=%Q|"TDAP@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDTS@HI.M".ts_eval=%Q|"TDTS@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDTS@HI.M".ts_eval=%Q|"TDTS@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDCT@HI.M".ts_eval=%Q|"TDCT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDCT@HI.M".ts_eval=%Q|"TDCT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDCTFU@HI.M".ts_eval=%Q|"TDCTFU@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDCTFU@HI.M".ts_eval=%Q|"TDCTFU@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TDCTTT@HI.M".ts_eval=%Q|"TDCTTT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TDCTTT@HI.M".ts_eval=%Q|"TDCTTT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim("1990-08-01","1990-12-01")|
  "TDCTTT@HI.M".ts_eval=%Q|"TDCTTT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TGRSV@HI.M".ts_eval=%Q|"TGRSV@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TGRSV@HI.M".ts_eval=%Q|"TGRSV@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRCO@HI.M".ts_eval=%Q|"TRCO@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRCO@HI.M".ts_eval=%Q|"TRCO@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  "TRIN@HI.M".ts_eval=%Q|"TRIN@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata").trim|
  "TRIN@HI.M".ts_eval=%Q|"TRIN@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls", "sadata"|
  
  
  ["TDAP","TDCT","TDCTFU","TDCTTT","TDGF","TDHW","TDTS","TGB","TGBHT","TGBRT","TGBSV","TGR","TGRCT","TGRHT",
  "TGRRT","TGRSV","TR","TRCO","TRCOES","TRCOPR","TRCORF","TRFU","TRGT","TRIN","TRINES","TRINPR","TRINRF","TRINWH","TRTT"].each do |pre|
  "#{pre}@HI.Q".ts_eval= %Q|"#{pre}@HI.M".ts.aggregate(:quarter, :sum)|
  end

  ["HAW", "HI", "HON", "KAU", "MAU"].each do |cnty|
    #"TGBCT_R@#{cnty}.A".ts_eval= %Q|"TGBCT@#{cnty}.A".ts / "PICTSGF@HON.A".ts * 100|
    "TGBCTNS_R@#{cnty}.Q".ts_eval= %Q|"TGBCTNS@#{cnty}.Q".ts / "PICTSGF@HON.Q".ts * 100|
    #"TGBCT_R@#{cnty}.Q".ts_eval= %Q|"TGBCTNS@#{cnty}.Q".ts / "PICTSGF@HON.Q".ts * 100| # these are being taken out of AREMOS
    "TRMS@#{cnty}.Q".ts_eval= %Q|"TRMS@#{cnty}.A".ts.trms_interpolate_to_quarterly|
  end
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tax_identities", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end
