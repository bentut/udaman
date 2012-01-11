#BLS AND HIWI DATA DOWNLOADS


###*******************************************************************
###NOTES BOX

#BLS_CPI only pulling through 1986 and jumps to 1997 with one month (may be okay due to S download)
#BLS_CPI prints in a random order
#BLS_JOB_UPD_M works (have some series commented out, and need to check on the status of these)

###*******************************************************************


task :bls_cpi_upd_m => :environment do

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
	
end

task :bls_cpi_upd_s => :environment do
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
	
end

task :bls_job_upd_m => :environment do

	bls_job_m = {
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
    "EMPLSA@HI.M" => %Q|Series.load_from_bls("LASST15000005", "M")|,
    "EMPLNS@HI.M" => %Q|Series.load_from_bls("LAUST15000005", "M")|,
    "EMPLNS@HON.M" => %Q|Series.load_from_bls("LAUPS15007005", "M")|,
    "EMPLNS@HAW.M" => %Q|Series.load_from_bls("LAUPA15010005", "M")|,
    "EMPLNS@MAU.M" => %Q|Series.load_from_bls("LAUPA15015005", "M")|,
    "EMPLNS@KAU.M" => %Q|Series.load_from_bls("LAUCN15007005", "M")|,
#   "LFSA@HI.M" => %Q|Series.load_from_bls("LASST15000006 ", "M")|,
    "LFNS@HI.M" => %Q|Series.load_from_bls("LAUST15000006", "M")|,
    "LFNS@HON.M" => %Q|Series.load_from_bls("LAUPS15007006", "M")|,
    "LFNS@HAW.M" => %Q|Series.load_from_bls("LAUPA15010006", "M")|,
    "LFNS@MAU.M" => %Q|Series.load_from_bls("LAUPA15015006", "M")|,
    "LFNS@KAU.M" => %Q|Series.load_from_bls("LAUCN15007006", "M")|,
#   "URSA@HI.M" => %Q|Series.load_from_bls("LASST15000003 ", "M")|,
    "URNS@HI.M" => %Q|Series.load_from_bls("LAUST15000003", "M")|,
    "URNS@HON.M" => %Q|Series.load_from_bls("LAUPS15007003", "M")|,
    "URNS@HAW.M" => %Q|Series.load_from_bls("LAUPA15010003", "M")|,
    "URNS@MAU.M" => %Q|Series.load_from_bls("LAUPA15015003", "M")|,
    "URNS@KAU.M" => %Q|Series.load_from_bls("LAUCN15007003", "M")|,
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
     "WWAFACNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072100030", "M")|,
     "WHAFACNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072100008", "M")|,
#   "WWAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200030", "M")|,
#   "WHAFFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072200008", "M")|,
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
    "EAFFDRSNS@HI.M" => %Q|Series.load_from_bls("SMU15000007072210001", "M")|,
    "EOSNS@HI.M" => %Q|Series.load_from_bls("SMU15000008000000001", "M")|,
    "EGVNS@HI.M" => %Q|Series.load_from_bls("SMU15000009000000001", "M")|,
    "EGVFDNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091000001", "M")|,
    "EGVFDSPNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091336601", "M")|,
#   "EGVFDDDNS@HI.M" => %Q|Series.load_from_bls("SMU15000009091911001", "M")|,
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
    "EAFFDRSNS@HON.M" => %Q|Series.load_from_bls("SMU15261807072210001", "M")|,
    "EOSNS@HON.M" => %Q|Series.load_from_bls("SMU15261808000000001", "M")|,
    "EGVNS@HON.M" => %Q|Series.load_from_bls("SMU15261809000000001", "M")|,
    "EGVFDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091000001", "M")|,
    "EGVFDSPNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091336601", "M")|,
#   "EGVFDDDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809091911001", "M")|,
		"EGVSTNS@HON.M" => %Q|Series.load_from_bls("SMU15261809092000001", "M")|,
		"EGVSTEDNS@HON.M" => %Q|Series.load_from_bls("SMU15261809092161101", "M")|,
		"EGVLCNS@HON.M" => %Q|Series.load_from_bls("SMU15261809093000001", "M")|
	}
	
	p = Packager.new
	p.add_definitions bls_job_m
	p.write_definitions_to "/Volumes/UHEROwork/data/bls/update/bls_job_upd_m_NEW.xls"
	
end





###*******************************************************************


# 
# task :hiwi_upd => :environment do
#   require "Spreadsheet"
#   path_HIWI2011           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2011.xls"
#   path_HIWI2010           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2010.xls"
#   path_HIWI2009           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2009.xls"
#   path_HIWI2008           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2008.xls"
#   path_HIWI2007           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2007.xls"
#   path_HIWI2006           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2006.xls"
#   path_HIWI2005           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2005.xls"
#   path_HIWI2004           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2004.xls"
#   path_HIWI2003           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2003.xls"
#   path_HIWI2002           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2002.xls"
#   path_HIWI2001           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2001.xls"
#   path_HIWI2000           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI2000.xls"
#   path_HIWI1999           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1999.xls"
#   path_HIWI1998           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1998.xls"
#   path_HIWI1997           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1997.xls"
#   path_HIWI1996           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1996.xls"
#   path_HIWI1995           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1995.xls"
#   path_HIWI1994           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1994.xls"
#   path_HIWI1993           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1993.xls"
#   path_HIWI1992           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1992.xls"
#   path_HIWI1991           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1991.xls"
#   path_HIWI1990           = "/Volumes/UHEROwork/data/rawdata/BLS_HIWI1990.xls"
# 
#   output_path      = "/Volumes/UHEROwork/data/misc/bls/update/HIWI_upd_m_NEW.xls"
# 
#   dsd_HIWI2011   = DataSourceDownload.get path_HIWI2011
#   dsd_HIWI2010   = DataSourceDownload.get path_HIWI2010
#   dsd_HIWI2009   = DataSourceDownload.get path_HIWI2009
#   dsd_HIWI2008   = DataSourceDownload.get path_HIWI2008
#   dsd_HIWI2007   = DataSourceDownload.get path_HIWI2007
#   dsd_HIWI2006   = DataSourceDownload.get path_HIWI2006
#   dsd_HIWI2005   = DataSourceDownload.get path_HIWI2005
#   dsd_HIWI2004   = DataSourceDownload.get path_HIWI2004
#   dsd_HIWI2003   = DataSourceDownload.get path_HIWI2003
#   dsd_HIWI2002   = DataSourceDownload.get path_HIWI2002
#   dsd_HIWI2001   = DataSourceDownload.get path_HIWI2001
#   dsd_HIWI2000   = DataSourceDownload.get path_HIWI2000
#   dsd_HIWI1999   = DataSourceDownload.get path_HIWI1999
#   dsd_HIWI1998   = DataSourceDownload.get path_HIWI1998
#   dsd_HIWI1997   = DataSourceDownload.get path_HIWI1997
#   dsd_HIWI1996   = DataSourceDownload.get path_HIWI1996
#   dsd_HIWI1995   = DataSourceDownload.get path_HIWI1995
#   dsd_HIWI1994   = DataSourceDownload.get path_HIWI1994
#   dsd_HIWI1993   = DataSourceDownload.get path_HIWI1993
#   dsd_HIWI1992   = DataSourceDownload.get path_HIWI1992
#   dsd_HIWI1991   = DataSourceDownload.get path_HIWI1991
#   dsd_HIWI1990   = DataSourceDownload.get path_HIWI1990
# 
#   
#   if dsd_HIWI2011.download_changed? || dsd_HIWI2010.download_changed? || dsd_HIWI2009.download_changed? || dsd_HIWI2008.download_changed?  || dsd_HIWI2007.download_changed? || dsd_HIWI2006.download_changed? 
# # Don't check all of them for changes b/c line would be too long.  What does whitespace do here?
#     sox = SeriesOutputXls.new(output_path)  
#   sox.add "E_NFNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "/Volumes/UHEROwork/data/rawdata/BLS_HIWI%Y.xls", "State", 7, "repeat:2:13")
#   sox.add "E_PRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 11, "repeat:2:13")
#   sox.add "ECTNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 13, "repeat:2:13")
#   sox.add "ECTBLNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 14, "repeat:2:13")
#   sox.add "ECTSPNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 15, "repeat:2:13")
#   sox.add "EMNNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 17, "repeat:2:13")
#   sox.add "EMNDRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 18, "repeat:2:13")
#   sox.add "EMNNDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 19, "repeat:2:13")
#   sox.add "E_SVCPRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 21, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 25, "repeat:2:13")
#   sox.add "EWTNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 26, "repeat:2:13")
#   sox.add "ERTNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 27, "repeat:2:13")
#   sox.add "ERTFDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 28, "repeat:2:13")
#   sox.add "ERTFDGSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 29, "repeat:2:13")
#   sox.add "ERTCLNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 30, "repeat:2:13")
#   sox.add "ERTGMNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 31, "repeat:2:13")
#   sox.add "ERTGMDSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 32, "repeat:2:13")
#   sox.add "E_TUNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 33, "repeat:2:13")
#   sox.add "EUTNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 34, "repeat:2:13")
#   sox.add "ETWNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 35, "repeat:2:13")
#   sox.add "ETWTANS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 36, "repeat:2:13")
#   sox.add "EIFNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 38, "repeat:2:13")
#   sox.add "EIFTCNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 39, "repeat:2:13")
#   sox.add "E_FIRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 41, "repeat:2:13")
#   sox.add "EFINS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 42, "repeat:2:13")
#   sox.add "ERENS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 43, "repeat:2:13")
#   sox.add "E_PBSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 45, "repeat:2:13")
#   sox.add "EPSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 46, "repeat:2:13")
#   sox.add "EMANS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 47, "repeat:2:13")
#   sox.add "EADNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 49, "repeat:2:13")
#   sox.add "EADESNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 50, "repeat:2:13")
#   sox.add "E_EDHCNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 52, "repeat:2:13")
#   sox.add "EEDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 53, "repeat:2:13")
#   sox.add "EED12NS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 54, "repeat:2:13")
#   sox.add "EHCNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 55, "repeat:2:13")
#   sox.add "EHCAMNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 56, "repeat:2:13")
#   sox.add "EHCHONS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 57, "repeat:2:13")
#   sox.add "EHCNRNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 58, "repeat:2:13")
#   sox.add "EHCSONS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 59, "repeat:2:13")
#   sox.add "EHCSOIFNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 60, "repeat:2:13")
#   sox.add "E_LHNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 62, "repeat:2:13")
#   sox.add "EAENS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 63, "repeat:2:13")
#   sox.add "EAFNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 64, "repeat:2:13")
#   sox.add "EAFACNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 65, "repeat:2:13")
#   sox.add "EAFFDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 66, "repeat:2:13")
#   sox.add "EAFFDRSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 67, "repeat:2:13")
#   sox.add "EOSNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 69, "repeat:2:13")
#   sox.add "EGVNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 71, "repeat:2:13")
#   sox.add "EGVFDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 72, "repeat:2:13")
#   sox.add "EGVFDDDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 73, "repeat:2:13")
#   sox.add "EGVFDSPNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 74, "repeat:2:13")
#   sox.add "EGVSTNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 75, "repeat:2:13")
#   sox.add "EGVSTEDNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 76, "repeat:2:13")
#   sox.add "EGVLCNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 77, "repeat:2:13")
#   sox.add "EAGNS@HI.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 79, "repeat:2:13")
#   sox.add "E_NFNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 7, "repeat:2:13")
#   sox.add "E_PRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 11, "repeat:2:13")
#   sox.add "ECTNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 13, "repeat:2:13")
#   sox.add "ECTSPNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 14, "repeat:2:13")
#   sox.add "EMNNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 16, "repeat:2:13")
#   sox.add "EMNDRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 17, "repeat:2:13")
#   sox.add "EMNNDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 24, "repeat:2:13")
#   sox.add "EWTNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 25, "repeat:2:13")
#   sox.add "ERTNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 26, "repeat:2:13")
#   sox.add "ERTFDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 28, "repeat:2:13")
#   sox.add "ERTCLNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 29, "repeat:2:13")
#   sox.add "ERTGMNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 31, "repeat:2:13")
#   sox.add "E_TUNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 32, "repeat:2:13")
#   sox.add "ETWNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 33, "repeat:2:13")
#   sox.add "ETWTANS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 34, "repeat:2:13")
#   sox.add "EIFNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 36, "repeat:2:13")
#   sox.add "EIFTCNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 37, "repeat:2:13")
#   sox.add "E_FIRNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 39, "repeat:2:13")
#   sox.add "EFINS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 40, "repeat:2:13")
#   sox.add "ERENS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 41, "repeat:2:13")
#   sox.add "E_PBSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 43, "repeat:2:13")
#   sox.add "EPSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 44, "repeat:2:13")
#   sox.add "EMANS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 45, "repeat:2:13")
#   sox.add "EADNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 47, "repeat:2:13")
#   sox.add "EADESNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 48, "repeat:2:13")
#   sox.add "E_EDHCNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 50, "repeat:2:13")
#   sox.add "EEDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 51, "repeat:2:13")
#   sox.add "EED12NS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 52, "repeat:2:13")
#   sox.add "EHCNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 53, "repeat:2:13")
#   sox.add "EHCAMNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 54, "repeat:2:13")
#   sox.add "EHCHONS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 55, "repeat:2:13")
#   sox.add "E_LHNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 57, "repeat:2:13")
# #  sox.add "#EAENS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", #N/A Discontinued?, "repeat:2:13")
#   sox.add "EAFNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 58, "repeat:2:13")
#   sox.add "EAFACNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 59, "repeat:2:13")
#   sox.add "EAFFDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 60, "repeat:2:13")
#   sox.add "EAFFDRSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 61, "repeat:2:13")
#   sox.add "EOSNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 63, "repeat:2:13")
#   sox.add "EGVNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 65, "repeat:2:13")
#   sox.add "EGVFDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 66, "repeat:2:13")
#   sox.add "EGVFDDDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 67, "repeat:2:13")
#   sox.add "EGVFDSPNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 68, "repeat:2:13")
#   sox.add "EGVSTNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 69, "repeat:2:13")
#   sox.add "EGVSTEDNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 70, "repeat:2:13")
#   sox.add "EGVLCNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 71, "repeat:2:13")
#   sox.add "EAGNS@HON.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 73, "repeat:2:13")
#   sox.add "E_NFNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 11, "repeat:2:13")
#   sox.add "ECTNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 14, "repeat:2:13")
#   sox.add "EMNNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 24, "repeat:2:13")
#   sox.add "EWTNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 25, "repeat:2:13")
#   sox.add "ERTNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 33, "repeat:2:13")
#   sox.add "EIFNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 38, "repeat:2:13")
#   sox.add "EFINS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 41, "repeat:2:13")
#   sox.add "EPSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 42, "repeat:2:13")
#   sox.add "EADNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 46, "repeat:2:13")
#   sox.add "EEDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 47, "repeat:2:13")
#   sox.add "EHCNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 50, "repeat:2:13")
# #  sox.add "#EAENS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", #N/A Discontinued?, "repeat:2:13")
#   sox.add "EAFNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 51, "repeat:2:13")
#   sox.add "EAFACNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 52, "repeat:2:13")
#   sox.add "EAFFDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 53, "repeat:2:13")
#   sox.add "EAFFDRSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 54, "repeat:2:13")
#   sox.add "EOSNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 56, "repeat:2:13")
#   sox.add "EGVNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 58, "repeat:2:13")
#   sox.add "EGVFDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 59, "repeat:2:13")
#   sox.add "EGVFDDDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 60, "repeat:2:13")
#   sox.add "EGVSTNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 61, "repeat:2:13")
#   sox.add "EGVSTEDNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 62, "repeat:2:13")
#   sox.add "EGVLCNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 63, "repeat:2:13")
#   sox.add "EAGNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 65, "repeat:2:13")
#   sox.add "E_NFNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 11, "repeat:2:13")
#   sox.add "ECTNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 14, "repeat:2:13")
#   sox.add "EMNNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 24, "repeat:2:13")
#   sox.add "EWTNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 25, "repeat:2:13")
#   sox.add "ERTNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 33, "repeat:2:13")
#   sox.add "EIFNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 38, "repeat:2:13")
#   sox.add "EFINS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 41, "repeat:2:13")
#   sox.add "EPSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 42, "repeat:2:13")
#   sox.add "EADNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 46, "repeat:2:13")
#   sox.add "EEDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 47, "repeat:2:13")
#   sox.add "EHCNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 50, "repeat:2:13")
# #  sox.add "EAENS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", #N/A Discontinued?, "repeat:2:13")
#   sox.add "EAFNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 51, "repeat:2:13")
#   sox.add "EAFACNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 52, "repeat:2:13")
#   sox.add "EAFFDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 53, "repeat:2:13")
#   sox.add "EAFFDRSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 54, "repeat:2:13")
#   sox.add "EOSNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 56, "repeat:2:13")
#   sox.add "EGVNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 58, "repeat:2:13")
#   sox.add "EGVFDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 59, "repeat:2:13")
#   sox.add "EGVFDDDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 60, "repeat:2:13")
#   sox.add "EGVSTNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 61, "repeat:2:13")
#   sox.add "EGVSTEDNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 62, "repeat:2:13")
#   sox.add "EGVLCNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 63, "repeat:2:13")
#   sox.add "EAGNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 65, "repeat:2:13")
#   sox.add "E_NFNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 11, "repeat:2:13")
#   sox.add "ECTNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 14, "repeat:2:13")
#   sox.add "EMNNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 24, "repeat:2:13")
#   sox.add "EWTNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 25, "repeat:2:13")
#   sox.add "ERTNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 33, "repeat:2:13")
#   sox.add "EIFNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 38, "repeat:2:13")
#   sox.add "EFINS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 41, "repeat:2:13")
#   sox.add "EPSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 42, "repeat:2:13")
#   sox.add "EADNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 46, "repeat:2:13")
#   sox.add "EEDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 47, "repeat:2:13")
#   sox.add "EHCNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 50, "repeat:2:13")
# #  sox.add "#EAENS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", #N/A Discontinued?, "repeat:2:13")
#   sox.add "EAFNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 51, "repeat:2:13")
#   sox.add "EAFACNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 52, "repeat:2:13")
#   sox.add "EAFFDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 53, "repeat:2:13")
#   sox.add "EAFFDRSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 54, "repeat:2:13")
#   sox.add "EOSNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 56, "repeat:2:13")
#   sox.add "EGVNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 58, "repeat:2:13")
#   sox.add "EGVFDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 59, "repeat:2:13")
#   sox.add "EGVFDDDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 60, "repeat:2:13")
#   sox.add "EGVSTNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 61, "repeat:2:13")
#   sox.add "EGVSTEDNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 62, "repeat:2:13")
#   sox.add "EGVLCNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 63, "repeat:2:13")
#   sox.add "EAGNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 65, "repeat:2:13")
# #  sox.add "#E_GVSLNS@HAW.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@KAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@MAU.M",         Series.load_pattern("2011-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# 
#   sox.add "E_NFNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 7, "repeat:2:13")
#   sox.add "E_PRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 11, "repeat:2:13")
#   sox.add "ECTNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 13, "repeat:2:13")
#   sox.add "ECTBLNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 14, "repeat:2:13")
#   sox.add "ECTSPNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 15, "repeat:2:13")
#   sox.add "EMNNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 17, "repeat:2:13")
#   sox.add "EMNDRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 18, "repeat:2:13")
#   sox.add "EMNNDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 19, "repeat:2:13")
#   sox.add "E_SVCPRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 21, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 25, "repeat:2:13")
#   sox.add "EWTNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 26, "repeat:2:13")
#   sox.add "ERTNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 27, "repeat:2:13")
#   sox.add "ERTFDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 28, "repeat:2:13")
#   sox.add "ERTFDGSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 29, "repeat:2:13")
#   sox.add "ERTCLNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 30, "repeat:2:13")
#   sox.add "ERTGMNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 31, "repeat:2:13")
#   sox.add "ERTGMDSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 32, "repeat:2:13")
#   sox.add "E_TUNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 33, "repeat:2:13")
#   sox.add "EUTNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 34, "repeat:2:13")
#   sox.add "ETWNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 35, "repeat:2:13")
#   sox.add "ETWTANS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 36, "repeat:2:13")
#   sox.add "EIFNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 38, "repeat:2:13")
#   sox.add "EIFTCNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 39, "repeat:2:13")
#   sox.add "E_FIRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 41, "repeat:2:13")
#   sox.add "EFINS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 42, "repeat:2:13")
#   sox.add "ERENS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 43, "repeat:2:13")
#   sox.add "E_PBSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 45, "repeat:2:13")
#   sox.add "EPSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 46, "repeat:2:13")
#   sox.add "EMANS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 47, "repeat:2:13")
#   sox.add "EADNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 49, "repeat:2:13")
#   sox.add "EADESNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 50, "repeat:2:13")
#   sox.add "E_EDHCNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 52, "repeat:2:13")
#   sox.add "EEDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 53, "repeat:2:13")
#   sox.add "EED12NS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 54, "repeat:2:13")
#   sox.add "EHCNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 55, "repeat:2:13")
#   sox.add "EHCAMNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 56, "repeat:2:13")
#   sox.add "EHCHONS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 57, "repeat:2:13")
#   sox.add "EHCNRNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 58, "repeat:2:13")
#   sox.add "EHCSONS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 59, "repeat:2:13")
#   sox.add "EHCSOIFNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 60, "repeat:2:13")
#   sox.add "E_LHNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 62, "repeat:2:13")
#   sox.add "EAENS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 63, "repeat:2:13")
#   sox.add "EAFNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 64, "repeat:2:13")
#   sox.add "EAFACNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 65, "repeat:2:13")
#   sox.add "EAFFDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 66, "repeat:2:13")
#   sox.add "EAFFDRSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 67, "repeat:2:13")
#   sox.add "EOSNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 69, "repeat:2:13")
#   sox.add "EGVNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 71, "repeat:2:13")
#   sox.add "EGVFDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 72, "repeat:2:13")
#   sox.add "EGVFDDDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 73, "repeat:2:13")
#   sox.add "EGVFDSPNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 74, "repeat:2:13")
#   sox.add "EGVSTNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 75, "repeat:2:13")
#   sox.add "EGVSTEDNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 76, "repeat:2:13")
#   sox.add "EGVLCNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 77, "repeat:2:13")
#   sox.add "EAGNS@HI.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 79, "repeat:2:13")
#   sox.add "E_NFNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 7, "repeat:2:13")
#   sox.add "E_PRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 11, "repeat:2:13")
#   sox.add "ECTNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 13, "repeat:2:13")
#   sox.add "ECTSPNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 14, "repeat:2:13")
#   sox.add "EMNNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 16, "repeat:2:13")
#   sox.add "EMNDRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 17, "repeat:2:13")
#   sox.add "EMNNDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 24, "repeat:2:13")
#   sox.add "EWTNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 25, "repeat:2:13")
#   sox.add "ERTNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 26, "repeat:2:13")
#   sox.add "ERTFDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 28, "repeat:2:13")
#   sox.add "ERTCLNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 29, "repeat:2:13")
#   sox.add "ERTGMNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 31, "repeat:2:13")
#   sox.add "E_TUNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 32, "repeat:2:13")
#   sox.add "ETWNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 33, "repeat:2:13")
#   sox.add "ETWTANS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 34, "repeat:2:13")
#   sox.add "EIFNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 36, "repeat:2:13")
#   sox.add "EIFTCNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 37, "repeat:2:13")
#   sox.add "E_FIRNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 39, "repeat:2:13")
#   sox.add "EFINS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 40, "repeat:2:13")
#   sox.add "ERENS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 41, "repeat:2:13")
#   sox.add "E_PBSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 43, "repeat:2:13")
#   sox.add "EPSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 44, "repeat:2:13")
#   sox.add "EMANS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 45, "repeat:2:13")
#   sox.add "EADNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 47, "repeat:2:13")
#   sox.add "EADESNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 48, "repeat:2:13")
#   sox.add "E_EDHCNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 50, "repeat:2:13")
#   sox.add "EEDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 51, "repeat:2:13")
#   sox.add "EED12NS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 52, "repeat:2:13")
#   sox.add "EHCNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 53, "repeat:2:13")
#   sox.add "EHCAMNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 54, "repeat:2:13")
#   sox.add "EHCHONS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 55, "repeat:2:13")
#   sox.add "E_LHNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 57, "repeat:2:13")
#   sox.add "EAENS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 58, "repeat:2:13")
#   sox.add "EAFNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 59, "repeat:2:13")
#   sox.add "EAFACNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 60, "repeat:2:13")
#   sox.add "EAFFDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 61, "repeat:2:13")
#   sox.add "EAFFDRSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 62, "repeat:2:13")
#   sox.add "EOSNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 64, "repeat:2:13")
#   sox.add "EGVNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 66, "repeat:2:13")
#   sox.add "EGVFDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 67, "repeat:2:13")
#   sox.add "EGVFDDDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 68, "repeat:2:13")
#   sox.add "EGVFDSPNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 69, "repeat:2:13")
#   sox.add "EGVSTNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 70, "repeat:2:13")
#   sox.add "EGVSTEDNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 71, "repeat:2:13")
#   sox.add "EGVLCNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 72, "repeat:2:13")
#   sox.add "EAGNS@HON.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 74, "repeat:2:13")
#   sox.add "E_NFNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 11, "repeat:2:13")
#   sox.add "ECTNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 14, "repeat:2:13")
#   sox.add "EMNNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 24, "repeat:2:13")
#   sox.add "EWTNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 25, "repeat:2:13")
#   sox.add "ERTNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 33, "repeat:2:13")
#   sox.add "EIFNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 38, "repeat:2:13")
#   sox.add "EFINS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 41, "repeat:2:13")
#   sox.add "EPSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 42, "repeat:2:13")
#   sox.add "EADNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 46, "repeat:2:13")
#   sox.add "EEDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 47, "repeat:2:13")
#   sox.add "EHCNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 50, "repeat:2:13")
#   sox.add "EAENS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 51, "repeat:2:13")
#   sox.add "EAFNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 52, "repeat:2:13")
#   sox.add "EAFACNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 53, "repeat:2:13")
#   sox.add "EAFFDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 54, "repeat:2:13")
#   sox.add "EAFFDRSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 55, "repeat:2:13")
#   sox.add "EOSNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 57, "repeat:2:13")
#   sox.add "EGVNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 59, "repeat:2:13")
#   sox.add "EGVFDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 60, "repeat:2:13")
#   sox.add "EGVFDDDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 61, "repeat:2:13")
#   sox.add "EGVSTNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 62, "repeat:2:13")
#   sox.add "EGVSTEDNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 63, "repeat:2:13")
#   sox.add "EGVLCNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 64, "repeat:2:13")
#   sox.add "EAGNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 66, "repeat:2:13")
#   sox.add "E_NFNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 11, "repeat:2:13")
#   sox.add "ECTNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 14, "repeat:2:13")
#   sox.add "EMNNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 24, "repeat:2:13")
#   sox.add "EWTNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 25, "repeat:2:13")
#   sox.add "ERTNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 33, "repeat:2:13")
#   sox.add "EIFNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 38, "repeat:2:13")
#   sox.add "EFINS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 41, "repeat:2:13")
#   sox.add "EPSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 42, "repeat:2:13")
#   sox.add "EADNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 46, "repeat:2:13")
#   sox.add "EEDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 47, "repeat:2:13")
#   sox.add "EHCNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 50, "repeat:2:13")
#   sox.add "EAENS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 51, "repeat:2:13")
#   sox.add "EAFNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 52, "repeat:2:13")
#   sox.add "EAFACNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 53, "repeat:2:13")
#   sox.add "EAFFDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 54, "repeat:2:13")
#   sox.add "EAFFDRSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 55, "repeat:2:13")
#   sox.add "EOSNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 57, "repeat:2:13")
#   sox.add "EGVNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 59, "repeat:2:13")
#   sox.add "EGVFDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 60, "repeat:2:13")
#   sox.add "EGVFDDDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 61, "repeat:2:13")
#   sox.add "EGVSTNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 62, "repeat:2:13")
#   sox.add "EGVSTEDNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 63, "repeat:2:13")
#   sox.add "EGVLCNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 64, "repeat:2:13")
#   sox.add "EAGNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 66, "repeat:2:13")
#   sox.add "E_NFNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 7, "repeat:2:13")
#   sox.add "E_PRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 9, "repeat:2:13")
#   sox.add "E_GDSPRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 11, "repeat:2:13")
#   sox.add "ECTNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 13, "repeat:2:13")
#   sox.add "ECTSPNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 14, "repeat:2:13")
#   sox.add "EMNNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 16, "repeat:2:13")
#   sox.add "EMNDRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 17, "repeat:2:13")
#   sox.add "EMNNDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 18, "repeat:2:13")
#   sox.add "E_SVCPRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 20, "repeat:2:13")
#   sox.add "E_PRSVCPRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 22, "repeat:2:13")
#   sox.add "E_TTUNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 24, "repeat:2:13")
#   sox.add "EWTNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 25, "repeat:2:13")
#   sox.add "ERTNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 26, "repeat:2:13")
#   sox.add "ERTFDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 27, "repeat:2:13")
#   sox.add "ERTFDGSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 28, "repeat:2:13")
#   sox.add "ERTCLNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 29, "repeat:2:13")
#   sox.add "ERTGMNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 30, "repeat:2:13")
#   sox.add "ERTGMDSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 31, "repeat:2:13")
#   sox.add "E_TUNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 32, "repeat:2:13")
#   sox.add "ETWTANS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 33, "repeat:2:13")
#   sox.add "EIFNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 35, "repeat:2:13")
#   sox.add "EIFTCNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 36, "repeat:2:13")
#   sox.add "E_FIRNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 38, "repeat:2:13")
#   sox.add "EFINS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 39, "repeat:2:13")
#   sox.add "E_PBSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 41, "repeat:2:13")
#   sox.add "EPSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 42, "repeat:2:13")
#   sox.add "EADNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 44, "repeat:2:13")
#   sox.add "E_EDHCNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 46, "repeat:2:13")
#   sox.add "EEDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 47, "repeat:2:13")
#   sox.add "EHCNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 48, "repeat:2:13")
#   sox.add "E_LHNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 50, "repeat:2:13")
#   sox.add "EAENS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 51, "repeat:2:13")
#   sox.add "EAFNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 52, "repeat:2:13")
#   sox.add "EAFACNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 53, "repeat:2:13")
#   sox.add "EAFFDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 54, "repeat:2:13")
#   sox.add "EAFFDRSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 55, "repeat:2:13")
#   sox.add "EOSNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 57, "repeat:2:13")
#   sox.add "EGVNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 59, "repeat:2:13")
#   sox.add "EGVFDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 60, "repeat:2:13")
#   sox.add "EGVFDDDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 61, "repeat:2:13")
#   sox.add "EGVSTNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 62, "repeat:2:13")
#   sox.add "EGVSTEDNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 63, "repeat:2:13")
#   sox.add "EGVLCNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 64, "repeat:2:13")
#   sox.add "EAGNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 66, "repeat:2:13")
# #  sox.add "#E_GVSLNS@HAW.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@KAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@MAU.M",         Series.load_pattern("2009-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# 
#   sox.add "E_NFNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 7, "repeat:3:14")
#   sox.add "E_PRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 11, "repeat:3:14")
#   sox.add "ECTNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 13, "repeat:3:14")
#   sox.add "ECTBLNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 14, "repeat:3:14")
#   sox.add "ECTSPNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 15, "repeat:3:14")
#   sox.add "EMNNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 17, "repeat:3:14")
#   sox.add "EMNDRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 18, "repeat:3:14")
#   sox.add "EMNNDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 22, "repeat:3:14")
#   sox.add "E_TTUNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 25, "repeat:3:14")
#   sox.add "EWTNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 26, "repeat:3:14")
#   sox.add "ERTNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 27, "repeat:3:14")
#   sox.add "ERTFDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 29, "repeat:3:14")
#   sox.add "ERTCLNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 30, "repeat:3:14")
#   sox.add "ERTGMNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 32, "repeat:3:14")
#   sox.add "E_TUNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 33, "repeat:3:14")
#   sox.add "EUTNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 34, "repeat:3:14")
#   sox.add "ETWNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 35, "repeat:3:14")
#   sox.add "ETWTANS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 36, "repeat:3:14")
#   sox.add "EIFNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 38, "repeat:3:14")
#   sox.add "EIFTCNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 39, "repeat:3:14")
#   sox.add "E_FIRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 41, "repeat:3:14")
#   sox.add "EFINS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 42, "repeat:3:14")
#   sox.add "ERENS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 43, "repeat:3:14")
#   sox.add "E_PBSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 45, "repeat:3:14")
#   sox.add "EPSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 46, "repeat:3:14")
#   sox.add "EMANS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 47, "repeat:3:14")
#   sox.add "EADNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 49, "repeat:3:14")
#   sox.add "EADESNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 50, "repeat:3:14")
#   sox.add "E_EDHCNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 52, "repeat:3:14")
#   sox.add "EEDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 53, "repeat:3:14")
#   sox.add "EED12NS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 54, "repeat:3:14")
#   sox.add "EHCNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 55, "repeat:3:14")
#   sox.add "EHCAMNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 56, "repeat:3:14")
#   sox.add "EHCHONS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 57, "repeat:3:14")
#   sox.add "EHCNRNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 58, "repeat:3:14")
#   sox.add "EHCSONS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 59, "repeat:3:14")
#   sox.add "EHCSOIFNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 60, "repeat:3:14")
#   sox.add "E_LHNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 62, "repeat:3:14")
#   sox.add "EAENS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 63, "repeat:3:14")
#   sox.add "EAFNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 64, "repeat:3:14")
#   sox.add "EAFACNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 65, "repeat:3:14")
#   sox.add "EAFFDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 66, "repeat:3:14")
#   sox.add "EAFFDRSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 67, "repeat:3:14")
#   sox.add "EOSNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 69, "repeat:3:14")
#   sox.add "EGVNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 71, "repeat:3:14")
#   sox.add "EGVFDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 72, "repeat:3:14")
#   sox.add "EGVFDDDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 73, "repeat:3:14")
#   sox.add "EGVFDSPNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 74, "repeat:3:14")
#   sox.add "EGVSTNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 75, "repeat:3:14")
#   sox.add "EGVSTEDNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 76, "repeat:3:14")
#   sox.add "EGVLCNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 77, "repeat:3:14")
#   sox.add "EAGNS@HI.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 79, "repeat:3:14")
#   sox.add "E_NFNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 7, "repeat:3:14")
#   sox.add "E_PRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 11, "repeat:3:14")
#   sox.add "ECTNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 13, "repeat:3:14")
#   sox.add "ECTSPNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 14, "repeat:3:14")
#   sox.add "EMNNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 16, "repeat:3:14")
#   sox.add "EMNDRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 17, "repeat:3:14")
#   sox.add "EMNNDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 22, "repeat:3:14")
#   sox.add "E_TTUNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 24, "repeat:3:14")
#   sox.add "EWTNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 25, "repeat:3:14")
#   sox.add "ERTNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 26, "repeat:3:14")
#   sox.add "ERTFDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 28, "repeat:3:14")
#   sox.add "ERTCLNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 29, "repeat:3:14")
#   sox.add "ERTGMNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 31, "repeat:3:14")
#   sox.add "E_TUNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 32, "repeat:3:14")
#   sox.add "ETWNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 33, "repeat:3:14")
#   sox.add "ETWTANS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 34, "repeat:3:14")
#   sox.add "EIFNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 36, "repeat:3:14")
#   sox.add "EIFTCNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 37, "repeat:3:14")
#   sox.add "E_FIRNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 39, "repeat:3:14")
#   sox.add "EFINS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 40, "repeat:3:14")
#   sox.add "ERENS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 41, "repeat:3:14")
#   sox.add "E_PBSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 43, "repeat:3:14")
#   sox.add "EPSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 44, "repeat:3:14")
#   sox.add "EMANS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 45, "repeat:3:14")
#   sox.add "EADNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 47, "repeat:3:14")
#   sox.add "EADESNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 48, "repeat:3:14")
#   sox.add "E_EDHCNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 50, "repeat:3:14")
#   sox.add "EEDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 51, "repeat:3:14")
#   sox.add "EED12NS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 52, "repeat:3:14")
#   sox.add "EHCNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 53, "repeat:3:14")
#   sox.add "EHCAMNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 54, "repeat:3:14")
#   sox.add "EHCHONS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 55, "repeat:3:14")
#   sox.add "E_LHNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 57, "repeat:3:14")
#   sox.add "EAENS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 58, "repeat:3:14")
#   sox.add "EAFNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 59, "repeat:3:14")
#   sox.add "EAFACNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 60, "repeat:3:14")
#   sox.add "EAFFDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 61, "repeat:3:14")
#   sox.add "EAFFDRSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 62, "repeat:3:14")
#   sox.add "EOSNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 64, "repeat:3:14")
#   sox.add "EGVNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 66, "repeat:3:14")
#   sox.add "EGVFDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 67, "repeat:3:14")
#   sox.add "EGVFDDDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 68, "repeat:3:14")
#   sox.add "EGVFDSPNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 69, "repeat:3:14")
#   sox.add "EGVSTNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 70, "repeat:3:14")
#   sox.add "EGVSTEDNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 71, "repeat:3:14")
#   sox.add "EGVLCNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 72, "repeat:3:14")
#   sox.add "EAGNS@HON.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 74, "repeat:3:14")
#   sox.add "E_NFNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 7, "repeat:3:14")
#   sox.add "E_PRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 11, "repeat:3:14")
#   sox.add "ECTNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 13, "repeat:3:14")
#   sox.add "ECTSPNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 14, "repeat:3:14")
#   sox.add "EMNNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 16, "repeat:3:14")
#   sox.add "EMNDRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 17, "repeat:3:14")
#   sox.add "EMNNDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 22, "repeat:3:14")
#   sox.add "E_TTUNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 24, "repeat:3:14")
#   sox.add "EWTNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 25, "repeat:3:14")
#   sox.add "ERTNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 26, "repeat:3:14")
#   sox.add "ERTFDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 28, "repeat:3:14")
#   sox.add "ERTCLNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 29, "repeat:3:14")
#   sox.add "ERTGMNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 31, "repeat:3:14")
#   sox.add "E_TUNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 32, "repeat:3:14")
#   sox.add "ETWTANS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 33, "repeat:3:14")
#   sox.add "EIFNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 35, "repeat:3:14")
#   sox.add "EIFTCNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 36, "repeat:3:14")
#   sox.add "E_FIRNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 38, "repeat:3:14")
#   sox.add "EFINS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 39, "repeat:3:14")
#   sox.add "E_PBSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 41, "repeat:3:14")
#   sox.add "EPSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 42, "repeat:3:14")
#   sox.add "EADNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 44, "repeat:3:14")
#   sox.add "E_EDHCNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 46, "repeat:3:14")
#   sox.add "EEDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 47, "repeat:3:14")
#   sox.add "EHCNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 48, "repeat:3:14")
#   sox.add "E_LHNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 50, "repeat:3:14")
#   sox.add "EAENS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 51, "repeat:3:14")
#   sox.add "EAFNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 55, "repeat:3:14")
#   sox.add "EOSNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 57, "repeat:3:14")
#   sox.add "EGVNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 59, "repeat:3:14")
#   sox.add "EGVFDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 60, "repeat:3:14")
#   sox.add "EGVFDDDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 61, "repeat:3:14")
#   sox.add "EGVSTNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 62, "repeat:3:14")
#   sox.add "EGVSTEDNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 63, "repeat:3:14")
#   sox.add "EGVLCNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 64, "repeat:3:14")
#   sox.add "EAGNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 66, "repeat:3:14")
#   sox.add "E_NFNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 7, "repeat:3:14")
#   sox.add "E_PRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 11, "repeat:3:14")
#   sox.add "ECTNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 13, "repeat:3:14")
#   sox.add "ECTSPNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 14, "repeat:3:14")
#   sox.add "EMNNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 16, "repeat:3:14")
#   sox.add "EMNDRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 17, "repeat:3:14")
#   sox.add "EMNNDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 22, "repeat:3:14")
#   sox.add "E_TTUNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 24, "repeat:3:14")
#   sox.add "EWTNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 25, "repeat:3:14")
#   sox.add "ERTNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 26, "repeat:3:14")
#   sox.add "ERTFDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 28, "repeat:3:14")
#   sox.add "ERTCLNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 29, "repeat:3:14")
#   sox.add "ERTGMNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 31, "repeat:3:14")
#   sox.add "E_TUNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 32, "repeat:3:14")
#   sox.add "ETWTANS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 33, "repeat:3:14")
#   sox.add "EIFNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 35, "repeat:3:14")
#   sox.add "EIFTCNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 36, "repeat:3:14")
#   sox.add "E_FIRNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 38, "repeat:3:14")
#   sox.add "EFINS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 39, "repeat:3:14")
#   sox.add "E_PBSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 41, "repeat:3:14")
#   sox.add "EPSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 42, "repeat:3:14")
#   sox.add "EADNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 44, "repeat:3:14")
#   sox.add "E_EDHCNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 46, "repeat:3:14")
#   sox.add "EEDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 47, "repeat:3:14")
#   sox.add "EHCNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 48, "repeat:3:14")
#   sox.add "E_LHNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 50, "repeat:3:14")
#   sox.add "EAENS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 51, "repeat:3:14")
#   sox.add "EAFNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 55, "repeat:3:14")
#   sox.add "EOSNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 57, "repeat:3:14")
#   sox.add "EGVNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 59, "repeat:3:14")
#   sox.add "EGVFDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 60, "repeat:3:14")
#   sox.add "EGVFDDDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 61, "repeat:3:14")
#   sox.add "EGVSTNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 62, "repeat:3:14")
#   sox.add "EGVSTEDNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 63, "repeat:3:14")
#   sox.add "EGVLCNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 64, "repeat:3:14")
#   sox.add "EAGNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 66, "repeat:3:14")
#   sox.add "E_NFNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 7, "repeat:3:14")
#   sox.add "E_PRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 11, "repeat:3:14")
#   sox.add "ECTNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 13, "repeat:3:14")
#   sox.add "ECTSPNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 14, "repeat:3:14")
#   sox.add "EMNNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 16, "repeat:3:14")
#   sox.add "EMNDRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 17, "repeat:3:14")
#   sox.add "EMNNDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 22, "repeat:3:14")
#   sox.add "E_TTUNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 24, "repeat:3:14")
#   sox.add "EWTNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 25, "repeat:3:14")
#   sox.add "ERTNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 26, "repeat:3:14")
#   sox.add "ERTFDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 28, "repeat:3:14")
#   sox.add "ERTCLNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 29, "repeat:3:14")
#   sox.add "ERTGMNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 31, "repeat:3:14")
#   sox.add "E_TUNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 32, "repeat:3:14")
#   sox.add "ETWTANS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 33, "repeat:3:14")
#   sox.add "EIFNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 35, "repeat:3:14")
#   sox.add "EIFTCNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 36, "repeat:3:14")
#   sox.add "E_FIRNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 38, "repeat:3:14")
#   sox.add "EFINS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 39, "repeat:3:14")
#   sox.add "E_PBSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 41, "repeat:3:14")
#   sox.add "EPSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 42, "repeat:3:14")
#   sox.add "EADNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 44, "repeat:3:14")
#   sox.add "E_EDHCNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 46, "repeat:3:14")
#   sox.add "EEDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 47, "repeat:3:14")
#   sox.add "EHCNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 48, "repeat:3:14")
#   sox.add "E_LHNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 50, "repeat:3:14")
#   sox.add "EAENS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 51, "repeat:3:14")
#   sox.add "EAFNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 55, "repeat:3:14")
#   sox.add "EOSNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 57, "repeat:3:14")
#   sox.add "EGVNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 59, "repeat:3:14")
#   sox.add "EGVFDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 60, "repeat:3:14")
#   sox.add "EGVFDDDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 61, "repeat:3:14")
#   sox.add "EGVSTNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 62, "repeat:3:14")
#   sox.add "EGVSTEDNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 63, "repeat:3:14")
#   sox.add "EGVLCNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 64, "repeat:3:14")
#   sox.add "EAGNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 66, "repeat:3:14")
# #  sox.add "#E_GVSLNS@HAW.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@KAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@MAU.M",         Series.load_pattern("2002-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# 
#   sox.add "E_NFNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 6, "repeat:3:14")
#   sox.add "E_PRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 8, "repeat:3:14")
#   sox.add "E_GDSPRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 10, "repeat:3:14")
#   sox.add "ECTNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 12, "repeat:3:14")
#   sox.add "ECTBLNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 13, "repeat:3:14")
#   sox.add "ECTSPNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 14, "repeat:3:14")
#   sox.add "EMNNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 16, "repeat:3:14")
#   sox.add "EMNDRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 17, "repeat:3:14")
#   sox.add "EMNNDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 21, "repeat:3:14")
#   sox.add "E_TTUNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 24, "repeat:3:14")
#   sox.add "EWTNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 25, "repeat:3:14")
#   sox.add "ERTNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 26, "repeat:3:14")
#   sox.add "ERTFDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 28, "repeat:3:14")
#   sox.add "ERTCLNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 29, "repeat:3:14")
#   sox.add "ERTGMNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 31, "repeat:3:14")
#   sox.add "E_TUNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 32, "repeat:3:14")
#   sox.add "EUTNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 33, "repeat:3:14")
#   sox.add "ETWNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 34, "repeat:3:14")
#   sox.add "ETWTANS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 35, "repeat:3:14")
#   sox.add "EIFNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 37, "repeat:3:14")
#   sox.add "EIFTCNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 38, "repeat:3:14")
#   sox.add "E_FIRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 40, "repeat:3:14")
#   sox.add "EFINS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 41, "repeat:3:14")
#   sox.add "ERENS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 42, "repeat:3:14")
#   sox.add "E_PBSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 44, "repeat:3:14")
#   sox.add "EPSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 45, "repeat:3:14")
#   sox.add "EMANS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 46, "repeat:3:14")
#   sox.add "EADNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 48, "repeat:3:14")
#   sox.add "EADESNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 49, "repeat:3:14")
#   sox.add "E_EDHCNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 51, "repeat:3:14")
#   sox.add "EEDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 52, "repeat:3:14")
#   sox.add "EED12NS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 53, "repeat:3:14")
#   sox.add "EHCNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 54, "repeat:3:14")
#   sox.add "EHCAMNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 55, "repeat:3:14")
#   sox.add "EHCHONS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 56, "repeat:3:14")
#   sox.add "EHCNRNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 57, "repeat:3:14")
#   sox.add "EHCSONS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 58, "repeat:3:14")
#   sox.add "EHCSOIFNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 59, "repeat:3:14")
#   sox.add "E_LHNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 61, "repeat:3:14")
#   sox.add "EAENS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 62, "repeat:3:14")
#   sox.add "EAFNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 63, "repeat:3:14")
#   sox.add "EAFACNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 64, "repeat:3:14")
#   sox.add "EAFFDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 65, "repeat:3:14")
#   sox.add "EAFFDRSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 66, "repeat:3:14")
#   sox.add "EOSNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 68, "repeat:3:14")
#   sox.add "EGVNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 70, "repeat:3:14")
#   sox.add "EGVFDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 71, "repeat:3:14")
#   sox.add "EGVFDDDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 72, "repeat:3:14")
#   sox.add "EGVFDSPNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 73, "repeat:3:14")
#   sox.add "EGVSTNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 74, "repeat:3:14")
#   sox.add "EGVSTEDNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 75, "repeat:3:14")
#   sox.add "EGVLCNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 76, "repeat:3:14")
#   sox.add "EAGNS@HI.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 78, "repeat:3:14")
#   sox.add "E_NFNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 7, "repeat:3:14")
#   sox.add "E_PRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 11, "repeat:3:14")
#   sox.add "ECTNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 13, "repeat:3:14")
#   sox.add "ECTSPNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 14, "repeat:3:14")
#   sox.add "EMNNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 16, "repeat:3:14")
#   sox.add "EMNDRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 17, "repeat:3:14")
#   sox.add "EMNNDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 22, "repeat:3:14")
#   sox.add "E_TTUNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 24, "repeat:3:14")
#   sox.add "EWTNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 25, "repeat:3:14")
#   sox.add "ERTNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 26, "repeat:3:14")
#   sox.add "ERTFDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 28, "repeat:3:14")
#   sox.add "ERTCLNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 29, "repeat:3:14")
#   sox.add "ERTGMNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 31, "repeat:3:14")
#   sox.add "E_TUNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 32, "repeat:3:14")
#   sox.add "ETWNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 33, "repeat:3:14")
#   sox.add "ETWTANS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 34, "repeat:3:14")
#   sox.add "EIFNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 36, "repeat:3:14")
#   sox.add "EIFTCNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 37, "repeat:3:14")
#   sox.add "E_FIRNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 39, "repeat:3:14")
#   sox.add "EFINS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 40, "repeat:3:14")
#   sox.add "ERENS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 41, "repeat:3:14")
#   sox.add "E_PBSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 43, "repeat:3:14")
#   sox.add "EPSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 44, "repeat:3:14")
#   sox.add "EMANS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 45, "repeat:3:14")
#   sox.add "EADNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 47, "repeat:3:14")
#   sox.add "EADESNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 48, "repeat:3:14")
#   sox.add "E_EDHCNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 50, "repeat:3:14")
#   sox.add "EEDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 51, "repeat:3:14")
#   sox.add "EED12NS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 52, "repeat:3:14")
#   sox.add "EHCNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 53, "repeat:3:14")
#   sox.add "EHCAMNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 54, "repeat:3:14")
#   sox.add "EHCHONS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 55, "repeat:3:14")
#   sox.add "E_LHNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 57, "repeat:3:14")
#   sox.add "EAENS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 58, "repeat:3:14")
#   sox.add "EAFNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 59, "repeat:3:14")
#   sox.add "EAFACNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 60, "repeat:3:14")
#   sox.add "EAFFDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 61, "repeat:3:14")
#   sox.add "EAFFDRSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 62, "repeat:3:14")
#   sox.add "EOSNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 64, "repeat:3:14")
#   sox.add "EGVNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 66, "repeat:3:14")
#   sox.add "EGVFDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 67, "repeat:3:14")
#   sox.add "EGVFDDDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 68, "repeat:3:14")
#   sox.add "EGVFDSPNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 69, "repeat:3:14")
#   sox.add "EGVSTNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 70, "repeat:3:14")
#   sox.add "EGVSTEDNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 71, "repeat:3:14")
#   sox.add "EGVLCNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 72, "repeat:3:14")
#   sox.add "EAGNS@HON.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 74, "repeat:3:14")
#   sox.add "E_NFNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 6, "repeat:3:14")
#   sox.add "E_PRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 8, "repeat:3:14")
#   sox.add "E_GDSPRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 10, "repeat:3:14")
#   sox.add "ECTNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 12, "repeat:3:14")
#   sox.add "ECTSPNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 13, "repeat:3:14")
#   sox.add "EMNNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 15, "repeat:3:14")
#   sox.add "EMNDRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 16, "repeat:3:14")
#   sox.add "EMNNDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 17, "repeat:3:14")
#   sox.add "E_SVCPRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 19, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 21, "repeat:3:14")
#   sox.add "E_TTUNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 23, "repeat:3:14")
#   sox.add "EWTNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 24, "repeat:3:14")
#   sox.add "ERTNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 25, "repeat:3:14")
#   sox.add "ERTFDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 26, "repeat:3:14")
#   sox.add "ERTFDGSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 27, "repeat:3:14")
#   sox.add "ERTCLNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 28, "repeat:3:14")
#   sox.add "ERTGMNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 29, "repeat:3:14")
#   sox.add "ERTGMDSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 30, "repeat:3:14")
#   sox.add "E_TUNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 31, "repeat:3:14")
#   sox.add "ETWTANS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 32, "repeat:3:14")
#   sox.add "EIFNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 34, "repeat:3:14")
#   sox.add "EIFTCNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 35, "repeat:3:14")
#   sox.add "E_FIRNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 37, "repeat:3:14")
#   sox.add "EFINS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 38, "repeat:3:14")
#   sox.add "E_PBSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 40, "repeat:3:14")
#   sox.add "EPSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 41, "repeat:3:14")
#   sox.add "EADNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 43, "repeat:3:14")
#   sox.add "E_EDHCNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 45, "repeat:3:14")
#   sox.add "EEDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 46, "repeat:3:14")
#   sox.add "EHCNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 47, "repeat:3:14")
#   sox.add "E_LHNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 49, "repeat:3:14")
#   sox.add "EAENS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 50, "repeat:3:14")
#   sox.add "EAFNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 51, "repeat:3:14")
#   sox.add "EAFACNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 52, "repeat:3:14")
#   sox.add "EAFFDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 53, "repeat:3:14")
#   sox.add "EAFFDRSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 54, "repeat:3:14")
#   sox.add "EOSNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 56, "repeat:3:14")
#   sox.add "EGVNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 58, "repeat:3:14")
#   sox.add "EGVFDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 59, "repeat:3:14")
#   sox.add "EGVFDDDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 60, "repeat:3:14")
#   sox.add "EGVSTNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 61, "repeat:3:14")
#   sox.add "EGVSTEDNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 62, "repeat:3:14")
#   sox.add "EGVLCNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 63, "repeat:3:14")
#   sox.add "EAGNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 65, "repeat:3:14")
#   sox.add "E_NFNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 7, "repeat:3:14")
#   sox.add "E_PRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 11, "repeat:3:14")
#   sox.add "ECTNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 13, "repeat:3:14")
#   sox.add "ECTSPNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 14, "repeat:3:14")
#   sox.add "EMNNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 16, "repeat:3:14")
#   sox.add "EMNDRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 17, "repeat:3:14")
#   sox.add "EMNNDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 22, "repeat:3:14")
#   sox.add "E_TTUNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 24, "repeat:3:14")
#   sox.add "EWTNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 25, "repeat:3:14")
#   sox.add "ERTNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 26, "repeat:3:14")
#   sox.add "ERTFDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 28, "repeat:3:14")
#   sox.add "ERTCLNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 29, "repeat:3:14")
#   sox.add "ERTGMNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 31, "repeat:3:14")
#   sox.add "E_TUNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 32, "repeat:3:14")
#   sox.add "ETWTANS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 33, "repeat:3:14")
#   sox.add "EIFNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 35, "repeat:3:14")
#   sox.add "EIFTCNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 36, "repeat:3:14")
#   sox.add "E_FIRNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 38, "repeat:3:14")
#   sox.add "EFINS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 39, "repeat:3:14")
#   sox.add "E_PBSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 41, "repeat:3:14")
#   sox.add "EPSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 42, "repeat:3:14")
#   sox.add "EADNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 44, "repeat:3:14")
#   sox.add "E_EDHCNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 46, "repeat:3:14")
#   sox.add "EEDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 47, "repeat:3:14")
#   sox.add "EHCNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 48, "repeat:3:14")
#   sox.add "E_LHNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 50, "repeat:3:14")
#   sox.add "EAENS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 51, "repeat:3:14")
#   sox.add "EAFNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 55, "repeat:3:14")
#   sox.add "EOSNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 57, "repeat:3:14")
#   sox.add "EGVNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 59, "repeat:3:14")
#   sox.add "EGVFDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 60, "repeat:3:14")
#   sox.add "EGVFDDDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 61, "repeat:3:14")
#   sox.add "EGVSTNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 62, "repeat:3:14")
#   sox.add "EGVSTEDNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 63, "repeat:3:14")
#   sox.add "EGVLCNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 64, "repeat:3:14")
#   sox.add "EAGNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 66, "repeat:3:14")
#   sox.add "E_NFNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 7, "repeat:3:14")
#   sox.add "E_PRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 11, "repeat:3:14")
#   sox.add "ECTNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 13, "repeat:3:14")
#   sox.add "ECTSPNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 14, "repeat:3:14")
#   sox.add "EMNNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 16, "repeat:3:14")
#   sox.add "EMNDRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 17, "repeat:3:14")
#   sox.add "EMNNDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 18, "repeat:3:14")
#   sox.add "E_SVCPRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 20, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 22, "repeat:3:14")
#   sox.add "E_TTUNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 24, "repeat:3:14")
#   sox.add "EWTNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 25, "repeat:3:14")
#   sox.add "ERTNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 26, "repeat:3:14")
#   sox.add "ERTFDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 27, "repeat:3:14")
#   sox.add "ERTFDGSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 28, "repeat:3:14")
#   sox.add "ERTCLNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 29, "repeat:3:14")
#   sox.add "ERTGMNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 30, "repeat:3:14")
#   sox.add "ERTGMDSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 31, "repeat:3:14")
#   sox.add "E_TUNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 32, "repeat:3:14")
#   sox.add "ETWTANS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 33, "repeat:3:14")
#   sox.add "EIFNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 35, "repeat:3:14")
#   sox.add "EIFTCNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 36, "repeat:3:14")
#   sox.add "E_FIRNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 38, "repeat:3:14")
#   sox.add "EFINS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 39, "repeat:3:14")
#   sox.add "E_PBSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 41, "repeat:3:14")
#   sox.add "EPSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 42, "repeat:3:14")
#   sox.add "EADNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 44, "repeat:3:14")
#   sox.add "E_EDHCNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 46, "repeat:3:14")
#   sox.add "EEDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 47, "repeat:3:14")
#   sox.add "EHCNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 48, "repeat:3:14")
#   sox.add "E_LHNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 50, "repeat:3:14")
#   sox.add "EAENS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 51, "repeat:3:14")
#   sox.add "EAFNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 55, "repeat:3:14")
#   sox.add "EOSNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 57, "repeat:3:14")
#   sox.add "EGVNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 59, "repeat:3:14")
#   sox.add "EGVFDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 60, "repeat:3:14")
#   sox.add "EGVFDDDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 61, "repeat:3:14")
#   sox.add "EGVSTNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 62, "repeat:3:14")
#   sox.add "EGVSTEDNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 63, "repeat:3:14")
#   sox.add "EGVLCNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 64, "repeat:3:14")
#   sox.add "EAGNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 66, "repeat:3:14")
# #  sox.add "#E_GVSLNS@HAW.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@KAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@MAU.M",         Series.load_pattern("2001-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# 
#   sox.add "E_NFNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 7, "repeat:3:14")
#   sox.add "E_PRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 9, "repeat:3:14")
#   sox.add "E_GDSPRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 11, "repeat:3:14")
#   sox.add "ECTNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 13, "repeat:3:14")
#   sox.add "ECTBLNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 14, "repeat:3:14")
#   sox.add "ECTSPNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 15, "repeat:3:14")
#   sox.add "EMNNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 17, "repeat:3:14")
#   sox.add "EMNDRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 18, "repeat:3:14")
#   sox.add "EMNNDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 22, "repeat:3:14")
#   sox.add "E_TTUNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 25, "repeat:3:14")
#   sox.add "EWTNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 26, "repeat:3:14")
#   sox.add "ERTNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 27, "repeat:3:14")
#   sox.add "ERTFDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 29, "repeat:3:14")
#   sox.add "ERTCLNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 30, "repeat:3:14")
#   sox.add "ERTGMNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 32, "repeat:3:14")
#   sox.add "E_TUNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 33, "repeat:3:14")
#   sox.add "EUTNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 34, "repeat:3:14")
#   sox.add "ETWNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 35, "repeat:3:14")
#   sox.add "ETWTANS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 36, "repeat:3:14")
#   sox.add "EIFNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 38, "repeat:3:14")
#   sox.add "EIFTCNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 39, "repeat:3:14")
#   sox.add "E_FIRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 41, "repeat:3:14")
#   sox.add "EFINS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 42, "repeat:3:14")
#   sox.add "ERENS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 43, "repeat:3:14")
#   sox.add "E_PBSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 45, "repeat:3:14")
#   sox.add "EPSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 46, "repeat:3:14")
#   sox.add "EMANS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 47, "repeat:3:14")
#   sox.add "EADNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 49, "repeat:3:14")
#   sox.add "EADESNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 50, "repeat:3:14")
#   sox.add "E_EDHCNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 52, "repeat:3:14")
#   sox.add "EEDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 53, "repeat:3:14")
#   sox.add "EED12NS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 54, "repeat:3:14")
#   sox.add "EHCNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 55, "repeat:3:14")
#   sox.add "EHCAMNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 56, "repeat:3:14")
#   sox.add "EHCHONS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 57, "repeat:3:14")
#   sox.add "EHCNRNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 58, "repeat:3:14")
#   sox.add "EHCSONS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 59, "repeat:3:14")
#   sox.add "EHCSOIFNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 60, "repeat:3:14")
#   sox.add "E_LHNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 62, "repeat:3:14")
#   sox.add "EAENS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 63, "repeat:3:14")
#   sox.add "EAFNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 64, "repeat:3:14")
#   sox.add "EAFACNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 65, "repeat:3:14")
#   sox.add "EAFFDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 66, "repeat:3:14")
#   sox.add "EAFFDRSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 67, "repeat:3:14")
#   sox.add "EOSNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 69, "repeat:3:14")
#   sox.add "EGVNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 71, "repeat:3:14")
#   sox.add "EGVFDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 72, "repeat:3:14")
#   sox.add "EGVFDDDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 73, "repeat:3:14")
#   sox.add "EGVSTNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 74, "repeat:3:14")
#   sox.add "EGVSTEDNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 75, "repeat:3:14")
#   sox.add "EGVLCNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 76, "repeat:3:14")
#   sox.add "EAGNS@HI.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "State", 78, "repeat:3:14")
#   sox.add "E_NFNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 8, "repeat:3:14")
#   sox.add "E_PRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 10, "repeat:3:14")
#   sox.add "E_GDSPRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 12, "repeat:3:14")
#   sox.add "ECTNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 14, "repeat:3:14")
#   sox.add "ECTSPNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 15, "repeat:3:14")
#   sox.add "EMNNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 17, "repeat:3:14")
#   sox.add "EMNDRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 18, "repeat:3:14")
#   sox.add "EMNNDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 23, "repeat:3:14")
#   sox.add "E_TTUNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 25, "repeat:3:14")
#   sox.add "EWTNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 26, "repeat:3:14")
#   sox.add "ERTNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 27, "repeat:3:14")
#   sox.add "ERTFDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 29, "repeat:3:14")
#   sox.add "ERTCLNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 30, "repeat:3:14")
#   sox.add "ERTGMNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 32, "repeat:3:14")
#   sox.add "E_TUNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 33, "repeat:3:14")
#   sox.add "ETWNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 34, "repeat:3:14")
#   sox.add "ETWTANS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 35, "repeat:3:14")
#   sox.add "EIFNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 37, "repeat:3:14")
#   sox.add "EIFTCNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 38, "repeat:3:14")
#   sox.add "E_FIRNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 40, "repeat:3:14")
#   sox.add "EFINS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 41, "repeat:3:14")
#   sox.add "ERENS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 42, "repeat:3:14")
#   sox.add "E_PBSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 44, "repeat:3:14")
#   sox.add "EPSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 45, "repeat:3:14")
#   sox.add "EMANS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 46, "repeat:3:14")
#   sox.add "EADNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 48, "repeat:3:14")
#   sox.add "EADESNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 49, "repeat:3:14")
#   sox.add "E_EDHCNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 51, "repeat:3:14")
#   sox.add "EEDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 52, "repeat:3:14")
#   sox.add "EED12NS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 53, "repeat:3:14")
#   sox.add "EHCNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 54, "repeat:3:14")
#   sox.add "EHCAMNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 55, "repeat:3:14")
#   sox.add "EHCHONS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 56, "repeat:3:14")
#   sox.add "E_LHNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 58, "repeat:3:14")
#   sox.add "EAFNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 59, "repeat:3:14")
#   sox.add "EAFACNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 60, "repeat:3:14")
#   sox.add "EAFFDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 61, "repeat:3:14")
#   sox.add "EAFFDRSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 62, "repeat:3:14")
#   sox.add "EOSNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 64, "repeat:3:14")
#   sox.add "EGVNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 66, "repeat:3:14")
#   sox.add "EGVFDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 67, "repeat:3:14")
#   sox.add "EGVFDDDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 68, "repeat:3:14")
#   sox.add "EGVFDSPNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 69, "repeat:3:14")
#   sox.add "EGVSTNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 70, "repeat:3:14")
#   sox.add "EGVSTEDNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 71, "repeat:3:14")
#   sox.add "EGVLCNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 72, "repeat:3:14")
#   sox.add "EAGNS@HON.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Oahu", 74, "repeat:3:14")
#   sox.add "E_NFNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 8, "repeat:3:14")
#   sox.add "E_PRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 10, "repeat:3:14")
#   sox.add "E_GDSPRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 12, "repeat:3:14")
#   sox.add "ECTNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 14, "repeat:3:14")
#   sox.add "ECTSPNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 15, "repeat:3:14")
#   sox.add "EMNNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 17, "repeat:3:14")
#   sox.add "EMNDRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 18, "repeat:3:14")
#   sox.add "EMNNDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 23, "repeat:3:14")
#   sox.add "E_TTUNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 25, "repeat:3:14")
#   sox.add "EWTNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 26, "repeat:3:14")
#   sox.add "ERTNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 27, "repeat:3:14")
#   sox.add "ERTFDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 29, "repeat:3:14")
#   sox.add "ERTCLNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 30, "repeat:3:14")
#   sox.add "ERTGMNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 32, "repeat:3:14")
#   sox.add "E_TUNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 33, "repeat:3:14")
#   sox.add "ETWTANS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 34, "repeat:3:14")
#   sox.add "EIFNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 36, "repeat:3:14")
#   sox.add "EIFTCNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 37, "repeat:3:14")
#   sox.add "E_FIRNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 39, "repeat:3:14")
#   sox.add "EFINS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 40, "repeat:3:14")
#   sox.add "E_PBSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 42, "repeat:3:14")
#   sox.add "EPSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 43, "repeat:3:14")
#   sox.add "EADNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 45, "repeat:3:14")
#   sox.add "E_EDHCNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 47, "repeat:3:14")
#   sox.add "EEDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 48, "repeat:3:14")
#   sox.add "EHCNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 49, "repeat:3:14")
#   sox.add "E_LHNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 51, "repeat:3:14")
#   sox.add "EAFNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 55, "repeat:3:14")
#   sox.add "EOSNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 58, "repeat:3:14")
#   sox.add "EGVNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 60, "repeat:3:14")
#   sox.add "EGVFDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 61, "repeat:3:14")
#   sox.add "EGVFDDDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 62, "repeat:3:14")
#   sox.add "EGVSTNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 63, "repeat:3:14")
#   sox.add "EGVSTEDNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 64, "repeat:3:14")
#   sox.add "EGVLCNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 65, "repeat:3:14")
#   sox.add "EAGNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Hcty", 67, "repeat:3:14")
#   sox.add "E_NFNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 8, "repeat:3:14")
#   sox.add "E_PRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 10, "repeat:3:14")
#   sox.add "E_GDSPRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 12, "repeat:3:14")
#   sox.add "ECTNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 14, "repeat:3:14")
#   sox.add "ECTSPNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 15, "repeat:3:14")
#   sox.add "EMNNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 17, "repeat:3:14")
#   sox.add "EMNDRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 18, "repeat:3:14")
#   sox.add "EMNNDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 23, "repeat:3:14")
#   sox.add "E_TTUNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 25, "repeat:3:14")
#   sox.add "EWTNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 26, "repeat:3:14")
#   sox.add "ERTNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 27, "repeat:3:14")
#   sox.add "ERTFDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 29, "repeat:3:14")
#   sox.add "ERTCLNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 30, "repeat:3:14")
#   sox.add "ERTGMNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 32, "repeat:3:14")
#   sox.add "E_TUNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 33, "repeat:3:14")
#   sox.add "ETWTANS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 34, "repeat:3:14")
#   sox.add "EIFNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 36, "repeat:3:14")
#   sox.add "EIFTCNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 37, "repeat:3:14")
#   sox.add "E_FIRNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 39, "repeat:3:14")
#   sox.add "EFINS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 40, "repeat:3:14")
#   sox.add "E_PBSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 42, "repeat:3:14")
#   sox.add "EPSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 43, "repeat:3:14")
#   sox.add "EADNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 45, "repeat:3:14")
#   sox.add "E_EDHCNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 47, "repeat:3:14")
#   sox.add "EEDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 48, "repeat:3:14")
#   sox.add "EHCNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 49, "repeat:3:14")
#   sox.add "E_LHNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 51, "repeat:3:14")
#   sox.add "EAFNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 55, "repeat:3:14")
#   sox.add "EOSNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 58, "repeat:3:14")
#   sox.add "EGVNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 60, "repeat:3:14")
#   sox.add "EGVFDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 61, "repeat:3:14")
#   sox.add "EGVFDDDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 62, "repeat:3:14")
#   sox.add "EGVSTNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 63, "repeat:3:14")
#   sox.add "EGVSTEDNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 64, "repeat:3:14")
#   sox.add "EGVLCNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 65, "repeat:3:14")
#   sox.add "EAGNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Kcty", 67, "repeat:3:14")
#   sox.add "E_NFNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 8, "repeat:3:14")
#   sox.add "E_PRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 10, "repeat:3:14")
#   sox.add "E_GDSPRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 12, "repeat:3:14")
#   sox.add "ECTNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 14, "repeat:3:14")
#   sox.add "ECTSPNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 15, "repeat:3:14")
#   sox.add "EMNNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 17, "repeat:3:14")
#   sox.add "EMNDRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 18, "repeat:3:14")
#   sox.add "EMNNDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 19, "repeat:3:14")
#   sox.add "E_SVCPRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 21, "repeat:3:14")
#   sox.add "E_PRSVCPRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 23, "repeat:3:14")
#   sox.add "E_TTUNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 25, "repeat:3:14")
#   sox.add "EWTNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 26, "repeat:3:14")
#   sox.add "ERTNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 27, "repeat:3:14")
#   sox.add "ERTFDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 28, "repeat:3:14")
#   sox.add "ERTFDGSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 29, "repeat:3:14")
#   sox.add "ERTCLNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 30, "repeat:3:14")
#   sox.add "ERTGMNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 31, "repeat:3:14")
#   sox.add "ERTGMDSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 32, "repeat:3:14")
#   sox.add "E_TUNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 33, "repeat:3:14")
#   sox.add "ETWTANS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 34, "repeat:3:14")
#   sox.add "EIFNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 36, "repeat:3:14")
#   sox.add "EIFTCNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 37, "repeat:3:14")
#   sox.add "E_FIRNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 39, "repeat:3:14")
#   sox.add "EFINS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 40, "repeat:3:14")
#   sox.add "E_PBSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 42, "repeat:3:14")
#   sox.add "EPSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 43, "repeat:3:14")
#   sox.add "EADNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 45, "repeat:3:14")
#   sox.add "E_EDHCNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 47, "repeat:3:14")
#   sox.add "EEDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 48, "repeat:3:14")
#   sox.add "EHCNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 49, "repeat:3:14")
#   sox.add "E_LHNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 51, "repeat:3:14")
#   sox.add "EAFNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 52, "repeat:3:14")
#   sox.add "EAFACNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 53, "repeat:3:14")
#   sox.add "EAFFDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 54, "repeat:3:14")
#   sox.add "EAFFDRSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 55, "repeat:3:14")
#   sox.add "EOSNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 58, "repeat:3:14")
#   sox.add "EGVNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 60, "repeat:3:14")
#   sox.add "EGVFDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 61, "repeat:3:14")
#   sox.add "EGVFDDDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 62, "repeat:3:14")
#   sox.add "EGVSTNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 63, "repeat:3:14")
#   sox.add "EGVSTEDNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 64, "repeat:3:14")
#   sox.add "EGVLCNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 65, "repeat:3:14")
#   sox.add "EAGNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "Mcty", 67, "repeat:3:14")
# #  sox.add "#E_GVSLNS@HAW.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@KAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# #  sox.add "#E_GVSLNS@MAU.M",         Series.load_pattern("2000-01-01", "M",  "BLS_HIWI%Y.XLS", "#N/A Calc", #N/A Calc, "#N/A Calc")
# 
#   
#  #   sox.add "PICTSGFNS@US.M",       Series.load_pattern("1964-01-01", "M", pathPICT, "fixed", "block:9:1:12", "repeat_with_step:7:29:2")
#     sox.write_xls
#     NotificationMailer.deliver_new_download_notification "Monthly HIWI Employment (rake HIWI_upd_m)", sox.output_summary
#   end
# end
