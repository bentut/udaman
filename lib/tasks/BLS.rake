
#BLS AND HIWI DATA DOWNLOADS


###*******************************************************************
###NOTES BOX

#BLS_CPI only pulling through 1986 and jumps to 1997 with one month (may be okay due to S download)
#BLS_CPI prints in a random order
#BLS_JOB_UPD_M works (have some series commented out, and need to check on the status of these)

###*******************************************************************


task :bls_cpi_upd_m => :environment do
  t = Time.now
	bls_cpi_m = {
		"PC@HON.M" => %Q|Series.load_from_bls("CUURA426SA0", "M")|,
		"PCFB@HON.M" => %Q|Series.load_from_bls("CUURA426SAF", "M")|,
		"PCFBFD@HON.M" => %Q|Series.load_from_bls("CUURA426SAF1", "M")|,
		"PCFBFDHM@HON.M" => %Q|Series.load_from_bls("CUURA426SAF11", "M")|,
		"PCFBFDAW@HON.M" => %Q|Series.load_from_bls("CUURA426SEFV", "M")|,
		"PCFBFDBV@HON.M" => %Q|Series.load_from_bls("CUURA426SAF116", "M")|,
		"PCHS@HON.M" => %Q|Series.load_from_bls("CUURA426SAH", "M")|,
		"PCHSSH@HON.M" => %Q|Series.load_from_bls("CUURA426SAH1", "M")|,
		"PCHSSHRT@HON.M" => %Q|Series.load_from_bls("CUURA426SEHA", "M")|,
		"PCHSSHOW@HON.M" => %Q|Series.load_from_bls("CUURA426SEHC", "M")|,
		"PCHSFU@HON.M" => %Q|Series.load_from_bls("CUURA426SAH2", "M")|,
		"PCHSFUEL@HON.M" => %Q|Series.load_from_bls("CUURA426SAH21", "M")|,
		"PCHSFUGS@HON.M" => %Q|Series.load_from_bls("CUURA426SEHF", "M")|,
		"PCHSFUGSE@HON.M" => %Q|Series.load_from_bls("CUURA426SEHF01", "M")|,
		"PCHSFUGSU@HON.M" => %Q|Series.load_from_bls("CUURA426SEHF02", "M")|,
		"PCHSHF@HON.M" => %Q|Series.load_from_bls("CUURA426SAH3", "M")|,
		"PCAP@HON.M" => %Q|Series.load_from_bls("CUURA426SAA", "M")|,
		"PCTR@HON.M" => %Q|Series.load_from_bls("CUURA426SAT", "M")|,
		"PCTRPR@HON.M" => %Q|Series.load_from_bls("CUURA426SAT1", "M")|,
		"PCTRMF@HON.M" => %Q|Series.load_from_bls("CUURA426SETB", "M")|,
		"PCTRGS@HON.M" => %Q|Series.load_from_bls("CUURA426SETB01", "M")|,
		"PCTRGSRG@HON.M" => %Q|Series.load_from_bls("CUURA426SS47014", "M")|,
		"PCTRGSPR@HON.M" => %Q|Series.load_from_bls("CUURA426SS47016", "M")|,
		"PCMD@HON.M" => %Q|Series.load_from_bls("CUURA426SAM", "M")|,
		"PCRE@HON.M" => %Q|Series.load_from_bls("CUURA426SAR", "M")|,
		"PCED@HON.M" => %Q|Series.load_from_bls("CUURA426SAE", "M")|,
		"PCOT@HON.M" => %Q|Series.load_from_bls("CUURA426SAG", "M")|,
		"PCCM@HON.M" => %Q|Series.load_from_bls("CUURA426SAC", "M")|,
		"PCCM_FD@HON.M" => %Q|Series.load_from_bls("CUURA426SACL1", "M")|,
		"PCCM_FB@HON.M" => %Q|Series.load_from_bls("CUURA426SACL11", "M")|,
		"PCCMND@HON.M" => %Q|Series.load_from_bls("CUURA426SAN", "M")|,
		"PCCMND_FD@HON.M" => %Q|Series.load_from_bls("CUURA426SANL1", "M")|,
		"PCCMND_FB@HON.M" => %Q|Series.load_from_bls("CUURA426SANL11", "M")|,
		"PCCMDR@HON.M" => %Q|Series.load_from_bls("CUURA426SAD", "M")|,
		"PCSV@HON.M" => %Q|Series.load_from_bls("CUURA426SAS", "M")|,
		"PCSV_MD@HON.M" => %Q|Series.load_from_bls("CUURA426SASL5", "M")|,
		"PCSV_RN@HON.M" => %Q|Series.load_from_bls("CUURA426SASL2RS", "M")|,
		"PC_MD@HON.M" => %Q|Series.load_from_bls("CUURA426SA0L5", "M")|,
		"PC_EN@HON.M" => %Q|Series.load_from_bls("CUURA426SA0LE", "M")|,
		"PC_FDEN@HON.M" => %Q|Series.load_from_bls("CUURA426SA0L1E", "M")|,
		"PC_SH@HON.M" => %Q|Series.load_from_bls("CUURA426SA0L2", "M")|,
		"PCEN@HON.M" => %Q|Series.load_from_bls("CUURA426SA0E", "M")|
	}
	
	p = Packager.new
	p.add_definitions bls_cpi_m
	p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m_NEW.xls"
	
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["bls_cpi_upd_m", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :bls_cpi_upd_s => :environment do
  t = Time.now
	bls_cpi_s = {
		"PC@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0", "S")|,
		"PCFB@HON.S" => %Q|Series.load_from_bls("CUUSA426SAF", "S")|,
		"PCFBFD@HON.S" => %Q|Series.load_from_bls("CUUSA426SAF1", "S")|,
		"PCFBFDHM@HON.S" => %Q|Series.load_from_bls("CUUSA426SAF11", "S")|,
		"PCFBFDAW@HON.S" => %Q|Series.load_from_bls("CUUSA426SEFV", "S")|,
		"PCFBFDBV@HON.S" => %Q|Series.load_from_bls("CUUSA426SAF116", "S")|,
		"PCHS@HON.S" => %Q|Series.load_from_bls("CUUSA426SAH", "S")|,
		"PCHSSH@HON.S" => %Q|Series.load_from_bls("CUUSA426SAH1", "S")|,
		"PCHSSHRT@HON.S" => %Q|Series.load_from_bls("CUUSA426SEHA", "S")|,
		"PCHSSHOW@HON.S" => %Q|Series.load_from_bls("CUUSA426SEHC", "S")|,
		"PCHSFU@HON.S" => %Q|Series.load_from_bls("CUUSA426SAH2", "S")|,
		"PCHSFUEL@HON.S" => %Q|Series.load_from_bls("CUUSA426SAH21", "S")|,
		"PCHSFUGS@HON.S" => %Q|Series.load_from_bls("CUUSA426SEHF", "S")|,
		"PCHSFUGSE@HON.S" => %Q|Series.load_from_bls("CUUSA426SEHF01", "S")|,
		"PCHSFUGSU@HON.S" => %Q|Series.load_from_bls("CUUSA426SEHF02", "S")|,
		"PCHSHF@HON.S" => %Q|Series.load_from_bls("CUUSA426SAH3", "S")|,
		"PCAP@HON.S" => %Q|Series.load_from_bls("CUUSA426SAA", "S")|,
		"PCTR@HON.S" => %Q|Series.load_from_bls("CUUSA426SAT", "S")|,
		"PCTRPR@HON.S" => %Q|Series.load_from_bls("CUUSA426SAT1", "S")|,
		"PCTRMF@HON.S" => %Q|Series.load_from_bls("CUUSA426SETB", "S")|,
		"PCTRGS@HON.S" => %Q|Series.load_from_bls("CUUSA426SETB01", "S")|,
		"PCTRGSRG@HON.S" => %Q|Series.load_from_bls("CUUSA426SS47014", "S")|,
		"PCTRGSMD@HON.S" => %Q|Series.load_from_bls("CUUSA426SS47015", "S")|,
		"PCTRGSPR@HON.S" => %Q|Series.load_from_bls("CUUSA426SS47016", "S")|,
		"PCMD@HON.S" => %Q|Series.load_from_bls("CUUSA426SAM", "S")|,
		"PCRE@HON.S" => %Q|Series.load_from_bls("CUUSA426SAR", "S")|,
		"PCED@HON.S" => %Q|Series.load_from_bls("CUUSA426SAE", "S")|,
		"PCOT@HON.S" => %Q|Series.load_from_bls("CUUSA426SAG", "S")|,
		"PCCM@HON.S" => %Q|Series.load_from_bls("CUUSA426SAC", "S")|,
		"PCCM_FD@HON.S" => %Q|Series.load_from_bls("CUUSA426SACL1", "S")|,
		"PCCM_FB@HON.S" => %Q|Series.load_from_bls("CUUSA426SACL11", "S")|,
		"PCCMND@HON.S" => %Q|Series.load_from_bls("CUUSA426SAN", "S")|,
		"PCCMND_FD@HON.S" => %Q|Series.load_from_bls("CUUSA426SANL1", "S")|,
		"PCCMND_FB@HON.S" => %Q|Series.load_from_bls("CUUSA426SANL11", "S")|,
		"PCCMDR@HON.S" => %Q|Series.load_from_bls("CUUSA426SAD", "S")|,
		"PCSV@HON.S" => %Q|Series.load_from_bls("CUUSA426SAS", "S")|,
		"PCSV_MD@HON.S" => %Q|Series.load_from_bls("CUUSA426SASL5", "S")|,
		"PCSV_RN@HON.S" => %Q|Series.load_from_bls("CUUSA426SASL2RS", "S")|,
		"PC_MD@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0L5", "S")|,
		"PC_EN@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0LE", "S")|,
		"PC_FDEN@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0L1E", "S")|,
		"PC_SH@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0L2", "S")|,
		"PCEN@HON.S" => %Q|Series.load_from_bls("CUUSA426SA0E", "S")|
	}
	
	p = Packager.new
	p.add_definitions bls_cpi_s
	p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s_NEW.xls"
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["bls_cpi_upd_s", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :bls_job_upd_m => :environment do
  t = Time.now
	bls_job_m = {
	
	#These top several lines pull EMPL, LF, and UR data from HIWI as a temporary placeholder
	#because HIWI releases the data a week before BLS. 
	#once BLS releases official values, these will be overwritten

		
		

    "E_NFSA@HI.M" => %Q|Series.load_from_bls("SMS15000000000000001", "M")|,
    "ECTSA@HI.M" => %Q|Series.load_from_bls("SMS15000001500000001", "M")|,
#   "EMNSA@HI.M" => %Q|Series.load_from_bls("SMS15000003000000001", "M")|,
    "E_TTUSA@HI.M" => %Q|Series.load_from_bls("SMS15000004000000001", "M")|,
    "E_EDHCSA@HI.M" => %Q|Series.load_from_bls("SMS15000006500000001", "M")|,
    "E_LHSA@HI.M" => %Q|Series.load_from_bls("SMS15000007000000001", "M")|,
    "EOSSA@HI.M" => %Q|Series.load_from_bls("SMS15000008000000001", "M")|,
    "EGVSA@HI.M" => %Q|Series.load_from_bls("SMS15000009000000001", "M")|,
    "EWTSA@HI.M" => %Q|Series.load_from_bls("SMS15000004100000001", "M")|,
    "ERTSA@HI.M" => %Q|Series.load_from_bls("SMS15000004200000001", "M")|,
    "E_FIRSA@HI.M" => %Q|Series.load_from_bls("SMS15000005500000001", "M")|,
    "ERESA@HI.M" => %Q|Series.load_from_bls("SMS15000005553000001", "M")|,
    "E_PBSSA@HI.M" => %Q|Series.load_from_bls("SMS15000006000000001", "M")|,
    "EPSSA@HI.M" => %Q|Series.load_from_bls("SMS15000006054000001", "M")|,
    "EEDSA@HI.M" => %Q|Series.load_from_bls("SMS15000006561000001", "M")|,
    "EHCSA@HI.M" => %Q|Series.load_from_bls("SMS15000006562000001", "M")|,
    "EAESA@HI.M" => %Q|Series.load_from_bls("SMS15000007071000001", "M")|,
    "EAFSA@HI.M" => %Q|Series.load_from_bls("SMS15000007072000001", "M")|,
    "EGVFDSA@HI.M" => %Q|Series.load_from_bls("SMS15000009091000001", "M")|,
    "EGVSTSA@HI.M" => %Q|Series.load_from_bls("SMS15000009092000001", "M")|,
    "EGVLCSA@HI.M" => %Q|Series.load_from_bls("SMS15000009093000001", "M")|,
    "EMNSA@HI.M" => %Q|Series.load_from_bls("SMS15000003000000001", "M")|,
    "EMA@HI.M" => %Q|Series.load_from_bls("SMS15000006055000001", "M")|,
    # divide these all by 1000?
    "EMPLSA@HI.M" => %Q|Series.load_from_bls("LASST15000005", "M")|,
    
    #We only need to keep the BLS EMPL, UR, LF commented out for benchmarking in the beginning of the year
    #For the rest of the year, we want to uncomment it for the other 11 months in the year so BLS overwrites HIWI
    #The reason is because BLS has more accuracy (HIWI rounds to 50 people) and BLS does backward revisions for 3 months
    
    "EMPLNS@HI.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1976-01-01", :sheet => "State", :row => "increment:51:1", :col =>4, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUST15000005", "M")|],
    "EMPLNS@HON.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Honolulu", :row => "increment:36:1", :col =>4, :frequency => "M"})/1|] ,
    	#%Q|Series.load_from_bls("LAUPS15007005", "M")|],
    "EMPLNS@HAW.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Hawaii Cty", :row => "increment:36:1", :col =>4, :frequency => "M"})/1|] ,
    	#%Q|Series.load_from_bls("LAUPA15010005", "M")|],
    "EMPLNS@MAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Cty", :row => "increment:36:1", :col =>4, :frequency => "M"})/1|],
    	#%Q|Series.load_from_bls("LAUPA15015005", "M")|],
    "EMPLNS@KAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Kauai Cty", :row => "increment:36:1", :col =>4, :frequency => "M"})/1|] ,
    	#%Q|Series.load_from_bls("LAUCN15007005", "M")|],
    #"EMPLNS@MAUI.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Isl", :row => "increment:37:1", :col =>4, :frequency => "M"})/1|, 
    #"EMPLNS@MOL.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Molokai", :row => "increment:37:1", :col =>4, :frequency => "M"})/1|, 
    #"EMPLNS@LAN.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Lanai", :row => "increment:51:1", :col =>4, :frequency => "M"})/1|, 
    
    
    "LFSA@HI.M" => %Q|Series.load_from_bls("LASST15000006", "M")|,
   
    "LFNS@HI.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1976-01-01", :sheet => "State", :row => "increment:51:1", :col =>3, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUST15000006", "M")|],
    "LFNS@HON.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Honolulu", :row => "increment:36:1", :col =>3, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUPS15007006", "M")|],
    "LFNS@HAW.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Hawaii Cty", :row => "increment:36:1", :col =>3, :frequency => "M"})/1|],
    	#%Q|Series.load_from_bls("LAUPA15010006", "M")|],
    "LFNS@MAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Cty", :row => "increment:36:1", :col =>3, :frequency => "M"})/1|],
    	#%Q|Series.load_from_bls("LAUPA15015006", "M")|],
    "LFNS@KAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Kauai Cty", :row => "increment:36:1", :col =>3, :frequency => "M"})/1|],
    	#%Q|Series.load_from_bls("LAUCN15007006", "M")|],
    #"LFNS@MAUI.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Isl", :row => "increment:37:1", :col =>3, :frequency => "M"})/1|, 
    #"LFNS@MOL.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Molokai", :row => "increment:37:1", :col =>3, :frequency => "M"})/1|, 
    #"LFNS@LAN.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Lanai", :row => "increment:51:1", :col =>3, :frequency => "M"})/1|, 



   "URSA@HI.M" => %Q|Series.load_from_bls("LASST15000003", "M")|,
   
    "URNS@HI.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1976-01-01", :sheet => "State", :row => "increment:51:1", :col =>6, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUST15000003", "M")|],
    "URNS@HON.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Honolulu", :row => "increment:36:1", :col =>6, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUPS15007003", "M")|],
    "URNS@HAW.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Hawaii Cty", :row => "increment:36:1", :col =>6, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUPA15010003", "M")|],
    "URNS@MAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Cty", :row => "increment:36:1", :col =>6, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUPA15015003", "M")|],
    "URNS@KAU.M" => [%Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Kauai Cty", :row => "increment:36:1", :col =>6, :frequency => "M"})/1|], 
    	#%Q|Series.load_from_bls("LAUCN15007003", "M")|],
    #"URNS@MAUI.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Maui Isl", :row => "increment:37:1", :col =>6, :frequency => "M"})/1|, 
    #"URNS@MOL.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Molokai", :row => "increment:37:1", :col =>6, :frequency => "M"})/1|, 
    #"URNS@LAN.M" => %Q|Series.load_from_download("LF@hiwi.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "Lanai", :row => "increment:51:1", :col =>6, :frequency => "M"})/1|, 
    
    
    "WWCTNS@HI.M" => %Q|Series.load_from_bls("SMU15000001500000030", "M")|,
    "WHCTNS@HI.M" => %Q|Series.load_from_bls("SMU15000001500000008", "M")|,
    "WWMNNS@HI.M" => %Q|Series.load_from_bls("SMU15000003000000030", "M")|,
    "WHMNNS@HI.M" => %Q|Series.load_from_bls("SMU15000003000000008", "M")|,
    "WW_TTUNS@HI.M" => %Q|Series.load_from_bls("SMU15000004000000030", "M")|,
    "WH_TTUNS@HI.M" => %Q|Series.load_from_bls("SMU15000004000000008", "M")|,
    "WWWTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004100000030", "M")|,
    "WHWTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004100000008", "M")|,
    "WWRTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004200000030", "M")|,
    "WHRTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004200000008", "M")|,
#   "WWIFNS@HI.M" => %Q|Series.load_from_bls("SMU15000005000000030", "M")|,
#   "WHIFNS@HI.M" => %Q|Series.load_from_bls("SMU15000005000000008", "M")|,
    "WW_FINNS@HI.M" => %Q|Series.load_from_bls("SMU15000005500000030", "M")|,
    "WH_FINNS@HI.M" => %Q|Series.load_from_bls("SMU15000005500000008", "M")|,
    "WWAFNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072000030", "M")|,
    "WHAFNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072000008", "M")|,
     #"WWAFACNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072100030", "M")|,
     #"WHAFACNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072100008", "M")|,
#   "WWAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200030", "M")|,
#   "WHAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200008", "M")|,
    "WHAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200008", "M")|,
    "WWAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200030", "M")|,
    "WWCTNS@HON.M" => %Q|Series.load_from_bls("SMU15261801500000030", "M")|,
    "WHCTNS@HON.M" => %Q|Series.load_from_bls("SMU15261801500000008", "M")|,
    "WWMNNS@HON.M" => %Q|Series.load_from_bls("SMU15261803000000030", "M")|,
    "WHMNNS@HON.M" => %Q|Series.load_from_bls("SMU15261803000000008", "M")|,
    "WW_TTUNS@HON.M" => %Q|Series.load_from_bls("SMU15261804000000030", "M")|,
    "WH_TTUNS@HON.M" => %Q|Series.load_from_bls("SMU15261804000000008", "M")|,
    "WWWTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804100000030", "M")|,
    "WHWTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804100000008", "M")|,
    "WWRTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804200000030", "M")|,
    "WHRTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804200000008", "M")|,
#   "WWIFNS@HON.M" => %Q|Series.load_from_bls("SMU15261805000000030", "M")|,
#   "WHIFNS@HON.M" => %Q|Series.load_from_bls("SMU15261805000000008", "M")|,
    "WW_FINNS@HON.M" => %Q|Series.load_from_bls("SMU15261805500000030", "M")|,
    "WH_FINNS@HON.M" => %Q|Series.load_from_bls("SMU15261805500000008", "M")|,
    "WWAFNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072000030", "M")|,
    "WHAFNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072000008", "M")|,
#   "WWAFACNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072100030", "M")|,
#   "WHAFACNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072100008", "M")|,
    "WWAFFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072200030", "M")|,
    "WHAFFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072200008", "M")|,
    "E_NFNS@HI.M" => %Q|Series.load_from_bls("SMU15000000000000001", "M")|,
    "E_PRNS@HI.M" => %Q|Series.load_from_bls("SMU15000000500000001", "M")|,
    "E_GDSPRNS@HI.M" => %Q|Series.load_from_bls("SMU15000000600000001", "M")|,
    "E_SVCPRNS@HI.M" => %Q|Series.load_from_bls("SMU15000000700000001", "M")|,
    "E_PRSVCPRNS@HI.M" => %Q|Series.load_from_bls("SMU15000000800000001", "M")|,
    "ECTNS@HI.M" => %Q|Series.load_from_bls("SMU15000001500000001", "M")|,
    "ECTBLNS@HI.M" => %Q|Series.load_from_bls("SMU15000001523600001", "M")|,
    "ECTSPNS@HI.M" => %Q|Series.load_from_bls("SMU15000001523800001", "M")|,
    "EMNNS@HI.M" => %Q|Series.load_from_bls("SMU15000003000000001", "M")|,
    "EMNDRNS@HI.M" => %Q|Series.load_from_bls("SMU15000003100000001", "M")|,
    "EMNNDNS@HI.M" => %Q|Series.load_from_bls("SMU15000003200000001", "M")|,
    "E_TTUNS@HI.M" => %Q|Series.load_from_bls("SMU15000004000000001", "M")|,
    "EWTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004100000001", "M")|,
    "ERTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004200000001", "M")|,
    "ERTFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000004244500001", "M")|,
    "ERTFDGSNS@HI.M" => %Q|Series.load_from_bls("SMU15000004244510001", "M")|,
    "ERTCLNS@HI.M" => %Q|Series.load_from_bls("SMU15000004244800001", "M")|,
    "ERTGMNS@HI.M" => %Q|Series.load_from_bls("SMU15000004245200001", "M")|,
    "ERTGMDSNS@HI.M" => %Q|Series.load_from_bls("SMU15000004245210001", "M")|,
    "E_TUNS@HI.M" => %Q|Series.load_from_bls("SMU15000004300000001", "M")|,
    "EUTNS@HI.M" => %Q|Series.load_from_bls("SMU15000004322000001", "M")|,
    "ETWNS@HI.M" => %Q|Series.load_from_bls("SMU15000004340008901", "M")|,
    "ETWTANS@HI.M" => %Q|Series.load_from_bls("SMU15000004348100001", "M")|,
    "EIFNS@HI.M" => %Q|Series.load_from_bls("SMU15000005000000001", "M")|,
    "EIFTCNS@HI.M" => %Q|Series.load_from_bls("SMU15000005051700001", "M")|,
    "E_FIRNS@HI.M" => %Q|Series.load_from_bls("SMU15000005500000001", "M")|,
    "EFINS@HI.M" => %Q|Series.load_from_bls("SMU15000005552000001", "M")|,
    "ERENS@HI.M" => %Q|Series.load_from_bls("SMU15000005553000001", "M")|,
    "E_PBSNS@HI.M" => %Q|Series.load_from_bls("SMU15000006000000001", "M")|,
    "EPSNS@HI.M" => %Q|Series.load_from_bls("SMU15000006054000001", "M")|,
    "EMANS@HI.M" => %Q|Series.load_from_bls("SMU15000006055000001", "M")|,
    "EADNS@HI.M" => %Q|Series.load_from_bls("SMU15000006056000001", "M")|,
    "EADESNS@HI.M" => %Q|Series.load_from_bls("SMU15000006056130001", "M")|,
    "E_EDHCNS@HI.M" => %Q|Series.load_from_bls("SMU15000006500000001", "M")|,
    "EEDNS@HI.M" => %Q|Series.load_from_bls("SMU15000006561000001", "M")|,
    "EED12NS@HI.M" => %Q|Series.load_from_bls("SMU15000006561110001", "M")|,
    "EHCNS@HI.M" => %Q|Series.load_from_bls("SMU15000006562000001", "M")|,
    "EHCAMNS@HI.M" => %Q|Series.load_from_bls("SMU15000006562100001", "M")|,
    "EHCHONS@HI.M" => %Q|Series.load_from_bls("SMU15000006562200001", "M")|,
    "EHCNRNS@HI.M" => %Q|Series.load_from_bls("SMU15000006562300001", "M")|,
    "EHCSONS@HI.M" => %Q|Series.load_from_bls("SMU15000006562400001", "M")|,
    "EHCSOIFNS@HI.M" => %Q|Series.load_from_bls("SMU15000006562410001", "M")|,
    "E_LHNS@HI.M" => %Q|Series.load_from_bls("SMU15000007000000001", "M")|,
    "EAENS@HI.M" => %Q|Series.load_from_bls("SMU15000007071000001", "M")|,
    "EAFNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072000001", "M")|,
    "EAFACNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072100001", "M")|,
    "EAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200001", "M")|,
    "EAFFDRSNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072251101", "M")|,
    "EOSNS@HI.M" => %Q|Series.load_from_bls("SMU15000008000000001", "M")|,
    "EGVNS@HI.M" => %Q|Series.load_from_bls("SMU15000009000000001", "M")|,
    "EGVFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091000001", "M")|,
    "EGVFDSPNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091336601", "M")|,
    #{}"EGVFDDDNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091911001", "M")|,
    "EGVSTNS@HI.M" => %Q|Series.load_from_bls("SMU15000009092000001", "M")|,
    "EGVSTEDNS@HI.M" => %Q|Series.load_from_bls("SMU15000009092161101", "M")|,
    "EGVLCNS@HI.M" => %Q|Series.load_from_bls("SMU15000009093000001", "M")|,
    "E_NFNS@HON.M" => %Q|Series.load_from_bls("SMU15261800000000001", "M")|,
    "E_PRNS@HON.M" => %Q|Series.load_from_bls("SMU15261800500000001", "M")|,
    "E_GDSPRNS@HON.M" => %Q|Series.load_from_bls("SMU15261800600000001", "M")|,
    "E_SVCPRNS@HON.M" => %Q|Series.load_from_bls("SMU15261800700000001", "M")|,
    "E_PRSVCPRNS@HON.M" => %Q|Series.load_from_bls("SMU15261800800000001", "M")|,
    "ECTNS@HON.M" => %Q|Series.load_from_bls("SMU15261801500000001", "M")|,
    "ECTSPNS@HON.M" => %Q|Series.load_from_bls("SMU15261801523800001", "M")|,
    "EMNNS@HON.M" => %Q|Series.load_from_bls("SMU15261803000000001", "M")|,
    "EMNDRNS@HON.M" => %Q|Series.load_from_bls("SMU15261803100000001", "M")|,
    "EMNNDNS@HON.M" => %Q|Series.load_from_bls("SMU15261803200000001", "M")|,
    "E_TTUNS@HON.M" => %Q|Series.load_from_bls("SMU15261804000000001", "M")|,
    "EWTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804100000001", "M")|,
    "ERTNS@HON.M" => %Q|Series.load_from_bls("SMU15261804200000001", "M")|,
    "ERTFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261804244500001", "M")|,
    "ERTFDGSNS@HON.M" => %Q|Series.load_from_bls("SMU15261804244510001", "M")|,
    "ERTCLNS@HON.M" => %Q|Series.load_from_bls("SMU15261804244800001", "M")|,
    "ERTGMNS@HON.M" => %Q|Series.load_from_bls("SMU15261804245200001", "M")|,
    "ERTGMDSNS@HON.M" => %Q|Series.load_from_bls("SMU15261804245210001", "M")|,
    "E_TUNS@HON.M" => %Q|Series.load_from_bls("SMU15261804300000001", "M")|,
    "ETWNS@HON.M" => %Q|Series.load_from_bls("SMU15261804340008901", "M")|,
    "ETWTANS@HON.M" => %Q|Series.load_from_bls("SMU15261804348100001", "M")|,
    "EIFNS@HON.M" => %Q|Series.load_from_bls("SMU15261805000000001", "M")|,
    "EIFTCNS@HON.M" => %Q|Series.load_from_bls("SMU15261805051700001", "M")|,
    "E_FIRNS@HON.M" => %Q|Series.load_from_bls("SMU15261805500000001", "M")|,
    "EFINS@HON.M" => %Q|Series.load_from_bls("SMU15261805552000001", "M")|,
    "ERENS@HON.M" => %Q|Series.load_from_bls("SMU15261805553000001", "M")|,
    "E_PBSNS@HON.M" => %Q|Series.load_from_bls("SMU15261806000000001", "M")|,
    "EPSNS@HON.M" => %Q|Series.load_from_bls("SMU15261806054000001", "M")|,
    "EMANS@HON.M" => %Q|Series.load_from_bls("SMU15261806055000001", "M")|,
    "EADNS@HON.M" => %Q|Series.load_from_bls("SMU15261806056000001", "M")|,
    "EADESNS@HON.M" => %Q|Series.load_from_bls("SMU15261806056130001", "M")|,
    "E_EDHCNS@HON.M" => %Q|Series.load_from_bls("SMU15261806500000001", "M")|,
    "EEDNS@HON.M" => %Q|Series.load_from_bls("SMU15261806561000001", "M")|,
    "EED12NS@HON.M" => %Q|Series.load_from_bls("SMU15261806561110001", "M")|,
    "EHCNS@HON.M" => %Q|Series.load_from_bls("SMU15261806562000001", "M")|,
    "EHCAMNS@HON.M" => %Q|Series.load_from_bls("SMU15261806562100001", "M")|,
    "EHCHONS@HON.M" => %Q|Series.load_from_bls("SMU15261806562200001", "M")|,
    "E_LHNS@HON.M" => %Q|Series.load_from_bls("SMU15261807000000001", "M")|,
    "EAFNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072000001", "M")|,
    "EAFACNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072100001", "M")|,
    "EAFFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072200001", "M")|,
    "EAFFDRSNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072251101", "M")|,
    "EOSNS@HON.M" => %Q|Series.load_from_bls("SMU15261808000000001", "M")|,
    "EGVNS@HON.M" => %Q|Series.load_from_bls("SMU15261809000000001", "M")|,
    "EGVFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091000001", "M")|,
    "EGVFDSPNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091336601", "M")|,
    #{}"EGVFDDDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091911001", "M")|,
    	#we are going to use EGVFDDDNS@HON.M from BLS because that is what AREMOS is using...although HIWI has more data"
		"EGVSTNS@HON.M" => %Q|Series.load_from_bls("SMU15261809092000001", "M")|,
		"EGVSTEDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809092161101", "M")|,
		"EGVLCNS@HON.M" => %Q|Series.load_from_bls("SMU15261809093000001", "M")|,
		
	}
	
	p = Packager.new
	p.add_definitions bls_job_m
	p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/bls_job_upd_m_NEW.xls"
	
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["bls_job_upd_m", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end



task :hiwi_upd => :environment do

  t = Time.now
  
  hiwi_upd = {
    
    'E_NFNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:WAGE & SALARY JOBS", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Total Private", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_GDSPRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Goods-Producing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Nat. Resources & Mining & Construction", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTBLNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Construction of Buildings", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTSPNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Special Trade Contractors", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Manufacturing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNDRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Non-Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_SVCPRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRSVCPRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Private Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TTUNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Trade, Transportation & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EWTNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Wholesale Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Retail Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Food & Beverage Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDGSNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Grocery Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTCLNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Clothing & Clothing Accessories Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:General Merchandise", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMDSNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Department Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TUNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Transportation, Warehousing & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EUTNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Utilites", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Transportation & Warehousing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWTANS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Air Transportation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Information", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFTCNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Telecommunications", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_FIRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Financial Activities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EFINS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Finance & Insurance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERENS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Real Estate & Rental & Leasing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PBSNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Professional & Business Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EPSNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Professional, Scientific & Tech. Svcs.", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMANS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Management of Companies & Enterprises", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Management & Remediation Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADESNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Employment Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_EDHCNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Educational & Health Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EEDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Educational Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EED12NS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Elementary & Secondary Schools", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Health Care & Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCAMNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Ambulatory Health Care Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCHONS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Hospitals", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNRNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Nursing & Residenial Care Facilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCSONS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCSOIFNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Individual & Family Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_LHNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Leisure and Hospitality", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAENS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Arts, Entertainment, & Recreation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Accommodation & Food Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFACNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Accommodation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Food Services & Drinking Places", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDRSNS@HI.M' => [%Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Full-Service Restaurants", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    	%Q|Series.load_from_bls("SMU15000007072251101", "M")|],
    'EOSNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Other Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Federal Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDDDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Department of Defense", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDSPNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Naval Shipyard", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:State Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTEDNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:State Education", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVLCNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:Local Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAGNS@HI.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "State", :row => "header:col:1:AGRICULTURE", :col => "repeat:2:13" , :frequency => "M"})/1000|

  }
    
  hiwi_upd_hon = {

    'E_NFNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:WAGE & SALARY JOBS", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Total Private", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_GDSPRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Goods-Producing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Nat. Resources & Mining & Construction", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ECTBLNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Construction of Buildings", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTSPNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Special Trade Contractors", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Manufacturing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNDRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Non-Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_SVCPRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRSVCPRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Private Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TTUNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Trade, Transportation & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EWTNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Wholesale Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Retail Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Food & Beverage Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDGSNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Grocery Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTCLNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Clothing & Clothing Accessories Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:General Merchandise", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMDSNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Department Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TUNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Transportation, Warehousing & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Transportation & Warehousing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWTANS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Air Transportation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Information", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFTCNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Telecommunications", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_FIRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Financial Activities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EFINS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Finance & Insurance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERENS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Real Estate & Rental & Leasing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PBSNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Professional & Business Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EPSNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Professional, Scientific & Tech. Svcs.", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMANS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Management of Companies & Enterprises", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Management & Remediation Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADESNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Employment Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_EDHCNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Educational & Health Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EEDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Educational Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EED12NS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Elementary & Secondary Schools", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Health Care & Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCAMNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Ambulatory Health Care Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCHONS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Hospitals", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCNRNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Nursing & Residenial Care Facilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSONS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSOIFNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Individual & Family Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_LHNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Leisure and Hospitality", :col => "repeat:2:13" , :frequency => "M"})/1000|,    	
    'EAFNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Accommodation & Food Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFACNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Accommodation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Food Services & Drinking Places", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDRSNS@HON.M' => [%Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Full-Service Restaurants", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    	%Q|Series.load_from_bls("SMU15261807072251101", "M")|],
    'EOSNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Other Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Federal Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDDDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Department of Defense", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDSPNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Naval Shipyard", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:State Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTEDNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:State Education", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVLCNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:Local Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAGNS@HON.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "Oahu", :row => "header:col:1:AGRICULTURE", :col => "repeat:2:13" , :frequency => "M"})/1000|,
  }
  
  hiwi_upd_haw = {
    
    'E_NFNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:WAGE & SALARY JOBS", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Total Private", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_GDSPRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Goods-Producing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Nat. Resources & Mining & Construction", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ECTBLNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Construction of Buildings", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTSPNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Special Trade Contractors", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Manufacturing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNDRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Non-Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_SVCPRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRSVCPRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Private Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TTUNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Trade, Transportation & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EWTNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Wholesale Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Retail Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Food & Beverage Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDGSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Grocery Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTCLNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Clothing & Clothing Accessories Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:General Merchandise", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMDSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Department Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TUNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Transportation, Warehousing & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EUTNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Utilites", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ETWNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Transportation & Warehousing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWTANS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Air Transportation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Information", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFTCNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Telecommunications", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_FIRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Financial Activities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EFINS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Finance & Insurance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ERENS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Real Estate & Rental & Leasing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PBSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Professional & Business Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EPSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Professional, Scientific & Tech. Svcs.", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EMANS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Management of Companies & Enterprises", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Management & Remediation Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EADESNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Employment Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_EDHCNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Educational & Health Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EEDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Educational Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EED12NS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Elementary & Secondary Schools", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Health Care & Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCAMNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Ambulatory Health Care Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCHONS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Hospitals", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCNRNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Nursing & Residenial Care Facilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSONS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSOIFNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Individual & Family Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_LHNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Leisure and Hospitality", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EAENS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :end_date=>"2010-12-01", :sheet => "HCty", :row => "header:col:1:Arts, Entertainment, & Recreation", :col => "repeat:2:13" , :frequency => "M"})/1000|,  
    'EAFNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Accommodation & Food Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFACNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Accommodation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Food Services & Drinking Places", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDRSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Full-Service Restaurants", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EOSNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Other Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Federal Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDDDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Department of Defense", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EGVFDSPNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Naval Shipyard", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:State Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTEDNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:State Education", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVLCNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:Local Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAGNS@HAW.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "HCty", :row => "header:col:1:AGRICULTURE", :col => "repeat:2:13" , :frequency => "M"})/1000|
    
  }
  
  hiwi_upd_kau = {

    'E_NFNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:WAGE & SALARY JOBS", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Total Private", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_GDSPRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Goods-Producing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Nat. Resources & Mining & Construction", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ECTBLNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Construction of Buildings", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTSPNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Special Trade Contractors", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Manufacturing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNDRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Non-Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_SVCPRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRSVCPRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Private Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TTUNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Trade, Transportation & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EWTNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Wholesale Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Retail Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Food & Beverage Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDGSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Grocery Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTCLNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Clothing & Clothing Accessories Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:General Merchandise", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMDSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Department Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TUNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Transportation, Warehousing & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EUTNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Utilites", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ETWNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Transportation & Warehousing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWTANS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Air Transportation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Information", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFTCNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Telecommunications", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_FIRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Financial Activities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EFINS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Finance & Insurance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ERENS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Real Estate & Rental & Leasing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PBSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Professional & Business Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EPSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Professional, Scientific & Tech. Svcs.", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EMANS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Management of Companies & Enterprises", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Management & Remediation Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EADESNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Employment Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_EDHCNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Educational & Health Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EEDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Educational Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EED12NS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Elementary & Secondary Schools", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Health Care & Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCAMNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Ambulatory Health Care Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCHONS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Hospitals", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCNRNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Nursing & Residenial Care Facilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSONS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSOIFNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Individual & Family Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_LHNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Leisure and Hospitality", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EAENS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :end_date=>"2010-12-01", :sheet => "KCty", :row => "header:col:1:Arts, Entertainment, & Recreation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Accommodation & Food Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFACNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Accommodation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Food Services & Drinking Places", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDRSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Full-Service Restaurants", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EOSNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Other Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Federal Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDDDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Department of Defense", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EGVFDSPNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Naval Shipyard", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:State Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTEDNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:State Education", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVLCNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:Local Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAGNS@KAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "KCty", :row => "header:col:1:AGRICULTURE", :col => "repeat:2:13" , :frequency => "M"})/1000|    
    
  }
  
  hiwi_upd_mau = {
    
    'E_NFNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:WAGE & SALARY JOBS", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Total Private", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_GDSPRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Goods-Producing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Nat. Resources & Mining & Construction", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ECTBLNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Construction of Buildings", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ECTSPNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Special Trade Contractors", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Manufacturing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNDRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EMNNDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Non-Durable Goods", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_SVCPRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PRSVCPRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Private Service-Providing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TTUNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Trade, Transportation & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EWTNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Wholesale Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Retail Trade", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Food & Beverage Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTFDGSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Grocery Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTCLNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Clothing & Clothing Accessories Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:General Merchandise", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ERTGMDSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Department Stores", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_TUNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Transportation, Warehousing & Utilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EUTNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Utilites", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ETWNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Transportation & Warehousing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'ETWTANS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Air Transportation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Information", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EIFTCNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Telecommunications", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_FIRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Financial Activities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EFINS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Finance & Insurance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'ERENS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Real Estate & Rental & Leasing", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_PBSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Professional & Business Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EPSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Professional, Scientific & Tech. Svcs.", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EMANS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Management of Companies & Enterprises", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EADNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Management & Remediation Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EADESNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Employment Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_EDHCNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Educational & Health Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EEDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Educational Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EED12NS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Elementary & Secondary Schools", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EHCNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Health Care & Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCAMNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Ambulatory Health Care Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCHONS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Hospitals", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCNRNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Nursing & Residenial Care Facilities", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSONS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Social Assistance", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EHCSOIFNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Individual & Family Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'E_LHNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Leisure and Hospitality", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EAENS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :end_date=>"2010-12-01", :sheet => "MCty", :row => "header:col:1:Arts, Entertainment, & Recreation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Accommodation & Food Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFACNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Accommodation", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Food Services & Drinking Places", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAFFDRSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Full-Service Restaurants", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EOSNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Other Services", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Federal Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVFDDDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Department of Defense", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    #'EGVFDSPNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Naval Shipyard", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:State Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVSTEDNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:State Education", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EGVLCNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:Local Government", :col => "repeat:2:13" , :frequency => "M"})/1000|,
    'EAGNS@MAU.M' => %Q|Series.load_from_download( "%Y@hiwi.org", { :file_type => "xls", :start_date => "2009-01-01", :sheet => "MCty", :row => "header:col:1:AGRICULTURE", :col => "repeat:2:13" , :frequency => "M"})/1000|,    
  }
  
  
  p = Packager.new
  p.add_definitions hiwi_upd
  p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/hiwi_upd_HI_NEW.xls"
  
  p = Packager.new
  p.add_definitions hiwi_upd_hon
  p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/hiwi_upd_HON_NEW.xls"
  
  p = Packager.new
  p.add_definitions hiwi_upd_haw
  p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/hiwi_upd_HAW_NEW.xls"
  
  
  p = Packager.new
  p.add_definitions hiwi_upd_kau
  p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/hiwi_upd_KAU_NEW.xls"
  
  
  p = Packager.new
  p.add_definitions hiwi_upd_mau
  p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/hiwi_upd_MAU_NEW.xls"
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["hiwi_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end


task :bls_identities => :environment do
  t= Time.now
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.S".ts.interpolate(:quarter, :linear).trim("1985-01-01")|
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.M".ts.aggregate(:quarter, :average)|
  "PC@HON.A".ts_append_eval %Q|"PC@HON.S".ts.aggregate(:year, :average)|
  "PC@HON.A".ts_append_eval %Q|"PC@HON.M".ts.aggregate(:year, :average)|
  "CPI@HON.S".ts_eval= %Q|"PC@HON.S".ts|
  "CPI@HON.A".ts_eval= %Q|"PC@HON.A".ts|
  "CPI@HON.Q".ts_eval= %Q|"PC@HON.Q".ts|
  
  "PCDMNS@HI.Q".ts_eval=%Q|"PCDMNS@HI.M".ts.aggregate(:quarter, :sum)|
  "PCITJPNS@HI.Q".ts_eval=%Q|"PCITJPNS@HI.M".ts.aggregate(:quarter, :sum)|
  "PCITOTNS@HI.Q".ts_eval=%Q|"PCITOTNS@HI.M".ts.aggregate(:quarter, :sum)|
  "PCNS@HI.Q".ts_eval=%Q|"PCNS@HI.M".ts.aggregate(:quarter, :sum)|
  
  "PCE@US.Q".ts_eval=%Q|"PCE@US.M".ts.aggregate(:quarter, :average)|
  "PCECORE@US.Q".ts_eval=%Q|"PCECORE@US.M".ts.aggregate(:quarter, :average)|
  "PCE@US.A".ts_eval=%Q|"PCE@US.Q".ts.aggregate(:year, :average)|
  "PCECORE@US.A".ts_eval=%Q|"PCECORE@US.Q".ts.aggregate(:year, :average)|

  
  ["PC_FDEN",  "PC_MD",  "PC_SH",  "PCAP",  "PCCM_FB", "PCCM_FD","PCCM", "PCCMDR", "PCCMND_FB","PCCMND_FD","PCCMND", "PCED", 
  "PCEN", "PCFB", "PCFBFD", "PCFBFDAW", "PCFBFDBV", "PCFBFDHM", "PCHS", "PCHSFU", "PCHSFUEL", "PCHSFUGS", "PCHSFUGSE","PCHSFUGSU",
  "PCHSHF","PCHSSH","PCHSSHOW", "PCHSSHRT", "PCMD", "PCOT", "PCRE", "PCSV_MD","PCSV_RN","PCSV", "PCTR", "PCTRGS", "PCTRGSMD", "PCTRGSPR",
  "PCTRGSRG", "PCTRMF",  "PCTRPR",  "PC_EN"].each do |prefix|
    "#{prefix}@HON.Q".ts_eval=      %Q|"#{prefix}@HON.M".ts.aggregate(:quarter, :average)|
    "#{prefix}@HON.Q".ts_eval=      %Q|"#{prefix}@HON.S".ts.interpolate(:quarter, :linear).trim("1987-01-01")|
    "#{prefix}@HON.A".ts_eval=      %Q|"#{prefix}@HON.Q".ts.aggregate(:year, :average)|
  end
  
  "INF@HON.Q".ts_eval= %Q|"CPI@HON.Q".ts.rebase("2010-01-01").annualized_percentage_change|
  "INFCORE@HON.Q".ts_eval= %Q|"PC_FDEN@HON.Q".ts.annualized_percentage_change|
  "INF_SH@HON.Q".ts_eval= %Q|"PC_SH@HON.Q".ts.annualized_percentage_change|
  
  #Series loaded from this history sheet... may not need to load every day. But relatively fast...
  #["E_FIR@HI.M", "E_FIR@HON.M", "E_GDSPR@HON.M", "E_GVSL@HON.M", "E_TTU@HAW.M", "E_TTU@HON.M", "E_TTU@KAU.M", "E_TTU@MAU.M", "E_TU@HI.M", "E_TU@HON.M", "EAF@HI.M", "EAF@HON.M", "EAFAC@HI.M", "EAFAC@HON.M", "EAFFD@HI.M", "EAFFD@HON.M", "ECT@HI.M", "ECT@HON.M", "EFI@HI.M", "EFI@HON.M", "EGVFD@HI.M", "EGVFD@HON.M", "EGVLC@HI.M", "EGVLC@HON.M", "EGVST@HI.M", "EGVST@HON.M", "EHC@HI.M", "EHC@HON.M", "EMN@HI.M", "EMN@HON.M", "ERE@HI.M", "ERE@HON.M"]  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"
  #needs EMN up here....
  
  "PC@HI.M".ts_eval= %Q|"PC@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata").trim("2000-10-01", "2001-12-01")|
  "PC@HI.M".ts_eval= %Q| "PC@HI.M".tsn.load_mean_corrected_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata")|
  "PC@HI.M".ts_eval= %Q|"PC@HI.M".ts.apply_seasonal_adjustment :additive|

  "PCITJP@HI.M".ts_eval= %Q|"PCITJP@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata").trim("2000-10-01", "2001-12-01")|
  "PCITJP@HI.M".ts_eval= %Q| "PCITJP@HI.M".tsn.load_mean_corrected_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata") |
  "PCITJP@HI.M".ts_eval= %Q| "PCITJP@HI.M".ts.apply_seasonal_adjustment :additive|

  "PCITOT@HI.M".ts_eval= %Q|"PCITOT@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata").trim("2000-10-01", "2001-12-01")|
  "PCITOT@HI.M".ts_eval= %Q|   "PCITOT@HI.M".tsn.load_mean_corrected_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata") |
  "PCITOT@HI.M".ts_eval= %Q| "PCITOT@HI.M".ts.apply_seasonal_adjustment :additive |

  "PCDM@HI.M".ts_eval= %Q|"PCDM@HI.M".tsn.load_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata").trim("2000-10-01", "2001-12-01")|
  "PCDM@HI.M".ts_eval= %Q|"PCDM@HI.M".tsn.load_mean_corrected_sa_from("/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata")|
  "PCDM@HI.M".ts_eval= %Q|"PCDM@HI.M".ts.apply_seasonal_adjustment :additive|

  "OCUP%@HI.M".ts_eval= %Q|"OCUP%@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PRM@HI.M".ts_eval= %Q|"PRM@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "RMRV@HI.M".ts_eval= %Q|"RMRV@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  
  ["HI", "HON", "HAW", "MAU", "KAU"].each do |cnty|
    "ENS@#{cnty}.M".ts_append_eval %Q|"E_NFNS@#{cnty}.M".ts + "EAGNS@#{cnty}.M".ts| 
    "E_TRADENS@#{cnty}.M".ts_append_eval %Q|"EWTNS@#{cnty}.M".ts + "ERTNS@#{cnty}.M".ts| 
    "E_GVSLNS@#{cnty}.M".ts_append_eval %Q|"EGVNS@#{cnty}.M".ts - "EGVFDNS@#{cnty}.M".ts| 
    "E_SVNS@#{cnty}.M".ts_append_eval %Q|"E_NFNS@#{cnty}.M".ts - ("ECTNS@#{cnty}.M".ts + "EMNNS@#{cnty}.M".ts + "E_TRADENS@#{cnty}.M".ts + "E_TUNS@#{cnty}.M".ts + "E_FIRNS@#{cnty}.M".ts + "EGVNS@#{cnty}.M".ts) | 
    "E_ELSENS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".ts - ("ECTNS@HI.M".ts + "EMNNS@HI.M".ts + "E_TRADENS@HI.M".ts  + "E_TUNS@HI.M".ts + "E_FIRNS@HI.M".ts + "EAFNS@HI.M".ts + "EHCNS@HI.M".ts + "EGVNS@HI.M".ts)|
  end

  "EAENS@HON.M".ts_eval= %Q|"E_LHNS@HON.M".ts - "EAFNS@HON.M".ts|
  'EAENS@HAW.M'.ts_eval= %Q|"E_LHNS@HAW.M".ts - "EAFNS@HAW.M".ts|
  'EAENS@KAU.M'.ts_eval= %Q|"E_LHNS@KAU.M".ts - "EAFNS@KAU.M".ts|
  'EAENS@MAU.M'.ts_eval= %Q|"E_LHNS@MAU.M".ts - "EAFNS@MAU.M".ts|
  
  'EUTNS@HON.M'.ts_eval= %Q|"E_TUNS@HON.M".ts - "ETWNS@HON.M".ts|
  
  ["HAW", "MAU", "KAU"].each do |cnty|
    "ERENS@#{cnty}.M".ts_append_eval %Q|"E_FIRNS@#{cnty}.M".ts - "EFINS@#{cnty}.M".ts| 
    "EMANS@#{cnty}.M".ts_append_eval %Q|"E_PBSNS@#{cnty}.M".ts - "EPSNS@#{cnty}.M".ts - "EADNS@#{cnty}.M".ts| 
    "E_OTNS@#{cnty}.M".ts_append_eval %Q|"EMANS@#{cnty}.M".ts + "EADNS@#{cnty}.M".ts + "EEDNS@#{cnty}.M".ts + "EOSNS@#{cnty}.M".ts| 
  end
  
  "UR@HI.M".ts_eval= %Q|"URSA@HI.M".ts|
  "LF_MC@HI.M".ts_eval= %Q|"LFSA@HI.M".ts / "LFSA@HI.M".ts.annual_sum * "LFNS@HI.M".ts.annual_sum|
  "LF@HI.M".ts_append_eval %Q|"LF_MC@HI.M".ts|
  "LF@HI.M".ts_append_eval %Q|"LFSA@HI.M".ts.trim|
  "EMPL_MC@HI.M".ts_eval= %Q|"EMPLSA@HI.M".ts / "EMPLSA@HI.M".ts.annual_sum * "EMPLNS@HI.M".ts.annual_sum|
  "EMPL@HI.M".ts_append_eval %Q|"EMPL_MC@HI.M".ts|
  "EMPL@HI.M".ts_append_eval %Q|"EMPLSA@HI.M".ts.trim|

  ["LF", "EMPL"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}_MC@HI.M".ts.share_using("#{s_name}NS@#{county}.M".ts, "#{s_name}NS@HI.M".ts)|
      "#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}@HI.M".ts.share_using("#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim,"#{s_name}NS@HI.M".ts.backward_looking_moving_average.trim)| 
    end
  end
  
  ["HON", "HAW", "MAU", "KAU"].each do |county|
    puts "distributing UR, #{county}"
    ("UR@#{county}.M".ts_eval= %Q|(("EMPL@#{county}.M".ts / "LF@#{county}.M".ts) * -1 + 1)*100|) rescue puts "problem with UR, #{county}"
  end
    
  ["ECT", "E_TTU", "E_EDHC", "E_LH", "EOS", "EGV", "EWT", "ERT", "E_FIR", "ERE", "E_PBS", "EPS", "EED", "EHC", "EAE", "EAF", "EGVFD", "EGVST", "EGVLC"].each do |list|
    "#{list}@HI.M".ts_append_eval %Q|"#{list}SA@HI.M".ts|
  end
  
  "E_GVSL@HI.M".ts_eval= %Q|"EGVST@HI.M".ts + "EGVLC@HI.M".ts| 
  
  "EAFAC@HI.M".ts_eval= %Q|"EAF@HI.M".ts.share_using("EAFACNS@HI.M".ts.annual_average,"EAFNS@HI.M".ts.annual_average).trim("1990-01-01")|
  "EAFAC@HI.M".ts_append_eval %Q|"EAF@HI.M".ts.share_using("EAFACNS@HI.M".ts.backward_looking_moving_average.trim,"EAFNS@HI.M".ts.backward_looking_moving_average.trim)|
  "EAFFD@HI.M".ts_eval= %Q|"EAF@HI.M".ts.share_using("EAFFDNS@HI.M".ts.annual_average,"EAFNS@HI.M".ts.annual_average).trim("1990-01-01")|
  "EAFFD@HI.M".ts_append_eval %Q|"EAF@HI.M".ts.share_using("EAFFDNS@HI.M".ts.backward_looking_moving_average.trim,"EAFNS@HI.M".ts.backward_looking_moving_average.trim)|

  #{}"EMA@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EMANS@HI.M".ts.annual_sum, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).annual_sum)|
  #{}"#EMA@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EMANS@HI.M".ts.backward_looking_moving_average.trim, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).backward_looking_moving_average.trim)|
  #{}"EAD@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EADNS@HI.M".ts.annual_sum, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).annual_sum)|
  #{}"EAD@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EADNS@HI.M".ts.backward_looking_moving_average.trim, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).backward_looking_moving_average.trim)|
  "EAD@HI.M".ts_eval = %Q|"E_PBS@HI.M".ts - "EPS@HI.M".ts - "EMA@HI.M".ts|
  
  "EMN@HI.M".ts_eval= %Q|"EMN@HI.M".ts.load_sa_from("/Volumes/UHEROwork/data/bls/seasadj/sadata.xls").trim("1990-01-01","2006-12-01")|
  "EMN@HI.M".ts_eval= %Q|"EMNSA@HI.M".ts|
  #"EMN@HI.M".ts_eval= %Q|"EMN@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  "EIF@HI.M".ts_eval= %Q|"EIF@HI.M".ts.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls"|
  "EIF@HI.M".ts_eval= %Q|"EIF@HI.M".ts.apply_seasonal_adjustment :additive|
  "EFI@HI.M".ts_eval= %Q|"E_FIR@HI.M".ts - "ERE@HI.M".ts|
  
  "EAG@HI.M".ts_eval= %Q|"EAG@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls"|
  
  "E_TRADE@HI.M".ts_append_eval %Q|"EWT@HI.M".ts + "ERT@HI.M".ts| 
  "E_TU@HI.M".ts_eval= %Q|"E_TTU@HI.M".ts - "E_TRADE@HI.M".ts|
      
  "E_NF@HI.M".ts_append_eval %Q|"E_NFSA@HI.M".ts.trim("1957-12-01","1989-12-01")|
  "E_NF@HI.M".ts_append_eval %Q|"ECT@HI.M".ts + "EMN@HI.M".ts + "E_TTU@HI.M".ts + "EIF@HI.M".ts + "E_FIR@HI.M".ts + "E_PBS@HI.M".ts + "E_EDHC@HI.M".ts + "E_LH@HI.M".ts + "EOS@HI.M".ts + "EGV@HI.M".ts|
  
  "E_PR@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - "EGV@HI.M".ts|
   
  ["ECT", "EWT","ERT", "EED", "EHC", "EOS", "EGVST", "EGVLC", "EGVFD", "EAE", "ERE", "EPS", "EAFAC", "EAFFD", "EMA", "EAD", "EMN", "EIF", "EFI", "E_TU"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}@HI.M".ts.aa_state_based_county_share_for("#{county}").trim("1990-01-01")|
    end
  end

  #this might repeat what's above?
  "EGVST@HI.M".ts_eval= %Q|"EGVST@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|  
  "EGVFD@HI.M".ts_eval= %Q|"EGVFD@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|  
  "EGVFD@HON.M".ts_eval= %Q|"EGVFD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EGVST@HON.M".ts_eval= %Q|"EGVST@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EGVLC@HON.M".ts_eval= %Q|"EGVLC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EMN@HON.M".ts_eval= %Q|"EMN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "ECT@HON.M".ts_eval= %Q|"ECT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EAFAC@HON.M".ts_eval= %Q|"EAFAC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EAFFD@HON.M".ts_eval= %Q|"EAFFD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "ERE@HON.M".ts_eval= %Q|"ERE@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EFI@HON.M".ts_eval= %Q|"EFI@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "E_TU@HON.M".ts_eval= %Q|"E_TU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  "EHC@HON.M".ts_eval= %Q|"EHC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"|
  
  ["HON", "HAW", "MAU", "KAU"].each do |county|
    puts county
    
    "E_GVSL@#{county}.M".ts_append_eval %Q|"EGVST@#{county}.M".ts + "EGVLC@#{county}.M".ts|     
    "EGV@#{county}.M".ts_eval= %Q|"EGV@HI.M".ts.aa_state_based_county_share_for("#{county}").trim("1959-12-01","1989-12-01")| 
    "EGV@#{county}.M".ts_append_eval      %Q|("EGVFD@#{county}.M".ts + "E_GVSL@#{county}.M".ts).trim("1990-01-01")|
    "EAF@#{county}.M".ts_eval=            %Q|"EAFAC@#{county}.M".ts + "EAFFD@#{county}.M".ts|
    "E_LH@#{county}.M".ts_append_eval     %Q|"EAE@#{county}.M".ts + "EAF@#{county}.M".ts|
    "E_EDHC@#{county}.M".ts_append_eval   %Q|"EED@#{county}.M".ts + "EHC@#{county}.M".ts|
    "E_PBS@#{county}.M".ts_append_eval    %Q|"EPS@#{county}.M".ts + "EMA@#{county}.M".ts + "EAD@#{county}.M".ts|
    "E_FIR@#{county}.M".ts_append_eval    %Q|"EFI@#{county}.M".ts + "ERE@#{county}.M".ts|
    "E_TRADE@#{county}.M".ts_append_eval  %Q|"EWT@#{county}.M".ts + "ERT@#{county}.M".ts|
    "E_TTU@#{county}.M".ts_append_eval    %Q|"E_TU@#{county}.M".ts + "E_TRADE@#{county}.M".ts|
    "E_GDSPR@#{county}.M".ts_append_eval %Q|"ECT@#{county}.M".ts + "EMN@#{county}.M".ts| 
    "E_NF@#{county}.M".ts_append_eval %Q|"E_NF@HI.M".ts.aa_state_based_county_share_for("#{county}").trim("1971-12-01","1989-12-01")|
    "E_NF@#{county}.M".ts_append_eval %Q|"ECT@#{county}.M".ts + "EMN@#{county}.M".ts + "E_TTU@#{county}.M".ts + "EIF@#{county}.M".ts + "E_FIR@#{county}.M".ts + "E_PBS@#{county}.M".ts + "E_EDHC@#{county}.M".ts + "E_LH@#{county}.M".ts + "EOS@#{county}.M".ts + "EGV@#{county}.M".ts|    
    "E_PR@#{county}.M".ts_append_eval %Q|"E_NF@#{county}.M".ts - "EGV@#{county}.M".ts| 
    "E_SVCPR@#{county}.M".ts_append_eval %Q|"E_NF@#{county}.M".ts - "E_GDSPR@#{county}.M".ts| 
    "E_PRSVCPR@#{county}.M".ts_append_eval %Q|"E_SVCPR@#{county}.M".ts - "EGV@#{county}.M".ts|
    
  end
  
  # ["EGV", "E_LH", "E_PBS", "E_FIR", "EAE"].each do |s_name|
  #   ["HON", "HAW", "MAU", "KAU"].each do |county|
  #     puts "distributing #{s_name}, #{county}"
  #     "#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}@HI.M".ts.aa_county_share_for("#{county}")|
  #   end
  # end
  
  # EAF@HI.M
  # Before 1990 calculate with identity  
  #circular reference
  #"EAF@HI.M".ts_eval= %Q|("EAFAC@HI.M".ts + "EAFFD@HI.M".ts).trim("1972-01-01","1989-12-01")|

  # E_FIR@HI.M
  # Before 1990 calculate with identity:
  #circular reference
  "E_FIR@HI.M".ts_eval= %Q|("EFI@HI.M".ts + "ERE@HI.M".ts).trim("1958-01-01","1989-12-01")|

  # E_TTU@cnty
  # Before 1990 distribute HI to CNTY
  # circular refs
  # ["HON", "HAW", "MAU", "KAU"].each do |county| 
  #   "E_TTU@#{county}.M".ts_eval= %Q|"E_TU@HI.M".ts.aa_state_based_county_share_for("#{county}").trim("1972-01-01","1989-12-01")|
  # end 

  # E_trade/tradens @hi/cnty
  # Before 1990 calculate with identity
  ["HI", "HON", "HAW", "MAU", "KAU"].each do |county|
    #causes mismatches (but not circular references... though there does seem to be weird related slowdowns)
    #{}"E_TRADENS@#{county}.M".ts_eval= %Q|("E_TTUNS@#{county}.M".ts - "E_TUNS@#{county}.M".ts).trim("1972-01-01","1989-12-01")|
    #circular reference
    #"E_TRADE@#{county}.M".ts_eval= %Q|("E_TTU@#{county}.M".ts - "E_TU@#{county}.M".ts).trim("1972-01-01","1989-12-01")|
  end
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["bls_identities", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end
