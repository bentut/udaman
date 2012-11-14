task :reload_aremos => :environment do
  #evenaully move this to a standalone task
  CSV.open("public/rake_time.csv", "wb") {|csv| csv << ["name", "duration", "start", "end"] }
  
  #this currently runs in 5 minutes even with the complete delete
  AremosSeries.delete_all
   t = Time.now
  AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/A_DATA.TSD")
  at = Time.now
  AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/S_DATA.TSD")
  st = Time.now
  AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/Q_DATA.TSD")
  qt = Time.now 
  AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/M_DATA.TSD")
  mt = Time.now
   AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/W_DATA.TSD")
   wt = Time.now
   AremosSeries.load_tsd("/Volumes/UHEROwork/data/EXPORT/D_DATA.TSD")
   dt = Time.now
   
  puts "#{"%.2f" % (dt - t)} | to write all"
  puts "#{"%.2f" % (dt-wt)} | days"
  puts "#{"%.2f" % (wt-mt)} | weeks"
  puts "#{"%.2f" % (mt-qt)} | months"
  puts "#{"%.2f" % (qt-st)} | quarters"
  puts "#{"%.2f" % (st-at)} | half-years"
  puts "#{"%.2f" % (at-t)} | years"
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["reload_aremos", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end



task :load_all_v_series => :environment do

  # possible sequence
  #VISRES?
  #VDAY
  #VIS These come from :visitor_series task
  
  # VLOS
  # VSO
  # VDAY
  # VRL
  # VISCRAIR
  # VDAYCRAIR
  # VDAYCRB
  # VEXPPT
  # 
  # MORE VLOS
  # MORE VEXP
  # MOR VISDM
  # VLOSIT
  # MORE VLOS
  # MORE VDAY
  # MORE VEXP
  # MORE VISUS
  # MORE VRLS
  # MORE VISRES
  
  
  
  
  ["HON", "KAU", "MAUI", "MOL", "LAN", "HAW"].each do |cnty| #note MAU is not included here. totally separate calculations
    #{circular reference}"VRLSDMNS@#{cnty}.M".ts_eval= %Q|"VDAYDMNS@#{cnty}.M".ts / "VISDMNS@#{cnty}.M".ts|
    #{another circular reference}"VRLSITNS@#{cnty}.M".ts_eval= %Q|"VDAYITNS@#{cnty}.M".ts / "VISITNS@#{cnty}.M".ts| This breaks it
    "VRLSITNS@#{cnty}.M".ts_eval= %Q|"VDAYITNS@#{cnty}.M".ts / "VISITNS@#{cnty}.M".ts|
    "VRLSUSWNS@#{cnty}.M".ts_eval= %Q|"VDAYUSWNS@#{cnty}.M".ts / "VISUSWNS@#{cnty}.M".ts|
    "VRLSUSENS@#{cnty}.M".ts_eval= %Q|"VDAYUSENS@#{cnty}.M".ts / "VISUSENS@#{cnty}.M".ts|
    "VRLSJPNS@#{cnty}.M".ts_eval= %Q|"VDAYJPNS@#{cnty}.M".ts / "VISJPNS@#{cnty}.M".ts|
    "VRLSCANNS@#{cnty}.M".ts_eval= %Q|"VDAYCANNS@#{cnty}.M".ts / "VISCANNS@#{cnty}.M".ts|
  end
  
  "VRLSCANNS@MAU.M".ts_eval= %Q|("VRLSCANNS@MAUI.M".ts * "VISCANNS@MAUI.M".ts + "VRLSCANNS@MOL.M".ts * "VISCANNS@MOL.M".ts + "VRLSCANNS@LAN.M".ts * "VISCANNS@LAN.M".ts) / "VISCANNS@MAU.M".ts|
  
  #from task vlos requires vdayNSs and visNSs and vrlsNSs
  ["CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
      "VLOS#{serlist}NS@#{cnty}.M".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.M".ts / "VIS#{serlist}NS@#{cnty}.M".ts|
    end
  end
end


task :daily_history_load => :environment do
  t = Time.now
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/AgricultureForNewDB.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/Kauai.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/permits_upd.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICDATA1.xls" #creates diffs, SIC History might be better
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICDATA2.xls" #creates diffs for LFNS, WH, WWs etc
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICHistory.xls" #this might fix the two above. NO DIFFS
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/hiwi_hist.xls"

  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_HAW.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_HI.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_HON.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_MAU.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_KAU.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_A_NBI.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_Q.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "hon" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "haw" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "mau" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "kau" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "hi"

  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_CNTY_a.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_CNTY_m.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_CNTY_q.xls" 
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HI_a.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HI_m.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HI_q.xls" 
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HON_a.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HON_m.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/esic_HON_q.xls" 
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls" #diffs starting in 2011
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls" #diffs mostly in 2011, some in 2010. runs fast
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd3_hist.xls" #diffs starting in 2011, some in 2012 also runs fast
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_histextend_date_format_correct.xls" #Diffs for EMPLNS@HI, EMPLSA@HI, EOSNS@HON, LFNS@HI, LFSA@HI, URSA@HI, WWAFFDNS@HI, WHAFFDNS@HI, EGVNS@HON and EAFFDNS@HON (but could be from other things)
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/const_hist_m.xls" #one big diff KPPRVNR... couls be something else... not sure which is correct?
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/pc_upd_hist.xls" #2012 diffs. could probably just revisions. This one is amazingly up to date. Jimmy must be updating
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/jp_upd_a.xls" #removed the sections that get overwritten by FRED data
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/jp_upd_q.xls" #removed the sections that get overwritten by FRED data
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/jp_upd_m.xls" #removed the sections that get overwritten by FRED data
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/vexp_upd.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/seats_upd_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/vday_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/const_hist_q.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/const_hist_a.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/jp_m_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_histextend_date_format_correct.xls", "hiwi" #some diffs, but could be something else
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/vx_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/TGBCT_hist.xls"
  
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tax_hist_new.xls", "ge" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tax_hist_new.xls", "collec" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_sic_detail.xls" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_cpi_int_m.XLS" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HI_Q" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HI" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HON" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HAW" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "MAU" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "KAU" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SQ5NHistory.xls" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/gsp_hist.xls" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_job_hist.xls" #moved up from below
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["daily_history_load", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
  
  # ---------------------------------------------------------
end

task :load_all_histories => :environment do
  # Added after inspecting current, but not updated sources
  # these are slower than doing cached versions, I think
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/AgricultureForNewDB.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/Kauai.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/permits_upd.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICDATA1.xls" #creates diffs, SIC History might be better
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICDATA2.xls" #creates diffs for LFNS, WH, WWs etc
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SICHistory.xls" #this might fix the two above. NO DIFFS
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/hiwi_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "hon" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "haw" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "mau" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "kau" 
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SIC_income.xls", "hi"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls" #diffs starting in 2011
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls" #diffs mostly in 2011, some in 2010. runs fast
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd3_hist.xls" #diffs starting in 2011, some in 2012 also runs fast
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_histextend_date_format_correct.xls" #Diffs for EMPLNS@HI, EMPLSA@HI, EOSNS@HON, LFNS@HI, LFSA@HI, URSA@HI, WWAFFDNS@HI, WHAFFDNS@HI, EGVNS@HON and EAFFDNS@HON (but could be from other things)
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/const_hist_m.xls" #one big diff KPPRVNR... couls be something else... not sure which is correct?
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/pc_upd_hist.xls" #2012 diffs. could probably just revisions. This one is amazingly up to date. Jimmy must be updating
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tax_hist_new.xls", "ge" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/tax_hist_new.xls", "collec" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_sic_detail.xls" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_cpi_int_m.XLS" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HI_Q" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HI" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HON" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "HAW" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "MAU" #moved up from below
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", "KAU" #moved up from below
  
  # ---------------------------------------------------------
  

  
  #not all of these are matching
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls"
  #-----------------------------
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/SQ5NHistory.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/gsp_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/bls_job_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/prud_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/prud_upd.xls" #also manual? not sure if we need both, or one one screws up the other?
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/hiwi_hist.xls"
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/History/v_day.xls"
  
  Series.load_all_series_from "/Volumes/UHEROwork/data/rawdata/Manual/TOUR_OCUP.xls"

    
  #seasonal adjustments
  "VDAYIT@HI.M".ts_eval= %Q|"VDAYIT@HI.M".ts.apply_seasonal_adjustment :additive|
  #"VDAYUS@HI.M".ts.apply_seasonal_adjustment :additive 
  
end

# fixed a problem with the semi-annual reads
# DataSource.where("eval LIKE '%load_from_bls%\"S\"%'").each do |ds|
# dsd=ds
# ds.delete
# eval("\"#{dsd.eval.split("\"")[1]}\".ts_eval=%Q|#{dsd.eval}|")
# end


# DataSource.where("eval LIKE '%load_from_bls%'").each do |ds|
#   puts "\"#{ds.eval.split("\"")[1]}\".ts_eval=%Q|#{ds.eval}|" 
# end


# task :us_from_bls => :environment do
#   
#   sox.add_data "E_NF@US.M", DataHtmlParser.new.get_bls_series("CES0000000001", "M")
#   sox.add_data "E_NFNS@US.M", DataHtmlParser.new.get_bls_series("CEU0000000001", "M")
#   sox.add_data "E_PR@US.M", DataHtmlParser.new.get_bls_series("CES0500000001", "M")
#   sox.add_data "E_PRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0500000001", "M")
#   sox.add_data "E_GDSPR@US.M", DataHtmlParser.new.get_bls_series("CES0600000001", "M")
#   sox.add_data "E_GDSPRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0600000001", "M")
#   sox.add_data "E_SVCPR@US.M", DataHtmlParser.new.get_bls_series("CES0700000001", "M")
#   sox.add_data "E_SVCPRNS@US.M", DataHtmlParser.new.get_bls_series("CEU0700000001", "M")
#   sox.add_data "EMI@US.M", DataHtmlParser.new.get_bls_series("CES1000000001", "M")
#   sox.add_data "EMINS@US.M", DataHtmlParser.new.get_bls_series("CEU1000000001", "M")
#   sox.add_data "ECT@US.M", DataHtmlParser.new.get_bls_series("CES2000000001", "M")
#   sox.add_data "ECTNS@US.M", DataHtmlParser.new.get_bls_series("CEU2000000001", "M")
#   sox.add_data "EMN@US.M", DataHtmlParser.new.get_bls_series("CES3000000001", "M")
#   sox.add_data "EMNNS@US.M", DataHtmlParser.new.get_bls_series("CEU3000000001", "M")
#   sox.add_data "EMNDR@US.M", DataHtmlParser.new.get_bls_series("CES3100000001", "M")
#   sox.add_data "EMNDRNS@US.M", DataHtmlParser.new.get_bls_series("CEU3100000001", "M")
#   sox.add_data "EMNND@US.M", DataHtmlParser.new.get_bls_series("CES3200000001", "M")
#   sox.add_data "EMNNDNS@US.M", DataHtmlParser.new.get_bls_series("CEU3200000001", "M")
#   sox.add_data "E_TTU@US.M", DataHtmlParser.new.get_bls_series("CES4000000001", "M")
#   sox.add_data "E_TTUNS@US.M", DataHtmlParser.new.get_bls_series("CEU4000000001", "M")
#   sox.add_data "EWT@US.M", DataHtmlParser.new.get_bls_series("CES4142000001", "M")
#   sox.add_data "EWTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4142000001", "M")
#   sox.add_data "ERT@US.M", DataHtmlParser.new.get_bls_series("CES4200000001", "M")
#   sox.add_data "ERTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4200000001", "M")
#   sox.add_data "ETW@US.M", DataHtmlParser.new.get_bls_series("CES4300000001", "M")
#   sox.add_data "ETWNS@US.M", DataHtmlParser.new.get_bls_series("CEU4300000001", "M")
#   sox.add_data "EUT@US.M", DataHtmlParser.new.get_bls_series("CES4422000001", "M")
#   sox.add_data "EUTNS@US.M", DataHtmlParser.new.get_bls_series("CEU4422000001", "M")
#   sox.add_data "EIF@US.M", DataHtmlParser.new.get_bls_series("CES5000000001", "M")
#   sox.add_data "EIFNS@US.M", DataHtmlParser.new.get_bls_series("CEU5000000001", "M")
#   sox.add_data "E_FIR@US.M", DataHtmlParser.new.get_bls_series("CES5500000001", "M")
#   sox.add_data "E_FIRNS@US.M", DataHtmlParser.new.get_bls_series("CEU5500000001", "M")
#   sox.add_data "EFI@US.M", DataHtmlParser.new.get_bls_series("CES5552000001", "M")
#   sox.add_data "EFINS@US.M", DataHtmlParser.new.get_bls_series("CEU5552000001", "M")
#   sox.add_data "ERE@US.M", DataHtmlParser.new.get_bls_series("CES5553000001", "M")
#   sox.add_data "ERENS@US.M", DataHtmlParser.new.get_bls_series("CEU5553000001", "M")
#   sox.add_data "E_PBS@US.M", DataHtmlParser.new.get_bls_series("CES6000000001", "M")
#   sox.add_data "E_PBSNS@US.M", DataHtmlParser.new.get_bls_series("CEU6000000001", "M")
#   sox.add_data "EPS@US.M", DataHtmlParser.new.get_bls_series("CES6054000001", "M")
#   sox.add_data "EPSNS@US.M", DataHtmlParser.new.get_bls_series("CEU6054000001", "M")
#   sox.add_data "EMA@US.M", DataHtmlParser.new.get_bls_series("CES6055000001", "M")
#   sox.add_data "EMANS@US.M", DataHtmlParser.new.get_bls_series("CEU6055000001", "M")
#   sox.add_data "EAD@US.M", DataHtmlParser.new.get_bls_series("CES6056000001", "M")
#   sox.add_data "EADNS@US.M", DataHtmlParser.new.get_bls_series("CEU6056000001", "M")
#   sox.add_data "E_EDHC@US.M", DataHtmlParser.new.get_bls_series("CES6500000001", "M")
#   sox.add_data "E_EDHCNS@US.M", DataHtmlParser.new.get_bls_series("CEU6500000001", "M")
#   sox.add_data "EED@US.M", DataHtmlParser.new.get_bls_series("CES6561000001", "M")
#   sox.add_data "EEDNS@US.M", DataHtmlParser.new.get_bls_series("CEU6561000001", "M")
#   sox.add_data "EHC@US.M", DataHtmlParser.new.get_bls_series("CES6562000001", "M")
#   sox.add_data "EHCNS@US.M", DataHtmlParser.new.get_bls_series("CEU6562000001", "M")
#   sox.add_data "E_LH@US.M", DataHtmlParser.new.get_bls_series("CES7000000001", "M")
#   sox.add_data "E_LHNS@US.M", DataHtmlParser.new.get_bls_series("CEU7000000001", "M")
#   sox.add_data "EAE@US.M", DataHtmlParser.new.get_bls_series("CES7071000001", "M")
#   sox.add_data "EAENS@US.M", DataHtmlParser.new.get_bls_series("CEU7071000001", "M")
#   sox.add_data "EAF@US.M", DataHtmlParser.new.get_bls_series("CES7072000001", "M")
#   sox.add_data "EAFNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072000001", "M")
#   sox.add_data "EAFAC@US.M", DataHtmlParser.new.get_bls_series("CES7072100001", "M")
#   sox.add_data "EAFACNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072100001", "M")
#   sox.add_data "EAFFD@US.M", DataHtmlParser.new.get_bls_series("CES7072200001", "M")
#   sox.add_data "EAFFDNS@US.M", DataHtmlParser.new.get_bls_series("CEU7072200001", "M")
#   sox.add_data "EOS@US.M", DataHtmlParser.new.get_bls_series("CES8000000001", "M")
#   sox.add_data "EOSNS@US.M", DataHtmlParser.new.get_bls_series("CEU8000000001", "M")
#   sox.add_data "EGV@US.M", DataHtmlParser.new.get_bls_series("CES9000000001", "M")
#   sox.add_data "EGVNS@US.M", DataHtmlParser.new.get_bls_series("CEU9000000001", "M")
#   sox.add_data "EGVFD@US.M", DataHtmlParser.new.get_bls_series("CES9091000001", "M")
#   sox.add_data "EGVFDNS@US.M", DataHtmlParser.new.get_bls_series("CEU9091000001", "M")
#   sox.add_data "EGVST@US.M", DataHtmlParser.new.get_bls_series("CES9092000001", "M")
#   sox.add_data "EGVSTNS@US.M", DataHtmlParser.new.get_bls_series("CEU9092000001", "M")
#   sox.add_data "EGVLC@US.M", DataHtmlParser.new.get_bls_series("CES9093000001", "M")
#   sox.add_data "EGVLCNS@US.M", DataHtmlParser.new.get_bls_series("CEU9093000001", "M")
#   
#   sox.add_data "LF@US.M", DataHtmlParser.new.get_bls_series("LNS11000000", "M")
#   sox.add_data "LFNS@US.M", DataHtmlParser.new.get_bls_series("LNU01000000", "M")
#   sox.add_data "EMPL@US.M", DataHtmlParser.new.get_bls_series("LNS12000000", "M")
#   sox.add_data "EMPLNS@US.M", DataHtmlParser.new.get_bls_series("LNU02000000", "M")
#   sox.add_data "UR@US.M", DataHtmlParser.new.get_bls_series("LNS14000000", "M")
#   sox.add_data "URNS@US.M", DataHtmlParser.new.get_bls_series("LNU04000000", "M")
#   
#   sox.add_data "UR@CA.M", DataHtmlParser.new.get_bls_series("LASST06000003", "M")
#   sox.add_data "EMPL@CA.M", DataHtmlParser.new.get_bls_series("LASST06000005", "M")
#   sox.add_data "LF@CA.M", DataHtmlParser.new.get_bls_series("LASST06000006", "M")
#   sox.add_data "URNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000003", "M")
#   sox.add_data "EMPLNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000005", "M")
#   sox.add_data "LFNS@CA.M", DataHtmlParser.new.get_bls_series("LAUST06000006", "M")
#   sox.add_data "ENF@CA.M", DataHtmlParser.new.get_bls_series("SMS06000000000000001", "M")
#   sox.add_data "ENFNS@CA.M", DataHtmlParser.new.get_bls_series("SMU06000000000000001", "M")
#   
#   sox.add_data "CPI@US.M", DataHtmlParser.new.get_bls_series("CUSR0000SA0", "M")
#   sox.add_data "CPINS@US.M", DataHtmlParser.new.get_bls_series("CUUR0000SA0", "M")
#   sox.add_data "CPICORE@US.M", DataHtmlParser.new.get_bls_series("CUSR0000SA0L1E", "M")
#   sox.add_data "CPICORENS@US.M", DataHtmlParser.new.get_bls_series("CUUR0000SA0L1E", "M")
# end

task :bls_web_series => :environment do
  "PC@HON.M".ts_eval=%Q|"PC@HON.M".tsn.load_from_bls("CUURA426SA0", "M")|
  "PCFB@HON.M".ts_eval=%Q|"PCFB@HON.M".tsn.load_from_bls("CUURA426SAF", "M")|
  "PCFBFD@HON.M".ts_eval=%Q|"PCFBFD@HON.M".tsn.load_from_bls("CUURA426SAF1", "M")|
  "PCFBFDHM@HON.M".ts_eval=%Q|"PCFBFDHM@HON.M".tsn.load_from_bls("CUURA426SAF11", "M")|
  "PCFBFDAW@HON.M".ts_eval=%Q|"PCFBFDAW@HON.M".tsn.load_from_bls("CUURA426SEFV", "M")|
  "PCFBFDBV@HON.M".ts_eval=%Q|"PCFBFDBV@HON.M".tsn.load_from_bls("CUURA426SAF116", "M")|
  "PCHS@HON.M".ts_eval=%Q|"PCHS@HON.M".tsn.load_from_bls("CUURA426SAH", "M")|
  "PCHSSH@HON.M".ts_eval=%Q|"PCHSSH@HON.M".tsn.load_from_bls("CUURA426SAH1", "M")|
  "PCHSSHRT@HON.M".ts_eval=%Q|"PCHSSHRT@HON.M".tsn.load_from_bls("CUURA426SEHA", "M")|
  "PCHSSHOW@HON.M".ts_eval=%Q|"PCHSSHOW@HON.M".tsn.load_from_bls("CUURA426SEHC", "M")|
  "PCHSFU@HON.M".ts_eval=%Q|"PCHSFU@HON.M".tsn.load_from_bls("CUURA426SAH2", "M")|
  "PCHSFUEL@HON.M".ts_eval=%Q|"PCHSFUEL@HON.M".tsn.load_from_bls("CUURA426SAH21", "M")|
  "PCHSFUGS@HON.M".ts_eval=%Q|"PCHSFUGS@HON.M".tsn.load_from_bls("CUURA426SEHF", "M")|
  "PCHSFUGSE@HON.M".ts_eval=%Q|"PCHSFUGSE@HON.M".tsn.load_from_bls("CUURA426SEHF01", "M")|
  "PCHSFUGSU@HON.M".ts_eval=%Q|"PCHSFUGSU@HON.M".tsn.load_from_bls("CUURA426SEHF02", "M")|
  "PCHSHF@HON.M".ts_eval=%Q|"PCHSHF@HON.M".tsn.load_from_bls("CUURA426SAH3", "M")|
  "PCAP@HON.M".ts_eval=%Q|"PCAP@HON.M".tsn.load_from_bls("CUURA426SAA", "M")|
  "PCTR@HON.M".ts_eval=%Q|"PCTR@HON.M".tsn.load_from_bls("CUURA426SAT", "M")|
  "PCTRPR@HON.M".ts_eval=%Q|"PCTRPR@HON.M".tsn.load_from_bls("CUURA426SAT1", "M")|
  "PCTRMF@HON.M".ts_eval=%Q|"PCTRMF@HON.M".tsn.load_from_bls("CUURA426SETB", "M")|
  "PCTRGS@HON.M".ts_eval=%Q|"PCTRGS@HON.M".tsn.load_from_bls("CUURA426SETB01", "M")|
  "PCTRGSRG@HON.M".ts_eval=%Q|"PCTRGSRG@HON.M".tsn.load_from_bls("CUURA426SS47014", "M")|

  "PCTRGSPR@HON.M".ts_eval=%Q|"PCTRGSPR@HON.M".tsn.load_from_bls("CUURA426SS47016", "M")|
  "PCMD@HON.M".ts_eval=%Q|"PCMD@HON.M".tsn.load_from_bls("CUURA426SAM", "M")|
  "PCRE@HON.M".ts_eval=%Q|"PCRE@HON.M".tsn.load_from_bls("CUURA426SAR", "M")|
  "PCED@HON.M".ts_eval=%Q|"PCED@HON.M".tsn.load_from_bls("CUURA426SAE", "M")|
  "PCOT@HON.M".ts_eval=%Q|"PCOT@HON.M".tsn.load_from_bls("CUURA426SAG", "M")|
  "PCCM@HON.M".ts_eval=%Q|"PCCM@HON.M".tsn.load_from_bls("CUURA426SAC", "M")|
  "PCCM_FD@HON.M".ts_eval=%Q|"PCCM_FD@HON.M".tsn.load_from_bls("CUURA426SACL1", "M")|
  "PCCM_FB@HON.M".ts_eval=%Q|"PCCM_FB@HON.M".tsn.load_from_bls("CUURA426SACL11", "M")|
  "PCCMND@HON.M".ts_eval=%Q|"PCCMND@HON.M".tsn.load_from_bls("CUURA426SAN", "M")|
  "PCCMND_FD@HON.M".ts_eval=%Q|"PCCMND_FD@HON.M".tsn.load_from_bls("CUURA426SANL1", "M")|
  "PCCMND_FB@HON.M".ts_eval=%Q|"PCCMND_FB@HON.M".tsn.load_from_bls("CUURA426SANL11", "M")|
  "PCCMDR@HON.M".ts_eval=%Q|"PCCMDR@HON.M".tsn.load_from_bls("CUURA426SAD", "M")|
  "PCSV@HON.M".ts_eval=%Q|"PCSV@HON.M".tsn.load_from_bls("CUURA426SAS", "M")|
  "PCSV_MD@HON.M".ts_eval=%Q|"PCSV_MD@HON.M".tsn.load_from_bls("CUURA426SASL5", "M")|
  "PCSV_RN@HON.M".ts_eval=%Q|"PCSV_RN@HON.M".tsn.load_from_bls("CUURA426SASL2RS", "M")|
  "PC_MD@HON.M".ts_eval=%Q|"PC_MD@HON.M".tsn.load_from_bls("CUURA426SA0L5", "M")|
  "PC_EN@HON.M".ts_eval=%Q|"PC_EN@HON.M".tsn.load_from_bls("CUURA426SA0LE", "M")|
  "PC_FDEN@HON.M".ts_eval=%Q|"PC_FDEN@HON.M".tsn.load_from_bls("CUURA426SA0L1E", "M")|
  "PC_SH@HON.M".ts_eval=%Q|"PC_SH@HON.M".tsn.load_from_bls("CUURA426SA0L2", "M")|
  "PCEN@HON.M".ts_eval=%Q|"PCEN@HON.M".tsn.load_from_bls("CUURA426SA0E", "M")|

  "PC@HON.S".ts_eval=%Q|"PC@HON.S".tsn.load_from_bls("CUUSA426SA0", "S")|
  "PCFB@HON.S".ts_eval=%Q|"PCFB@HON.S".tsn.load_from_bls("CUUSA426SAF", "S")|
  "PCFBFD@HON.S".ts_eval=%Q|"PCFBFD@HON.S".tsn.load_from_bls("CUUSA426SAF1", "S")|
  "PCFBFDHM@HON.S".ts_eval=%Q|"PCFBFDHM@HON.S".tsn.load_from_bls("CUUSA426SAF11", "S")|
  "PCFBFDAW@HON.S".ts_eval=%Q|"PCFBFDAW@HON.S".tsn.load_from_bls("CUUSA426SEFV", "S")|
  "PCFBFDBV@HON.S".ts_eval=%Q|"PCFBFDBV@HON.S".tsn.load_from_bls("CUUSA426SAF116", "S")|
  "PCHS@HON.S".ts_eval=%Q|"PCHS@HON.S".tsn.load_from_bls("CUUSA426SAH", "S")|
  "PCHSSH@HON.S".ts_eval=%Q|"PCHSSH@HON.S".tsn.load_from_bls("CUUSA426SAH1", "S")|
  "PCHSSHRT@HON.S".ts_eval=%Q|"PCHSSHRT@HON.S".tsn.load_from_bls("CUUSA426SEHA", "S")|
  "PCHSSHOW@HON.S".ts_eval=%Q|"PCHSSHOW@HON.S".tsn.load_from_bls("CUUSA426SEHC", "S")|
  "PCHSFU@HON.S".ts_eval=%Q|"PCHSFU@HON.S".tsn.load_from_bls("CUUSA426SAH2", "S")|
  "PCHSFUEL@HON.S".ts_eval=%Q|"PCHSFUEL@HON.S".tsn.load_from_bls("CUUSA426SAH21", "S")|
  "PCHSFUGS@HON.S".ts_eval=%Q|"PCHSFUGS@HON.S".tsn.load_from_bls("CUUSA426SEHF", "S")|
  "PCHSFUGSE@HON.S".ts_eval=%Q|"PCHSFUGSE@HON.S".tsn.load_from_bls("CUUSA426SEHF01", "S")|
  "PCHSFUGSU@HON.S".ts_eval=%Q|"PCHSFUGSU@HON.S".tsn.load_from_bls("CUUSA426SEHF02", "S")|
  "PCHSHF@HON.S".ts_eval=%Q|"PCHSHF@HON.S".tsn.load_from_bls("CUUSA426SAH3", "S")|
  "PCAP@HON.S".ts_eval=%Q|"PCAP@HON.S".tsn.load_from_bls("CUUSA426SAA", "S")|
  "PCTR@HON.S".ts_eval=%Q|"PCTR@HON.S".tsn.load_from_bls("CUUSA426SAT", "S")|
  "PCTRPR@HON.S".ts_eval=%Q|"PCTRPR@HON.S".tsn.load_from_bls("CUUSA426SAT1", "S")|
  "PCTRMF@HON.S".ts_eval=%Q|"PCTRMF@HON.S".tsn.load_from_bls("CUUSA426SETB", "S")|
  "PCTRGS@HON.S".ts_eval=%Q|"PCTRGS@HON.S".tsn.load_from_bls("CUUSA426SETB01", "S")|
  "PCTRGSRG@HON.S".ts_eval=%Q|"PCTRGSRG@HON.S".tsn.load_from_bls("CUUSA426SS47014", "S")|
  "PCTRGSMD@HON.S".ts_eval=%Q|"PCTRGSMD@HON.S".tsn.load_from_bls("CUUSA426SS47015", "S")|
  "PCTRGSPR@HON.S".ts_eval=%Q|"PCTRGSPR@HON.S".tsn.load_from_bls("CUUSA426SS47016", "S")|
  "PCMD@HON.S".ts_eval=%Q|"PCMD@HON.S".tsn.load_from_bls("CUUSA426SAM", "S")|
  "PCRE@HON.S".ts_eval=%Q|"PCRE@HON.S".tsn.load_from_bls("CUUSA426SAR", "S")|
  "PCED@HON.S".ts_eval=%Q|"PCED@HON.S".tsn.load_from_bls("CUUSA426SAE", "S")|
  "PCOT@HON.S".ts_eval=%Q|"PCOT@HON.S".tsn.load_from_bls("CUUSA426SAG", "S")|
  "PCCM@HON.S".ts_eval=%Q|"PCCM@HON.S".tsn.load_from_bls("CUUSA426SAC", "S")|
  "PCCM_FD@HON.S".ts_eval=%Q|"PCCM_FD@HON.S".tsn.load_from_bls("CUUSA426SACL1", "S")|
  "PCCM_FB@HON.S".ts_eval=%Q|"PCCM_FB@HON.S".tsn.load_from_bls("CUUSA426SACL11", "S")|
  "PCCMND@HON.S".ts_eval=%Q|"PCCMND@HON.S".tsn.load_from_bls("CUUSA426SAN", "S")|
  "PCCMND_FD@HON.S".ts_eval=%Q|"PCCMND_FD@HON.S".tsn.load_from_bls("CUUSA426SANL1", "S")|
  "PCCMND_FB@HON.S".ts_eval=%Q|"PCCMND_FB@HON.S".tsn.load_from_bls("CUUSA426SANL11", "S")|
  "PCCMDR@HON.S".ts_eval=%Q|"PCCMDR@HON.S".tsn.load_from_bls("CUUSA426SAD", "S")|
  "PCSV@HON.S".ts_eval=%Q|"PCSV@HON.S".tsn.load_from_bls("CUUSA426SAS", "S")|
  "PCSV_MD@HON.S".ts_eval=%Q|"PCSV_MD@HON.S".tsn.load_from_bls("CUUSA426SASL5", "S")|
  "PCSV_RN@HON.S".ts_eval=%Q|"PCSV_RN@HON.S".tsn.load_from_bls("CUUSA426SASL2RS", "S")|
  "PC_MD@HON.S".ts_eval=%Q|"PC_MD@HON.S".tsn.load_from_bls("CUUSA426SA0L5", "S")|
  "PC_EN@HON.S".ts_eval=%Q|"PC_EN@HON.S".tsn.load_from_bls("CUUSA426SA0LE", "S")|
  "PC_FDEN@HON.S".ts_eval=%Q|"PC_FDEN@HON.S".tsn.load_from_bls("CUUSA426SA0L1E", "S")|
  "PC_SH@HON.S".ts_eval=%Q|"PC_SH@HON.S".tsn.load_from_bls("CUUSA426SA0L2", "S")|
  "PCEN@HON.S".ts_eval=%Q|"PCEN@HON.S".tsn.load_from_bls("CUUSA426SA0E", "S")|












  "E_NFSA@HI.M".ts_eval=%Q|"E_NFSA@HI.M".tsn.load_from_bls("SMS15000000000000001", "M")|
  "ECTSA@HI.M".ts_eval=%Q|"ECTSA@HI.M".tsn.load_from_bls("SMS15000001500000001", "M")|
  "EMNSA@HI.M".ts_eval=%Q|"EMNSA@HI.M".tsn.load_from_bls("SMS15000003000000001", "M")|
  "E_TTUSA@HI.M".ts_eval=%Q|"E_TTUSA@HI.M".tsn.load_from_bls("SMS15000004000000001", "M")|
  "E_EDHCSA@HI.M".ts_eval=%Q|"E_EDHCSA@HI.M".tsn.load_from_bls("SMS15000006500000001", "M")|
  "E_LHSA@HI.M".ts_eval=%Q|"E_LHSA@HI.M".tsn.load_from_bls("SMS15000007000000001", "M")|
  "EOSSA@HI.M".ts_eval=%Q|"EOSSA@HI.M".tsn.load_from_bls("SMS15000008000000001", "M")|
  "EGVSA@HI.M".ts_eval=%Q|"EGVSA@HI.M".tsn.load_from_bls("SMS15000009000000001", "M")|

  "EWTSA@HI.M".ts_eval=%Q|"EWTSA@HI.M".tsn.load_from_bls("SMS15000004100000001", "M")|
  "ERTSA@HI.M".ts_eval=%Q|"ERTSA@HI.M".tsn.load_from_bls("SMS15000004200000001", "M")|
  "E_FIRSA@HI.M".ts_eval=%Q|"E_FIRSA@HI.M".tsn.load_from_bls("SMS15000005500000001", "M")|
  "ERESA@HI.M".ts_eval=%Q|"ERESA@HI.M".tsn.load_from_bls("SMS15000005553000001", "M")|
  "E_PBSSA@HI.M".ts_eval=%Q|"E_PBSSA@HI.M".tsn.load_from_bls("SMS15000006000000001", "M")|
  "EPSSA@HI.M".ts_eval=%Q|"EPSSA@HI.M".tsn.load_from_bls("SMS15000006054000001", "M")|
  "EEDSA@HI.M".ts_eval=%Q|"EEDSA@HI.M".tsn.load_from_bls("SMS15000006561000001", "M")|
  "EHCSA@HI.M".ts_eval=%Q|"EHCSA@HI.M".tsn.load_from_bls("SMS15000006562000001", "M")|
  "EAESA@HI.M".ts_eval=%Q|"EAESA@HI.M".tsn.load_from_bls("SMS15000007071000001", "M")|
  "EAFSA@HI.M".ts_eval=%Q|"EAFSA@HI.M".tsn.load_from_bls("SMS15000007072000001", "M")|
  "EGVFDSA@HI.M".ts_eval=%Q|"EGVFDSA@HI.M".tsn.load_from_bls("SMS15000009091000001", "M")|
  "EGVSTSA@HI.M".ts_eval=%Q|"EGVSTSA@HI.M".tsn.load_from_bls("SMS15000009092000001", "M")|
  "EGVLCSA@HI.M".ts_eval=%Q|"EGVLCSA@HI.M".tsn.load_from_bls("SMS15000009093000001", "M")|

  "EMPLSA@HI.M".ts_eval=%Q|"EMPLSA@HI.M".tsn.load_from_bls("LASST15000005", "M")|
  "EMPLNS@HI.M".ts_eval=%Q|"EMPLNS@HI.M".tsn.load_from_bls("LAUST15000005", "M")|
  "EMPLNS@HON.M".ts_eval=%Q|"EMPLNS@HON.M".tsn.load_from_bls("LAUPS15007005", "M")|
  "EMPLNS@HAW.M".ts_eval=%Q|"EMPLNS@HAW.M".tsn.load_from_bls("LAUPA15010005", "M")|
  "EMPLNS@MAU.M".ts_eval=%Q|"EMPLNS@MAU.M".tsn.load_from_bls("LAUPA15015005", "M")|
  "EMPLNS@KAU.M".ts_eval=%Q|"EMPLNS@KAU.M".tsn.load_from_bls("LAUCN15007005", "M")|
  "LFSA@HI.M".ts_eval=%Q|"LFSA@HI.M".tsn.load_from_bls("LASST15000006 ", "M")|
  "LFNS@HI.M".ts_eval=%Q|"LFNS@HI.M".tsn.load_from_bls("LAUST15000006", "M")|
  "LFNS@HON.M".ts_eval=%Q|"LFNS@HON.M".tsn.load_from_bls("LAUPS15007006", "M")|
  "LFNS@HAW.M".ts_eval=%Q|"LFNS@HAW.M".tsn.load_from_bls("LAUPA15010006", "M")|
  "LFNS@MAU.M".ts_eval=%Q|"LFNS@MAU.M".tsn.load_from_bls("LAUPA15015006", "M")|
  "LFNS@KAU.M".ts_eval=%Q|"LFNS@KAU.M".tsn.load_from_bls("LAUCN15007006", "M")|
  "URSA@HI.M".ts_eval=%Q|"URSA@HI.M".tsn.load_from_bls("LASST15000003 ", "M")|
  "URNS@HI.M".ts_eval=%Q|"URNS@HI.M".tsn.load_from_bls("LAUST15000003", "M")|
  "URNS@HON.M".ts_eval=%Q|"URNS@HON.M".tsn.load_from_bls("LAUPS15007003", "M")|
  "URNS@HAW.M".ts_eval=%Q|"URNS@HAW.M".tsn.load_from_bls("LAUPA15010003", "M")|
  "URNS@MAU.M".ts_eval=%Q|"URNS@MAU.M".tsn.load_from_bls("LAUPA15015003", "M")|
  "URNS@KAU.M".ts_eval=%Q|"URNS@KAU.M".tsn.load_from_bls("LAUCN15007003", "M")|

  "WWCTNS@HI.M".ts_eval=%Q|"WWCTNS@HI.M".tsn.load_from_bls("SMU15000001500000030", "M")|
  "WHCTNS@HI.M".ts_eval=%Q|"WHCTNS@HI.M".tsn.load_from_bls("SMU15000001500000008", "M")|
  "WWMNNS@HI.M".ts_eval=%Q|"WWMNNS@HI.M".tsn.load_from_bls("SMU15000003000000030", "M")|
  "WHMNNS@HI.M".ts_eval=%Q|"WHMNNS@HI.M".tsn.load_from_bls("SMU15000003000000008", "M")|
  "WW_TTUNS@HI.M".ts_eval=%Q|"WW_TTUNS@HI.M".tsn.load_from_bls("SMU15000004000000030", "M")|
  "WH_TTUNS@HI.M".ts_eval=%Q|"WH_TTUNS@HI.M".tsn.load_from_bls("SMU15000004000000008", "M")|
  "WWWTNS@HI.M".ts_eval=%Q|"WWWTNS@HI.M".tsn.load_from_bls("SMU15000004100000030", "M")|
  "WHWTNS@HI.M".ts_eval=%Q|"WHWTNS@HI.M".tsn.load_from_bls("SMU15000004100000008", "M")|
  "WWRTNS@HI.M".ts_eval=%Q|"WWRTNS@HI.M".tsn.load_from_bls("SMU15000004200000030", "M")|
  "WHRTNS@HI.M".ts_eval=%Q|"WHRTNS@HI.M".tsn.load_from_bls("SMU15000004200000008", "M")|
  "WWIFNS@HI.M".ts_eval=%Q|"WWIFNS@HI.M".tsn.load_from_bls("SMU15000005000000030", "M")|
  "WHIFNS@HI.M".ts_eval=%Q|"WHIFNS@HI.M".tsn.load_from_bls("SMU15000005000000008", "M")|
  "WW_FINNS@HI.M".ts_eval=%Q|"WW_FINNS@HI.M".tsn.load_from_bls("SMU15000005500000030", "M")|
  "WH_FINNS@HI.M".ts_eval=%Q|"WH_FINNS@HI.M".tsn.load_from_bls("SMU15000005500000008", "M")|
  "WWAFNS@HI.M".ts_eval=%Q|"WWAFNS@HI.M".tsn.load_from_bls("SMU15000007072000030", "M")|
  "WHAFNS@HI.M".ts_eval=%Q|"WHAFNS@HI.M".tsn.load_from_bls("SMU15000007072000008", "M")|
  "WWAFACNS@HI.M".ts_eval=%Q|"WWAFACNS@HI.M".tsn.load_from_bls("SMU15000007072100030", "M")|
  "WHAFACNS@HI.M".ts_eval=%Q|"WHAFACNS@HI.M".tsn.load_from_bls("SMU15000007072100008", "M")|
  "WWAFFDNS@HI.M".ts_eval=%Q|"WWAFFDNS@HI.M".tsn.load_from_bls("SMU15000007072200030", "M")|
  "WHAFFDNS@HI.M".ts_eval=%Q|"WHAFFDNS@HI.M".tsn.load_from_bls("SMU15000007072200008", "M")|
  "WWCTNS@HON.M".ts_eval=%Q|"WWCTNS@HON.M".tsn.load_from_bls("SMU15261801500000030", "M")|
  "WHCTNS@HON.M".ts_eval=%Q|"WHCTNS@HON.M".tsn.load_from_bls("SMU15261801500000008", "M")|
  "WWMNNS@HON.M".ts_eval=%Q|"WWMNNS@HON.M".tsn.load_from_bls("SMU15261803000000030", "M")|
  "WHMNNS@HON.M".ts_eval=%Q|"WHMNNS@HON.M".tsn.load_from_bls("SMU15261803000000008", "M")|
  "WW_TTUNS@HON.M".ts_eval=%Q|"WW_TTUNS@HON.M".tsn.load_from_bls("SMU15261804000000030", "M")|
  "WH_TTUNS@HON.M".ts_eval=%Q|"WH_TTUNS@HON.M".tsn.load_from_bls("SMU15261804000000008", "M")|
  "WWWTNS@HON.M".ts_eval=%Q|"WWWTNS@HON.M".tsn.load_from_bls("SMU15261804100000030", "M")|
  "WHWTNS@HON.M".ts_eval=%Q|"WHWTNS@HON.M".tsn.load_from_bls("SMU15261804100000008", "M")|
  "WWRTNS@HON.M".ts_eval=%Q|"WWRTNS@HON.M".tsn.load_from_bls("SMU15261804200000030", "M")|
  "WHRTNS@HON.M".ts_eval=%Q|"WHRTNS@HON.M".tsn.load_from_bls("SMU15261804200000008", "M")|
  "WWIFNS@HON.M".ts_eval=%Q|"WWIFNS@HON.M".tsn.load_from_bls("SMU15261805000000030", "M")|
  "WHIFNS@HON.M".ts_eval=%Q|"WHIFNS@HON.M".tsn.load_from_bls("SMU15261805000000008", "M")|
  "WW_FINNS@HON.M".ts_eval=%Q|"WW_FINNS@HON.M".tsn.load_from_bls("SMU15261805500000030", "M")|
  "WH_FINNS@HON.M".ts_eval=%Q|"WH_FINNS@HON.M".tsn.load_from_bls("SMU15261805500000008", "M")|
  "WWAFNS@HON.M".ts_eval=%Q|"WWAFNS@HON.M".tsn.load_from_bls("SMU15261807072000030", "M")|
  "WHAFNS@HON.M".ts_eval=%Q|"WHAFNS@HON.M".tsn.load_from_bls("SMU15261807072000008", "M")|
  "WWAFACNS@HON.M".ts_eval=%Q|"WWAFACNS@HON.M".tsn.load_from_bls("SMU15261807072100030", "M")|
  "WHAFACNS@HON.M".ts_eval=%Q|"WHAFACNS@HON.M".tsn.load_from_bls("SMU15261807072100008", "M")|
  "WWAFFDNS@HON.M".ts_eval=%Q|"WWAFFDNS@HON.M".tsn.load_from_bls("SMU15261807072200030", "M")|
  "WHAFFDNS@HON.M".ts_eval=%Q|"WHAFFDNS@HON.M".tsn.load_from_bls("SMU15261807072200008", "M")|

  "E_NFNS@HI.M".ts_eval=%Q|"E_NFNS@HI.M".tsn.load_from_bls("SMU15000000000000001", "M")|
  "E_PRNS@HI.M".ts_eval=%Q|"E_PRNS@HI.M".tsn.load_from_bls("SMU15000000500000001", "M")|
  "E_GDSPRNS@HI.M".ts_eval=%Q|"E_GDSPRNS@HI.M".tsn.load_from_bls("SMU15000000600000001", "M")|
  "E_SVCPRNS@HI.M".ts_eval=%Q|"E_SVCPRNS@HI.M".tsn.load_from_bls("SMU15000000700000001", "M")|
  "E_PRSVCPRNS@HI.M".ts_eval=%Q|"E_PRSVCPRNS@HI.M".tsn.load_from_bls("SMU15000000800000001", "M")|
  "ECTNS@HI.M".ts_eval=%Q|"ECTNS@HI.M".tsn.load_from_bls("SMU15000001500000001", "M")|
  "ECTBLNS@HI.M".ts_eval=%Q|"ECTBLNS@HI.M".tsn.load_from_bls("SMU15000001523600001", "M")|
  "ECTSPNS@HI.M".ts_eval=%Q|"ECTSPNS@HI.M".tsn.load_from_bls("SMU15000001523800001", "M")|
  "EMNNS@HI.M".ts_eval=%Q|"EMNNS@HI.M".tsn.load_from_bls("SMU15000003000000001", "M")|
  "EMNDRNS@HI.M".ts_eval=%Q|"EMNDRNS@HI.M".tsn.load_from_bls("SMU15000003100000001", "M")|
  "EMNNDNS@HI.M".ts_eval=%Q|"EMNNDNS@HI.M".tsn.load_from_bls("SMU15000003200000001", "M")|
  "E_TTUNS@HI.M".ts_eval=%Q|"E_TTUNS@HI.M".tsn.load_from_bls("SMU15000004000000001", "M")|
  "EWTNS@HI.M".ts_eval=%Q|"EWTNS@HI.M".tsn.load_from_bls("SMU15000004100000001", "M")|
  "ERTNS@HI.M".ts_eval=%Q|"ERTNS@HI.M".tsn.load_from_bls("SMU15000004200000001", "M")|
  "ERTFDNS@HI.M".ts_eval=%Q|"ERTFDNS@HI.M".tsn.load_from_bls("SMU15000004244500001", "M")|
  "ERTFDGSNS@HI.M".ts_eval=%Q|"ERTFDGSNS@HI.M".tsn.load_from_bls("SMU15000004244510001", "M")|
  "ERTCLNS@HI.M".ts_eval=%Q|"ERTCLNS@HI.M".tsn.load_from_bls("SMU15000004244800001", "M")|
  "ERTGMNS@HI.M".ts_eval=%Q|"ERTGMNS@HI.M".tsn.load_from_bls("SMU15000004245200001", "M")|
  "ERTGMDSNS@HI.M".ts_eval=%Q|"ERTGMDSNS@HI.M".tsn.load_from_bls("SMU15000004245210001", "M")|
  "E_TUNS@HI.M".ts_eval=%Q|"E_TUNS@HI.M".tsn.load_from_bls("SMU15000004300000001", "M")|
  "EUTNS@HI.M".ts_eval=%Q|"EUTNS@HI.M".tsn.load_from_bls("SMU15000004322000001", "M")|
  "ETWNS@HI.M".ts_eval=%Q|"ETWNS@HI.M".tsn.load_from_bls("SMU15000004340008901", "M")|
  "ETWTANS@HI.M".ts_eval=%Q|"ETWTANS@HI.M".tsn.load_from_bls("SMU15000004348100001", "M")|
  "EIFNS@HI.M".ts_eval=%Q|"EIFNS@HI.M".tsn.load_from_bls("SMU15000005000000001", "M")|
  "EIFTCNS@HI.M".ts_eval=%Q|"EIFTCNS@HI.M".tsn.load_from_bls("SMU15000005051700001", "M")|
  "E_FIRNS@HI.M".ts_eval=%Q|"E_FIRNS@HI.M".tsn.load_from_bls("SMU15000005500000001", "M")|
  "EFINS@HI.M".ts_eval=%Q|"EFINS@HI.M".tsn.load_from_bls("SMU15000005552000001", "M")|
  "ERENS@HI.M".ts_eval=%Q|"ERENS@HI.M".tsn.load_from_bls("SMU15000005553000001", "M")|
  "E_PBSNS@HI.M".ts_eval=%Q|"E_PBSNS@HI.M".tsn.load_from_bls("SMU15000006000000001", "M")|
  "EPSNS@HI.M".ts_eval=%Q|"EPSNS@HI.M".tsn.load_from_bls("SMU15000006054000001", "M")|
  "EMANS@HI.M".ts_eval=%Q|"EMANS@HI.M".tsn.load_from_bls("SMU15000006055000001", "M")|
  "EADNS@HI.M".ts_eval=%Q|"EADNS@HI.M".tsn.load_from_bls("SMU15000006056000001", "M")|
  "EADESNS@HI.M".ts_eval=%Q|"EADESNS@HI.M".tsn.load_from_bls("SMU15000006056130001", "M")|
  "E_EDHCNS@HI.M".ts_eval=%Q|"E_EDHCNS@HI.M".tsn.load_from_bls("SMU15000006500000001", "M")|
  "EEDNS@HI.M".ts_eval=%Q|"EEDNS@HI.M".tsn.load_from_bls("SMU15000006561000001", "M")|
  "EED12NS@HI.M".ts_eval=%Q|"EED12NS@HI.M".tsn.load_from_bls("SMU15000006561110001", "M")|
  "EHCNS@HI.M".ts_eval=%Q|"EHCNS@HI.M".tsn.load_from_bls("SMU15000006562000001", "M")|
  "EHCAMNS@HI.M".ts_eval=%Q|"EHCAMNS@HI.M".tsn.load_from_bls("SMU15000006562100001", "M")|
  "EHCHONS@HI.M".ts_eval=%Q|"EHCHONS@HI.M".tsn.load_from_bls("SMU15000006562200001", "M")|
  "EHCNRNS@HI.M".ts_eval=%Q|"EHCNRNS@HI.M".tsn.load_from_bls("SMU15000006562300001", "M")|
  "EHCSONS@HI.M".ts_eval=%Q|"EHCSONS@HI.M".tsn.load_from_bls("SMU15000006562400001", "M")|
  "EHCSOIFNS@HI.M".ts_eval=%Q|"EHCSOIFNS@HI.M".tsn.load_from_bls("SMU15000006562410001", "M")|
  "E_LHNS@HI.M".ts_eval=%Q|"E_LHNS@HI.M".tsn.load_from_bls("SMU15000007000000001", "M")|
  "EAENS@HI.M".ts_eval=%Q|"EAENS@HI.M".tsn.load_from_bls("SMU15000007071000001", "M")|
  "EAFNS@HI.M".ts_eval=%Q|"EAFNS@HI.M".tsn.load_from_bls("SMU15000007072000001", "M")|
  "EAFACNS@HI.M".ts_eval=%Q|"EAFACNS@HI.M".tsn.load_from_bls("SMU15000007072100001", "M")|
  "EAFFDNS@HI.M".ts_eval=%Q|"EAFFDNS@HI.M".tsn.load_from_bls("SMU15000007072200001", "M")|
  "EAFFDRSNS@HI.M".ts_eval=%Q|"EAFFDRSNS@HI.M".tsn.load_from_bls("SMU15000007072210001", "M")|
  "EOSNS@HI.M".ts_eval=%Q|"EOSNS@HI.M".tsn.load_from_bls("SMU15000008000000001", "M")|
  "EGVNS@HI.M".ts_eval=%Q|"EGVNS@HI.M".tsn.load_from_bls("SMU15000009000000001", "M")|
  "EGVFDNS@HI.M".ts_eval=%Q|"EGVFDNS@HI.M".tsn.load_from_bls("SMU15000009091000001", "M")|
  "EGVFDSPNS@HI.M".ts_eval=%Q|"EGVFDSPNS@HI.M".tsn.load_from_bls("SMU15000009091336601", "M")|
  "EGVFDDDNS@HI.M".ts_eval=%Q|"EGVFDDDNS@HI.M".tsn.load_from_bls("SMU15000009091911001", "M")|
  "EGVSTNS@HI.M".ts_eval=%Q|"EGVSTNS@HI.M".tsn.load_from_bls("SMU15000009092000001", "M")|
  "EGVSTEDNS@HI.M".ts_eval=%Q|"EGVSTEDNS@HI.M".tsn.load_from_bls("SMU15000009092161101", "M")|
  "EGVLCNS@HI.M".ts_eval=%Q|"EGVLCNS@HI.M".tsn.load_from_bls("SMU15000009093000001", "M")|
  "E_NFNS@HON.M".ts_eval=%Q|"E_NFNS@HON.M".tsn.load_from_bls("SMU15261800000000001", "M")|
  "E_PRNS@HON.M".ts_eval=%Q|"E_PRNS@HON.M".tsn.load_from_bls("SMU15261800500000001", "M")|
  "E_GDSPRNS@HON.M".ts_eval=%Q|"E_GDSPRNS@HON.M".tsn.load_from_bls("SMU15261800600000001", "M")|
  "E_SVCPRNS@HON.M".ts_eval=%Q|"E_SVCPRNS@HON.M".tsn.load_from_bls("SMU15261800700000001", "M")|
  "E_PRSVCPRNS@HON.M".ts_eval=%Q|"E_PRSVCPRNS@HON.M".tsn.load_from_bls("SMU15261800800000001", "M")|
  "ECTNS@HON.M".ts_eval=%Q|"ECTNS@HON.M".tsn.load_from_bls("SMU15261801500000001", "M")|
  "ECTSPNS@HON.M".ts_eval=%Q|"ECTSPNS@HON.M".tsn.load_from_bls("SMU15261801523800001", "M")|
  "EMNNS@HON.M".ts_eval=%Q|"EMNNS@HON.M".tsn.load_from_bls("SMU15261803000000001", "M")|
  "EMNDRNS@HON.M".ts_eval=%Q|"EMNDRNS@HON.M".tsn.load_from_bls("SMU15261803100000001", "M")|
  "EMNNDNS@HON.M".ts_eval=%Q|"EMNNDNS@HON.M".tsn.load_from_bls("SMU15261803200000001", "M")|
  "E_TTUNS@HON.M".ts_eval=%Q|"E_TTUNS@HON.M".tsn.load_from_bls("SMU15261804000000001", "M")|
  "EWTNS@HON.M".ts_eval=%Q|"EWTNS@HON.M".tsn.load_from_bls("SMU15261804100000001", "M")|
  "ERTNS@HON.M".ts_eval=%Q|"ERTNS@HON.M".tsn.load_from_bls("SMU15261804200000001", "M")|
  "ERTFDNS@HON.M".ts_eval=%Q|"ERTFDNS@HON.M".tsn.load_from_bls("SMU15261804244500001", "M")|
  "ERTFDGSNS@HON.M".ts_eval=%Q|"ERTFDGSNS@HON.M".tsn.load_from_bls("SMU15261804244510001", "M")|
  "ERTCLNS@HON.M".ts_eval=%Q|"ERTCLNS@HON.M".tsn.load_from_bls("SMU15261804244800001", "M")|
  "ERTGMNS@HON.M".ts_eval=%Q|"ERTGMNS@HON.M".tsn.load_from_bls("SMU15261804245200001", "M")|
  "ERTGMDSNS@HON.M".ts_eval=%Q|"ERTGMDSNS@HON.M".tsn.load_from_bls("SMU15261804245210001", "M")|
  "E_TUNS@HON.M".ts_eval=%Q|"E_TUNS@HON.M".tsn.load_from_bls("SMU15261804300000001", "M")|
  "ETWNS@HON.M".ts_eval=%Q|"ETWNS@HON.M".tsn.load_from_bls("SMU15261804340008901", "M")|
  "ETWTANS@HON.M".ts_eval=%Q|"ETWTANS@HON.M".tsn.load_from_bls("SMU15261804348100001", "M")|
  "EIFNS@HON.M".ts_eval=%Q|"EIFNS@HON.M".tsn.load_from_bls("SMU15261805000000001", "M")|
  "EIFTCNS@HON.M".ts_eval=%Q|"EIFTCNS@HON.M".tsn.load_from_bls("SMU15261805051700001", "M")|
  "E_FIRNS@HON.M".ts_eval=%Q|"E_FIRNS@HON.M".tsn.load_from_bls("SMU15261805500000001", "M")|
  "EFINS@HON.M".ts_eval=%Q|"EFINS@HON.M".tsn.load_from_bls("SMU15261805552000001", "M")|
  "ERENS@HON.M".ts_eval=%Q|"ERENS@HON.M".tsn.load_from_bls("SMU15261805553000001", "M")|
  "E_PBSNS@HON.M".ts_eval=%Q|"E_PBSNS@HON.M".tsn.load_from_bls("SMU15261806000000001", "M")|
  "EPSNS@HON.M".ts_eval=%Q|"EPSNS@HON.M".tsn.load_from_bls("SMU15261806054000001", "M")|
  "EMANS@HON.M".ts_eval=%Q|"EMANS@HON.M".tsn.load_from_bls("SMU15261806055000001", "M")|
  "EADNS@HON.M".ts_eval=%Q|"EADNS@HON.M".tsn.load_from_bls("SMU15261806056000001", "M")|
  "EADESNS@HON.M".ts_eval=%Q|"EADESNS@HON.M".tsn.load_from_bls("SMU15261806056130001", "M")|
  "E_EDHCNS@HON.M".ts_eval=%Q|"E_EDHCNS@HON.M".tsn.load_from_bls("SMU15261806500000001", "M")|
  "EEDNS@HON.M".ts_eval=%Q|"EEDNS@HON.M".tsn.load_from_bls("SMU15261806561000001", "M")|
  "EED12NS@HON.M".ts_eval=%Q|"EED12NS@HON.M".tsn.load_from_bls("SMU15261806561110001", "M")|
  "EHCNS@HON.M".ts_eval=%Q|"EHCNS@HON.M".tsn.load_from_bls("SMU15261806562000001", "M")|
  "EHCAMNS@HON.M".ts_eval=%Q|"EHCAMNS@HON.M".tsn.load_from_bls("SMU15261806562100001", "M")|
  "EHCHONS@HON.M".ts_eval=%Q|"EHCHONS@HON.M".tsn.load_from_bls("SMU15261806562200001", "M")|
  "E_LHNS@HON.M".ts_eval=%Q|"E_LHNS@HON.M".tsn.load_from_bls("SMU15261807000000001", "M")|
  "EAFNS@HON.M".ts_eval=%Q|"EAFNS@HON.M".tsn.load_from_bls("SMU15261807072000001", "M")|
  "EAFACNS@HON.M".ts_eval=%Q|"EAFACNS@HON.M".tsn.load_from_bls("SMU15261807072100001", "M")|
  "EAFFDNS@HON.M".ts_eval=%Q|"EAFFDNS@HON.M".tsn.load_from_bls("SMU15261807072200001", "M")|
  "EAFFDRSNS@HON.M".ts_eval=%Q|"EAFFDRSNS@HON.M".tsn.load_from_bls("SMU15261807072210001", "M")|
  "EOSNS@HON.M".ts_eval=%Q|"EOSNS@HON.M".tsn.load_from_bls("SMU15261808000000001", "M")|
  "EGVNS@HON.M".ts_eval=%Q|"EGVNS@HON.M".tsn.load_from_bls("SMU15261809000000001", "M")|
  "EGVFDNS@HON.M".ts_eval=%Q|"EGVFDNS@HON.M".tsn.load_from_bls("SMU15261809091000001", "M")|
  "EGVFDSPNS@HON.M".ts_eval=%Q|"EGVFDSPNS@HON.M".tsn.load_from_bls("SMU15261809091336601", "M")|
  "EGVFDDDNS@HON.M".ts_eval=%Q|"EGVFDDDNS@HON.M".tsn.load_from_bls("SMU15261809091911001", "M")|
  "EGVSTNS@HON.M".ts_eval=%Q|"EGVSTNS@HON.M".tsn.load_from_bls("SMU15261809092000001", "M")|
  "EGVSTEDNS@HON.M".ts_eval=%Q|"EGVSTEDNS@HON.M".tsn.load_from_bls("SMU15261809092161101", "M")|
  "EGVLCNS@HON.M".ts_eval=%Q|"EGVLCNS@HON.M".tsn.load_from_bls("SMU15261809093000001", "M")|
end


task :reconstruct_db => :environment do
    "AVC@KAU.A".ts_append_eval %Q|"AVC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMNDRMS@KAU.A".ts_append_eval %Q|"YCMNDRMS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNND@KAU.A".ts_append_eval %Q|"YCMNND@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YLAGFFFS@HI.A".ts_append_eval %Q|"YLAGFFFS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTBL@HI.A".ts_append_eval %Q|"YLCTBL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTHV@HI.A".ts_append_eval %Q|"YLCTHV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMN@HI.A".ts_append_eval %Q|"YLMN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLMN@HI.A".ts_append_eval %Q|"YLMN@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTW@HI.A".ts_append_eval %Q|"YLTW@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "GDP_IRS_R@US.A".ts_append_eval %Q|"GDP_IRS_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "AVCVG@KAU.A".ts_append_eval %Q|"AVCVG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMNDRMS@HI.A".ts_append_eval %Q|"YCMNDRMS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDBV@HI.A".ts_append_eval %Q|"YCMNNDBV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTSP@HI.A".ts_append_eval %Q|"YCRTSP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCAM@HI.A".ts_append_eval %Q|"YCHCAM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCHO@HI.A".ts_append_eval %Q|"YCHCHO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXM@HON.A".ts_append_eval %Q|"YCMNNDXM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDLT@HON.A".ts_append_eval %Q|"YCMNNDLT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCWT@HON.A".ts_append_eval %Q|"YCWT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMV@HON.A".ts_append_eval %Q|"YCRTMV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTEL@HON.A".ts_append_eval %Q|"YCRTEL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFOT@KAU.A".ts_append_eval %Q|"YCAGFFOT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTBL@HON.A".ts_append_eval %Q|"YCRTBL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFD@HON.A".ts_append_eval %Q|"YCRTFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTSP@HON.A".ts_append_eval %Q|"YCRTSP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMS@HON.A".ts_append_eval %Q|"YCRTMS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTR@HON.A".ts_append_eval %Q|"YCTWTR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTW@HON.A".ts_append_eval %Q|"YCTWTW@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTT@HON.A".ts_append_eval %Q|"YCTWTT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVST@HON.A".ts_append_eval %Q|"YCGVST@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAVR@HAW.A".ts_append_eval %Q|"YCAVR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFA@HAW.A".ts_append_eval %Q|"YCAGFA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_PR@HAW.A".ts_append_eval %Q|"YC_PR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFR@HAW.A".ts_append_eval %Q|"YCRTFR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTOT@HAW.A".ts_append_eval %Q|"YCRTOT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFTC@HAW.A".ts_append_eval %Q|"YCIFTC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFICR@HAW.A".ts_append_eval %Q|"YCFICR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRELE@HAW.A".ts_append_eval %Q|"YCRELE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCPS@HAW.A".ts_append_eval %Q|"YCPS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCAM@HAW.A".ts_append_eval %Q|"YCHCAM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCHO@HAW.A".ts_append_eval %Q|"YCHCHO@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSPL@HAW.A".ts_append_eval %Q|"YCOSPL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGV@HAW.A".ts_append_eval %Q|"YCGV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVLC@HAW.A".ts_append_eval %Q|"YCGVLC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_NF@KAU.A".ts_append_eval %Q|"YC_NF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTBL@KAU.A".ts_append_eval %Q|"YCCTBL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTSP@KAU.A".ts_append_eval %Q|"YCCTSP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRNM@KAU.A".ts_append_eval %Q|"YCMNDRNM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMV@KAU.A".ts_append_eval %Q|"YCMNDRMV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDBV@KAU.A".ts_append_eval %Q|"YCMNNDBV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTSP@KAU.A".ts_append_eval %Q|"YCRTSP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTOT@KAU.A".ts_append_eval %Q|"YCRTOT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTA@KAU.A".ts_append_eval %Q|"YCTWTA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTW@KAU.A".ts_append_eval %Q|"YCTWTW@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFICR@KAU.A".ts_append_eval %Q|"YCFICR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFISE@KAU.A".ts_append_eval %Q|"YCFISE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERL@KAU.A".ts_append_eval %Q|"YCRERL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCAM@KAU.A".ts_append_eval %Q|"YCHCAM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDBV@MAU.A".ts_append_eval %Q|"YCMNNDBV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXM@MAU.A".ts_append_eval %Q|"YCMNNDXM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDLT@MAU.A".ts_append_eval %Q|"YCMNNDLT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPL@MAU.A".ts_append_eval %Q|"YCMNNDPL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCWT@MAU.A".ts_append_eval %Q|"YCWT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFR@MAU.A".ts_append_eval %Q|"YCRTFR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTBL@MAU.A".ts_append_eval %Q|"YCRTBL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFD@MAU.A".ts_append_eval %Q|"YCRTFD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTG@MAU.A".ts_append_eval %Q|"YCTWTG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSC@MAU.A".ts_append_eval %Q|"YCTWSC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFPB@MAU.A".ts_append_eval %Q|"YCIFPB@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIMO@MAU.A".ts_append_eval %Q|"YCFIMO@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIOT@MAU.A".ts_append_eval %Q|"YCFIOT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERL@MAU.A".ts_append_eval %Q|"YCRERL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAD@MAU.A".ts_append_eval %Q|"YCAD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHC@MAU.A".ts_append_eval %Q|"YCHC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAF@MAU.A".ts_append_eval %Q|"YCAF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSHH@MAU.A".ts_append_eval %Q|"YCOSHH@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVML@MAU.A".ts_append_eval %Q|"YCGVML@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVST@MAU.A".ts_append_eval %Q|"YCGVST@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAD@HAW.A".ts_append_eval %Q|"YCAD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVFD@HAW.A".ts_append_eval %Q|"YCGVFD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVML@HAW.A".ts_append_eval %Q|"YCGVML@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_GVSL@HAW.A".ts_append_eval %Q|"YC_GVSL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMI@KAU.A".ts_append_eval %Q|"YCMI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDR@KAU.A".ts_append_eval %Q|"YCMNDR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDREL@KAU.A".ts_append_eval %Q|"YCMNDREL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YLAGFFSP@HI.A".ts_append_eval %Q|"YLAGFFSP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIMI@HI.A".ts_append_eval %Q|"YLMIMI@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTSP@HI.A".ts_append_eval %Q|"YLRTSP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGM@HI.A".ts_append_eval %Q|"YLRTGM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTW@HI.A".ts_append_eval %Q|"YLTWTW@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTT@HI.A".ts_append_eval %Q|"YLTWTT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSC@HI.A".ts_append_eval %Q|"YLTWSC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWCU@HI.A".ts_append_eval %Q|"YLTWCU@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWWH@HI.A".ts_append_eval %Q|"YLTWWH@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTA@HON.A".ts_append_eval %Q|"YLTWTA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA@HI.A".ts_append_eval %Q|"NRBEA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "NRBEA@HI.A".ts_append_eval %Q|"NRBEA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVST@HI.A".ts_append_eval %Q|"YLGVST@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGVST@HI.A".ts_append_eval %Q|"YLGVST@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "PMKRCON@HAW.Q".ts_append_eval %Q|"PMKRCON@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRSGF@MAU.Q".ts_append_eval %Q|"PMKRSGF@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "YLFISE@HI.A".ts_append_eval %Q|"YLFISE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPA@HON.A".ts_append_eval %Q|"YLMNNDPA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPR@HON.A".ts_append_eval %Q|"YLMNNDPR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRWD@HON.A".ts_append_eval %Q|"YLMNDRWD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRNM@HON.A".ts_append_eval %Q|"YLMNDRNM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTHV@HAW.A".ts_append_eval %Q|"YLCTHV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTBL@MAU.A".ts_append_eval %Q|"YLRTBL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "AVLEG@KAU.A".ts_append_eval %Q|"AVLEG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YLTW@HAW.A".ts_append_eval %Q|"YLTW@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCMNDREL@HI.A".ts_append_eval %Q|"YCMNDREL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "ANFL@HON.A".ts_append_eval %Q|"ANFL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCRTOT@HI.A".ts_append_eval %Q|"YCRTOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWCU@HI.A".ts_append_eval %Q|"YCTWCU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIF@HI.A".ts_append_eval %Q|"YCIF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFPB@HI.A".ts_append_eval %Q|"YCIFPB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFS@HON.A".ts_append_eval %Q|"YCAGFFFS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFSP@HON.A".ts_append_eval %Q|"YCAGFFSP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIOG@HON.A".ts_append_eval %Q|"YCMIOG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTG@HON.A".ts_append_eval %Q|"YCTWTG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIMO@HON.A".ts_append_eval %Q|"YCFIMO@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIOT@HON.A".ts_append_eval %Q|"YCFIOT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERL@HON.A".ts_append_eval %Q|"YCRERL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDREL@HAW.A".ts_append_eval %Q|"YCMNDREL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMV@HAW.A".ts_append_eval %Q|"YCMNDRMV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXP@HAW.A".ts_append_eval %Q|"YCMNNDXP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPA@HAW.A".ts_append_eval %Q|"YCMNNDPA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPR@HAW.A".ts_append_eval %Q|"YCMNNDPR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDCH@HAW.A".ts_append_eval %Q|"YCMNNDCH@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPL@HAW.A".ts_append_eval %Q|"YCMNNDPL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRT@HAW.A".ts_append_eval %Q|"YCRT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAE@HAW.A".ts_append_eval %Q|"YCAE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEMU@HAW.A".ts_append_eval %Q|"YCAEMU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFFD@HAW.A".ts_append_eval %Q|"YCAFFD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSRP@HAW.A".ts_append_eval %Q|"YCOSRP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCWT@KAU.A".ts_append_eval %Q|"YCWT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRT@KAU.A".ts_append_eval %Q|"YCRT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMV@KAU.A".ts_append_eval %Q|"YCRTMV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFD@KAU.A".ts_append_eval %Q|"YCRTFD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTT@KAU.A".ts_append_eval %Q|"YCTWTT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSC@KAU.A".ts_append_eval %Q|"YCTWSC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWCU@KAU.A".ts_append_eval %Q|"YCTWCU@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFPB@KAU.A".ts_append_eval %Q|"YCIFPB@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFBC@KAU.A".ts_append_eval %Q|"YCIFBC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAERE@KAU.A".ts_append_eval %Q|"YCAERE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAF@KAU.A".ts_append_eval %Q|"YCAF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSPL@KAU.A".ts_append_eval %Q|"YCOSPL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVML@KAU.A".ts_append_eval %Q|"YCGVML@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YSMNND@HI.A".ts_append_eval %Q|"YSMNND@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDXX@HI.A".ts_append_eval %Q|"YSMNNDXX@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSFI@HI.A".ts_append_eval %Q|"YSFI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSOS@HI.A".ts_append_eval %Q|"YSOS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "AASU@HI.A".ts_append_eval %Q|"AASU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAVG@HI.A".ts_append_eval %Q|"AAVG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AACF@HI.A".ts_append_eval %Q|"AACF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAOT@HI.A".ts_append_eval %Q|"AAOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AA@HI.A".ts_append_eval %Q|"AA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AASU@HAW.A".ts_append_eval %Q|"AASU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AASU@HON.A".ts_append_eval %Q|"AASU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAVG@HON.A".ts_append_eval %Q|"AAVG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAFR@HON.A".ts_append_eval %Q|"AAFR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AA@KAU.A".ts_append_eval %Q|"AA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AASU@MAU.A".ts_append_eval %Q|"AASU@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAVG@MAU.A".ts_append_eval %Q|"AAVG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAFR@MAU.A".ts_append_eval %Q|"AAFR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AACF@MAU.A".ts_append_eval %Q|"AACF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAMC@MAU.A".ts_append_eval %Q|"AAMC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFR@HI.A".ts_append_eval %Q|"ANFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANMC@HI.A".ts_append_eval %Q|"ANMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANSU@HAW.A".ts_append_eval %Q|"ANSU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANCF@MAU.A".ts_append_eval %Q|"ANCF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCVG@HI.A".ts_append_eval %Q|"AVCVG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMIOG@HI.A".ts_append_eval %Q|"YCMIOG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTW@HON.A".ts_append_eval %Q|"YCTW@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCUT@HAW.A".ts_append_eval %Q|"YCUT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRCM@HAW.A".ts_append_eval %Q|"YCMNDRCM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFR@HAW.A".ts_append_eval %Q|"YCMNDRFR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNND@HAW.A".ts_append_eval %Q|"YCMNND@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDBV@HAW.A".ts_append_eval %Q|"YCMNNDBV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPT@HAW.A".ts_append_eval %Q|"YCMNNDPT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERE@HAW.A".ts_append_eval %Q|"YCRERE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCSO@HAW.A".ts_append_eval %Q|"YCHCSO@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEPF@HAW.A".ts_append_eval %Q|"YCAEPF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIMI@KAU.A".ts_append_eval %Q|"YCMIMI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRTR@KAU.A".ts_append_eval %Q|"YCMNDRTR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YWAGE@HI.A".ts_append_eval %Q|"YWAGE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YWAGE@HI.A".ts_append_eval %Q|"YWAGE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTHC@HI.A".ts_append_eval %Q|"YLRTHC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGA@HI.A".ts_append_eval %Q|"YLRTGA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTA@HI.A".ts_append_eval %Q|"YLTWTA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTR@HI.A".ts_append_eval %Q|"YLTWTR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTG@HI.A".ts_append_eval %Q|"YLTWTG@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFTC@HI.A".ts_append_eval %Q|"YLIFTC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIIN@HI.A".ts_append_eval %Q|"YLFIIN@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRE@HI.A".ts_append_eval %Q|"YLRE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLRE@HI.A".ts_append_eval %Q|"YLRE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPS@HI.A".ts_append_eval %Q|"YLPS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLPS@HI.A".ts_append_eval %Q|"YLPS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPR@HAW.A".ts_append_eval %Q|"YLMNNDPR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPT@HAW.A".ts_append_eval %Q|"YLMNNDPT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "GDP_CS_R@US.A".ts_append_eval %Q|"GDP_CS_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YPCDPI_R@US.A".ts_append_eval %Q|"YPCDPI_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YLPMNCH&@HAW.A".ts_append_eval %Q|"YLPMNCH&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "PAKRCON@HON.Q".ts_append_eval %Q|"PAKRCON@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRCON@HON.Q".ts_append_eval %Q|"PMKRCON@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRSGF@HAW.Q".ts_append_eval %Q|"PMKRSGF@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PAKRCON@HAW.Q".ts_append_eval %Q|"PAKRCON@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "YLRTMV@HON.A".ts_append_eval %Q|"YLRTMV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFR@HON.A".ts_append_eval %Q|"YLRTFR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCHO@HON.A".ts_append_eval %Q|"YLHCHO@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSP@KAU.A".ts_append_eval %Q|"YLTWSP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YTRNSF@HI.A".ts_append_eval %Q|"YTRNSF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YTRNSF@HI.A".ts_append_eval %Q|"YTRNSF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGV@HI.A".ts_append_eval %Q|"YLGV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGV@HI.A".ts_append_eval %Q|"YLGV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRNM@HI.A".ts_append_eval %Q|"YLMNDRNM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRPM@HI.A".ts_append_eval %Q|"YLMNDRPM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFB@HI.A".ts_append_eval %Q|"YLMNDRFB@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMC@HI.A".ts_append_eval %Q|"YLMNDRMC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLAB&@HI.A".ts_append_eval %Q|"YOTLAB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "PCCM_FB@HON.S".ts_append_eval %Q|"PCCM_FB@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCAP@HON.S".ts_append_eval %Q|"PCAP@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSFU@HON.S".ts_append_eval %Q|"PCHSFU@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCSV@HON.S".ts_append_eval %Q|"PCSV@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCMD@HON.S".ts_append_eval %Q|"PCMD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRGSPR@HON.S".ts_append_eval %Q|"PCTRGSPR@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCCMDR@HON.S".ts_append_eval %Q|"PCCMDR@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "YLMNDR@HI.Q".ts_append_eval %Q|"YLMNDR@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLCTBL@HON.A".ts_append_eval %Q|"YLCTBL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTSP@HON.A".ts_append_eval %Q|"YLCTSP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFB@HON.A".ts_append_eval %Q|"YLMNDRFB@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMC@HON.A".ts_append_eval %Q|"YLMNDRMC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFO@HAW.A".ts_append_eval %Q|"YLAGFFFO@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFS@HAW.A".ts_append_eval %Q|"YLAGFFFS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIMI@HAW.A".ts_append_eval %Q|"YLMIMI@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTBL@HAW.A".ts_append_eval %Q|"YLCTBL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTSP@HAW.A".ts_append_eval %Q|"YLCTSP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTR@HAW.A".ts_append_eval %Q|"YLTWTR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTG@HAW.A".ts_append_eval %Q|"YLTWTG@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECPR@MAU.A".ts_append_eval %Q|"YSOCSECPR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECEM@MAU.A".ts_append_eval %Q|"YSOCSECEM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFR@MAU.A".ts_append_eval %Q|"YLRTFR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFD@MAU.A".ts_append_eval %Q|"YLRTFD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTHC@MAU.A".ts_append_eval %Q|"YLRTHC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECPR@KAU.A".ts_append_eval %Q|"YSOCSECPR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECEM@KAU.A".ts_append_eval %Q|"YSOCSECEM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDLT@KAU.A".ts_append_eval %Q|"YLMNNDLT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPA@KAU.A".ts_append_eval %Q|"YLMNNDPA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPR@KAU.A".ts_append_eval %Q|"YLMNNDPR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPT@KAU.A".ts_append_eval %Q|"YLMNNDPT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDCH@KAU.A".ts_append_eval %Q|"YLMNNDCH@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPL@KAU.A".ts_append_eval %Q|"YLMNNDPL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMV@KAU.A".ts_append_eval %Q|"YLRTMV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA&@HI.A".ts_append_eval %Q|"NRBEA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPCBEA&@HI.A".ts_append_eval %Q|"YPCBEA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@HI.A".ts_append_eval %Q|"YLP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@HI.A".ts_append_eval %Q|"YTWPER&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@HI.A".ts_append_eval %Q|"YRESADJ&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YNETR&@HI.A".ts_append_eval %Q|"YNETR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@HI.A".ts_append_eval %Q|"YDIR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YV&@HI.A".ts_append_eval %Q|"YV&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YWAGE&@HI.A".ts_append_eval %Q|"YWAGE&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROP&@HI.A".ts_append_eval %Q|"YPROP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPR&@HI.A".ts_append_eval %Q|"YLPMNPR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPR&@HI.A".ts_append_eval %Q|"YLPR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTR&@HI.A".ts_append_eval %Q|"YLPRTR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTT&@HI.A".ts_append_eval %Q|"YLPRTT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPROT&@HI.A".ts_append_eval %Q|"YLPROT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTA&@HI.A".ts_append_eval %Q|"YLPRTA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRPL&@HI.A".ts_append_eval %Q|"YLPRPL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRSV&@HI.A".ts_append_eval %Q|"YLPRSV&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRCM&@HI.A".ts_append_eval %Q|"YLPRCM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRUT&@HI.A".ts_append_eval %Q|"YLPRUT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTW&@HI.A".ts_append_eval %Q|"YLPTW&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTR&@HI.A".ts_append_eval %Q|"YLPTR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRBL&@HI.A".ts_append_eval %Q|"YLPTRBL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRGM&@HI.A".ts_append_eval %Q|"YLPTRGM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPCBEA&@HON.A".ts_append_eval %Q|"YPCBEA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@HON.A".ts_append_eval %Q|"YLP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@HON.A".ts_append_eval %Q|"YTWPER&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@HON.A".ts_append_eval %Q|"YRESADJ&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@HON.A".ts_append_eval %Q|"YLPAGFA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@HON.A".ts_append_eval %Q|"YL_NF&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_PR&@HON.A".ts_append_eval %Q|"YL_PR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFA&@HON.A".ts_append_eval %Q|"YLPAGFFA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFO&@HON.A".ts_append_eval %Q|"YLPAGFFFFO&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRLT&@HON.A".ts_append_eval %Q|"YLPRLT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRUT&@HON.A".ts_append_eval %Q|"YLPRUT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRBL&@HON.A".ts_append_eval %Q|"YLPTRBL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRGM&@HON.A".ts_append_eval %Q|"YLPTRGM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFD&@HON.A".ts_append_eval %Q|"YLPTRFD&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAT&@HON.A".ts_append_eval %Q|"YLPTRAT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAP&@HON.A".ts_append_eval %Q|"YLPTRAP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFR&@HON.A".ts_append_eval %Q|"YLPTRFR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRET&@HON.A".ts_append_eval %Q|"YLPTRET&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTROT&@HON.A".ts_append_eval %Q|"YLPTROT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRDP&@HON.A".ts_append_eval %Q|"YLPFIRDP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIROF&@HON.A".ts_append_eval %Q|"YLPFIROF&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRSE&@HON.A".ts_append_eval %Q|"YLPFIRSE&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPFA&@HAW.A".ts_append_eval %Q|"YPROPFA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPNF&@HAW.A".ts_append_eval %Q|"YPROPNF&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@HAW.A".ts_append_eval %Q|"YLPAGFA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@HAW.A".ts_append_eval %Q|"YL_NF&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_PR&@HAW.A".ts_append_eval %Q|"YL_PR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFA&@HAW.A".ts_append_eval %Q|"YLPAGFFA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFF&@HAW.A".ts_append_eval %Q|"YLPAGFFF&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFO&@HAW.A".ts_append_eval %Q|"YLPAGFFFFO&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFS&@HAW.A".ts_append_eval %Q|"YLPAGFFFFS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFOT&@HAW.A".ts_append_eval %Q|"YLPAGFFFOT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIMT&@HAW.A".ts_append_eval %Q|"YLPMIMT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMICO&@HAW.A".ts_append_eval %Q|"YLPMICO&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIOL&@HAW.A".ts_append_eval %Q|"YLPMIOL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMINM&@HAW.A".ts_append_eval %Q|"YLPMINM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCGB&@HAW.A".ts_append_eval %Q|"YLPCGB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCHV&@HAW.A".ts_append_eval %Q|"YLPCHV&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCST&@HAW.A".ts_append_eval %Q|"YLPCST&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFR&@HAW.A".ts_append_eval %Q|"YLPMDFR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFD&@HAW.A".ts_append_eval %Q|"YLPTRFD&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAT&@HAW.A".ts_append_eval %Q|"YLPTRAT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAP&@HAW.A".ts_append_eval %Q|"YLPTRAP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFR&@HAW.A".ts_append_eval %Q|"YLPTRFR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRET&@HAW.A".ts_append_eval %Q|"YLPTRET&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTROT&@HAW.A".ts_append_eval %Q|"YLPTROT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRDP&@HAW.A".ts_append_eval %Q|"YLPFIRDP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIROF&@HAW.A".ts_append_eval %Q|"YLPFIROF&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRSE&@HAW.A".ts_append_eval %Q|"YLPFIRSE&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIC&@HAW.A".ts_append_eval %Q|"YLPFIRIC&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIA&@HAW.A".ts_append_eval %Q|"YLPFIRIA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRRE&@HAW.A".ts_append_eval %Q|"YLPFIRRE&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRCR&@HAW.A".ts_append_eval %Q|"YLPFIRCR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRHD&@HAW.A".ts_append_eval %Q|"YLPFIRHD&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPS&@HAW.A".ts_append_eval %Q|"YLPSVPS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPH&@HAW.A".ts_append_eval %Q|"YLPSVPH&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMO&@HAW.A".ts_append_eval %Q|"YLPSVMO&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMS&@HAW.A".ts_append_eval %Q|"YLPSVMS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFOT&@MAU.A".ts_append_eval %Q|"YLPAGFFFOT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIMT&@MAU.A".ts_append_eval %Q|"YLPMIMT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMICO&@MAU.A".ts_append_eval %Q|"YLPMICO&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIOL&@MAU.A".ts_append_eval %Q|"YLPMIOL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMINM&@MAU.A".ts_append_eval %Q|"YLPMINM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCGB&@MAU.A".ts_append_eval %Q|"YLPCGB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCHV&@MAU.A".ts_append_eval %Q|"YLPCHV&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCST&@MAU.A".ts_append_eval %Q|"YLPCST&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDWD&@MAU.A".ts_append_eval %Q|"YLPMDWD&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFR&@MAU.A".ts_append_eval %Q|"YLPMDFR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDST&@MAU.A".ts_append_eval %Q|"YLPMDST&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDPM&@MAU.A".ts_append_eval %Q|"YLPMDPM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFB&@MAU.A".ts_append_eval %Q|"YLPMDFB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMC&@MAU.A".ts_append_eval %Q|"YLPMDMC&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDTR&@MAU.A".ts_append_eval %Q|"YLPMDTR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMS&@MAU.A".ts_append_eval %Q|"YLPMDMS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDOR&@MAU.A".ts_append_eval %Q|"YLPMDOR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNAP&@MAU.A".ts_append_eval %Q|"YLPMNAP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIC&@MAU.A".ts_append_eval %Q|"YLPFIRIC&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIA&@MAU.A".ts_append_eval %Q|"YLPFIRIA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRRE&@MAU.A".ts_append_eval %Q|"YLPFIRRE&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRCR&@MAU.A".ts_append_eval %Q|"YLPFIRCR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRHD&@MAU.A".ts_append_eval %Q|"YLPFIRHD&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPS&@MAU.A".ts_append_eval %Q|"YLPSVPS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPH&@MAU.A".ts_append_eval %Q|"YLPSVPH&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAU&@MAU.A".ts_append_eval %Q|"YLPSVAU&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMO&@MAU.A".ts_append_eval %Q|"YLPSVMO&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFR&@KAU.A".ts_append_eval %Q|"YLPMDFR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDST&@KAU.A".ts_append_eval %Q|"YLPMDST&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDPM&@KAU.A".ts_append_eval %Q|"YLPMDPM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMC&@KAU.A".ts_append_eval %Q|"YLPMDMC&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDEL&@KAU.A".ts_append_eval %Q|"YLPMDEL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDTR&@KAU.A".ts_append_eval %Q|"YLPMDTR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDIS&@KAU.A".ts_append_eval %Q|"YLPMDIS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMS&@KAU.A".ts_append_eval %Q|"YLPMDMS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDOR&@KAU.A".ts_append_eval %Q|"YLPMDOR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNFD&@KAU.A".ts_append_eval %Q|"YLPMNFD&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNTB&@KAU.A".ts_append_eval %Q|"YLPMNTB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNXM&@KAU.A".ts_append_eval %Q|"YLPMNXM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNCH&@KAU.A".ts_append_eval %Q|"YLPMNCH&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVLG&@KAU.A".ts_append_eval %Q|"YLPSVLG&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVED&@KAU.A".ts_append_eval %Q|"YLPSVED&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMU&@KAU.A".ts_append_eval %Q|"YLPSVMU&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVEN&@KAU.A".ts_append_eval %Q|"YLPSVEN&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YC_PR@MAU.A".ts_append_eval %Q|"YC_PR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "NDEA@HAW.A".ts_append_eval %Q|"NDEA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "AAMC@HON.A".ts_append_eval %Q|"AAMC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFL@HAW.A".ts_append_eval %Q|"ANFL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCPI@HI.A".ts_append_eval %Q|"AVCPI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLA@KAU.A".ts_append_eval %Q|"AVLA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSU@HI.A".ts_append_eval %Q|"AVCSU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AACF@KAU.A".ts_append_eval %Q|"AACF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFL@KAU.A".ts_append_eval %Q|"AVCFL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFR@MAU.A".ts_append_eval %Q|"ANFR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANVG@KAU.A".ts_append_eval %Q|"ANVG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFR@HAW.A".ts_append_eval %Q|"ANFR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YLRE@MAU.A".ts_append_eval %Q|"YLRE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFOT@HON.A".ts_append_eval %Q|"YLAGFFOT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNND@KAU.A".ts_append_eval %Q|"YLMNND@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "KVIHST@KAU.A".ts_append_eval %Q|"KVIHST@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVT@KAU.A".ts_append_eval %Q|"KVT@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVI@KAU.A".ts_append_eval %Q|"KVI@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GGNGNS@KAU.A".ts_append_eval %Q|"GGNGNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GPWKNS@KAU.A".ts_append_eval %Q|"GPWKNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GCULNS@KAU.A".ts_append_eval %Q|"GCULNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GPWFNS@KAU.A".ts_append_eval %Q|"GPWFNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GCAPNS@KAU.A".ts_append_eval %Q|"GCAPNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GNS@KAU.A".ts_append_eval %Q|"GNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "RTNS@KAU.A".ts_append_eval %Q|"RTNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "ROLCNNS@KAU.A".ts_append_eval %Q|"ROLCNNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "RORENNS@KAU.A".ts_append_eval %Q|"RORENNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "ROINTNS@KAU.A".ts_append_eval %Q|"ROINTNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "ROITGNS@KAU.A".ts_append_eval %Q|"ROITGNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "Y@MAU.A".ts_append_eval %Q|"Y@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
  "Y@MAU.A".ts_append_eval %Q|"Y@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "ANTR@HAW.A".ts_append_eval %Q|"ANTR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANTR@HON.A".ts_append_eval %Q|"ANTR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANMC@KAU.A".ts_append_eval %Q|"ANMC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANTR@MAU.A".ts_append_eval %Q|"ANTR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFL@MAU.A".ts_append_eval %Q|"ANFL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSC@HON.A".ts_append_eval %Q|"AVCSC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLCT@HI.A".ts_append_eval %Q|"AVLCT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLHG@KAU.A".ts_append_eval %Q|"AVLHG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVL@KAU.A".ts_append_eval %Q|"AVL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVA@MAU.A".ts_append_eval %Q|"AVA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMNNDAP@HI.A".ts_append_eval %Q|"YCMNNDAP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC@HI.A".ts_append_eval %Q|"YC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAVR@HI.A".ts_append_eval %Q|"YCAVR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFA@HI.A".ts_append_eval %Q|"YCAGFA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_NF@HI.A".ts_append_eval %Q|"YC_NF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_PR@HI.A".ts_append_eval %Q|"YC_PR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFF@HI.A".ts_append_eval %Q|"YCAGFF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFS@HI.A".ts_append_eval %Q|"YCAGFFFS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFSP@HI.A".ts_append_eval %Q|"YCAGFFSP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRTR@HI.A".ts_append_eval %Q|"YCMNDRTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFR@HI.A".ts_append_eval %Q|"YCMNDRFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNND@HI.A".ts_append_eval %Q|"YCMNND@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXM@HI.A".ts_append_eval %Q|"YCMNNDXM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDLT@HI.A".ts_append_eval %Q|"YCMNNDLT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDCH@HI.A".ts_append_eval %Q|"YCMNNDCH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRT@HI.A".ts_append_eval %Q|"YCRT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMV@HI.A".ts_append_eval %Q|"YCRTMV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTA@HI.A".ts_append_eval %Q|"YCTWTA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTR@HI.A".ts_append_eval %Q|"YCTWTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTW@HI.A".ts_append_eval %Q|"YCTWTW@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTG@HI.A".ts_append_eval %Q|"YCTWTG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWPL@HI.A".ts_append_eval %Q|"YCTWPL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSC@HI.A".ts_append_eval %Q|"YCTWSC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRE@HI.A".ts_append_eval %Q|"YCRE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERE@HI.A".ts_append_eval %Q|"YCRERE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERL@HI.A".ts_append_eval %Q|"YCRERL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCPS@HI.A".ts_append_eval %Q|"YCPS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMA@HI.A".ts_append_eval %Q|"YCMA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADWM@HI.A".ts_append_eval %Q|"YCADWM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCED@HI.A".ts_append_eval %Q|"YCED@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHC@HI.A".ts_append_eval %Q|"YCHC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCNR@HI.A".ts_append_eval %Q|"YCHCNR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAE@HI.A".ts_append_eval %Q|"YCAE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEMU@HI.A".ts_append_eval %Q|"YCAEMU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAERE@HI.A".ts_append_eval %Q|"YCAERE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFFD@HI.A".ts_append_eval %Q|"YCAFFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSRP@HI.A".ts_append_eval %Q|"YCOSRP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSPL@HI.A".ts_append_eval %Q|"YCOSPL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSMA@HI.A".ts_append_eval %Q|"YCOSMA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSHH@HI.A".ts_append_eval %Q|"YCOSHH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGV@HI.A".ts_append_eval %Q|"YCGV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVLC@HI.A".ts_append_eval %Q|"YCGVLC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_NF@HON.A".ts_append_eval %Q|"YC_NF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFF@HON.A".ts_append_eval %Q|"YCAGFF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMISP@HON.A".ts_append_eval %Q|"YCMISP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTBL@HON.A".ts_append_eval %Q|"YCCTBL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHC@HON.A".ts_append_eval %Q|"YCHC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAF@HON.A".ts_append_eval %Q|"YCAF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSHH@HON.A".ts_append_eval %Q|"YCOSHH@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVML@HON.A".ts_append_eval %Q|"YCGVML@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCT@HAW.A".ts_append_eval %Q|"YCCT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTSP@HAW.A".ts_append_eval %Q|"YCCTSP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRWD@HAW.A".ts_append_eval %Q|"YCMNDRWD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFB@HAW.A".ts_append_eval %Q|"YCMNDRFB@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFBC@HAW.A".ts_append_eval %Q|"YCIFBC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_PR@KAU.A".ts_append_eval %Q|"YC_PR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFF@KAU.A".ts_append_eval %Q|"YCAGFF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFO@KAU.A".ts_append_eval %Q|"YCAGFFFO@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMISP@KAU.A".ts_append_eval %Q|"YCMISP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCT@KAU.A".ts_append_eval %Q|"YCCT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_NF@MAU.A".ts_append_eval %Q|"YC_NF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFF@MAU.A".ts_append_eval %Q|"YCAGFF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFO@MAU.A".ts_append_eval %Q|"YCAGFFFO@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFSP@MAU.A".ts_append_eval %Q|"YCAGFFSP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFOT@MAU.A".ts_append_eval %Q|"YCAGFFOT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIOG@MAU.A".ts_append_eval %Q|"YCMIOG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIMI@MAU.A".ts_append_eval %Q|"YCMIMI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMISP@MAU.A".ts_append_eval %Q|"YCMISP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRNM@MAU.A".ts_append_eval %Q|"YCMNDRNM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMS@MAU.A".ts_append_eval %Q|"YCRTMS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTA@MAU.A".ts_append_eval %Q|"YCTWTA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTW@MAU.A".ts_append_eval %Q|"YCTWTW@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTT@MAU.A".ts_append_eval %Q|"YCTWTT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YSMISP@HI.A".ts_append_eval %Q|"YSMISP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSUT@HI.A".ts_append_eval %Q|"YSUT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRNM@HI.A".ts_append_eval %Q|"YSMNDRNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRFB@HI.A".ts_append_eval %Q|"YSMNDRFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDFD@HI.A".ts_append_eval %Q|"YSMNNDFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDPR@HI.A".ts_append_eval %Q|"YSMNNDPR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWTR@HI.A".ts_append_eval %Q|"YSTWTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWTT@HI.A".ts_append_eval %Q|"YSTWTT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWTG@HI.A".ts_append_eval %Q|"YSTWTG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWSP@HI.A".ts_append_eval %Q|"YSTWSP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSIFPB@HI.A".ts_append_eval %Q|"YSIFPB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSPS@HI.A".ts_append_eval %Q|"YSPS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAE@HI.A".ts_append_eval %Q|"YSAE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAFFD@HI.A".ts_append_eval %Q|"YSAFFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSGVML@HI.A".ts_append_eval %Q|"YSGVML@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "AAFR@HI.A".ts_append_eval %Q|"AAFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAPI@HAW.A".ts_append_eval %Q|"AAPI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAVG@HAW.A".ts_append_eval %Q|"AAVG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAFR@HAW.A".ts_append_eval %Q|"AAFR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AACF@HAW.A".ts_append_eval %Q|"AACF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAOT@HAW.A".ts_append_eval %Q|"AAOT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AA@HAW.A".ts_append_eval %Q|"AA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAPI@HON.A".ts_append_eval %Q|"AAPI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AACF@HON.A".ts_append_eval %Q|"AACF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAOT@HON.A".ts_append_eval %Q|"AAOT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAPI@KAU.A".ts_append_eval %Q|"AAPI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAVG@KAU.A".ts_append_eval %Q|"AAVG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAFR@KAU.A".ts_append_eval %Q|"AAFR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAMC@KAU.A".ts_append_eval %Q|"AAMC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAOT@KAU.A".ts_append_eval %Q|"AAOT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAPI@MAU.A".ts_append_eval %Q|"AAPI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AAOT@MAU.A".ts_append_eval %Q|"AAOT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANSU@HI.A".ts_append_eval %Q|"ANSU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANPI@HI.A".ts_append_eval %Q|"ANPI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANCF@HI.A".ts_append_eval %Q|"ANCF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANTR@HI.A".ts_append_eval %Q|"ANTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFL@HI.A".ts_append_eval %Q|"ANFL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANSU@HON.A".ts_append_eval %Q|"ANSU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANMC@MAU.A".ts_append_eval %Q|"ANMC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFL@HON.A".ts_append_eval %Q|"AVCFL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSU@KAU.A".ts_append_eval %Q|"AVCSU@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFL@MAU.A".ts_append_eval %Q|"AVCFL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLML@HI.A".ts_append_eval %Q|"AVLML@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCCT@HI.A".ts_append_eval %Q|"YCCT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTHV@HI.A".ts_append_eval %Q|"YCCTHV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGM@HI.A".ts_append_eval %Q|"YCRTGM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTT@HI.A".ts_append_eval %Q|"YCTWTT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSP@HI.A".ts_append_eval %Q|"YCTWSP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWWH@HI.A".ts_append_eval %Q|"YCTWWH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCUT@HI.A".ts_append_eval %Q|"YCUT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMN@HI.A".ts_append_eval %Q|"YCMN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDR@HI.A".ts_append_eval %Q|"YCMNDR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRWD@HI.A".ts_append_eval %Q|"YCMNDRWD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRNM@HI.A".ts_append_eval %Q|"YCMNDRNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRCM@HI.A".ts_append_eval %Q|"YCMNDRCM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMV@HI.A".ts_append_eval %Q|"YCMNDRMV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDFD@HI.A".ts_append_eval %Q|"YCMNNDFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXP@HI.A".ts_append_eval %Q|"YCMNNDXP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPT@HI.A".ts_append_eval %Q|"YCMNNDPT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPL@HI.A".ts_append_eval %Q|"YCMNNDPL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRELE@HI.A".ts_append_eval %Q|"YCRELE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADAD@HI.A".ts_append_eval %Q|"YCADAD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEPF@HI.A".ts_append_eval %Q|"YCAEPF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAF@HI.A".ts_append_eval %Q|"YCAF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFAC@HI.A".ts_append_eval %Q|"YCAFAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC@HON.A".ts_append_eval %Q|"YC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFA@HON.A".ts_append_eval %Q|"YCAGFA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFOT@HON.A".ts_append_eval %Q|"YCAGFFOT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCUT@HON.A".ts_append_eval %Q|"YCUT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTHV@HON.A".ts_append_eval %Q|"YCCTHV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMN@HON.A".ts_append_eval %Q|"YCMN@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRWD@HON.A".ts_append_eval %Q|"YCMNDRWD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRCM@HON.A".ts_append_eval %Q|"YCMNDRCM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMV@HON.A".ts_append_eval %Q|"YCMNDRMV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDFD@HON.A".ts_append_eval %Q|"YCMNNDFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDBV@HON.A".ts_append_eval %Q|"YCMNNDBV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPR@HON.A".ts_append_eval %Q|"YCMNNDPR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPT@HON.A".ts_append_eval %Q|"YCMNNDPT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDCH@HON.A".ts_append_eval %Q|"YCMNNDCH@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPL@HON.A".ts_append_eval %Q|"YCMNNDPL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRT@HON.A".ts_append_eval %Q|"YCRT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTHC@HON.A".ts_append_eval %Q|"YCRTHC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTCL@HON.A".ts_append_eval %Q|"YCRTCL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTOT@HON.A".ts_append_eval %Q|"YCRTOT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWPL@HON.A".ts_append_eval %Q|"YCTWPL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSC@HON.A".ts_append_eval %Q|"YCTWSC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIF@HON.A".ts_append_eval %Q|"YCIF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFBC@HON.A".ts_append_eval %Q|"YCIFBC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFIT@HON.A".ts_append_eval %Q|"YCIFIT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFDP@HON.A".ts_append_eval %Q|"YCIFDP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFI@HON.A".ts_append_eval %Q|"YCFI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFICR@HON.A".ts_append_eval %Q|"YCFICR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFISE@HON.A".ts_append_eval %Q|"YCFISE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRE@HON.A".ts_append_eval %Q|"YCRE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMA@HON.A".ts_append_eval %Q|"YCMA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAD@HON.A".ts_append_eval %Q|"YCAD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCED@HON.A".ts_append_eval %Q|"YCED@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEPF@HON.A".ts_append_eval %Q|"YCAEPF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAERE@HON.A".ts_append_eval %Q|"YCAERE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSRP@HON.A".ts_append_eval %Q|"YCOSRP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSPL@HON.A".ts_append_eval %Q|"YCOSPL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVFD@HON.A".ts_append_eval %Q|"YCGVFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_GVSL@HON.A".ts_append_eval %Q|"YC_GVSL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABPEN@HAW.A".ts_append_eval %Q|"YOTLABPEN@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YC_NF@HAW.A".ts_append_eval %Q|"YC_NF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFF@HAW.A".ts_append_eval %Q|"YCAGFF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFO@HAW.A".ts_append_eval %Q|"YCAGFFFO@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFS@HAW.A".ts_append_eval %Q|"YCAGFFFS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFOT@HAW.A".ts_append_eval %Q|"YCAGFFOT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMI@HAW.A".ts_append_eval %Q|"YCMI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIOG@HAW.A".ts_append_eval %Q|"YCMIOG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIMI@HAW.A".ts_append_eval %Q|"YCMIMI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMISP@HAW.A".ts_append_eval %Q|"YCMISP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTBL@HAW.A".ts_append_eval %Q|"YCCTBL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTHV@HAW.A".ts_append_eval %Q|"YCCTHV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMN@HAW.A".ts_append_eval %Q|"YCMN@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDR@HAW.A".ts_append_eval %Q|"YCMNDR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRPM@HAW.A".ts_append_eval %Q|"YCMNDRPM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMC@HAW.A".ts_append_eval %Q|"YCMNDRMC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRTR@HAW.A".ts_append_eval %Q|"YCMNDRTR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDFD@HAW.A".ts_append_eval %Q|"YCMNNDFD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXM@HAW.A".ts_append_eval %Q|"YCMNNDXM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDAP@HAW.A".ts_append_eval %Q|"YCMNNDAP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDLT@HAW.A".ts_append_eval %Q|"YCMNNDLT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCWT@HAW.A".ts_append_eval %Q|"YCWT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMV@HAW.A".ts_append_eval %Q|"YCRTMV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTEL@HAW.A".ts_append_eval %Q|"YCRTEL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTBL@HAW.A".ts_append_eval %Q|"YCRTBL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFD@HAW.A".ts_append_eval %Q|"YCRTFD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTHC@HAW.A".ts_append_eval %Q|"YCRTHC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGA@HAW.A".ts_append_eval %Q|"YCRTGA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTCL@HAW.A".ts_append_eval %Q|"YCRTCL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTSP@HAW.A".ts_append_eval %Q|"YCRTSP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGM@HAW.A".ts_append_eval %Q|"YCRTGM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMS@HAW.A".ts_append_eval %Q|"YCRTMS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTW@HAW.A".ts_append_eval %Q|"YCTW@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTA@HAW.A".ts_append_eval %Q|"YCTWTA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTR@HAW.A".ts_append_eval %Q|"YCTWTR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTW@HAW.A".ts_append_eval %Q|"YCTWTW@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWPL@HAW.A".ts_append_eval %Q|"YCTWPL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSC@HAW.A".ts_append_eval %Q|"YCTWSC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWWH@HAW.A".ts_append_eval %Q|"YCTWWH@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIF@HAW.A".ts_append_eval %Q|"YCIF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFPB@HAW.A".ts_append_eval %Q|"YCIFPB@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFDP@HAW.A".ts_append_eval %Q|"YCIFDP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFOT@HAW.A".ts_append_eval %Q|"YCIFOT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRE@HAW.A".ts_append_eval %Q|"YCRE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMA@HAW.A".ts_append_eval %Q|"YCMA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADWM@HAW.A".ts_append_eval %Q|"YCADWM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCED@HAW.A".ts_append_eval %Q|"YCED@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHC@HAW.A".ts_append_eval %Q|"YCHC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAERE@HAW.A".ts_append_eval %Q|"YCAERE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAF@HAW.A".ts_append_eval %Q|"YCAF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFAC@HAW.A".ts_append_eval %Q|"YCAFAC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOS@HAW.A".ts_append_eval %Q|"YCOS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSMA@HAW.A".ts_append_eval %Q|"YCOSMA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSHH@HAW.A".ts_append_eval %Q|"YCOSHH@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABSS@KAU.A".ts_append_eval %Q|"YOTLABSS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAGFA@KAU.A".ts_append_eval %Q|"YCAGFA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFS@KAU.A".ts_append_eval %Q|"YCAGFFFS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCUT@KAU.A".ts_append_eval %Q|"YCUT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTHV@KAU.A".ts_append_eval %Q|"YCCTHV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMN@KAU.A".ts_append_eval %Q|"YCMN@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRWD@KAU.A".ts_append_eval %Q|"YCMNDRWD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRPM@KAU.A".ts_append_eval %Q|"YCMNDRPM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFR@KAU.A".ts_append_eval %Q|"YCMNDRFR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLAB@HI.A".ts_append_eval %Q|"YOTLAB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YOTLAB@HI.A".ts_append_eval %Q|"YOTLAB@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLABPEN@HI.A".ts_append_eval %Q|"YOTLABPEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YOTLABPEN@HI.A".ts_append_eval %Q|"YOTLABPEN@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLABSS@HI.A".ts_append_eval %Q|"YOTLABSS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YOTLABSS@HI.A".ts_append_eval %Q|"YOTLABSS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFO@HI.A".ts_append_eval %Q|"YLAGFFFO@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIOG@HI.A".ts_append_eval %Q|"YLMIOG@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMISP@HI.A".ts_append_eval %Q|"YLMISP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLUT@HI.A".ts_append_eval %Q|"YLUT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTSP@HI.A".ts_append_eval %Q|"YLCTSP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFD@HI.A".ts_append_eval %Q|"YLRTFD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTCL@HI.A".ts_append_eval %Q|"YLRTCL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMS@HI.A".ts_append_eval %Q|"YLRTMS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTOT@HI.A".ts_append_eval %Q|"YLRTOT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWPL@HI.A".ts_append_eval %Q|"YLTWPL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSP@HI.A".ts_append_eval %Q|"YLTWSP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFPB@HI.A".ts_append_eval %Q|"YLIFPB@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFMP@HI.A".ts_append_eval %Q|"YLIFMP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFBC@HI.A".ts_append_eval %Q|"YLIFBC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFIT@HI.A".ts_append_eval %Q|"YLIFIT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFDP@HI.A".ts_append_eval %Q|"YLIFDP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFOT@HI.A".ts_append_eval %Q|"YLIFOT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIMO@HI.A".ts_append_eval %Q|"YLFIMO@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLED@HI.A".ts_append_eval %Q|"YLED@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLED@HI.A".ts_append_eval %Q|"YLED@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFAC@HI.A".ts_append_eval %Q|"YLAFAC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFAC@HI.A".ts_append_eval %Q|"YLAFAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGVLC@HI.A".ts_append_eval %Q|"YLGVLC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGVLC@HI.A".ts_append_eval %Q|"YLGVLC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFO@HON.A".ts_append_eval %Q|"YLAGFFFO@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDR@HON.A".ts_append_eval %Q|"YLMNDR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTHC@HON.A".ts_append_eval %Q|"YLRTHC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGA@HON.A".ts_append_eval %Q|"YLRTGA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTOT@HON.A".ts_append_eval %Q|"YLRTOT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPA@HAW.A".ts_append_eval %Q|"YLMNNDPA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPL@HAW.A".ts_append_eval %Q|"YLMNNDPL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDREL@MAU.A".ts_append_eval %Q|"YLMNDREL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMV@MAU.A".ts_append_eval %Q|"YLMNDRMV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRTR@MAU.A".ts_append_eval %Q|"YLMNDRTR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDBV@MAU.A".ts_append_eval %Q|"YLMNNDBV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTBL@KAU.A".ts_append_eval %Q|"YLCTBL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTHV@KAU.A".ts_append_eval %Q|"YLCTHV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFOT@KAU.A".ts_append_eval %Q|"YLIFOT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "PCHSHF@HON.S".ts_append_eval %Q|"PCHSHF@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCFBFD@HON.S".ts_append_eval %Q|"PCFBFD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PC_SH@HON.S".ts_append_eval %Q|"PC_SH@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCCM@HON.S".ts_append_eval %Q|"PCCM@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSFUGSE@HON.S".ts_append_eval %Q|"PCHSFUGSE@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSFUEL@HON.S".ts_append_eval %Q|"PCHSFUEL@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCFBFDBV@HON.S".ts_append_eval %Q|"PCFBFDBV@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PC_MD@HON.S".ts_append_eval %Q|"PC_MD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSSHOW@HON.S".ts_append_eval %Q|"PCHSSHOW@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PC@HON.S".ts_append_eval %Q|"PC@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSFUGSU@HON.S".ts_append_eval %Q|"PCHSFUGSU@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHS@HON.S".ts_append_eval %Q|"PCHS@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCFBFDHM@HON.S".ts_append_eval %Q|"PCFBFDHM@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "YMED@KAU.A".ts_append_eval %Q|"YMED@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/misc/hud/update/hud_upd.xls"|
  "YPCBEA@HI.A".ts_append_eval %Q|"YPCBEA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YPCBEA@HI.A".ts_append_eval %Q|"YPCBEA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCT@HI.A".ts_append_eval %Q|"YLCT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLCT@HI.A".ts_append_eval %Q|"YLCT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIF@HI.A".ts_append_eval %Q|"YLIF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLIF@HI.A".ts_append_eval %Q|"YLIF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAF@HI.A".ts_append_eval %Q|"YLAF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLAF@HI.A".ts_append_eval %Q|"YLAF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "Y@HON.A".ts_append_eval %Q|"Y@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "Y@HON.A".ts_append_eval %Q|"Y@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL@HON.A".ts_append_eval %Q|"YL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YL@HON.A".ts_append_eval %Q|"YL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YDIV@HON.A".ts_append_eval %Q|"YDIV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YDIV@HON.A".ts_append_eval %Q|"YDIV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YTRNSF@HON.A".ts_append_eval %Q|"YTRNSF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YTRNSF@HON.A".ts_append_eval %Q|"YTRNSF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVFD@HON.A".ts_append_eval %Q|"YLGVFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLGVFD@HON.A".ts_append_eval %Q|"YLGVFD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVML@HON.A".ts_append_eval %Q|"YLGVML@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLGVML@HON.A".ts_append_eval %Q|"YLGVML@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCT@HON.A".ts_append_eval %Q|"YLCT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLCT@HON.A".ts_append_eval %Q|"YLCT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFI@HON.A".ts_append_eval %Q|"YLFI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLFI@HON.A".ts_append_eval %Q|"YLFI@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAF@HON.A".ts_append_eval %Q|"YLAF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLAF@HON.A".ts_append_eval %Q|"YLAF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFAC@HON.A".ts_append_eval %Q|"YLAFAC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLAFAC@HON.A".ts_append_eval %Q|"YLAFAC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_OT@HON.A".ts_append_eval %Q|"YL_OT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YRESADJ@HAW.A".ts_append_eval %Q|"YRESADJ@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YRESADJ@HAW.A".ts_append_eval %Q|"YRESADJ@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "GDP_CP@JP.A".ts_append_eval %Q|"GDP_CP@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_INRP_R@JP.A".ts_append_eval %Q|"GDP_INRP_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_IFX@JP.A".ts_append_eval %Q|"GDP_IFX@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GNI_R@JP.A".ts_append_eval %Q|"GNI_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_IFX_R@JP.A".ts_append_eval %Q|"GDP_IFX_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "KNAAPT@HON.M".ts_append_eval %Q|"KNAAPT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KNAHTL@HON.M".ts_append_eval %Q|"KNAHTL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KNAAMU@HON.M".ts_append_eval %Q|"KNAAMU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVNSGF@HON.M".ts_append_eval %Q|"KVNSGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVNHTL@HON.M".ts_append_eval %Q|"KVNHTL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVAAPT@HON.M".ts_append_eval %Q|"KVAAPT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "TGRMNNS@HI.A".ts_append_eval %Q|"TGRMNNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRWTNS@HI.A".ts_append_eval %Q|"TGRWTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSINS@HI.A".ts_append_eval %Q|"TGRSINS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPINS@HAW.A".ts_append_eval %Q|"TGRPINS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPDNS@HAW.A".ts_append_eval %Q|"TGRPDNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRMNNS@HAW.A".ts_append_eval %Q|"TGRMNNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRNS@KAU.A".ts_append_eval %Q|"TGRNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "VSOJPNS@MAU.M".ts_append_eval %Q|"VSOJPNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTANS@MAU.M".ts_append_eval %Q|"VSOOTANS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@MAU.M".ts_append_eval %Q|"VSOAUSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@MAU.M".ts_append_eval %Q|"VSOOTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@KAU.M".ts_append_eval %Q|"VSOITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOJPNS@KAU.M".ts_append_eval %Q|"VSOJPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@KAU.M".ts_append_eval %Q|"VSOCANNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@KAU.M".ts_append_eval %Q|"VSOAUSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@KAU.M".ts_append_eval %Q|"VSOOTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSENS@HAWK.M".ts_append_eval %Q|"VSOUSENS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@HAWK.M".ts_append_eval %Q|"VSOAUSNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@HAWK.M".ts_append_eval %Q|"VSOOTNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSENS@HAWH.M".ts_append_eval %Q|"VSOUSENS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@HAWH.M".ts_append_eval %Q|"VSOITNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOJPNS@HAWH.M".ts_append_eval %Q|"VSOJPNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@HAWH.M".ts_append_eval %Q|"VSOCANNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTANS@HAWH.M".ts_append_eval %Q|"VSOOTANS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@HAWH.M".ts_append_eval %Q|"VSOAUSNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@HAWH.M".ts_append_eval %Q|"VSOOTNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VXPDUSW@HI.A".ts_append_eval %Q|"VXPDUSW@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSWTR@HI.A".ts_append_eval %Q|"VXPDUSWTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSWSH@HI.A".ts_append_eval %Q|"VXPDUSWSH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSWAC@HI.A".ts_append_eval %Q|"VXPDUSWAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSWOT@HI.A".ts_append_eval %Q|"VXPDUSWOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSE@HI.A".ts_append_eval %Q|"VXPDUSE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSEFB@HI.A".ts_append_eval %Q|"VXPDUSEFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSEEN@HI.A".ts_append_eval %Q|"VXPDUSEEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSETR@HI.A".ts_append_eval %Q|"VXPDUSETR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSESH@HI.A".ts_append_eval %Q|"VXPDUSESH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSEAC@HI.A".ts_append_eval %Q|"VXPDUSEAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDUSEOT@HI.A".ts_append_eval %Q|"VXPDUSEOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDJP@HI.A".ts_append_eval %Q|"VXPDJP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDJPAC@HI.A".ts_append_eval %Q|"VXPDJPAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDJPOT@HI.A".ts_append_eval %Q|"VXPDJPOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCAN@HI.A".ts_append_eval %Q|"VXPDCAN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANFB@HI.A".ts_append_eval %Q|"VXPDCANFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANEN@HI.A".ts_append_eval %Q|"VXPDCANEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANTR@HI.A".ts_append_eval %Q|"VXPDCANTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANSH@HI.A".ts_append_eval %Q|"VXPDCANSH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANAC@HI.A".ts_append_eval %Q|"VXPDCANAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDCANOT@HI.A".ts_append_eval %Q|"VXPDCANOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VX@HI.A".ts_append_eval %Q|"VX@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXFB@HI.A".ts_append_eval %Q|"VXFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXTR@HI.A".ts_append_eval %Q|"VXTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXSH@HI.A".ts_append_eval %Q|"VXSH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "GDP_NX@US.A".ts_append_eval %Q|"GDP_NX@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_I@US.A".ts_append_eval %Q|"GDP_I@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_EX@US.A".ts_append_eval %Q|"GDP_EX@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GNP_R@US.A".ts_append_eval %Q|"GNP_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GNP@US.A".ts_append_eval %Q|"GNP@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IM_R@US.A".ts_append_eval %Q|"GDP_IM_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YCE@US.A".ts_append_eval %Q|"YCE@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GNPPC_R@US.A".ts_append_eval %Q|"GNPPC_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_R@US.A".ts_append_eval %Q|"GDP_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IIV_R@US.A".ts_append_eval %Q|"GDP_IIV_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_G@US.A".ts_append_eval %Q|"GDP_G@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDPPC_R@US.A".ts_append_eval %Q|"GDPPC_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YCE_R@US.A".ts_append_eval %Q|"YCE_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GNPPC@US.A".ts_append_eval %Q|"GNPPC@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_I_R@US.A".ts_append_eval %Q|"GDP_I_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IM@US.A".ts_append_eval %Q|"GDP_IM@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_G_R@US.A".ts_append_eval %Q|"GDP_G_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_CS@US.A".ts_append_eval %Q|"GDP_CS@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YDPI@US.A".ts_append_eval %Q|"YDPI@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "Y@US.A".ts_append_eval %Q|"Y@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YPC@US.A".ts_append_eval %Q|"YPC@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "N@US.A".ts_append_eval %Q|"N@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "INF@CA.A".ts_append_eval %Q|"INF@CA.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_INR@US.A".ts_append_eval %Q|"GDP_INR@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_C_R@US.A".ts_append_eval %Q|"GDP_C_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YDPI_R@US.A".ts_append_eval %Q|"YDPI_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IFX@US.A".ts_append_eval %Q|"GDP_IFX@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YP_R@CA.A".ts_append_eval %Q|"YP_R@CA.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YPCCE_R@US.A".ts_append_eval %Q|"YPCCE_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YPCCE@US.A".ts_append_eval %Q|"YPCCE@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IFX_R@US.A".ts_append_eval %Q|"GDP_IFX_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YPCDPI@US.A".ts_append_eval %Q|"YPCDPI@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_INR_R@US.A".ts_append_eval %Q|"GDP_INR_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IIV@US.A".ts_append_eval %Q|"GDP_IIV@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_EX_R@US.A".ts_append_eval %Q|"GDP_EX_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_NX_R@US.A".ts_append_eval %Q|"GDP_NX_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "GDP_IRS@US.A".ts_append_eval %Q|"GDP_IRS@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "CPI@CA.A".ts_append_eval %Q|"CPI@CA.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "YLOSRP@HI.A".ts_append_eval %Q|"YLOSRP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSPL@HI.A".ts_append_eval %Q|"YLOSPL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSMA@HI.A".ts_append_eval %Q|"YLOSMA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTBL@HON.A".ts_append_eval %Q|"YLRTBL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFD@HON.A".ts_append_eval %Q|"YLRTFD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDAP@HAW.A".ts_append_eval %Q|"YLMNNDAP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDLT@HAW.A".ts_append_eval %Q|"YLMNNDLT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCAM@HAW.A".ts_append_eval %Q|"YLHCAM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCHO@HAW.A".ts_append_eval %Q|"YLHCHO@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCNR@HAW.A".ts_append_eval %Q|"YLHCNR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCSO@HAW.A".ts_append_eval %Q|"YLHCSO@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEPF@HAW.A".ts_append_eval %Q|"YLAEPF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRNM@MAU.A".ts_append_eval %Q|"YLMNDRNM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRPM@MAU.A".ts_append_eval %Q|"YLMNDRPM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFB@MAU.A".ts_append_eval %Q|"YLMNDRFB@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMC@MAU.A".ts_append_eval %Q|"YLMNDRMC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRCM@MAU.A".ts_append_eval %Q|"YLMNDRCM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIIN@MAU.A".ts_append_eval %Q|"YLFIIN@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIOT@MAU.A".ts_append_eval %Q|"YLFIOT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERE@MAU.A".ts_append_eval %Q|"YLRERE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERL@MAU.A".ts_append_eval %Q|"YLRERL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRELE@MAU.A".ts_append_eval %Q|"YLRELE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMI@KAU.A".ts_append_eval %Q|"YLMI@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIOG@KAU.A".ts_append_eval %Q|"YLMIOG@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIMI@KAU.A".ts_append_eval %Q|"YLMIMI@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMISP@KAU.A".ts_append_eval %Q|"YLMISP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFPB@KAU.A".ts_append_eval %Q|"YLIFPB@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFMP@KAU.A".ts_append_eval %Q|"YLIFMP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFBC@KAU.A".ts_append_eval %Q|"YLIFBC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFIT@KAU.A".ts_append_eval %Q|"YLIFIT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFTC@KAU.A".ts_append_eval %Q|"YLIFTC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFDP@KAU.A".ts_append_eval %Q|"YLIFDP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROPNF&@HI.A".ts_append_eval %Q|"YPROPNF&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDST&@HAW.A".ts_append_eval %Q|"YLPMDST&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMN&@HAW.A".ts_append_eval %Q|"YLPMN&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAU&@HAW.A".ts_append_eval %Q|"YLPSVAU&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMR&@HAW.A".ts_append_eval %Q|"YLPSVMR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMI&@MAU.A".ts_append_eval %Q|"YLPMI&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPG&@MAU.A".ts_append_eval %Q|"YLPG&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@MAU.A".ts_append_eval %Q|"YLPGFC&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NMIG@HAW.A".ts_append_eval %Q|"NMIG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NRC@HON.A".ts_append_eval %Q|"NRC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NRCNM@NBI.A".ts_append_eval %Q|"NRCNM@NBI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "YL_PR@HON.A".ts_append_eval %Q|"YL_PR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YL_PR@HON.A".ts_append_eval %Q|"YL_PR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_TRADE@HON.A".ts_append_eval %Q|"YL_TRADE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YL_TU@HON.A".ts_append_eval %Q|"YL_TU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "TGBU4NS@MAU.A".ts_append_eval %Q|"TGBU4NS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBOTNS@MAU.A".ts_append_eval %Q|"TGBOTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPINS@HI.A".ts_append_eval %Q|"TGRPINS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPDNS@HI.A".ts_append_eval %Q|"TGRPDNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRORNS@HAW.A".ts_append_eval %Q|"TGRORNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU4NS@HAW.A".ts_append_eval %Q|"TGRU4NS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGROTNS@HAW.A".ts_append_eval %Q|"TGROTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRISNS@HAW.A".ts_append_eval %Q|"TGRISNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "VXPDML@HI.A".ts_append_eval %Q|"VXPDML@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|

  "TGBCT@HI.Q".ts_append_eval %Q|"TGBCT@HI.Q".tsn.load_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls"|
  "VEXPUS@HI.M".ts_append_eval %Q|"VEXPUS@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTUS@HI.M".ts_append_eval %Q|"VEXPPTUS@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PAKRSGF@MAU.Q".ts_append_eval %Q|"PAKRSGF@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PAKRSGF@KAU.Q".ts_append_eval %Q|"PAKRSGF@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRSGF@KAU.Q".ts_append_eval %Q|"PMKRSGF@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRCON@HI.Q".ts_append_eval %Q|"PMKRCON@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "YL_TRADE@HI.A".ts_append_eval %Q|"YL_TRADE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLMNNDFD@HI.A".ts_append_eval %Q|"YLMNNDFD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDBV@HI.A".ts_append_eval %Q|"YLMNNDBV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIOT@HI.A".ts_append_eval %Q|"YLFIOT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFR@HON.A".ts_append_eval %Q|"YLMNDRFR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMS@HON.A".ts_append_eval %Q|"YLMNDRMS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPL@HON.A".ts_append_eval %Q|"YLMNNDPL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTCL@HON.A".ts_append_eval %Q|"YLRTCL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFIT@HON.A".ts_append_eval %Q|"YLIFIT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADAD@HON.A".ts_append_eval %Q|"YLADAD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCAM@HON.A".ts_append_eval %Q|"YLHCAM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEPF@HON.A".ts_append_eval %Q|"YLAEPF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEMU@HON.A".ts_append_eval %Q|"YLAEMU@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSMA@HON.A".ts_append_eval %Q|"YLOSMA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGV@HON.A".ts_append_eval %Q|"YLGV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLGV@HON.A".ts_append_eval %Q|"YLGV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRCM@HAW.A".ts_append_eval %Q|"YLMNDRCM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDREL@HAW.A".ts_append_eval %Q|"YLMNDREL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNND@HAW.A".ts_append_eval %Q|"YLMNND@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTT@HAW.A".ts_append_eval %Q|"YLTWTT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIMO@HAW.A".ts_append_eval %Q|"YLFIMO@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMS@MAU.A".ts_append_eval %Q|"YLRTMS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTW@MAU.A".ts_append_eval %Q|"YLTWTW@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTG@MAU.A".ts_append_eval %Q|"YLTWTG@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWPL@MAU.A".ts_append_eval %Q|"YLTWPL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSC@MAU.A".ts_append_eval %Q|"YLTWSC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSP@MAU.A".ts_append_eval %Q|"YLTWSP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFPB@MAU.A".ts_append_eval %Q|"YLIFPB@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFIT@MAU.A".ts_append_eval %Q|"YLIFIT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFS@KAU.A".ts_append_eval %Q|"YLAGFFFS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGA@KAU.A".ts_append_eval %Q|"YLRTGA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTW@KAU.A".ts_append_eval %Q|"YLTWTW@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWCU@KAU.A".ts_append_eval %Q|"YLTWCU@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWWH@KAU.A".ts_append_eval %Q|"YLTWWH@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCAM@KAU.A".ts_append_eval %Q|"YLHCAM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCHO@KAU.A".ts_append_eval %Q|"YLHCHO@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YNETR@HI.A".ts_append_eval %Q|"YNETR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YNETR@HI.A".ts_append_eval %Q|"YNETR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRWD@HI.A".ts_append_eval %Q|"YLMNDRWD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDREL@HI.A".ts_append_eval %Q|"YLMNDREL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMV@HI.A".ts_append_eval %Q|"YLMNDRMV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRTR@HI.A".ts_append_eval %Q|"YLMNDRTR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRCM@HON.A".ts_append_eval %Q|"YLMNDRCM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIOG@HAW.A".ts_append_eval %Q|"YLMIOG@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YP&@HI.A".ts_append_eval %Q|"YP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPT&@HI.A".ts_append_eval %Q|"YLPMNPT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNRB&@HI.A".ts_append_eval %Q|"YLPMNRB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTW&@HI.A".ts_append_eval %Q|"YLPRTW&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRLT&@HI.A".ts_append_eval %Q|"YLPRLT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDEL&@MAU.A".ts_append_eval %Q|"YLPMDEL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMV&@MAU.A".ts_append_eval %Q|"YLPMDMV&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPA&@KAU.A".ts_append_eval %Q|"YLPMNPA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPR&@KAU.A".ts_append_eval %Q|"YLPMNPR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMB&@KAU.A".ts_append_eval %Q|"YLPSVMB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMS&@KAU.A".ts_append_eval %Q|"YLPSVMS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "RTFUNS@KAU.A".ts_append_eval %Q|"RTFUNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "VXPDMLFB@HI.A".ts_append_eval %Q|"VXPDMLFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDMLEN@HI.A".ts_append_eval %Q|"VXPDMLEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDMLTR@HI.A".ts_append_eval %Q|"VXPDMLTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDMLSH@HI.A".ts_append_eval %Q|"VXPDMLSH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDMLAC@HI.A".ts_append_eval %Q|"VXPDMLAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPDMLOT@HI.A".ts_append_eval %Q|"VXPDMLOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "TGBTHNS@HON.A".ts_append_eval %Q|"TGBTHNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBITNS@HON.A".ts_append_eval %Q|"TGBITNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCMNS@HON.A".ts_append_eval %Q|"TGBCMNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBHTNS@HON.A".ts_append_eval %Q|"TGBHTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBORNS@HON.A".ts_append_eval %Q|"TGBORNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU4NS@HON.A".ts_append_eval %Q|"TGBU4NS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBOTNS@HON.A".ts_append_eval %Q|"TGBOTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPINS@HON.A".ts_append_eval %Q|"TGBPINS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPDNS@HON.A".ts_append_eval %Q|"TGBPDNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBNS@HON.A".ts_append_eval %Q|"TGBNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBRTNS@MAU.A".ts_append_eval %Q|"TGBRTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSVNS@MAU.A".ts_append_eval %Q|"TGBSVNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCTNS@MAU.A".ts_append_eval %Q|"TGBCTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBTHNS@MAU.A".ts_append_eval %Q|"TGBTHNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBITNS@MAU.A".ts_append_eval %Q|"TGBITNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCMNS@MAU.A".ts_append_eval %Q|"TGBCMNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBORNS@MAU.A".ts_append_eval %Q|"TGBORNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCMNS@KAU.A".ts_append_eval %Q|"TGBCMNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBHTNS@KAU.A".ts_append_eval %Q|"TGBHTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBORNS@KAU.A".ts_append_eval %Q|"TGBORNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU4NS@KAU.A".ts_append_eval %Q|"TGBU4NS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBOTNS@KAU.A".ts_append_eval %Q|"TGBOTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBISNS@KAU.A".ts_append_eval %Q|"TGBISNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSUNS@KAU.A".ts_append_eval %Q|"TGBSUNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPINS@KAU.A".ts_append_eval %Q|"TGBPINS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPDNS@KAU.A".ts_append_eval %Q|"TGBPDNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBMNNS@KAU.A".ts_append_eval %Q|"TGBMNNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBWTNS@KAU.A".ts_append_eval %Q|"TGBWTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSINS@KAU.A".ts_append_eval %Q|"TGBSINS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU5NS@KAU.A".ts_append_eval %Q|"TGBU5NS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBNS@KAU.A".ts_append_eval %Q|"TGBNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRRTNS@HI.A".ts_append_eval %Q|"TGRRTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSVNS@HI.A".ts_append_eval %Q|"TGRSVNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCTNS@HI.A".ts_append_eval %Q|"TGRCTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRTHNS@HI.A".ts_append_eval %Q|"TGRTHNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRITNS@HI.A".ts_append_eval %Q|"TGRITNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCMNS@HI.A".ts_append_eval %Q|"TGRCMNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRHTNS@HI.A".ts_append_eval %Q|"TGRHTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU4NS@HI.A".ts_append_eval %Q|"TGRU4NS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGROTNS@HI.A".ts_append_eval %Q|"TGROTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRITNS@MAU.A".ts_append_eval %Q|"TGRITNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRHTNS@MAU.A".ts_append_eval %Q|"TGRHTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU4NS@MAU.A".ts_append_eval %Q|"TGRU4NS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGROTNS@MAU.A".ts_append_eval %Q|"TGROTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRISNS@MAU.A".ts_append_eval %Q|"TGRISNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSUNS@MAU.A".ts_append_eval %Q|"TGRSUNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPDNS@MAU.A".ts_append_eval %Q|"TGRPDNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRMNNS@MAU.A".ts_append_eval %Q|"TGRMNNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU5NS@MAU.A".ts_append_eval %Q|"TGRU5NS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRALNS@MAU.A".ts_append_eval %Q|"TGRALNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRNS@MAU.A".ts_append_eval %Q|"TGRNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRRTNS@HAW.A".ts_append_eval %Q|"TGRRTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSVNS@HAW.A".ts_append_eval %Q|"TGRSVNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCTNS@HAW.A".ts_append_eval %Q|"TGRCTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRTHNS@HAW.A".ts_append_eval %Q|"TGRTHNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRITNS@HAW.A".ts_append_eval %Q|"TGRITNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCMNS@HAW.A".ts_append_eval %Q|"TGRCMNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRHTNS@HAW.A".ts_append_eval %Q|"TGRHTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "KPPRVRSDNS@NBI.A".ts_append_eval %Q|"KPPRVRSDNS@NBI.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "KPPRVNRSDNS@HI.A".ts_append_eval %Q|"KPPRVNRSDNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "KPPRVRSDNS@HON.A".ts_append_eval %Q|"KPPRVRSDNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "KPPRVRSDNS@HI.A".ts_append_eval %Q|"KPPRVRSDNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "KPPRVNRSDNS@HI.M".ts_append_eval %Q|"KPPRVNRSDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "YLTWTA@HAW.A".ts_append_eval %Q|"YLTWTA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRT@KAU.A".ts_append_eval %Q|"YLRT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPSV&@KAU.A".ts_append_eval %Q|"YLPSV&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHL&@KAU.A".ts_append_eval %Q|"YLPSVHL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLAE@KAU.A".ts_append_eval %Q|"YLAE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHC@MAU.A".ts_append_eval %Q|"YLHC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAE@MAU.A".ts_append_eval %Q|"YLAE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAF@MAU.A".ts_append_eval %Q|"YLAF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAD@HAW.A".ts_append_eval %Q|"YLAD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRT@MAU.A".ts_append_eval %Q|"YLRT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLUT@MAU.A".ts_append_eval %Q|"YLUT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRT@HON.A".ts_append_eval %Q|"YLRT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLUT@HON.A".ts_append_eval %Q|"YLUT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCT@MAU.A".ts_append_eval %Q|"YLCT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLED@KAU.A".ts_append_eval %Q|"YLED@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPS@KAU.A".ts_append_eval %Q|"YLPS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLED@MAU.A".ts_append_eval %Q|"YLED@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPS@MAU.A".ts_append_eval %Q|"YLPS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLWT@MAU.A".ts_append_eval %Q|"YLWT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLWT@HON.A".ts_append_eval %Q|"YLWT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRT@HAW.A".ts_append_eval %Q|"YLRT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLUT@HAW.A".ts_append_eval %Q|"YLUT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFI@MAU.A".ts_append_eval %Q|"YLFI@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIF@KAU.A".ts_append_eval %Q|"YLIF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOS@KAU.A".ts_append_eval %Q|"YLOS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIF@MAU.A".ts_append_eval %Q|"YLIF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAD@KAU.A".ts_append_eval %Q|"YLAD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOS@MAU.A".ts_append_eval %Q|"YLOS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOS@HON.A".ts_append_eval %Q|"YLOS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMA@MAU.A".ts_append_eval %Q|"YLMA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMA@HON.A".ts_append_eval %Q|"YLMA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAD@MAU.A".ts_append_eval %Q|"YLAD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAD@HON.A".ts_append_eval %Q|"YLAD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMN@KAU.A".ts_append_eval %Q|"YLMN@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMN@MAU.A".ts_append_eval %Q|"YLMN@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHC@KAU.A".ts_append_eval %Q|"YLHC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAGFFFO@HON.A".ts_append_eval %Q|"YCAGFFFO@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "AAMC@HAW.A".ts_append_eval %Q|"AAMC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCMC@HI.A".ts_append_eval %Q|"AVCMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AGP@KAU.A".ts_append_eval %Q|"AGP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANFR@HON.A".ts_append_eval %Q|"ANFR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANMC@HAW.A".ts_append_eval %Q|"ANMC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "VISITNS@MAUI.M".ts_append_eval %Q|"VISITNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@KAU.M".ts_append_eval %Q|"VISUSWNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@MAUI.M".ts_append_eval %Q|"VISUSWNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYUSWNS@MAUI.M".ts_append_eval %Q|"VDAYUSWNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSENS@MOL.M".ts_append_eval %Q|"VISUSENS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYCANNS@MAUI.M".ts_append_eval %Q|"VDAYCANNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCANNS@HI.M".ts_append_eval %Q|"VISCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYCANNS@HAW.M".ts_append_eval %Q|"VDAYCANNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISITNS@LAN.M".ts_append_eval %Q|"VISITNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCANNS@MAUI.M".ts_append_eval %Q|"VISCANNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYJPNS@LAN.M".ts_append_eval %Q|"VDAYJPNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRDCNS@HI.M".ts_append_eval %Q|"VRDCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VISDMNS@MAUI.M".ts_append_eval %Q|"VISDMNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISDMNS@HI.M".ts_append_eval %Q|"VISDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISDMNS@HAW.M".ts_append_eval %Q|"VISDMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYCANNS@MOL.M".ts_append_eval %Q|"VDAYCANNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISNS@HI.M".ts_append_eval %Q|"VISNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@LAN.M".ts_append_eval %Q|"VISUSWNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSENS@MAU.M".ts_append_eval %Q|"VISUSENS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSENS@HON.M".ts_append_eval %Q|"VISUSENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISITNS@MOL.M".ts_append_eval %Q|"VISITNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYUSENS@KAU.M".ts_append_eval %Q|"VDAYUSENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYJPNS@MOL.M".ts_append_eval %Q|"VDAYJPNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@HAW.M".ts_append_eval %Q|"VISUSWNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCANNS@KAU.M".ts_append_eval %Q|"VISCANNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "AVA@HON.A".ts_append_eval %Q|"AVA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMNDRMC@HI.A".ts_append_eval %Q|"YCMNDRMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTHC@HI.A".ts_append_eval %Q|"YCRTHC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "ANSU@MAU.A".ts_append_eval %Q|"ANSU@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANPI@MAU.A".ts_append_eval %Q|"ANPI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANVG@MAU.A".ts_append_eval %Q|"ANVG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFR@HI.A".ts_append_eval %Q|"AVCFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCCF@HI.A".ts_append_eval %Q|"AVCCF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCTR@HI.A".ts_append_eval %Q|"AVCTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSC@HI.A".ts_append_eval %Q|"AVCSC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFL@HI.A".ts_append_eval %Q|"AVCFL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVC@HI   .A".ts_append_eval %Q|"AVC@HI   .A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSU@HAW.A".ts_append_eval %Q|"AVCSU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCPI@HAW.A".ts_append_eval %Q|"AVCPI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCVG@HAW.A".ts_append_eval %Q|"AVCVG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFR@HAW.A".ts_append_eval %Q|"AVCFR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCCF@HAW.A".ts_append_eval %Q|"AVCCF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCMC@HAW.A".ts_append_eval %Q|"AVCMC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCTR@HAW.A".ts_append_eval %Q|"AVCTR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSC@HAW.A".ts_append_eval %Q|"AVCSC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFL@HAW.A".ts_append_eval %Q|"AVCFL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVC@HAW   .A".ts_append_eval %Q|"AVC@HAW   .A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSU@HON.A".ts_append_eval %Q|"AVCSU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCPI@HON.A".ts_append_eval %Q|"AVCPI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCVG@HON.A".ts_append_eval %Q|"AVCVG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFR@HON.A".ts_append_eval %Q|"AVCFR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCCF@HON.A".ts_append_eval %Q|"AVCCF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSC@KAU.A".ts_append_eval %Q|"AVCSC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCCF@MAU.A".ts_append_eval %Q|"AVCCF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCMC@MAU.A".ts_append_eval %Q|"AVCMC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCTR@MAU.A".ts_append_eval %Q|"AVCTR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSC@MAU.A".ts_append_eval %Q|"AVCSC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVL@HI.A".ts_append_eval %Q|"AVL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AV@HI.A".ts_append_eval %Q|"AV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AGP@HI.A".ts_append_eval %Q|"AGP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLCT@HAW.A".ts_append_eval %Q|"AVLCT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLHG@HAW.A".ts_append_eval %Q|"AVLHG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLML@HAW.A".ts_append_eval %Q|"AVLML@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLEG@HAW.A".ts_append_eval %Q|"AVLEG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVL@HAW.A".ts_append_eval %Q|"AVL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AV@KAU.A".ts_append_eval %Q|"AV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCIFOT@HI.A".ts_append_eval %Q|"YCIFOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIOT@HI.A".ts_append_eval %Q|"YCFIOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPR@HI.A".ts_append_eval %Q|"YCMNNDPR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFD@HI.A".ts_append_eval %Q|"YCRTFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTCL@HI.A".ts_append_eval %Q|"YCRTCL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTW@HI.A".ts_append_eval %Q|"YCTW@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFMP@HI.A".ts_append_eval %Q|"YCIFMP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFBC@HI.A".ts_append_eval %Q|"YCIFBC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFIT@HI.A".ts_append_eval %Q|"YCIFIT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFTC@HI.A".ts_append_eval %Q|"YCIFTC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAD@HI.A".ts_append_eval %Q|"YCAD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCSO@HI.A".ts_append_eval %Q|"YCHCSO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOS@HI.A".ts_append_eval %Q|"YCOS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABPEN@HON.A".ts_append_eval %Q|"YOTLABPEN@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAVR@HON.A".ts_append_eval %Q|"YCAVR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_PR@HON.A".ts_append_eval %Q|"YC_PR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTSP@HON.A".ts_append_eval %Q|"YCCTSP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDR@HON.A".ts_append_eval %Q|"YCMNDR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFB@HON.A".ts_append_eval %Q|"YCMNDRFB@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMS@HON.A".ts_append_eval %Q|"YCMNDRMS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDAP@HON.A".ts_append_eval %Q|"YCMNNDAP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTA@HON.A".ts_append_eval %Q|"YCTWTA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWCU@HON.A".ts_append_eval %Q|"YCTWCU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFMP@HON.A".ts_append_eval %Q|"YCIFMP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFOT@HON.A".ts_append_eval %Q|"YCIFOT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIIN@HON.A".ts_append_eval %Q|"YCFIIN@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERE@HON.A".ts_append_eval %Q|"YCRERE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRELE@HON.A".ts_append_eval %Q|"YCRELE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCPS@HON.A".ts_append_eval %Q|"YCPS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADAD@HON.A".ts_append_eval %Q|"YCADAD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADWM@HON.A".ts_append_eval %Q|"YCADWM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCAM@HON.A".ts_append_eval %Q|"YCHCAM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCHO@HON.A".ts_append_eval %Q|"YCHCHO@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCNR@HON.A".ts_append_eval %Q|"YCHCNR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCSO@HON.A".ts_append_eval %Q|"YCHCSO@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAE@HON.A".ts_append_eval %Q|"YCAE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEMU@HON.A".ts_append_eval %Q|"YCAEMU@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFFD@HON.A".ts_append_eval %Q|"YCAFFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSMA@HON.A".ts_append_eval %Q|"YCOSMA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVLC@HON.A".ts_append_eval %Q|"YCGVLC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC@HAW.A".ts_append_eval %Q|"YC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABSS@HAW.A".ts_append_eval %Q|"YOTLABSS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAGFFSP@HAW.A".ts_append_eval %Q|"YCAGFFSP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRNM@HAW.A".ts_append_eval %Q|"YCMNDRNM@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMS@HAW.A".ts_append_eval %Q|"YCMNDRMS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTT@HAW.A".ts_append_eval %Q|"YCTWTT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTG@HAW.A".ts_append_eval %Q|"YCTWTG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSP@HAW.A".ts_append_eval %Q|"YCTWSP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWCU@HAW.A".ts_append_eval %Q|"YCTWCU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFMP@HAW.A".ts_append_eval %Q|"YCIFMP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFIT@HAW.A".ts_append_eval %Q|"YCIFIT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFI@HAW.A".ts_append_eval %Q|"YCFI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIMO@HAW.A".ts_append_eval %Q|"YCFIMO@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFISE@HAW.A".ts_append_eval %Q|"YCFISE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIIN@HAW.A".ts_append_eval %Q|"YCFIIN@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIOT@HAW.A".ts_append_eval %Q|"YCFIOT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERL@HAW.A".ts_append_eval %Q|"YCRERL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADAD@HAW.A".ts_append_eval %Q|"YCADAD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCNR@HAW.A".ts_append_eval %Q|"YCHCNR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVST@HAW.A".ts_append_eval %Q|"YCGVST@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC@KAU.A".ts_append_eval %Q|"YC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABPEN@KAU.A".ts_append_eval %Q|"YOTLABPEN@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAGFFSP@KAU.A".ts_append_eval %Q|"YCAGFFSP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIOG@KAU.A".ts_append_eval %Q|"YCMIOG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFB@KAU.A".ts_append_eval %Q|"YCMNDRFB@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMC@KAU.A".ts_append_eval %Q|"YCMNDRMC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRCM@KAU.A".ts_append_eval %Q|"YCMNDRCM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YLRTSP@HON.A".ts_append_eval %Q|"YLRTSP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGM@HON.A".ts_append_eval %Q|"YLRTGM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMS@HON.A".ts_append_eval %Q|"YLRTMS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTR@HON.A".ts_append_eval %Q|"YLTWTR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTW@HON.A".ts_append_eval %Q|"YLTWTW@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTT@HON.A".ts_append_eval %Q|"YLTWTT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTG@HON.A".ts_append_eval %Q|"YLTWTG@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWPL@HON.A".ts_append_eval %Q|"YLTWPL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECPR@HAW.A".ts_append_eval %Q|"YSOCSECPR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECEM@HAW.A".ts_append_eval %Q|"YSOCSECEM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDCH@HAW.A".ts_append_eval %Q|"YLMNNDCH@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLWT@HAW.A".ts_append_eval %Q|"YLWT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMV@HAW.A".ts_append_eval %Q|"YLRTMV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFR@HAW.A".ts_append_eval %Q|"YLRTFR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTEL@HAW.A".ts_append_eval %Q|"YLRTEL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTBL@HAW.A".ts_append_eval %Q|"YLRTBL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFD@HAW.A".ts_append_eval %Q|"YLRTFD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEMU@HAW.A".ts_append_eval %Q|"YLAEMU@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAERE@HAW.A".ts_append_eval %Q|"YLAERE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSRP@HAW.A".ts_append_eval %Q|"YLOSRP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSPL@HAW.A".ts_append_eval %Q|"YLOSPL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFR@MAU.A".ts_append_eval %Q|"YLMNDRFR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMS@MAU.A".ts_append_eval %Q|"YLMNDRMS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNND@MAU.A".ts_append_eval %Q|"YLMNND@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDFD@MAU.A".ts_append_eval %Q|"YLMNNDFD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXM@MAU.A".ts_append_eval %Q|"YLMNNDXM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTSP@KAU.A".ts_append_eval %Q|"YLCTSP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDR@KAU.A".ts_append_eval %Q|"YLMNDR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRWD@KAU.A".ts_append_eval %Q|"YLMNDRWD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRNM@KAU.A".ts_append_eval %Q|"YLMNDRNM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRPM@KAU.A".ts_append_eval %Q|"YLMNDRPM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFB@KAU.A".ts_append_eval %Q|"YLMNDRFB@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMC@KAU.A".ts_append_eval %Q|"YLMNDRMC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_PR&@HI.A".ts_append_eval %Q|"YL_PR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFF&@HI.A".ts_append_eval %Q|"YLPAGFF&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFA&@HI.A".ts_append_eval %Q|"YLPAGFFA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFF&@HI.A".ts_append_eval %Q|"YLPAGFFF&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFO&@HI.A".ts_append_eval %Q|"YLPAGFFFFO&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFS&@HI.A".ts_append_eval %Q|"YLPAGFFFFS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFOT&@HI.A".ts_append_eval %Q|"YLPAGFFFOT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMI&@HI.A".ts_append_eval %Q|"YLPMI&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIMT&@HI.A".ts_append_eval %Q|"YLPMIMT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMICO&@HI.A".ts_append_eval %Q|"YLPMICO&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIOL&@HI.A".ts_append_eval %Q|"YLPMIOL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMINM&@HI.A".ts_append_eval %Q|"YLPMINM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPC&@HI.A".ts_append_eval %Q|"YLPC&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCGB&@HI.A".ts_append_eval %Q|"YLPCGB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCHV&@HI.A".ts_append_eval %Q|"YLPCHV&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCST&@HI.A".ts_append_eval %Q|"YLPCST&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPM&@HI.A".ts_append_eval %Q|"YLPM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDEL&@HI.A".ts_append_eval %Q|"YLPMDEL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMV&@HI.A".ts_append_eval %Q|"YLPMDMV&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDOR&@HI.A".ts_append_eval %Q|"YLPMDOR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDEL&@HON.A".ts_append_eval %Q|"YLPMDEL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVEN&@HON.A".ts_append_eval %Q|"YLPSVEN&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTW&@HAW.A".ts_append_eval %Q|"YLPRTW&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFA&@MAU.A".ts_append_eval %Q|"YLPAGFFA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMINM&@KAU.A".ts_append_eval %Q|"YLPMINM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRSE&@KAU.A".ts_append_eval %Q|"YLPFIRSE&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRCR&@KAU.A".ts_append_eval %Q|"YLPFIRCR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "PC_FDEN@HON.S".ts_append_eval %Q|"PC_FDEN@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCRE@HON.S".ts_append_eval %Q|"PCRE@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRMF@HON.S".ts_append_eval %Q|"PCTRMF@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCSV_MD@HON.S".ts_append_eval %Q|"PCSV_MD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "EGVLCSA@HI.M".ts_append_eval %Q|"EGVLCSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "EGVFDSA@HI.M".ts_append_eval %Q|"EGVFDSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "ERESA@HI.M".ts_append_eval %Q|"ERESA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "EMNDRSTNS&@HON.M".ts_append_eval %Q|"EMNDRSTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "EMNNDFDSNS&@HI.M".ts_append_eval %Q|"EMNNDFDSNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "EMPLNS&@KAU.M".ts_append_eval %Q|"EMPLNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ERTOTNS&@HI.M".ts_append_eval %Q|"ERTOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "HRSVACLCNS&@HI.M".ts_append_eval %Q|"HRSVACLCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWRTFDNS&@HI.M".ts_append_eval %Q|"PWRTFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWTUCUNS&@HON.M".ts_append_eval %Q|"PWTUCUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWWTNS&@HI.M".ts_append_eval %Q|"PWWTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "kpprvnrsdns@hi.A".ts_append_eval %Q|"kpprvnrsdns@hi.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "ERTCLNS@MAU.M".ts_append_eval %Q|"ERTCLNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "PICTCONNS@HON.Q".ts_append_eval %Q|"PICTCONNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
  "KNRSDNS@HI.Q".ts_append_eval %Q|"KNRSDNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
  "PICTSGFNS@HON.Q".ts_append_eval %Q|"PICTSGFNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
  "YMED@MAU.A".ts_append_eval %Q|"YMED@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/misc/hud/update/hud_upd.xls"|
  "YMED@HON.A".ts_append_eval %Q|"YMED@HON.A".tsn.load_from "/Volumes/UHEROwork/data/misc/hud/update/hud_upd.xls"|
  "YPROPFA@HAW.A".ts_append_eval %Q|"YPROPFA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YPROPFA@HAW.A".ts_append_eval %Q|"YPROPFA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_TRADE@HAW.A".ts_append_eval %Q|"YL_TRADE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YL_OT@HAW.A".ts_append_eval %Q|"YL_OT@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "GNIDEF@JP.A".ts_append_eval %Q|"GNIDEF@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GNI@JP.A".ts_append_eval %Q|"GNI@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "TKEMPLMNNS@JP.Q".ts_append_eval %Q|"TKEMPLMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCL_NS@JP.Q".ts_append_eval %Q|"TKBSCL_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_CG@JP.Q".ts_append_eval %Q|"GDP_CG@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IFXG@JP.Q".ts_append_eval %Q|"GDP_IFXG@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCANMNS@JP.Q".ts_append_eval %Q|"TKBSCANMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_INRP_RNS@JP.Q".ts_append_eval %Q|"GDP_INRP_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_EXNS@JP.Q".ts_append_eval %Q|"GDP_EXNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCSMNNS@JP.Q".ts_append_eval %Q|"TKBSCSMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDPNS@JP.Q".ts_append_eval %Q|"GDPNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP@JP.Q".ts_append_eval %Q|"GDP@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCA_NS@JP.Q".ts_append_eval %Q|"TKBSCA_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_INRP_R@JP.Q".ts_append_eval %Q|"GDP_INRP_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IFXG_RNS@JP.Q".ts_append_eval %Q|"GDP_IFXG_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_NXNS@JP.Q".ts_append_eval %Q|"GDP_NXNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GNINS@JP.Q".ts_append_eval %Q|"GNINS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKEMPSNS@JP.Q".ts_append_eval %Q|"TKEMPSNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKEMPMNS@JP.Q".ts_append_eval %Q|"TKEMPMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCM_NS@JP.Q".ts_append_eval %Q|"TKBSCM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IRSP_RNS@JP.Q".ts_append_eval %Q|"GDP_IRSP_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IMNS@JP.Q".ts_append_eval %Q|"GDP_IMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "KVLIND@KAU.A".ts_append_eval %Q|"KVLIND@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVIIND@KAU.A".ts_append_eval %Q|"KVIIND@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "GPSFNS@KAU.A".ts_append_eval %Q|"GPSFNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "RNS@KAU.A".ts_append_eval %Q|"RNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KNASER@HON.M".ts_append_eval %Q|"KNASER@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVNCHU@HON.M".ts_append_eval %Q|"KVNCHU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVAHTL@HON.M".ts_append_eval %Q|"KVAHTL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVAAMU@HON.M".ts_append_eval %Q|"KVAAMU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVACHU@HON.M".ts_append_eval %Q|"KVACHU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "KVAIND@HON.M".ts_append_eval %Q|"KVAIND@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "PMKRCONNS@HI.Q".ts_append_eval %Q|"PMKRCONNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
  "TGBTHNS@HI.A".ts_append_eval %Q|"TGBTHNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBITNS@HI.A".ts_append_eval %Q|"TGBITNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCMNS@HI.A".ts_append_eval %Q|"TGBCMNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBHTNS@HI.A".ts_append_eval %Q|"TGBHTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBORNS@HI.A".ts_append_eval %Q|"TGBORNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU4NS@HI.A".ts_append_eval %Q|"TGBU4NS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBOTNS@HI.A".ts_append_eval %Q|"TGBOTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBISNS@HI.A".ts_append_eval %Q|"TGBISNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSUNS@HI.A".ts_append_eval %Q|"TGBSUNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPINS@HI.A".ts_append_eval %Q|"TGBPINS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPDNS@HI.A".ts_append_eval %Q|"TGBPDNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBMNNS@HI.A".ts_append_eval %Q|"TGBMNNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBWTNS@HI.A".ts_append_eval %Q|"TGBWTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSINS@HI.A".ts_append_eval %Q|"TGBSINS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU5NS@HI.A".ts_append_eval %Q|"TGBU5NS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBNS@HI.A".ts_append_eval %Q|"TGBNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBRTNS@HON.A".ts_append_eval %Q|"TGBRTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSVNS@HON.A".ts_append_eval %Q|"TGBSVNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBMNNS@MAU.A".ts_append_eval %Q|"TGBMNNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBWTNS@MAU.A".ts_append_eval %Q|"TGBWTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSINS@MAU.A".ts_append_eval %Q|"TGBSINS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU5NS@MAU.A".ts_append_eval %Q|"TGBU5NS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBRTNS@HAW.A".ts_append_eval %Q|"TGBRTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSVNS@HAW.A".ts_append_eval %Q|"TGBSVNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCTNS@HAW.A".ts_append_eval %Q|"TGBCTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBITNS@HAW.A".ts_append_eval %Q|"TGBITNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCMNS@HAW.A".ts_append_eval %Q|"TGBCMNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBHTNS@HAW.A".ts_append_eval %Q|"TGBHTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBORNS@HAW.A".ts_append_eval %Q|"TGBORNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU4NS@HAW.A".ts_append_eval %Q|"TGBU4NS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBOTNS@HAW.A".ts_append_eval %Q|"TGBOTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBISNS@HAW.A".ts_append_eval %Q|"TGBISNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSUNS@HAW.A".ts_append_eval %Q|"TGBSUNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPINS@HAW.A".ts_append_eval %Q|"TGBPINS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBPDNS@HAW.A".ts_append_eval %Q|"TGBPDNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBMNNS@HAW.A".ts_append_eval %Q|"TGBMNNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBWTNS@HAW.A".ts_append_eval %Q|"TGBWTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBSINS@HAW.A".ts_append_eval %Q|"TGBSINS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBU5NS@HAW.A".ts_append_eval %Q|"TGBU5NS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBNS@HAW.A".ts_append_eval %Q|"TGBNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBRTNS@KAU.A".ts_append_eval %Q|"TGBRTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBCTNS@KAU.A".ts_append_eval %Q|"TGBCTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU5NS@HI.A".ts_append_eval %Q|"TGRU5NS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRALNS@HI.A".ts_append_eval %Q|"TGRALNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRUANS@HI.A".ts_append_eval %Q|"TGRUANS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRNS@HI.A".ts_append_eval %Q|"TGRNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRRTNS@HON.A".ts_append_eval %Q|"TGRRTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSVNS@HON.A".ts_append_eval %Q|"TGRSVNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCTNS@HON.A".ts_append_eval %Q|"TGRCTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRTHNS@HON.A".ts_append_eval %Q|"TGRTHNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRITNS@HON.A".ts_append_eval %Q|"TGRITNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCMNS@HON.A".ts_append_eval %Q|"TGRCMNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRHTNS@HON.A".ts_append_eval %Q|"TGRHTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRORNS@HON.A".ts_append_eval %Q|"TGRORNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU4NS@HON.A".ts_append_eval %Q|"TGRU4NS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGROTNS@HON.A".ts_append_eval %Q|"TGROTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRISNS@HON.A".ts_append_eval %Q|"TGRISNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSUNS@HON.A".ts_append_eval %Q|"TGRSUNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPINS@HON.A".ts_append_eval %Q|"TGRPINS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPDNS@HON.A".ts_append_eval %Q|"TGRPDNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRMNNS@HON.A".ts_append_eval %Q|"TGRMNNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRWTNS@HON.A".ts_append_eval %Q|"TGRWTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSINS@HON.A".ts_append_eval %Q|"TGRSINS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU5NS@HON.A".ts_append_eval %Q|"TGRU5NS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRALNS@HON.A".ts_append_eval %Q|"TGRALNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRUANS@HON.A".ts_append_eval %Q|"TGRUANS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRNS@HON.A".ts_append_eval %Q|"TGRNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRRTNS@MAU.A".ts_append_eval %Q|"TGRRTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSVNS@MAU.A".ts_append_eval %Q|"TGRSVNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCTNS@MAU.A".ts_append_eval %Q|"TGRCTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRTHNS@MAU.A".ts_append_eval %Q|"TGRTHNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRWTNS@HAW.A".ts_append_eval %Q|"TGRWTNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSINS@HAW.A".ts_append_eval %Q|"TGRSINS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU5NS@HAW.A".ts_append_eval %Q|"TGRU5NS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRALNS@HAW.A".ts_append_eval %Q|"TGRALNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRUANS@HAW.A".ts_append_eval %Q|"TGRUANS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRNS@HAW.A".ts_append_eval %Q|"TGRNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRRTNS@KAU.A".ts_append_eval %Q|"TGRRTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSVNS@KAU.A".ts_append_eval %Q|"TGRSVNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCTNS@KAU.A".ts_append_eval %Q|"TGRCTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRTHNS@KAU.A".ts_append_eval %Q|"TGRTHNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRITNS@KAU.A".ts_append_eval %Q|"TGRITNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRCMNS@KAU.A".ts_append_eval %Q|"TGRCMNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRHTNS@KAU.A".ts_append_eval %Q|"TGRHTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRORNS@KAU.A".ts_append_eval %Q|"TGRORNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU4NS@KAU.A".ts_append_eval %Q|"TGRU4NS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRISNS@KAU.A".ts_append_eval %Q|"TGRISNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSUNS@KAU.A".ts_append_eval %Q|"TGRSUNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPINS@KAU.A".ts_append_eval %Q|"TGRPINS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRPDNS@KAU.A".ts_append_eval %Q|"TGRPDNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRU5NS@KAU.A".ts_append_eval %Q|"TGRU5NS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRALNS@KAU.A".ts_append_eval %Q|"TGRALNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "VSOOTANS@HAWK.M".ts_append_eval %Q|"VSOOTANS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VXPDJPFB@HI.A".ts_append_eval %Q|"VXPDJPFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VRLSITNS@KAU.M".ts_append_eval %Q|"VRLSITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VAITOTNS@HI.M".ts_append_eval %Q|"VAITOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VAUSWOTNS@HI.M".ts_append_eval %Q|"VAUSWOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VSDMSCHNS@HI.M".ts_append_eval %Q|"VSDMSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VSAUSSCHNS@HAW.M".ts_append_eval %Q|"VSAUSSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VISOTNS@HI.M".ts_append_eval %Q|"VISOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCRAIRNS@HI.M".ts_append_eval %Q|"VISCRAIRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCRNS@HON.M".ts_append_eval %Q|"VISCRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISCRNS@HAW.M".ts_append_eval %Q|"VISCRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYOTNS@HI.M".ts_append_eval %Q|"VDAYOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSNS@HON.M".ts_append_eval %Q|"VRLSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSNS@HAW.M".ts_append_eval %Q|"VRLSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSNS@MAUI.M".ts_append_eval %Q|"VRLSNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSJPNS@MAUI.M".ts_append_eval %Q|"VRLSJPNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "YPCDPI_R@US.Q".ts_append_eval %Q|"YPCDPI_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_INR@US.Q".ts_append_eval %Q|"GDP_INR@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IFX@US.Q".ts_append_eval %Q|"GDP_IFX@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_CD@US.Q".ts_append_eval %Q|"GDP_CD@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YPCCE@US.Q".ts_append_eval %Q|"YPCCE@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YP@CA.Q".ts_append_eval %Q|"YP@CA.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YDPI_R@US.Q".ts_append_eval %Q|"YDPI_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_CN@US.Q".ts_append_eval %Q|"GDP_CN@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YPCCE_R@US.Q".ts_append_eval %Q|"YPCCE_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IFX_R@US.Q".ts_append_eval %Q|"GDP_IFX_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YPCDPI@US.Q".ts_append_eval %Q|"YPCDPI@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IIV@US.Q".ts_append_eval %Q|"GDP_IIV@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_NX_R@US.Q".ts_append_eval %Q|"GDP_NX_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_INR_R@US.Q".ts_append_eval %Q|"GDP_INR_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_EX_R@US.Q".ts_append_eval %Q|"GDP_EX_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IRS@US.Q".ts_append_eval %Q|"GDP_IRS@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_CD_R@US.Q".ts_append_eval %Q|"GDP_CD_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP@US.Q".ts_append_eval %Q|"GDP@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GNP@US.Q".ts_append_eval %Q|"GNP@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_NX@US.Q".ts_append_eval %Q|"GDP_NX@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IM_R@US.Q".ts_append_eval %Q|"GDP_IM_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_I@US.Q".ts_append_eval %Q|"GDP_I@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_EX@US.Q".ts_append_eval %Q|"GDP_EX@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GNP_R@US.Q".ts_append_eval %Q|"GNP_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GNPPC_R@US.Q".ts_append_eval %Q|"GNPPC_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDPPC@US.Q".ts_append_eval %Q|"GDPPC@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YCE@US.Q".ts_append_eval %Q|"YCE@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_I_R@US.Q".ts_append_eval %Q|"GDP_I_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IM@US.Q".ts_append_eval %Q|"GDP_IM@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_IIV_R@US.Q".ts_append_eval %Q|"GDP_IIV_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_G_R@US.Q".ts_append_eval %Q|"GDP_G_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_G@US.Q".ts_append_eval %Q|"GDP_G@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YDPI@US.Q".ts_append_eval %Q|"YDPI@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YPC@US.Q".ts_append_eval %Q|"YPC@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "N@US.Q".ts_append_eval %Q|"N@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_C_R@US.Q".ts_append_eval %Q|"GDP_C_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "GDP_C@US.Q".ts_append_eval %Q|"GDP_C@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "YLAGFFOT@HI.A".ts_append_eval %Q|"YLAGFFOT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMV@HI.A".ts_append_eval %Q|"YLRTMV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFR@HI.A".ts_append_eval %Q|"YLRTFR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTEL@HI.A".ts_append_eval %Q|"YLRTEL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTBL@HI.A".ts_append_eval %Q|"YLRTBL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSHH@HI.A".ts_append_eval %Q|"YLOSHH@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROPFA&@HI.A".ts_append_eval %Q|"YPROPFA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@HI.A".ts_append_eval %Q|"YLPAGFA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@HI.A".ts_append_eval %Q|"YL_NF&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDIS&@HI.A".ts_append_eval %Q|"YLPMDIS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFD&@HI.A".ts_append_eval %Q|"YLPTRFD&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFR&@HI.A".ts_append_eval %Q|"YLPTRFR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMINM&@HON.A".ts_append_eval %Q|"YLPMINM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFB&@HAW.A".ts_append_eval %Q|"YLPMDFB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAM&@HAW.A".ts_append_eval %Q|"YLPSVAM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDIS&@MAU.A".ts_append_eval %Q|"YLPMDIS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMS&@MAU.A".ts_append_eval %Q|"YLPSVMS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPT&@KAU.A".ts_append_eval %Q|"YLPMNPT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNRB&@KAU.A".ts_append_eval %Q|"YLPMNRB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTT&@KAU.A".ts_append_eval %Q|"YLPRTT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_TU@HI.A".ts_append_eval %Q|"YL_TU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "TGBISNS@MAU.A".ts_append_eval %Q|"TGBISNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "VADMFRNS@HI.M".ts_append_eval %Q|"VADMFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VPITFUNNS@HI.M".ts_append_eval %Q|"VPITFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "PCITOT@HI.M".ts_append_eval %Q|"PCITOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VLOSCRAIR@HI.M".ts_append_eval %Q|"VLOSCRAIR@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPJP@HI.M".ts_append_eval %Q|"VEXPJP@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PCITJP@HI.M".ts_append_eval %Q|"PCITJP@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPD@HI.M".ts_append_eval %Q|"VEXPPD@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VDAYUSE@HI.M".ts_append_eval %Q|"VDAYUSE@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "CPI@HON.S".ts_eval= %Q|"PC@HON.S".ts|

  "PCHSFUEL@HON.M".ts_append_eval %Q|"PCHSFUEL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHSFUEL@HON.Q".ts_eval= %Q|'PCHSFUEL@HON.S'.ts.interpolate :quarter, :linear|
  "PCHSFUEL@HON.Q".ts_append_eval %Q|"PCHSFUEL@HON.M".ts.aggregate(:quarter, :average)|
  "PCSV@HON.Q".ts_eval= %Q|'PCSV@HON.S'.ts.interpolate :quarter, :linear|
  "PC_FDEN@HON.Q".ts_eval= %Q|'PC_FDEN@HON.S'.ts.interpolate :quarter, :linear|
  "YPCBEA@HAW.A".ts_append_eval %Q|"YPCBEA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YPCBEA@HAW.A".ts_append_eval %Q|"YPCBEA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFF@HI.A".ts_append_eval %Q|"YLAGFF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLAGFF@HI.A".ts_append_eval %Q|"YLAGFF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNND@HI.A".ts_append_eval %Q|"YLMNND@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXM@HI.A".ts_append_eval %Q|"YLMNNDXM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDLT@HI.A".ts_append_eval %Q|"YLMNNDLT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPR@HI.A".ts_append_eval %Q|"YLMNNDPR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPT@HI.A".ts_append_eval %Q|"YLMNNDPT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPL@HI.A".ts_append_eval %Q|"YLMNNDPL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMV@HON.A".ts_append_eval %Q|"YLMNDRMV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNND@HON.A".ts_append_eval %Q|"YLMNND@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDFD@HON.A".ts_append_eval %Q|"YLMNNDFD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDBV@HON.A".ts_append_eval %Q|"YLMNNDBV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXM@HON.A".ts_append_eval %Q|"YLMNNDXM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXP@HON.A".ts_append_eval %Q|"YLMNNDXP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDAP@HON.A".ts_append_eval %Q|"YLMNNDAP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPT@HON.A".ts_append_eval %Q|"YLMNNDPT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTEL@HON.A".ts_append_eval %Q|"YLRTEL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTW@HON.A".ts_append_eval %Q|"YLTW@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFMP@HON.A".ts_append_eval %Q|"YLIFMP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFBC@HON.A".ts_append_eval %Q|"YLIFBC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFTC@HON.A".ts_append_eval %Q|"YLIFTC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFDP@HON.A".ts_append_eval %Q|"YLIFDP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERL@HON.A".ts_append_eval %Q|"YLRERL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSRP@HON.A".ts_append_eval %Q|"YLOSRP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSPL@HON.A".ts_append_eval %Q|"YLOSPL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDR@HAW.A".ts_append_eval %Q|"YLMNDR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRWD@HAW.A".ts_append_eval %Q|"YLMNDRWD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRNM@HAW.A".ts_append_eval %Q|"YLMNDRNM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRPM@HAW.A".ts_append_eval %Q|"YLMNDRPM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFB@HAW.A".ts_append_eval %Q|"YLMNDRFB@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFICR@HAW.A".ts_append_eval %Q|"YLFICR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIOT@HAW.A".ts_append_eval %Q|"YLFIOT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRELE@HAW.A".ts_append_eval %Q|"YLRELE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADAD@HAW.A".ts_append_eval %Q|"YLADAD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTHV@MAU.A".ts_append_eval %Q|"YLCTHV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTSP@MAU.A".ts_append_eval %Q|"YLCTSP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDR@MAU.A".ts_append_eval %Q|"YLMNDR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTCL@MAU.A".ts_append_eval %Q|"YLRTCL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTSP@MAU.A".ts_append_eval %Q|"YLRTSP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGM@MAU.A".ts_append_eval %Q|"YLRTGM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTA@MAU.A".ts_append_eval %Q|"YLTWTA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTR@MAU.A".ts_append_eval %Q|"YLTWTR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTT@MAU.A".ts_append_eval %Q|"YLTWTT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWCU@MAU.A".ts_append_eval %Q|"YLTWCU@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFMP@MAU.A".ts_append_eval %Q|"YLIFMP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFBC@MAU.A".ts_append_eval %Q|"YLIFBC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFDP@MAU.A".ts_append_eval %Q|"YLIFDP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFISE@MAU.A".ts_append_eval %Q|"YLFISE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFFD@MAU.A".ts_append_eval %Q|"YLAFFD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSRP@MAU.A".ts_append_eval %Q|"YLOSRP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSPL@MAU.A".ts_append_eval %Q|"YLOSPL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSMA@MAU.A".ts_append_eval %Q|"YLOSMA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSHH@MAU.A".ts_append_eval %Q|"YLOSHH@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFF@KAU.A".ts_append_eval %Q|"YLAGFF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFO@KAU.A".ts_append_eval %Q|"YLAGFFFO@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFSP@KAU.A".ts_append_eval %Q|"YLAGFFSP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCT@KAU.A".ts_append_eval %Q|"YLCT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFR@KAU.A".ts_append_eval %Q|"YLRTFR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTEL@KAU.A".ts_append_eval %Q|"YLRTEL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTBL@KAU.A".ts_append_eval %Q|"YLRTBL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTFD@KAU.A".ts_append_eval %Q|"YLRTFD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTCL@KAU.A".ts_append_eval %Q|"YLRTCL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTSP@KAU.A".ts_append_eval %Q|"YLRTSP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGM@KAU.A".ts_append_eval %Q|"YLRTGM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMS@KAU.A".ts_append_eval %Q|"YLRTMS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTOT@KAU.A".ts_append_eval %Q|"YLRTOT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTW@KAU.A".ts_append_eval %Q|"YLTW@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTA@KAU.A".ts_append_eval %Q|"YLTWTA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTR@KAU.A".ts_append_eval %Q|"YLTWTR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTT@KAU.A".ts_append_eval %Q|"YLTWTT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWTG@KAU.A".ts_append_eval %Q|"YLTWTG@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWPL@KAU.A".ts_append_eval %Q|"YLTWPL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSC@KAU.A".ts_append_eval %Q|"YLTWSC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMA@KAU.A".ts_append_eval %Q|"YLMA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADWM@KAU.A".ts_append_eval %Q|"YLADWM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCNR@KAU.A".ts_append_eval %Q|"YLHCNR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCSO@KAU.A".ts_append_eval %Q|"YLHCSO@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEPF@KAU.A".ts_append_eval %Q|"YLAEPF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFFD@KAU.A".ts_append_eval %Q|"YLAFFD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "KRSGFNS_NMC@HAW.Q".ts_append_eval %Q|"KRSGFNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
  "OCUP%NS@MAU.M".ts_append_eval %Q|"OCUP%NS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "TGRWTNS@MAU.A".ts_append_eval %Q|"TGRWTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSINS@MAU.A".ts_append_eval %Q|"TGRSINS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "YDIV@HI.A".ts_append_eval %Q|"YDIV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YDIV@HI.A".ts_append_eval %Q|"YDIV@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROP@HI.A".ts_append_eval %Q|"YPROP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YPROP@HI.A".ts_append_eval %Q|"YPROP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROPFA@HI.A".ts_append_eval %Q|"YPROPFA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YPROPFA@HI.A".ts_append_eval %Q|"YPROPFA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROPNF&@HI.Q".ts_append_eval %Q|"YPROPNF&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@HI.Q".ts_append_eval %Q|"YDIR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@HI.Q".ts_append_eval %Q|"YTWPER&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NMIG@HI.A".ts_append_eval %Q|"NMIG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NRCMD@HI.A".ts_append_eval %Q|"NRCMD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NRM@KAU.A".ts_append_eval %Q|"NRM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NDEA@KAU.A".ts_append_eval %Q|"NDEA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "NRCNM@HI.A".ts_append_eval %Q|"NRCNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "YLPSVHE&@KAU.A".ts_append_eval %Q|"YLPSVHE&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMN&@MAU.A".ts_append_eval %Q|"YLPMN&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMI&@HAW.A".ts_append_eval %Q|"YLPMI&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHL&@MAU.A".ts_append_eval %Q|"YLPSVHL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTR&@HAW.A".ts_append_eval %Q|"YLPTR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFF&@KAU.A".ts_append_eval %Q|"YLPAGFF&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIR&@MAU.A".ts_append_eval %Q|"YLPFIR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIR&@HON.A".ts_append_eval %Q|"YLPFIR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFF&@MAU.A".ts_append_eval %Q|"YLPAGFF&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTW&@HAW.A".ts_append_eval %Q|"YLPTW&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSV&@HON.A".ts_append_eval %Q|"YLPSV&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTR&@KAU.A".ts_append_eval %Q|"YLPTR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMI&@KAU.A".ts_append_eval %Q|"YLPMI&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPM&@HON.A".ts_append_eval %Q|"YLPM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIR&@HAW.A".ts_append_eval %Q|"YLPFIR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVBS&@HI.A".ts_append_eval %Q|"YLPSVBS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "TRMS@MAU.A".ts_append_eval %Q|"TRMS@MAU.A".tsn.load_from "   /Volumes/UHEROwork/data/tour/update/TRMS.xls"|
  "TRMS@HON.A".ts_append_eval %Q|"TRMS@HON.A".tsn.load_from "   /Volumes/UHEROwork/data/tour/update/TRMS.xls"|
  "YLPMN&@KAU.A".ts_append_eval %Q|"YLPMN&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSV&@HAW.A".ts_append_eval %Q|"YLPSV&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "VISCANNS@MOL.M".ts_append_eval %Q|"VISCANNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYUSWNS@LAN.M".ts_append_eval %Q|"VDAYUSWNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "PCTRGSMD@HON.M".ts_append_eval %Q|"PCTRGSMD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PC_SH@HON.M".ts_append_eval %Q|"PC_SH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PC_FDEN@HON.M".ts_append_eval %Q|"PC_FDEN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "YLAGFFFO@MAU.A".ts_append_eval %Q|"YLAGFFFO@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFFS@MAU.A".ts_append_eval %Q|"YLAGFFFS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMI@MAU.A".ts_append_eval %Q|"YLMI@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "KVTSFM@KAU.A".ts_append_eval %Q|"KVTSFM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "YNETR&@HON.A".ts_append_eval %Q|"YNETR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@HON.A".ts_append_eval %Q|"YDIR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIOL&@HON.A".ts_append_eval %Q|"YLPMIOL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVSO&@MAU.A".ts_append_eval %Q|"YLPSVSO&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMU&@MAU.A".ts_append_eval %Q|"YLPSVMU&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMB&@MAU.A".ts_append_eval %Q|"YLPSVMB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVEN&@MAU.A".ts_append_eval %Q|"YLPSVEN&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDWD&@KAU.A".ts_append_eval %Q|"YLPMDWD&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLAGFF@HI.Q".ts_append_eval %Q|"YLAGFF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLMI@HI.Q".ts_append_eval %Q|"YLMI@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLUT@HI.Q".ts_append_eval %Q|"YLUT@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLRT@HI.Q".ts_append_eval %Q|"YLRT@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLMA@HI.Q".ts_append_eval %Q|"YLMA@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLAGFFSP@HON.A".ts_append_eval %Q|"YLAGFFSP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGM@HAW.A".ts_append_eval %Q|"YLRTGM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTMV@MAU.A".ts_append_eval %Q|"YLRTMV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFOT@HAW.A".ts_append_eval %Q|"YLAGFFOT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFOT@MAU.A".ts_append_eval %Q|"YLAGFFOT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "VDAYJPNS@KAU.M".ts_append_eval %Q|"VDAYJPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@HI.M".ts_append_eval %Q|"VISUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSENS@HAW.M".ts_append_eval %Q|"VISUSENS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSENS@HI.M".ts_append_eval %Q|"VISUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYUSENS@LAN.M".ts_append_eval %Q|"VDAYUSENS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISUSWNS@MOL.M".ts_append_eval %Q|"VISUSWNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISITNS@MAU.M".ts_append_eval %Q|"VISITNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISITNS@HON.M".ts_append_eval %Q|"VISITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISNS@KAU.M".ts_append_eval %Q|"VISNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRDCDMNS@HI.M".ts_append_eval %Q|"VRDCDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VDAYUSENS@MAUI.M".ts_append_eval %Q|"VDAYUSENS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VDAYJPNS@HON.M".ts_append_eval %Q|"VDAYJPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "STKNS@JP.M".ts_append_eval %Q|"STKNS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "VEXPNS@HAW.M".ts_append_eval %Q|"VEXPNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "VEXPCANNS@HI.M".ts_append_eval %Q|"VEXPCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "E_NF@JP.M".ts_append_eval %Q|"E_NF@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "LF@JP.M".ts_append_eval %Q|"LF@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "IP@JP.M".ts_append_eval %Q|"IP@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "VEXPNS@HI.M".ts_append_eval %Q|"VEXPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "VEXPNS@MAUI.M".ts_append_eval %Q|"VEXPNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  
  "TROTNS@KAU.M".ts_append_eval %Q|"TROTNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRHSNS@KAU.M".ts_append_eval %Q|"TRHSNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGTNS@KAU.M".ts_append_eval %Q|"TRGTNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRMTNS@HAW.M".ts_append_eval %Q|"TRMTNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTFNS@HI.M".ts_append_eval %Q|"TRTFNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOPRNS@HI.M".ts_append_eval %Q|"TRCOPRNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRISNS@HAW.M".ts_append_eval %Q|"TRISNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRLINS@KAU.M".ts_append_eval %Q|"TRLINS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCORFNS@KAU.M".ts_append_eval %Q|"TRCORFNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTBNS@MAU.M".ts_append_eval %Q|"TRTBNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCVNS@MAU.M".ts_append_eval %Q|"TRCVNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCVNS@HON.M".ts_append_eval %Q|"TRCVNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTBNS@HON.M".ts_append_eval %Q|"TRTBNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TROTNS@MAU.M".ts_append_eval %Q|"TROTNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRHSNS@MAU.M".ts_append_eval %Q|"TRHSNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGTNS@MAU.M".ts_append_eval %Q|"TRGTNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINRFNS@HAW.M".ts_append_eval %Q|"TRINRFNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRNS@HAW.M".ts_append_eval %Q|"TRNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGTNS@HON.M".ts_append_eval %Q|"TRGTNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRPSNS@HON.M".ts_append_eval %Q|"TRPSNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TROTNS@HON.M".ts_append_eval %Q|"TROTNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRHSNS@HON.M".ts_append_eval %Q|"TRHSNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRSUNS@HI.M".ts_append_eval %Q|"TGRSUNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRISNS@HI.M".ts_append_eval %Q|"TGRISNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRMTNS@HI.M".ts_append_eval %Q|"TRMTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TREMNS@HAW.M".ts_append_eval %Q|"TREMNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGROTNS@HI.M".ts_append_eval %Q|"TGROTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRCORFNS@MAU.M".ts_append_eval %Q|"TRCORFNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCORFNS@HON.M".ts_append_eval %Q|"TRCORFNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRIHNS@KAU.M".ts_append_eval %Q|"TRIHNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRLINS@MAU.M".ts_append_eval %Q|"TRLINS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTTNS@HAW.M".ts_append_eval %Q|"TRTTNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINPRNS@HAW.M".ts_append_eval %Q|"TRINPRNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRLINS@HON.M".ts_append_eval %Q|"TRLINS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFINS@HAW.M".ts_append_eval %Q|"TRFINS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTTNS@HI.M".ts_append_eval %Q|"TRTTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFUNS@KAU.M".ts_append_eval %Q|"TRFUNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTBNS@HI.M".ts_append_eval %Q|"TRTBNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRIHNS@MAU.M".ts_append_eval %Q|"TRIHNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRNS@HI.M".ts_append_eval %Q|"TRNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRIHNS@HON.M".ts_append_eval %Q|"TRIHNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRALNS@HI.M".ts_append_eval %Q|"TGRALNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRGLNS@KAU.M".ts_append_eval %Q|"TRGLNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TREMNS@HI.M".ts_append_eval %Q|"TREMNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRTHNS@HI.M".ts_append_eval %Q|"TGRTHNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRFUNS@MAU.M".ts_append_eval %Q|"TRFUNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINWHNS@HAW.M".ts_append_eval %Q|"TRINWHNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOESNS@HAW.M".ts_append_eval %Q|"TRCOESNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFUNS@HON.M".ts_append_eval %Q|"TRFUNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOPRNS@HAW.M".ts_append_eval %Q|"TRCOPRNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGLNS@MAU.M".ts_append_eval %Q|"TRGLNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGLNS@HON.M".ts_append_eval %Q|"TRGLNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINESNS@MAU.M".ts_append_eval %Q|"TRINESNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTBNS@HAW.M".ts_append_eval %Q|"TRTBNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINRFNS@HI.M".ts_append_eval %Q|"TRINRFNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCVNS@HAW.M".ts_append_eval %Q|"TRCVNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TROTNS@HAW.M".ts_append_eval %Q|"TROTNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRPSNS@HAW.M".ts_append_eval %Q|"TRPSNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRHSNS@HAW.M".ts_append_eval %Q|"TRHSNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGTNS@HAW.M".ts_append_eval %Q|"TRGTNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRUANS@HI.M".ts_append_eval %Q|"TGRUANS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSVNS@HI.M".ts_append_eval %Q|"TGRSVNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRINESNS@KAU.M".ts_append_eval %Q|"TRINESNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRLINS@HAW.M".ts_append_eval %Q|"TRLINS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCORFNS@HAW.M".ts_append_eval %Q|"TRCORFNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTFNS@KAU.M".ts_append_eval %Q|"TRTFNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGLNS@HI.M".ts_append_eval %Q|"TRGLNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFINS@HI.M".ts_append_eval %Q|"TRFINS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINPRNS@HI.M".ts_append_eval %Q|"TRINPRNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRORNS@HI.M".ts_append_eval %Q|"TGRORNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRMTNS@KAU.M".ts_append_eval %Q|"TRMTNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINESNS@HON.M".ts_append_eval %Q|"TRINESNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRNS@HI.M".ts_append_eval %Q|"TGRNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRPSNS@KAU.M".ts_append_eval %Q|"TRPSNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRISNS@KAU.M".ts_append_eval %Q|"TRISNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTFNS@MAU.M".ts_append_eval %Q|"TRTFNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRIHNS@HAW.M".ts_append_eval %Q|"TRIHNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFUNS@HI.M".ts_append_eval %Q|"TRFUNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TROTNS@HI.M".ts_append_eval %Q|"TROTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTFNS@HON.M".ts_append_eval %Q|"TRTFNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRCTNS@HI.M".ts_append_eval %Q|"TGRCTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRINRFNS@KAU.M".ts_append_eval %Q|"TRINRFNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRNS@KAU.M".ts_append_eval %Q|"TRNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRMTNS@MAU.M".ts_append_eval %Q|"TRMTNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRMTNS@HON.M".ts_append_eval %Q|"TRMTNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCORFNS@HI.M".ts_append_eval %Q|"TRCORFNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFUNS@HAW.M".ts_append_eval %Q|"TRFUNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRRTNS@HI.M".ts_append_eval %Q|"TGRRTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TREMNS@KAU.M".ts_append_eval %Q|"TREMNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRPSNS@MAU.M".ts_append_eval %Q|"TRPSNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRISNS@MAU.M".ts_append_eval %Q|"TRISNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRISNS@HON.M".ts_append_eval %Q|"TRISNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TREMNS@HON.M".ts_append_eval %Q|"TREMNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "ERTSA@HI.M".ts_append_eval %Q|"ERTSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EHCSA@HI.M".ts_append_eval %Q|"EHCSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EFIDPNS&@HON.M".ts_append_eval %Q|"EFIDPNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EFIOTNS&@HON.M".ts_append_eval %Q|"EFIOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDNVNS&@HI.M".ts_append_eval %Q|"EGVFDNVNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDNVNS&@HON.M".ts_append_eval %Q|"EGVFDNVNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDPRNS&@HI.M".ts_append_eval %Q|"EMNNDPRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDTXNS&@HI.M".ts_append_eval %Q|"EMNNDTXNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDTXNS&@HON.M".ts_append_eval %Q|"EMNNDTXNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMPLNS&@HAW.M".ts_append_eval %Q|"EMPLNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMPLNS&@HON.M".ts_append_eval %Q|"EMPLNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ENS&@HAW.M".ts_append_eval %Q|"ENS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ERTOTNS&@HON.M".ts_append_eval %Q|"ERTOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVENNS&@HAW.M".ts_append_eval %Q|"ESVENNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVHCHONS&@HON.M".ts_append_eval %Q|"ESVHCHONS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVHCOTNS&@HON.M".ts_append_eval %Q|"ESVHCOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVSONS&@HON.M".ts_append_eval %Q|"ESVSONS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "E_SVCNS&@HI.M".ts_append_eval %Q|"E_SVCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "E_SVCNS&@HON.M".ts_append_eval %Q|"E_SVCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "HRFIDPNS&@HI.M".ts_append_eval %Q|"HRFIDPNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "HRFIDPNS&@HON.M".ts_append_eval %Q|"HRFIDPNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "HRRTFDNS&@HON.M".ts_append_eval %Q|"HRRTFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "HRRTNS&@HI.M".ts_append_eval %Q|"HRRTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "HRRTNS&@HON.M".ts_append_eval %Q|"HRRTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWFIDPNS&@HI.M".ts_append_eval %Q|"PWFIDPNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWMNNDPRNS&@HON.M".ts_append_eval %Q|"PWMNNDPRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWMNNS&@HON.M".ts_append_eval %Q|"PWMNNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWRTFDNS&@HON.M".ts_append_eval %Q|"PWRTFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWSVACNS&@HI.M".ts_append_eval %Q|"PWSVACNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWSVACNS&@HON.M".ts_append_eval %Q|"PWSVACNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWTUCUNS&@HI.M".ts_append_eval %Q|"PWTUCUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PWWTNS&@HON.M".ts_append_eval %Q|"PWWTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PW_TRADENS&@HI.M".ts_append_eval %Q|"PW_TRADENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "PW_TRADENS&@HON.M".ts_append_eval %Q|"PW_TRADENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "URNS&@HAW.M".ts_append_eval %Q|"URNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "URNS&@KAU.M".ts_append_eval %Q|"URNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "URNS&@MAU.M".ts_append_eval %Q|"URNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHCTNS&@HON.M".ts_append_eval %Q|"WHCTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHFIDPNS&@HI.M".ts_append_eval %Q|"WHFIDPNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHFIDPNS&@HON.M".ts_append_eval %Q|"WHFIDPNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHMNNDPRNS&@HON.M".ts_append_eval %Q|"WHMNNDPRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHRT$FDNS&@HI.M".ts_append_eval %Q|"WHRT$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHRTFDNS&@HON.M".ts_append_eval %Q|"WHRTFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "WHRTNS&@HI.M".ts_append_eval %Q|"WHRTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "NMIGCNM@HI.A".ts_append_eval %Q|"NMIGCNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "ERTGMDSNS@MAU.M".ts_append_eval %Q|"ERTGMDSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "KNRSDNS@HAW.Q".ts_append_eval %Q|"KNRSDNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "KNRSDNS@HON.Q".ts_append_eval %Q|"KNRSDNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "KNRSDSGFNS@HI.Q".ts_append_eval %Q|"KNRSDSGFNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "KBSGFNS@HON.M".ts_append_eval %Q|"KBSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
   "KBCONNS@HON.M".ts_append_eval %Q|"KBCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
   "PAKBSGF@HON.M".ts_append_eval %Q|"PAKBSGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
   "PAKBCON@HON.M".ts_append_eval %Q|"PAKBCON@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
   "YSOCSEC@HI.Q".ts_append_eval %Q|"YSOCSEC@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YSOCSEC@HI.Q".ts_append_eval %Q|"YSOCSEC@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YSOCSECPR@HI.Q".ts_append_eval %Q|"YSOCSECPR@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YSOCSECPR@HI.Q".ts_append_eval %Q|"YSOCSECPR@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YRESADJ@HI.Q".ts_append_eval %Q|"YRESADJ@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YRESADJ@HI.Q".ts_append_eval %Q|"YRESADJ@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YNETR@HI.Q".ts_append_eval %Q|"YNETR@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YNETR@HI.Q".ts_append_eval %Q|"YNETR@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YDIV@HI.Q".ts_append_eval %Q|"YDIV@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YDIV@HI.Q".ts_append_eval %Q|"YDIV@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YTRNSF@HI.Q".ts_append_eval %Q|"YTRNSF@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
   "YTRNSF@HI.Q".ts_append_eval %Q|"YTRNSF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLFI@HI.A".ts_append_eval %Q|"YLFI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
   "YLFI@HI.A".ts_append_eval %Q|"YLFI@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YSOCSEC@HON.A".ts_append_eval %Q|"YSOCSEC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YSOCSEC@HON.A".ts_append_eval %Q|"YSOCSEC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YRESADJ@HON.A".ts_append_eval %Q|"YRESADJ@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YRESADJ@HON.A".ts_append_eval %Q|"YRESADJ@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPFA@HON.A".ts_append_eval %Q|"YPROPFA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YPROPFA@HON.A".ts_append_eval %Q|"YPROPFA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPNF@HON.A".ts_append_eval %Q|"YPROPNF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YPROPNF@HON.A".ts_append_eval %Q|"YPROPNF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVST@HON.A".ts_append_eval %Q|"YLGVST@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLGVST@HON.A".ts_append_eval %Q|"YLGVST@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVLC@HON.A".ts_append_eval %Q|"YLGVLC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLGVLC@HON.A".ts_append_eval %Q|"YLGVLC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLPS@HON.A".ts_append_eval %Q|"YLPS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLPS@HON.A".ts_append_eval %Q|"YLPS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL@HAW.A".ts_append_eval %Q|"YL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
   "YL@HAW.A".ts_append_eval %Q|"YL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YSOCSEC@HAW.A".ts_append_eval %Q|"YSOCSEC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
   "YSOCSEC@HAW.A".ts_append_eval %Q|"YSOCSEC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLCT@HAW.A".ts_append_eval %Q|"YLCT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVLC@KAU.A".ts_append_eval %Q|"YLGVLC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YLGVLC@KAU.A".ts_append_eval %Q|"YLGVLC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "GDP_IIVG_R@JP.A".ts_append_eval %Q|"GDP_IIVG_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDPPC_R@JP.A".ts_append_eval %Q|"GDPPC_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDP_IFXG@JP.A".ts_append_eval %Q|"GDP_IFXG@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "CSCFNS@JP.M".ts_append_eval %Q|"CSCFNS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "GDP_IFX_R@JP.Q".ts_append_eval %Q|"GDP_IFX_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVP_RNS@JP.Q".ts_append_eval %Q|"GDP_IIVP_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPANM_NS@JP.Q".ts_append_eval %Q|"TKEMPANM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IRSP@JP.Q".ts_append_eval %Q|"GDP_IRSP@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CGNS@JP.Q".ts_append_eval %Q|"GDP_CGNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPLMN_NS@JP.Q".ts_append_eval %Q|"TKEMPLMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CP@JP.Q".ts_append_eval %Q|"GDP_CP@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_R@JP.Q".ts_append_eval %Q|"GDP_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCLNMNS@JP.Q".ts_append_eval %Q|"TKBSCLNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CG_RNS@JP.Q".ts_append_eval %Q|"GDP_CG_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCANM_NS@JP.Q".ts_append_eval %Q|"TKBSCANM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVG_RNS@JP.Q".ts_append_eval %Q|"GDP_IIVG_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPLNS@JP.Q".ts_append_eval %Q|"TKEMPLNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPAMN_NS@JP.Q".ts_append_eval %Q|"TKEMPAMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVPNS@JP.Q".ts_append_eval %Q|"GDP_IIVPNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GNI_R@JP.Q".ts_append_eval %Q|"GNI_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "INFGDPDEF@JP.Q".ts_append_eval %Q|"INFGDPDEF@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_NX@JP.Q".ts_append_eval %Q|"GDP_NX@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPA_NS@JP.Q".ts_append_eval %Q|"TKEMPA_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPAMNNS@JP.Q".ts_append_eval %Q|"TKEMPAMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IM_RNS@JP.Q".ts_append_eval %Q|"GDP_IM_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "CSCF@JP.Q".ts_append_eval %Q|"CSCF@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPMMNNS@JP.Q".ts_append_eval %Q|"TKEMPMMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVG_R@JP.Q".ts_append_eval %Q|"GDP_IIVG_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPSMN_NS@JP.Q".ts_append_eval %Q|"TKEMPSMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCLNM_NS@JP.Q".ts_append_eval %Q|"TKBSCLNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IRSPNS@JP.Q".ts_append_eval %Q|"GDP_IRSPNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CPNS@JP.Q".ts_append_eval %Q|"GDP_CPNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDPDEF@JP.Q".ts_append_eval %Q|"GDPDEF@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCSNMNS@JP.Q".ts_append_eval %Q|"TKBSCSNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_NX_RNS@JP.Q".ts_append_eval %Q|"GDP_NX_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCAMNNS@JP.Q".ts_append_eval %Q|"TKBSCAMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "CSCFNS@JP.Q".ts_append_eval %Q|"CSCFNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IM@JP.Q".ts_append_eval %Q|"GDP_IM@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GNI_RNS@JP.Q".ts_append_eval %Q|"GNI_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_EX@JP.Q".ts_append_eval %Q|"GDP_EX@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPM_NS@JP.Q".ts_append_eval %Q|"TKEMPM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPL_NS@JP.Q".ts_append_eval %Q|"TKEMPL_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPANMNS@JP.Q".ts_append_eval %Q|"TKEMPANMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCANS@JP.Q".ts_append_eval %Q|"TKBSCANS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CG_R@JP.Q".ts_append_eval %Q|"GDP_CG_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_INRPNS@JP.Q".ts_append_eval %Q|"GDP_INRPNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IFXNS@JP.Q".ts_append_eval %Q|"GDP_IFXNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPLNMNS@JP.Q".ts_append_eval %Q|"TKEMPLNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCS_NS@JP.Q".ts_append_eval %Q|"TKBSCS_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCLMNNS@JP.Q".ts_append_eval %Q|"TKBSCLMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IFX_RNS@JP.Q".ts_append_eval %Q|"GDP_IFX_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCSNS@JP.Q".ts_append_eval %Q|"TKBSCSNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCSNM_NS@JP.Q".ts_append_eval %Q|"TKBSCSNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVP_R@JP.Q".ts_append_eval %Q|"GDP_IIVP_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPSMNNS@JP.Q".ts_append_eval %Q|"TKEMPSMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPMMN_NS@JP.Q".ts_append_eval %Q|"TKEMPMMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GNI@JP.Q".ts_append_eval %Q|"GNI@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPMNM_NS@JP.Q".ts_append_eval %Q|"TKEMPMNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCSMN_NS@JP.Q".ts_append_eval %Q|"TKBSCSMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_CP_R@JP.Q".ts_append_eval %Q|"GDP_CP_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IIVG@JP.Q".ts_append_eval %Q|"GDP_IIVG@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPSNM_NS@JP.Q".ts_append_eval %Q|"TKEMPSNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IFX@JP.Q".ts_append_eval %Q|"GDP_IFX@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_IRSP_R@JP.Q".ts_append_eval %Q|"GDP_IRSP_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_EX_RNS@JP.Q".ts_append_eval %Q|"GDP_EX_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKEMPSNMNS@JP.Q".ts_append_eval %Q|"TKEMPSNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GDP_INRP@JP.Q".ts_append_eval %Q|"GDP_INRP@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCMMN_NS@JP.Q".ts_append_eval %Q|"TKBSCMMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCMMNNS@JP.Q".ts_append_eval %Q|"TKBSCMMNNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "TKBSCLNS@JP.Q".ts_append_eval %Q|"TKBSCLNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
   "GHWYNS@KAU.A".ts_append_eval %Q|"GHWYNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "GSANNS@KAU.A".ts_append_eval %Q|"GSANNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "GDEBNS@KAU.A".ts_append_eval %Q|"GDEBNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "ROCHGNS@KAU.A".ts_append_eval %Q|"ROCHGNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KNNSGF@HON.M".ts_append_eval %Q|"KNNSGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNN2FM@HON.M".ts_append_eval %Q|"KNN2FM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNAPT@HON.M".ts_append_eval %Q|"KNNAPT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNHTL@HON.M".ts_append_eval %Q|"KNNHTL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNAMU@HON.M".ts_append_eval %Q|"KNNAMU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNCHU@HON.M".ts_append_eval %Q|"KNNCHU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNGPR@HON.M".ts_append_eval %Q|"KNNGPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNSER@HON.M".ts_append_eval %Q|"KNNSER@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNINS@HON.M".ts_append_eval %Q|"KNNINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNOFC@HON.M".ts_append_eval %Q|"KNNOFC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNPBB@HON.M".ts_append_eval %Q|"KNNPBB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNSCH@HON.M".ts_append_eval %Q|"KNNSCH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNONR@HON.M".ts_append_eval %Q|"KNNONR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNOTH@HON.M".ts_append_eval %Q|"KNNOTH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNA2FM@HON.M".ts_append_eval %Q|"KNA2FM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAPBB@HON.M".ts_append_eval %Q|"KNAPBB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNASTB@HON.M".ts_append_eval %Q|"KNASTB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAOTH@HON.M".ts_append_eval %Q|"KNAOTH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNAMU@HON.M".ts_append_eval %Q|"KVNAMU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAGPB@HON.M".ts_append_eval %Q|"KVAGPB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASCH@HON.M".ts_append_eval %Q|"KVASCH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "TRMS@KAU.A".ts_append_eval %Q|"TRMS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/tour/update/TRMS.xls"|
   "TGRSUNS@HAW.A".ts_append_eval %Q|"TGRSUNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGROTNS@KAU.A".ts_append_eval %Q|"TGROTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRMNNS@KAU.A".ts_append_eval %Q|"TGRMNNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRUANS@KAU.A".ts_append_eval %Q|"TGRUANS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "VSOUSENS@KAU.M".ts_append_eval %Q|"VSOUSENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
   "VXPDJPEN@HI.A".ts_append_eval %Q|"VXPDJPEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VXPDJPTR@HI.A".ts_append_eval %Q|"VXPDJPTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VXPDJPSH@HI.A".ts_append_eval %Q|"VXPDJPSH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VXEN@HI.A".ts_append_eval %Q|"VXEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VXAC@HI.A".ts_append_eval %Q|"VXAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VRLSUSWNS@KAU.M".ts_append_eval %Q|"VRLSUSWNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRLSUSENS@KAU.M".ts_append_eval %Q|"VRLSUSENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRLSJPNS@KAU.M".ts_append_eval %Q|"VRLSJPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRLSCANNS@KAU.M".ts_append_eval %Q|"VRLSCANNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRDCCANNS@HI.M".ts_append_eval %Q|"VRDCCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRDCNS@HON.M".ts_append_eval %Q|"VRDCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VRDCDMNS@HON.M".ts_append_eval %Q|"VRDCDMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VAITBBNS@HI.M".ts_append_eval %Q|"VAITBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VAUSWCRNS@HI.M".ts_append_eval %Q|"VAUSWCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VAUSEHTNS@HI.M".ts_append_eval %Q|"VAUSEHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSUSWSCHNS@HI.M".ts_append_eval %Q|"VSUSWSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSOTSCHNS@MAU.M".ts_append_eval %Q|"VSOTSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSITCHTNS@MAU.M".ts_append_eval %Q|"VSITCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSUSESCHNS@HAW.M".ts_append_eval %Q|"VSUSESCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSCANSCHNS@HAW.M".ts_append_eval %Q|"VSCANSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSOTASCHNS@HAW.M".ts_append_eval %Q|"VSOTASCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSOTSCHNS@HAW.M".ts_append_eval %Q|"VSOTSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VSITCHTNS@HAW.M".ts_append_eval %Q|"VSITCHTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VISCRNS@HI.M".ts_append_eval %Q|"VISCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISCRSHPNS@HI.M".ts_append_eval %Q|"VISCRSHPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "NTTOURNS@HI.M".ts_append_eval %Q|"NTTOURNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISCRNS@KAU.M".ts_append_eval %Q|"VISCRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VRLSNS@LAN.M".ts_append_eval %Q|"VRLSNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "EAF@US.M".ts_append_eval %Q|"EAF@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "EAFFDNS@US.M".ts_append_eval %Q|"EAFFDNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "EAE@US.M".ts_append_eval %Q|"EAE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "GDPDEF@US.Q".ts_append_eval %Q|"GDPDEF@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "YLPMDOR&@HAW.A".ts_append_eval %Q|"YLPMDOR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "GDP@JP.A".ts_append_eval %Q|"GDP@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "YLPC&@KAU.A".ts_append_eval %Q|"YLPC&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "EHC@US.M".ts_append_eval %Q|"EHC@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "INFGDPDEF@US.Q".ts_append_eval %Q|"INFGDPDEF@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "GDP_R@US.Q".ts_append_eval %Q|"GDP_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "GDP_IRS_R@US.Q".ts_append_eval %Q|"GDP_IRS_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "YCE_R@US.Q".ts_append_eval %Q|"YCE_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "GDPPC_R@US.Q".ts_append_eval %Q|"GDPPC_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "Y@US.Q".ts_append_eval %Q|"Y@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "UICINS@HONO.W".ts_append_eval %Q|"UICINS@HONO.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
   "UICINS@KANE.W".ts_append_eval %Q|"UICINS@KANE.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
   "UICINS@WPHU.W".ts_append_eval %Q|"UICINS@WPHU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
   "PCSV_MD@HON.Q".ts_eval= %Q|'PCSV_MD@HON.S'.ts.interpolate :quarter, :linear|
   "YL_NF@HAW.A".ts_append_eval %Q|"YL_NF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
   "YL_NF@HAW.A".ts_append_eval %Q|"YL_NF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "NMIG@KAU.A".ts_append_eval %Q|"NMIG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "YLMNNDXP@HI.A".ts_append_eval %Q|"YLMNNDXP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDAP@HI.A".ts_append_eval %Q|"YLMNNDAP@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDPA@HI.A".ts_append_eval %Q|"YLMNNDPA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFICR@HI.A".ts_append_eval %Q|"YLFICR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDLT@HON.A".ts_append_eval %Q|"YLMNNDLT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFISE@HON.A".ts_append_eval %Q|"YLFISE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAERE@HON.A".ts_append_eval %Q|"YLAERE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDRMC@HAW.A".ts_append_eval %Q|"YLMNDRMC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDRFR@HAW.A".ts_append_eval %Q|"YLMNDRFR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFDP@HAW.A".ts_append_eval %Q|"YLIFDP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLADWM@HAW.A".ts_append_eval %Q|"YLADWM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLED@HAW.A".ts_append_eval %Q|"YLED@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDRWD@MAU.A".ts_append_eval %Q|"YLMNDRWD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLWT@KAU.A".ts_append_eval %Q|"YLWT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAERE@KAU.A".ts_append_eval %Q|"YLAERE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "PCCMDR@HON.Q".ts_eval= %Q|'PCCMDR@HON.S'.ts.interpolate :quarter, :linear|
   "PCHSFUGS@HON.S".ts_append_eval %Q|"PCHSFUGS@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "YSOCSEC@HI.A".ts_append_eval %Q|"YSOCSEC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
   "YSOCSEC@HI.A".ts_append_eval %Q|"YSOCSEC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLPSVAU&@KAU.A".ts_append_eval %Q|"YLPSVAU&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVMR&@KAU.A".ts_append_eval %Q|"YLPSVMR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVAM&@KAU.A".ts_append_eval %Q|"YLPSVAM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVMO&@KAU.A".ts_append_eval %Q|"YLPSVMO&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVSO&@KAU.A".ts_append_eval %Q|"YLPSVSO&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPGFM&@KAU.A".ts_append_eval %Q|"YLPGFM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPGSL&@KAU.A".ts_append_eval %Q|"YLPGSL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPGST&@KAU.A".ts_append_eval %Q|"YLPGST&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPGL&@KAU.A".ts_append_eval %Q|"YLPGL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "KVLAPT@KAU.A".ts_append_eval %Q|"KVLAPT@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVIAPT@KAU.A".ts_append_eval %Q|"KVIAPT@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "RTPTNS@KAU.A".ts_append_eval %Q|"RTPTNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "GDP_IRSP_R@JP.A".ts_append_eval %Q|"GDP_IRSP_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "TGBISNS@HON.A".ts_append_eval %Q|"TGBISNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBWTNS@HON.A".ts_append_eval %Q|"TGBWTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBSINS@HON.A".ts_append_eval %Q|"TGBSINS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBU5NS@HON.A".ts_append_eval %Q|"TGBU5NS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBHTNS@MAU.A".ts_append_eval %Q|"TGBHTNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRORNS@HI.A".ts_append_eval %Q|"TGRORNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRCMNS@MAU.A".ts_append_eval %Q|"TGRCMNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRORNS@MAU.A".ts_append_eval %Q|"TGRORNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRPINS@MAU.A".ts_append_eval %Q|"TGRPINS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRUANS@MAU.A".ts_append_eval %Q|"TGRUANS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "GDP_CD@US.A".ts_append_eval %Q|"GDP_CD@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
   "INF@JP.M".ts_append_eval %Q|"INF@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "VEXPNS@MOL.M".ts_append_eval %Q|"VEXPNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "INFCORE@JP.M".ts_append_eval %Q|"INFCORE@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "CPICORE@JP.M".ts_append_eval %Q|"CPICORE@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "EMPL@JP.M".ts_append_eval %Q|"EMPL@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "CPI@JP.M".ts_append_eval %Q|"CPI@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
   "VEXPNS@KAU.M".ts_append_eval %Q|"VEXPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VEXPNS@HON.M".ts_append_eval %Q|"VEXPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "PCFBFDAW@HON.M".ts_append_eval %Q|"PCFBFDAW@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCTR@HON.M".ts_append_eval %Q|"PCTR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCEN@HON.M".ts_append_eval %Q|"PCEN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCMD@HON.M".ts_append_eval %Q|"PCMD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "OCUP%NS@HI.M".ts_append_eval %Q|"OCUP%NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "YV&@HON.A".ts_append_eval %Q|"YV&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YWAGE&@HON.A".ts_append_eval %Q|"YWAGE&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YOTLAB&@HON.A".ts_append_eval %Q|"YOTLAB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YPROP&@HON.A".ts_append_eval %Q|"YPROP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YPROPNF&@HON.A".ts_append_eval %Q|"YPROPNF&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPAGFFF&@HON.A".ts_append_eval %Q|"YLPAGFFF&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPAGFFFFS&@HON.A".ts_append_eval %Q|"YLPAGFFFFS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMIMT&@HON.A".ts_append_eval %Q|"YLPMIMT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPRTA&@HON.A".ts_append_eval %Q|"YLPRTA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPRPL&@HON.A".ts_append_eval %Q|"YLPRPL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVAM&@MAU.A".ts_append_eval %Q|"YLPSVAM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVLG&@MAU.A".ts_append_eval %Q|"YLPSVLG&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVED&@MAU.A".ts_append_eval %Q|"YLPSVED&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "ERTGMDSNS@HAW.M".ts_append_eval %Q|"ERTGMDSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ECTSPNS@MAU.M".ts_append_eval %Q|"ECTSPNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "GNPPC@US.Q".ts_append_eval %Q|"GNPPC@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "GDP_CS_R@US.Q".ts_append_eval %Q|"GDP_CS_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "GDP_CS@US.Q".ts_append_eval %Q|"GDP_CS@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "CAPUMN@US.Q".ts_append_eval %Q|"CAPUMN@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
   "YLWT@HI.Q".ts_append_eval %Q|"YLWT@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLTW@HI.Q".ts_append_eval %Q|"YLTW@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLIF@HI.Q".ts_append_eval %Q|"YLIF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLFI@HI.Q".ts_append_eval %Q|"YLFI@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLRE@HI.Q".ts_append_eval %Q|"YLRE@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLPS@HI.Q".ts_append_eval %Q|"YLPS@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLAD@HI.Q".ts_append_eval %Q|"YLAD@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLED@HI.Q".ts_append_eval %Q|"YLED@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLHC@HI.Q".ts_append_eval %Q|"YLHC@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "KPGOVNS@HI.Q".ts_append_eval %Q|"KPGOVNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "PAKRSGFNS@HAW.Q".ts_append_eval %Q|"PAKRSGFNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRCONNS@HAW.Q".ts_append_eval %Q|"PAKRCONNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PMKRCONNS@KAU.Q".ts_append_eval %Q|"PMKRCONNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRSGFNS@KAU.Q".ts_append_eval %Q|"PAKRSGFNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRCONNS@KAU.Q".ts_append_eval %Q|"PAKRCONNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PMKRSGFNS@MAU.Q".ts_append_eval %Q|"PMKRSGFNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PMKRCONNS@MAU.Q".ts_append_eval %Q|"PMKRCONNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRSGFNS@MAU.Q".ts_append_eval %Q|"PAKRSGFNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRCONNS@MAU.Q".ts_append_eval %Q|"PAKRCONNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PMKRSGFNS@HI.Q".ts_append_eval %Q|"PMKRSGFNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "GNIPC_R@JP.A".ts_append_eval %Q|"GNIPC_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDP_IIVP@JP.A".ts_append_eval %Q|"GDP_IIVP@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDP_IIVG@JP.A".ts_append_eval %Q|"GDP_IIVG@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "VXPDUSWFB@HI.A".ts_append_eval %Q|"VXPDUSWFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "VXPDUSWEN@HI.A".ts_append_eval %Q|"VXPDUSWEN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "YLAGFFFS@HON.A".ts_append_eval %Q|"YLAGFFFS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMIOG@HON.A".ts_append_eval %Q|"YLMIOG@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMIMI@HON.A".ts_append_eval %Q|"YLMIMI@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMISP@HON.A".ts_append_eval %Q|"YLMISP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLCTHV@HON.A".ts_append_eval %Q|"YLCTHV@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDRPM@HON.A".ts_append_eval %Q|"YLMNDRPM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWCU@HON.A".ts_append_eval %Q|"YLTWCU@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFOT@HON.A".ts_append_eval %Q|"YLIFOT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDRMS@KAU.A".ts_append_eval %Q|"YLMNDRMS@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "TRCVNS@HI.M".ts_append_eval %Q|"TRCVNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRIHNS@HI.M".ts_append_eval %Q|"TRIHNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGLNS@HAW.M".ts_append_eval %Q|"TRGLNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTTNS@KAU.M".ts_append_eval %Q|"TRTTNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINPRNS@KAU.M".ts_append_eval %Q|"TRINPRNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFINS@KAU.M".ts_append_eval %Q|"TRFINS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINRFNS@MAU.M".ts_append_eval %Q|"TRINRFNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRNS@MAU.M".ts_append_eval %Q|"TRNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRNS@HON.M".ts_append_eval %Q|"TRNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRCMNS@HI.M".ts_append_eval %Q|"TGRCMNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TREMNS@MAU.M".ts_append_eval %Q|"TREMNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINRFNS@HON.M".ts_append_eval %Q|"TRINRFNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRU4NS@HI.M".ts_append_eval %Q|"TGRU4NS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRTTNS@MAU.M".ts_append_eval %Q|"TRTTNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINPRNS@MAU.M".ts_append_eval %Q|"TRINPRNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFINS@MAU.M".ts_append_eval %Q|"TRFINS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINPRNS@HON.M".ts_append_eval %Q|"TRINPRNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRFINS@HON.M".ts_append_eval %Q|"TRFINS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTTNS@HON.M".ts_append_eval %Q|"TRTTNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRLINS@HI.M".ts_append_eval %Q|"TRLINS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRHTNS@HI.M".ts_append_eval %Q|"TGRHTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRINWHNS@KAU.M".ts_append_eval %Q|"TRINWHNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOESNS@KAU.M".ts_append_eval %Q|"TRCOESNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRGTNS@HI.M".ts_append_eval %Q|"TRGTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRPSNS@HI.M".ts_append_eval %Q|"TRPSNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRITNS@HI.M".ts_append_eval %Q|"TGRITNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TRCOPRNS@KAU.M".ts_append_eval %Q|"TRCOPRNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINESNS@HI.M".ts_append_eval %Q|"TRINESNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINESNS@HAW.M".ts_append_eval %Q|"TRINESNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRHSNS@HI.M".ts_append_eval %Q|"TRHSNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINWHNS@MAU.M".ts_append_eval %Q|"TRINWHNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOESNS@MAU.M".ts_append_eval %Q|"TRCOESNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTFNS@HAW.M".ts_append_eval %Q|"TRTFNS@HAW.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOESNS@HI.M".ts_append_eval %Q|"TRCOESNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRTBNS@KAU.M".ts_append_eval %Q|"TRTBNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCVNS@KAU.M".ts_append_eval %Q|"TRCVNS@KAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOPRNS@MAU.M".ts_append_eval %Q|"TRCOPRNS@MAU.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOESNS@HON.M".ts_append_eval %Q|"TRCOESNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINWHNS@HON.M".ts_append_eval %Q|"TRINWHNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRISNS@HI.M".ts_append_eval %Q|"TRISNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRINWHNS@HI.M".ts_append_eval %Q|"TRINWHNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TRCOPRNS@HON.M".ts_append_eval %Q|"TRCOPRNS@HON.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBU4NS@HAW.M".ts_append_eval %Q|"TGBU4NS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSVNS@HAW.M".ts_append_eval %Q|"TGBSVNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU4NS@HI.M".ts_append_eval %Q|"TGBU4NS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDNANS@HI.M".ts_append_eval %Q|"TDNANS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBSINS@KAU.M".ts_append_eval %Q|"TGBSINS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBTHNS@KAU.M".ts_append_eval %Q|"TGBTHNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBRTNS@KAU.M".ts_append_eval %Q|"TGBRTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPINS@MAU.M".ts_append_eval %Q|"TGBPINS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBOTNS@MAU.M".ts_append_eval %Q|"TGBOTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPINS@HON.M".ts_append_eval %Q|"TGBPINS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCMNS@MAU.M".ts_append_eval %Q|"TGBCMNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBOTNS@HON.M".ts_append_eval %Q|"TGBOTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCMNS@HON.M".ts_append_eval %Q|"TGBCMNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGROTNS@KAU.M".ts_append_eval %Q|"TGROTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRTHNS@KAU.M".ts_append_eval %Q|"TGRTHNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSINS@HI.M".ts_append_eval %Q|"TGRSINS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSVNS@HAW.M".ts_append_eval %Q|"TGRSVNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRWTNS@KAU.M".ts_append_eval %Q|"TGRWTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSUNS@HON.M".ts_append_eval %Q|"TGRSUNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRHTNS@KAU.M".ts_append_eval %Q|"TGRHTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDRHNS@HI.M".ts_append_eval %Q|"TDRHNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBSINS@MAU.M".ts_append_eval %Q|"TGBSINS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBTHNS@MAU.M".ts_append_eval %Q|"TGBTHNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBRTNS@MAU.M".ts_append_eval %Q|"TGBRTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSINS@HON.M".ts_append_eval %Q|"TGBSINS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBTHNS@HON.M".ts_append_eval %Q|"TGBTHNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBRTNS@HON.M".ts_append_eval %Q|"TGBRTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDEMNS@HI.M".ts_append_eval %Q|"TDEMNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGRU4NS@HAW.M".ts_append_eval %Q|"TGRU4NS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCMNS@HI.M".ts_append_eval %Q|"TGBCMNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRMNNS@HI.M".ts_append_eval %Q|"TGRMNNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCENS@HI.M".ts_append_eval %Q|"TDCENS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGROTNS@MAU.M".ts_append_eval %Q|"TGROTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGROTNS@HON.M".ts_append_eval %Q|"TGROTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRRTNS@KAU.M".ts_append_eval %Q|"TGRRTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRTHNS@MAU.M".ts_append_eval %Q|"TGRTHNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRTHNS@HON.M".ts_append_eval %Q|"TGRTHNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBOTNS@HI.M".ts_append_eval %Q|"TGBOTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRWTNS@MAU.M".ts_append_eval %Q|"TGRWTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRWTNS@HON.M".ts_append_eval %Q|"TGRWTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRHTNS@MAU.M".ts_append_eval %Q|"TGRHTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRHTNS@HON.M".ts_append_eval %Q|"TGRHTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPDNS@HAW.M".ts_append_eval %Q|"TGBPDNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDEVNS@HI.M".ts_append_eval %Q|"TDEVNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBU5NS@KAU.M".ts_append_eval %Q|"TGBU5NS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBWTNS@HAW.M".ts_append_eval %Q|"TGBWTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBHTNS@HAW.M".ts_append_eval %Q|"TGBHTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPINS@KAU.M".ts_append_eval %Q|"TGRPINS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPDNS@HI.M".ts_append_eval %Q|"TGRPDNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRALNS@HAW.M".ts_append_eval %Q|"TGRALNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRRTNS@MAU.M".ts_append_eval %Q|"TGRRTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRRTNS@HON.M".ts_append_eval %Q|"TGRRTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPDNS@HAW.M".ts_append_eval %Q|"TGRPDNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDTSNS@HI.M".ts_append_eval %Q|"TDTSNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBMNNS@KAU.M".ts_append_eval %Q|"TGBMNNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRUANS@HAW.M".ts_append_eval %Q|"TGRUANS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCMNS@KAU.M".ts_append_eval %Q|"TGRCMNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBHTNS@HI.M".ts_append_eval %Q|"TGBHTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDHWNS@HI.M".ts_append_eval %Q|"TDHWNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TDGFNS@HI.M".ts_append_eval %Q|"TDGFNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBORNS@KAU.M".ts_append_eval %Q|"TGBORNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU5NS@MAU.M".ts_append_eval %Q|"TGBU5NS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU5NS@HON.M".ts_append_eval %Q|"TGBU5NS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRISNS@HAW.M".ts_append_eval %Q|"TGRISNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPINS@MAU.M".ts_append_eval %Q|"TGRPINS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBWTNS@HI.M".ts_append_eval %Q|"TGBWTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCTNS@HAW.M".ts_append_eval %Q|"TGBCTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPINS@HON.M".ts_append_eval %Q|"TGRPINS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBISNS@HI.M".ts_append_eval %Q|"TGBISNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBNS@KAU.M".ts_append_eval %Q|"TGBNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBMNNS@MAU.M".ts_append_eval %Q|"TGBMNNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBMNNS@HON.M".ts_append_eval %Q|"TGBMNNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCTNS@KAU.M".ts_append_eval %Q|"TGRCTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRMNNS@KAU.M".ts_append_eval %Q|"TGRMNNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCMNS@MAU.M".ts_append_eval %Q|"TGRCMNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBMNNS@HI.M".ts_append_eval %Q|"TGBMNNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCMNS@HON.M".ts_append_eval %Q|"TGRCMNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBISNS@KAU.M".ts_append_eval %Q|"TGBISNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBORNS@MAU.M".ts_append_eval %Q|"TGBORNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPINS@HAW.M".ts_append_eval %Q|"TGBPINS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBOTNS@HAW.M".ts_append_eval %Q|"TGBOTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBORNS@HON.M".ts_append_eval %Q|"TGBORNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPDNS@HI.M".ts_append_eval %Q|"TGBPDNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRORNS@KAU.M".ts_append_eval %Q|"TGRORNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCMNS@HAW.M".ts_append_eval %Q|"TGBCMNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU5NS@HI.M".ts_append_eval %Q|"TGRU5NS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBITNS@KAU.M".ts_append_eval %Q|"TGBITNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBNS@MAU.M".ts_append_eval %Q|"TGBNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSUNS@HAW.M".ts_append_eval %Q|"TGRSUNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCTNS@HON.M".ts_append_eval %Q|"TGRCTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBNS@HON.M".ts_append_eval %Q|"TGBNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRMNNS@MAU.M".ts_append_eval %Q|"TGRMNNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRMNNS@HON.M".ts_append_eval %Q|"TGRMNNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSINS@HI.M".ts_append_eval %Q|"TGBSINS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCTNS@MAU.M".ts_append_eval %Q|"TGRCTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBISNS@MAU.M".ts_append_eval %Q|"TGBISNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSINS@HAW.M".ts_append_eval %Q|"TGBSINS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBTHNS@HAW.M".ts_append_eval %Q|"TGBTHNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBRTNS@HAW.M".ts_append_eval %Q|"TGBRTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRNS@KAU.M".ts_append_eval %Q|"TGRNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRORNS@MAU.M".ts_append_eval %Q|"TGRORNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRORNS@HON.M".ts_append_eval %Q|"TGRORNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBISNS@HON.M".ts_append_eval %Q|"TGBISNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSUNS@HI.M".ts_append_eval %Q|"TGBSUNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSINS@KAU.M".ts_append_eval %Q|"TGRSINS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRWTNS@HAW.M".ts_append_eval %Q|"TGRWTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCVNS@HI.M".ts_append_eval %Q|"TDCVNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TDAPNS@HI.M".ts_append_eval %Q|"TDAPNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBSUNS@KAU.M".ts_append_eval %Q|"TGBSUNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRHTNS@HAW.M".ts_append_eval %Q|"TGRHTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRITNS@KAU.M".ts_append_eval %Q|"TGRITNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGROTNS@HAW.M".ts_append_eval %Q|"TGROTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBITNS@MAU.M".ts_append_eval %Q|"TGBITNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBITNS@HON.M".ts_append_eval %Q|"TGBITNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRNS@MAU.M".ts_append_eval %Q|"TGRNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRNS@HON.M".ts_append_eval %Q|"TGRNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU5NS@KAU.M".ts_append_eval %Q|"TGRU5NS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPINS@HI.M".ts_append_eval %Q|"TGRPINS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU4NS@KAU.M".ts_append_eval %Q|"TGBU4NS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSVNS@KAU.M".ts_append_eval %Q|"TGBSVNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSINS@MAU.M".ts_append_eval %Q|"TGRSINS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCANS@HI.M".ts_append_eval %Q|"TDCANS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBWTNS@KAU.M".ts_append_eval %Q|"TGBWTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSUNS@MAU.M".ts_append_eval %Q|"TGBSUNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSUNS@HON.M".ts_append_eval %Q|"TGBSUNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRITNS@HON.M".ts_append_eval %Q|"TGRITNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRRTNS@HAW.M".ts_append_eval %Q|"TGRRTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSINS@HON.M".ts_append_eval %Q|"TGRSINS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU5NS@HON.M".ts_append_eval %Q|"TGRU5NS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRITNS@MAU.M".ts_append_eval %Q|"TGRITNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU5NS@MAU.M".ts_append_eval %Q|"TGRU5NS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU4NS@MAU.M".ts_append_eval %Q|"TGBU4NS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSVNS@MAU.M".ts_append_eval %Q|"TGBSVNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU5NS@HAW.M".ts_append_eval %Q|"TGBU5NS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU4NS@HON.M".ts_append_eval %Q|"TGBU4NS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPINS@HAW.M".ts_append_eval %Q|"TGRPINS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCTNS@HI.M".ts_append_eval %Q|"TGBCTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSVNS@HON.M".ts_append_eval %Q|"TGBSVNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSVNS@KAU.M".ts_append_eval %Q|"TGRSVNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBWTNS@MAU.M".ts_append_eval %Q|"TGBWTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCTFUNS@HI.M".ts_append_eval %Q|"TDCTFUNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBMNNS@HAW.M".ts_append_eval %Q|"TGBMNNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU4NS@KAU.M".ts_append_eval %Q|"TGRU4NS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBTHNS@HI.M".ts_append_eval %Q|"TGBTHNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCMNS@HAW.M".ts_append_eval %Q|"TGRCMNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBRTNS@HI.M".ts_append_eval %Q|"TGBRTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBORNS@HAW.M".ts_append_eval %Q|"TGBORNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPINS@HI.M".ts_append_eval %Q|"TGBPINS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSVNS@MAU.M".ts_append_eval %Q|"TGRSVNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSVNS@HON.M".ts_append_eval %Q|"TGRSVNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPDNS@KAU.M".ts_append_eval %Q|"TGBPDNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDBONS@HI.M".ts_append_eval %Q|"TDBONS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBHTNS@KAU.M".ts_append_eval %Q|"TGBHTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBNS@HAW.M".ts_append_eval %Q|"TGBNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBU5NS@HI.M".ts_append_eval %Q|"TGBU5NS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBORNS@HI.M".ts_append_eval %Q|"TGBORNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRCTNS@HAW.M".ts_append_eval %Q|"TGRCTNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRALNS@KAU.M".ts_append_eval %Q|"TGRALNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRMNNS@HAW.M".ts_append_eval %Q|"TGRMNNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU4NS@MAU.M".ts_append_eval %Q|"TGRU4NS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU4NS@HON.M".ts_append_eval %Q|"TGRU4NS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBISNS@HAW.M".ts_append_eval %Q|"TGBISNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSUNS@KAU.M".ts_append_eval %Q|"TGRSUNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPDNS@KAU.M".ts_append_eval %Q|"TGRPDNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRORNS@HAW.M".ts_append_eval %Q|"TGRORNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPDNS@MAU.M".ts_append_eval %Q|"TGBPDNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBPDNS@HON.M".ts_append_eval %Q|"TGBPDNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRUANS@KAU.M".ts_append_eval %Q|"TGRUANS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBNS@HI.M".ts_append_eval %Q|"TGBNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDTTNS@HI.M".ts_append_eval %Q|"TDTTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBITNS@HAW.M".ts_append_eval %Q|"TGBITNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBWTNS@HON.M".ts_append_eval %Q|"TGBWTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRALNS@MAU.M".ts_append_eval %Q|"TGRALNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRALNS@HON.M".ts_append_eval %Q|"TGRALNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRISNS@KAU.M".ts_append_eval %Q|"TGRISNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCTNS@KAU.M".ts_append_eval %Q|"TGBCTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBHTNS@MAU.M".ts_append_eval %Q|"TGBHTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBHTNS@HON.M".ts_append_eval %Q|"TGBHTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPDNS@MAU.M".ts_append_eval %Q|"TGRPDNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSUNS@MAU.M".ts_append_eval %Q|"TGRSUNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRPDNS@HON.M".ts_append_eval %Q|"TGRPDNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRNS@HAW.M".ts_append_eval %Q|"TGRNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRWTNS@HI.M".ts_append_eval %Q|"TGRWTNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRUANS@HON.M".ts_append_eval %Q|"TGRUANS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBITNS@HI.M".ts_append_eval %Q|"TGBITNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSVNS@HI.M".ts_append_eval %Q|"TGBSVNS@HI.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRTHNS@HAW.M".ts_append_eval %Q|"TGRTHNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRSINS@HAW.M".ts_append_eval %Q|"TGRSINS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRUANS@MAU.M".ts_append_eval %Q|"TGRUANS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCTNS@HI.M".ts_append_eval %Q|"TDCTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "TGBPINS@KAU.M".ts_append_eval %Q|"TGBPINS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBOTNS@KAU.M".ts_append_eval %Q|"TGBOTNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBSUNS@HAW.M".ts_append_eval %Q|"TGBSUNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRITNS@HAW.M".ts_append_eval %Q|"TGRITNS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRISNS@MAU.M".ts_append_eval %Q|"TGRISNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRISNS@HON.M".ts_append_eval %Q|"TGRISNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGRU5NS@HAW.M".ts_append_eval %Q|"TGRU5NS@HAW.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCMNS@KAU.M".ts_append_eval %Q|"TGBCMNS@KAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCTNS@MAU.M".ts_append_eval %Q|"TGBCTNS@MAU.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TGBCTNS@HON.M".ts_append_eval %Q|"TGBCTNS@HON.M".tsn.load_from "    /Volumes/UHEROwork/data/tax/update/ge_upd.csv"|
   "TDCTTTNS@HI.M".ts_append_eval %Q|"TDCTTTNS@HI.M".tsn.load_from "   /Volumes/UHEROwork/data/tax/update/collec_upd.csv"|
   "YLAF@HI.Q".ts_append_eval %Q|"YLAF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLOS@HI.Q".ts_append_eval %Q|"YLOS@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLPAGFF&@HI.Q".ts_append_eval %Q|"YLPAGFF&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMI&@HI.Q".ts_append_eval %Q|"YLPMI&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPC&@HI.Q".ts_append_eval %Q|"YLPC&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPM&@HI.Q".ts_append_eval %Q|"YLPM&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMD&@HI.Q".ts_append_eval %Q|"YLPMD&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMN&@HI.Q".ts_append_eval %Q|"YLPMN&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPR&@HI.Q".ts_append_eval %Q|"YLPR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPTW&@HI.Q".ts_append_eval %Q|"YLPTW&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPTR&@HI.Q".ts_append_eval %Q|"YLPTR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPFIR&@HI.Q".ts_append_eval %Q|"YLPFIR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSV&@HI.Q".ts_append_eval %Q|"YLPSV&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "PMKRSGFNS@HON.Q".ts_append_eval %Q|"PMKRSGFNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PMKRCONNS@HON.Q".ts_append_eval %Q|"PMKRCONNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRSGFNS@HON.Q".ts_append_eval %Q|"PAKRSGFNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "PAKRCONNS@HON.Q".ts_append_eval %Q|"PAKRCONNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "EMNNS&@HON.M".ts_append_eval %Q|"EMNNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNDRNS&@HON.M".ts_append_eval %Q|"EMNDRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDNS&@HON.M".ts_append_eval %Q|"EMNNDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUNS&@HON.M".ts_append_eval %Q|"ETUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUTWNS&@HON.M".ts_append_eval %Q|"ETUTWNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "E_TRADENS&@HON.M".ts_append_eval %Q|"E_TRADENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EWTNS&@HON.M".ts_append_eval %Q|"EWTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ERTNS&@HON.M".ts_append_eval %Q|"ERTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EFINS&@HON.M".ts_append_eval %Q|"EFINS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVNS&@HON.M".ts_append_eval %Q|"ESVNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVACNS&@HON.M".ts_append_eval %Q|"ESVACNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVBSNS&@HON.M".ts_append_eval %Q|"ESVBSNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVHCNS&@HON.M".ts_append_eval %Q|"ESVHCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVNS&@HON.M".ts_append_eval %Q|"EGVNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDNS&@HON.M".ts_append_eval %Q|"EGVFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVSTNS&@HON.M".ts_append_eval %Q|"EGVSTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVLCNS&@HON.M".ts_append_eval %Q|"EGVLCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "AAMC@HI.A".ts_append_eval %Q|"AAMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "AA@HON.A".ts_append_eval %Q|"AA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "AASU@KAU.A".ts_append_eval %Q|"AASU@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "YCAGFFFO@HI.A".ts_append_eval %Q|"YCAGFFFO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCRTFR@HI.A".ts_append_eval %Q|"YCRTFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCRTEL@HI.A".ts_append_eval %Q|"YCRTEL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCRTBL@HI.A".ts_append_eval %Q|"YCRTBL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCRTGA@HI.A".ts_append_eval %Q|"YCRTGA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCGVFD@HI.A".ts_append_eval %Q|"YCGVFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCGVML@HI.A".ts_append_eval %Q|"YCGVML@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YC_GVSL@HI.A".ts_append_eval %Q|"YC_GVSL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCGVST@HI.A".ts_append_eval %Q|"YCGVST@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCMIMI@HON.A".ts_append_eval %Q|"YCMIMI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCMNDRNM@HON.A".ts_append_eval %Q|"YCMNDRNM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCMNDRPM@HON.A".ts_append_eval %Q|"YCMNDRPM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCMNDRTR@HON.A".ts_append_eval %Q|"YCMNDRTR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCIFPB@HON.A".ts_append_eval %Q|"YCIFPB@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "ANPI@HAW.A".ts_append_eval %Q|"ANPI@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANVG@HAW.A".ts_append_eval %Q|"ANVG@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANCF@HAW.A".ts_append_eval %Q|"ANCF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANPI@HON.A".ts_append_eval %Q|"ANPI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANMC@HON.A".ts_append_eval %Q|"ANMC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANSU@KAU.A".ts_append_eval %Q|"ANSU@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANPI@KAU.A".ts_append_eval %Q|"ANPI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANFR@KAU.A".ts_append_eval %Q|"ANFR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANCF@KAU.A".ts_append_eval %Q|"ANCF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANTR@KAU.A".ts_append_eval %Q|"ANTR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "ANFL@KAU.A".ts_append_eval %Q|"ANFL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "AVC@MAU   .A".ts_append_eval %Q|"AVC@MAU   .A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
   "YCCT@HON.A".ts_append_eval %Q|"YCCT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCAFAC@HON.A".ts_append_eval %Q|"YCAFAC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCOS@HON.A".ts_append_eval %Q|"YCOS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YCGV@HON.A".ts_append_eval %Q|"YCGV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
   "YLMNND@HI.Q".ts_append_eval %Q|"YLMNND@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YOTLABSS@HON.A".ts_append_eval %Q|"YOTLABSS@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAGFA@HON.A".ts_append_eval %Q|"YLAGFA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLAGFA@HON.A".ts_append_eval %Q|"YLAGFA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAGFF@HON.A".ts_append_eval %Q|"YLAGFF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLAGFF@HON.A".ts_append_eval %Q|"YLAGFF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMI@HON.A".ts_append_eval %Q|"YLMI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLMI@HON.A".ts_append_eval %Q|"YLMI@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMN@HON.A".ts_append_eval %Q|"YLMN@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YLMN@HON.A".ts_append_eval %Q|"YLMN@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDCH@HON.A".ts_append_eval %Q|"YLMNNDCH@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWSC@HON.A".ts_append_eval %Q|"YLTWSC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWSP@HON.A".ts_append_eval %Q|"YLTWSP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFI@KAU.A".ts_append_eval %Q|"YLFI@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "EFIOTNS&@HI.M".ts_append_eval %Q|"EFIOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDAFNS&@HI.M".ts_append_eval %Q|"EGVFDAFNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDAFNS&@HON.M".ts_append_eval %Q|"EGVFDAFNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDARNS&@HI.M".ts_append_eval %Q|"EGVFDARNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVFDARNS&@HON.M".ts_append_eval %Q|"EGVFDARNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVSTEDNS&@HI.M".ts_append_eval %Q|"EGVSTEDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVSTEDNS&@HON.M".ts_append_eval %Q|"EGVSTEDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVSTESNS&@HI.M".ts_append_eval %Q|"EGVSTESNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EGVSTESNS&@HON.M".ts_append_eval %Q|"EGVSTESNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNDROTNS&@HON.M".ts_append_eval %Q|"EMNDROTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDFDONS&@HI.M".ts_append_eval %Q|"EMNNDFDONS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDFDONS&@HON.M".ts_append_eval %Q|"EMNNDFDONS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDOTNS&@HI.M".ts_append_eval %Q|"EMNNDOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVEDNS&@HI.M".ts_append_eval %Q|"ESVEDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVEDNS&@HON.M".ts_append_eval %Q|"ESVEDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVOTNS&@HI.M".ts_append_eval %Q|"ESVOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVOTNS&@HON.M".ts_append_eval %Q|"ESVOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ESVSONS&@HI.M".ts_append_eval %Q|"ESVSONS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUCUCMNS&@HI.M".ts_append_eval %Q|"ETUCUCMNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUCUNS&@HAW.M".ts_append_eval %Q|"ETUCUNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "HRRTFDNS&@HI.M".ts_append_eval %Q|"HRRTFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
   "NR@HI.A".ts_append_eval %Q|"NR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDEA@HI.A".ts_append_eval %Q|"NDEA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NRM@HI.A".ts_append_eval %Q|"NRM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NRC@HI.A".ts_append_eval %Q|"NRC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIRCMD@HI.A".ts_append_eval %Q|"NBIRCMD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIRCNM@HI.A".ts_append_eval %Q|"NBIRCNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDEACMD@HI.A".ts_append_eval %Q|"NDEACMD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDEACNM@HI.A".ts_append_eval %Q|"NDEACNM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NR@HON.A".ts_append_eval %Q|"NR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NR@HAW.A".ts_append_eval %Q|"NR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NR@KAU.A".ts_append_eval %Q|"NR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NR@MAU.A".ts_append_eval %Q|"NR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDF@MAU.A".ts_append_eval %Q|"NDF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIR@HON.A".ts_append_eval %Q|"NBIR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIR@HAW.A".ts_append_eval %Q|"NBIR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIR@KAU.A".ts_append_eval %Q|"NBIR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIR@MAU.A".ts_append_eval %Q|"NBIR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NMIG@HON.A".ts_append_eval %Q|"NMIG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NMIG@MAU.A".ts_append_eval %Q|"NMIG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NR@NBI.A".ts_append_eval %Q|"NR@NBI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NRC@NBI.A".ts_append_eval %Q|"NRC@NBI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "kpprvrsdns@nbi.A".ts_append_eval %Q|"kpprvrsdns@nbi.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
   "kpprvrsdns@hon.A".ts_append_eval %Q|"kpprvrsdns@hon.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
   "kpprvrsdns@hi.A".ts_append_eval %Q|"kpprvrsdns@hi.A".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
   "KNRSDNS@KAU.Q".ts_append_eval %Q|"KNRSDNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "KNRSDNS@MAU.Q".ts_append_eval %Q|"KNRSDNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
   "YMED@HI.A".ts_append_eval %Q|"YMED@HI.A".tsn.load_from "/Volumes/UHEROwork/data/misc/hud/update/hud_upd.xls"|
   "YMED@HAW.A".ts_append_eval %Q|"YMED@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/misc/hud/update/hud_upd.xls"|
   "YLGVST@HAW.A".ts_append_eval %Q|"YLGVST@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
   "YLGVST@HAW.A".ts_append_eval %Q|"YLGVST@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMN@HAW.A".ts_append_eval %Q|"YLMN@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL_TU@HAW.A".ts_append_eval %Q|"YL_TU@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
   "YLAF@HAW.A".ts_append_eval %Q|"YLAF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAFAC@HAW.A".ts_append_eval %Q|"YLAFAC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAFFD@HAW.A".ts_append_eval %Q|"YLAFFD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLPS@HAW.A".ts_append_eval %Q|"YLPS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL@MAU.A".ts_append_eval %Q|"YL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YL@MAU.A".ts_append_eval %Q|"YL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YSOCSEC@MAU.A".ts_append_eval %Q|"YSOCSEC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YSOCSEC@MAU.A".ts_append_eval %Q|"YSOCSEC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YRESADJ@MAU.A".ts_append_eval %Q|"YRESADJ@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YRESADJ@MAU.A".ts_append_eval %Q|"YRESADJ@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YNETR@MAU.A".ts_append_eval %Q|"YNETR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YNETR@MAU.A".ts_append_eval %Q|"YNETR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YDIV@MAU.A".ts_append_eval %Q|"YDIV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YDIV@MAU.A".ts_append_eval %Q|"YDIV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YTRNSF@MAU.A".ts_append_eval %Q|"YTRNSF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YTRNSF@MAU.A".ts_append_eval %Q|"YTRNSF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YWAGE@MAU.A".ts_append_eval %Q|"YWAGE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YWAGE@MAU.A".ts_append_eval %Q|"YWAGE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YOTLAB@MAU.A".ts_append_eval %Q|"YOTLAB@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YOTLAB@MAU.A".ts_append_eval %Q|"YOTLAB@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROP@MAU.A".ts_append_eval %Q|"YPROP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YPROP@MAU.A".ts_append_eval %Q|"YPROP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPFA@MAU.A".ts_append_eval %Q|"YPROPFA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YPROPFA@MAU.A".ts_append_eval %Q|"YPROPFA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPNF@MAU.A".ts_append_eval %Q|"YPROPNF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YPROPNF@MAU.A".ts_append_eval %Q|"YPROPNF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL_NF@MAU.A".ts_append_eval %Q|"YL_NF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YL_NF@MAU.A".ts_append_eval %Q|"YL_NF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL_PR@MAU.A".ts_append_eval %Q|"YL_PR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YL_PR@MAU.A".ts_append_eval %Q|"YL_PR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVFD@MAU.A".ts_append_eval %Q|"YLGVFD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YLGVFD@MAU.A".ts_append_eval %Q|"YLGVFD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVML@MAU.A".ts_append_eval %Q|"YLGVML@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YLGVML@MAU.A".ts_append_eval %Q|"YLGVML@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVST@MAU.A".ts_append_eval %Q|"YLGVST@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YLGVST@MAU.A".ts_append_eval %Q|"YLGVST@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGVLC@MAU.A".ts_append_eval %Q|"YLGVLC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YLGVLC@MAU.A".ts_append_eval %Q|"YLGVLC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPCBEA@KAU.A".ts_append_eval %Q|"YPCBEA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YPCBEA@KAU.A".ts_append_eval %Q|"YPCBEA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL@KAU.A".ts_append_eval %Q|"YL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YL@KAU.A".ts_append_eval %Q|"YL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YRESADJ@KAU.A".ts_append_eval %Q|"YRESADJ@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YRESADJ@KAU.A".ts_append_eval %Q|"YRESADJ@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YNETR@KAU.A".ts_append_eval %Q|"YNETR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YNETR@KAU.A".ts_append_eval %Q|"YNETR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROP@KAU.A".ts_append_eval %Q|"YPROP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YPROP@KAU.A".ts_append_eval %Q|"YPROP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPFA@KAU.A".ts_append_eval %Q|"YPROPFA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YPROPFA@KAU.A".ts_append_eval %Q|"YPROPFA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YPROPNF@KAU.A".ts_append_eval %Q|"YPROPNF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YPROPNF@KAU.A".ts_append_eval %Q|"YPROPNF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAGFA@KAU.A".ts_append_eval %Q|"YLAGFA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YLAGFA@KAU.A".ts_append_eval %Q|"YLAGFA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL_PR@KAU.A".ts_append_eval %Q|"YL_PR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YL_PR@KAU.A".ts_append_eval %Q|"YL_PR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLGV@KAU.A".ts_append_eval %Q|"YLGV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
   "YLGV@KAU.A".ts_append_eval %Q|"YLGV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "GDP_IM@JP.A".ts_append_eval %Q|"GDP_IM@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDP_EX_R@JP.A".ts_append_eval %Q|"GDP_EX_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "KNNIND@HON.M".ts_append_eval %Q|"KNNIND@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNGPB@HON.M".ts_append_eval %Q|"KNNGPB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNNSTB@HON.M".ts_append_eval %Q|"KNNSTB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNACHU@HON.M".ts_append_eval %Q|"KNACHU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAIND@HON.M".ts_append_eval %Q|"KNAIND@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAGPB@HON.M".ts_append_eval %Q|"KNAGPB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAGPR@HON.M".ts_append_eval %Q|"KNAGPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAINS@HON.M".ts_append_eval %Q|"KNAINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAOFC@HON.M".ts_append_eval %Q|"KNAOFC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNAPBU@HON.M".ts_append_eval %Q|"KNAPBU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNASCH@HON.M".ts_append_eval %Q|"KNASCH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNASHD@HON.M".ts_append_eval %Q|"KNASHD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNASTR@HON.M".ts_append_eval %Q|"KNASTR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KNA@HON.M".ts_append_eval %Q|"KNA@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVN2FM@HON.M".ts_append_eval %Q|"KVN2FM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNAPT@HON.M".ts_append_eval %Q|"KVNAPT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNIND@HON.M".ts_append_eval %Q|"KVNIND@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNGPR@HON.M".ts_append_eval %Q|"KVNGPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNSER@HON.M".ts_append_eval %Q|"KVNSER@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNINS@HON.M".ts_append_eval %Q|"KVNINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNOFC@HON.M".ts_append_eval %Q|"KVNOFC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNPBB@HON.M".ts_append_eval %Q|"KVNPBB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNPBU@HON.M".ts_append_eval %Q|"KVNPBU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNSCH@HON.M".ts_append_eval %Q|"KVNSCH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNSHD@HON.M".ts_append_eval %Q|"KVNSHD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNSTB@HON.M".ts_append_eval %Q|"KVNSTB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNSTR@HON.M".ts_append_eval %Q|"KVNSTR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNONR@HON.M".ts_append_eval %Q|"KVNONR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVNOTH@HON.M".ts_append_eval %Q|"KVNOTH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVN@HON.M".ts_append_eval %Q|"KVN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASGF@HON.M".ts_append_eval %Q|"KVASGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVA2FM@HON.M".ts_append_eval %Q|"KVA2FM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAGPR@HON.M".ts_append_eval %Q|"KVAGPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASER@HON.M".ts_append_eval %Q|"KVASER@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAINS@HON.M".ts_append_eval %Q|"KVAINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAOFC@HON.M".ts_append_eval %Q|"KVAOFC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAPBB@HON.M".ts_append_eval %Q|"KVAPBB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAPBU@HON.M".ts_append_eval %Q|"KVAPBU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASHD@HON.M".ts_append_eval %Q|"KVASHD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASTB@HON.M".ts_append_eval %Q|"KVASTB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVASTR@HON.M".ts_append_eval %Q|"KVASTR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAONR@HON.M".ts_append_eval %Q|"KVAONR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVAOTH@HON.M".ts_append_eval %Q|"KVAOTH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "KVA@HON.M".ts_append_eval %Q|"KVA@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
   "LRSGFNS@HON.Q".ts_append_eval %Q|"LRSGFNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRCONNS@HON.Q".ts_append_eval %Q|"LRCONNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRSGFNS@MAU.Q".ts_append_eval %Q|"LRSGFNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRCONNS@MAU.Q".ts_append_eval %Q|"LRCONNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRSGFNS@HAW.Q".ts_append_eval %Q|"LRSGFNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRCONNS@HAW.Q".ts_append_eval %Q|"LRCONNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRSGFNS@KAU.Q".ts_append_eval %Q|"LRSGFNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "LRCONNS@KAU.Q".ts_append_eval %Q|"LRCONNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "TGBRTNS@HI.A".ts_append_eval %Q|"TGBRTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBSVNS@HI.A".ts_append_eval %Q|"TGBSVNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBCTNS@HI.A".ts_append_eval %Q|"TGBCTNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBSUNS@MAU.A".ts_append_eval %Q|"TGBSUNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBPINS@MAU.A".ts_append_eval %Q|"TGBPINS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBPDNS@MAU.A".ts_append_eval %Q|"TGBPDNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBNS@MAU.A".ts_append_eval %Q|"TGBNS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBTHNS@HAW.A".ts_append_eval %Q|"TGBTHNS@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBSVNS@KAU.A".ts_append_eval %Q|"TGBSVNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBTHNS@KAU.A".ts_append_eval %Q|"TGBTHNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGBITNS@KAU.A".ts_append_eval %Q|"TGBITNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "YLAFFD@HI.A".ts_append_eval %Q|"YLAFFD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAFFD@HI.A".ts_append_eval %Q|"YLAFFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
   "YLPGSL&@HI.Q".ts_append_eval %Q|"YLPGSL&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPAGFFFOT&@HON.A".ts_append_eval %Q|"YLPAGFFFOT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMICO&@HON.A".ts_append_eval %Q|"YLPMICO&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPFIRIC&@HON.A".ts_append_eval %Q|"YLPFIRIC&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPFIRIA&@HON.A".ts_append_eval %Q|"YLPFIRIA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPFIRRE&@HON.A".ts_append_eval %Q|"YLPFIRRE&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMDWD&@HAW.A".ts_append_eval %Q|"YLPMDWD&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMDPM&@HAW.A".ts_append_eval %Q|"YLPMDPM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMDMC&@HAW.A".ts_append_eval %Q|"YLPMDMC&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
    "PCFB@HON.S".ts_append_eval %Q|"PCFB@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
    "PCEN@HON.S".ts_append_eval %Q|"PCEN@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "TGRISNS@HI.A".ts_append_eval %Q|"TGRISNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "TGRSUNS@HI.A".ts_append_eval %Q|"TGRSUNS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "PAKRSGF@HON.Q".ts_append_eval %Q|"PAKRSGF@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "PMKRSGF@HON.Q".ts_append_eval %Q|"PMKRSGF@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "PAKRSGF@HAW.Q".ts_append_eval %Q|"PAKRSGF@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "PAKRCON@MAU.Q".ts_append_eval %Q|"PAKRCON@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "PAKRCON@KAU.Q".ts_append_eval %Q|"PAKRCON@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "PMKRCON@KAU.Q".ts_append_eval %Q|"PMKRCON@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
   "YPCBEA@MAU.A".ts_append_eval %Q|"YPCBEA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
   "YPCBEA@MAU.A".ts_append_eval %Q|"YPCBEA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDCH@HI.A".ts_append_eval %Q|"YLMNNDCH@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAD@HI.A".ts_append_eval %Q|"YLAD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLADAD@HI.A".ts_append_eval %Q|"YLADAD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLADWM@HI.A".ts_append_eval %Q|"YLADWM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCAM@HI.A".ts_append_eval %Q|"YLHCAM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCHO@HI.A".ts_append_eval %Q|"YLHCHO@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCNR@HI.A".ts_append_eval %Q|"YLHCNR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCSO@HI.A".ts_append_eval %Q|"YLHCSO@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAEPF@HI.A".ts_append_eval %Q|"YLAEPF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAEMU@HI.A".ts_append_eval %Q|"YLAEMU@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAERE@HI.A".ts_append_eval %Q|"YLAERE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNDREL@HON.A".ts_append_eval %Q|"YLMNDREL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRELE@HON.A".ts_append_eval %Q|"YLRELE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLADWM@HON.A".ts_append_eval %Q|"YLADWM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCNR@HON.A".ts_append_eval %Q|"YLHCNR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLHCSO@HON.A".ts_append_eval %Q|"YLHCSO@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YL_GVSL@HON.A".ts_append_eval %Q|"YL_GVSL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YL_GVSL@HON.A".ts_append_eval %Q|"YL_GVSL@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDFD@HAW.A".ts_append_eval %Q|"YLMNNDFD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDBV@HAW.A".ts_append_eval %Q|"YLMNNDBV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDXM@HAW.A".ts_append_eval %Q|"YLMNNDXM@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMNNDXP@HAW.A".ts_append_eval %Q|"YLMNNDXP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWTW@HAW.A".ts_append_eval %Q|"YLTWTW@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWSP@HAW.A".ts_append_eval %Q|"YLTWSP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWCU@HAW.A".ts_append_eval %Q|"YLTWCU@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWWH@HAW.A".ts_append_eval %Q|"YLTWWH@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFPB@HAW.A".ts_append_eval %Q|"YLIFPB@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFMP@HAW.A".ts_append_eval %Q|"YLIFMP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFBC@HAW.A".ts_append_eval %Q|"YLIFBC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFTC@HAW.A".ts_append_eval %Q|"YLIFTC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFOT@HAW.A".ts_append_eval %Q|"YLIFOT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFIIN@HAW.A".ts_append_eval %Q|"YLFIIN@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRE@HAW.A".ts_append_eval %Q|"YLRE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRERE@HAW.A".ts_append_eval %Q|"YLRERE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRERL@HAW.A".ts_append_eval %Q|"YLRERL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRTGA@MAU.A".ts_append_eval %Q|"YLRTGA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRTOT@MAU.A".ts_append_eval %Q|"YLRTOT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTW@MAU.A".ts_append_eval %Q|"YLTW@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLTWWH@MAU.A".ts_append_eval %Q|"YLTWWH@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFTC@MAU.A".ts_append_eval %Q|"YLIFTC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLIFOT@MAU.A".ts_append_eval %Q|"YLIFOT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFIMO@MAU.A".ts_append_eval %Q|"YLFIMO@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLFICR@MAU.A".ts_append_eval %Q|"YLFICR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAFAC@MAU.A".ts_append_eval %Q|"YLAFAC@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAGFFOT@KAU.A".ts_append_eval %Q|"YLAGFFOT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAFAC@KAU.A".ts_append_eval %Q|"YLAFAC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLOSRP@KAU.A".ts_append_eval %Q|"YLOSRP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLOSPL@KAU.A".ts_append_eval %Q|"YLOSPL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLOSMA@KAU.A".ts_append_eval %Q|"YLOSMA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLOSHH@KAU.A".ts_append_eval %Q|"YLOSHH@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  
  "VISDEMETRA_MC@HI.M".ts_eval= %Q|"VIS@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "PCHSSHRT@HON.S".ts_append_eval %Q|"PCHSSHRT@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCED@HON.S".ts_append_eval %Q|"PCED@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "YLMNDRCM@HI.A".ts_append_eval %Q|"YLMNDRCM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "RMRVNS@MAU.M".ts_append_eval %Q|"RMRVNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "KVISFM@KAU.A".ts_append_eval %Q|"KVISFM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "VXPR@HI.A".ts_append_eval %Q|"VXPR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPRUS@HI.A".ts_append_eval %Q|"VXPRUS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPRJP@HI.A".ts_append_eval %Q|"VXPRJP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "VXPRCAN@HI.A".ts_append_eval %Q|"VXPRCAN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "YDIV@HAW.A".ts_append_eval %Q|"YDIV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YDIV@HAW.A".ts_append_eval %Q|"YDIV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "TGBCTNS@HON.A".ts_append_eval %Q|"TGBCTNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGBMNNS@HON.A".ts_append_eval %Q|"TGBMNNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "YPROPNF@HI.A".ts_append_eval %Q|"YPROPNF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YPROPNF@HI.A".ts_append_eval %Q|"YPROPNF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "GDP@US.A".ts_append_eval %Q|"GDP@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "VISJPNS@MAUI.M".ts_append_eval %Q|"VISJPNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "RMRVNS@KAU.M".ts_append_eval %Q|"RMRVNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "PCCM_FD@HON.M".ts_append_eval %Q|"PCCM_FD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "RMRVNS@HON.M".ts_append_eval %Q|"RMRVNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "KVICOM@KAU.A".ts_append_eval %Q|"KVICOM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVIAGR@KAU.A".ts_append_eval %Q|"KVIAGR@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "VXOT@HI.A".ts_append_eval %Q|"VXOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
  "ECTSPNS@HAW.M".ts_append_eval %Q|"ECTSPNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "VISUSENS@LAN.M".ts_append_eval %Q|"VISUSENS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "PCCMND@HON.M".ts_append_eval %Q|"PCCMND@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "YLAE@HI.Q".ts_append_eval %Q|"YLAE@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "PMKRSGFNS@KAU.Q".ts_append_eval %Q|"PMKRSGFNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
  "GDP_EX@JP.A".ts_append_eval %Q|"GDP_EX@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_CG_R@JP.A".ts_append_eval %Q|"GDP_CG_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_CG@JP.A".ts_append_eval %Q|"GDP_CG@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDPDEF@JP.A".ts_append_eval %Q|"GDPDEF@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "KPPRVRSDNS@NBI.M".ts_append_eval %Q|"KPPRVRSDNS@NBI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
  "EAG@HI.M".ts_append_eval %Q|"EAG@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls"|
  "PCFBFD@HON.Q".ts_eval= %Q|'PCFBFD@HON.S'.ts.interpolate :quarter, :linear|
  "PCFBFDHM@HON.Q".ts_eval= %Q|'PCFBFDHM@HON.S'.ts.interpolate :quarter, :linear|
  "PCFBFDBV@HON.Q".ts_eval= %Q|'PCFBFDBV@HON.S'.ts.interpolate :quarter, :linear|
  "YPROP@HI.Q".ts_append_eval %Q|"YPROP@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YPROP@HI.Q".ts_append_eval %Q|"YPROP@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YPROPNF@HI.Q".ts_append_eval %Q|"YPROPNF@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YPROPNF@HI.Q".ts_append_eval %Q|"YPROPNF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YL_PR@HI.Q".ts_append_eval %Q|"YL_PR@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YL_PR@HI.Q".ts_append_eval %Q|"YL_PR@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLED@HON.A".ts_append_eval %Q|"YLED@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLED@HON.A".ts_append_eval %Q|"YLED@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "PMKRSGFNS@HON.A".ts_eval= %Q|"PMKRSGFNS@HON.Q".ts.aggregate(:year, :average)|
  "YLMISP@HAW.A".ts_append_eval %Q|"YLMISP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTEL@MAU.A".ts_append_eval %Q|"YLRTEL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXP@KAU.A".ts_append_eval %Q|"YLMNNDXP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWWH@HON.A".ts_append_eval %Q|"YLTWWH@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFPB@HON.A".ts_append_eval %Q|"YLIFPB@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFF@MAU.A".ts_append_eval %Q|"YLAGFF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "VSONS@HI.M".ts_append_eval %Q|"VSONS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@HI.M".ts_append_eval %Q|"VSODMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@HI.M".ts_append_eval %Q|"VSOUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSENS@HI.M".ts_append_eval %Q|"VSOUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@HI.M".ts_append_eval %Q|"VSOITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOJPNS@HI.M".ts_append_eval %Q|"VSOJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@HI.M".ts_append_eval %Q|"VSOCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTANS@HI.M".ts_append_eval %Q|"VSOOTANS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@HI.M".ts_append_eval %Q|"VSOAUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@HI.M".ts_append_eval %Q|"VSOOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSONS@HON.M".ts_append_eval %Q|"VSONS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@HON.M".ts_append_eval %Q|"VSODMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@HON.M".ts_append_eval %Q|"VSOUSWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSENS@HON.M".ts_append_eval %Q|"VSOUSENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@HON.M".ts_append_eval %Q|"VSOITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOJPNS@HON.M".ts_append_eval %Q|"VSOJPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@HON.M".ts_append_eval %Q|"VSOCANNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTANS@HON.M".ts_append_eval %Q|"VSOOTANS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOAUSNS@HON.M".ts_append_eval %Q|"VSOAUSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOOTNS@HON.M".ts_append_eval %Q|"VSOOTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSONS@MAU.M".ts_append_eval %Q|"VSONS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@MAU.M".ts_append_eval %Q|"VSODMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@MAU.M".ts_append_eval %Q|"VSOUSWNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSENS@MAU.M".ts_append_eval %Q|"VSOUSENS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@MAU.M".ts_append_eval %Q|"VSOITNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@MAU.M".ts_append_eval %Q|"VSOCANNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSONS@KAU.M".ts_append_eval %Q|"VSONS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@KAU.M".ts_append_eval %Q|"VSODMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@KAU.M".ts_append_eval %Q|"VSOUSWNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSONS@HAWK.M".ts_append_eval %Q|"VSONS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@HAWK.M".ts_append_eval %Q|"VSODMNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@HAWK.M".ts_append_eval %Q|"VSOUSWNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOITNS@HAWK.M".ts_append_eval %Q|"VSOITNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOJPNS@HAWK.M".ts_append_eval %Q|"VSOJPNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOCANNS@HAWK.M".ts_append_eval %Q|"VSOCANNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSONS@HAWH.M".ts_append_eval %Q|"VSONS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSODMNS@HAWH.M".ts_append_eval %Q|"VSODMNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VSOUSWNS@HAWH.M".ts_append_eval %Q|"VSOUSWNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VLOSUSWNS@MAUI.M".ts_eval= %Q|"VDAYUSWNS@MAUI.M".ts / "VISUSWNS@MAUI.M".ts|
  "VSONS@HAW.M".ts_eval= %Q|"VSONS@HAWH.M".ts + "VSONS@HAWK.M".ts|
  "VSODMNS@HAW.M".ts_eval= %Q|"VSODMNS@HAWH.M".ts + "VSODMNS@HAWK.M".ts|
  "VSOUSWNS@HAW.M".ts_eval= %Q|"VSOUSWNS@HAWH.M".ts + "VSOUSWNS@HAWK.M".ts|
  "VSOITNS@HAW.M".ts_eval= %Q|"VSOITNS@HAWH.M".ts.zero_add "VSOITNS@HAWK.M".ts|
  "VSOJPNS@HAW.M".ts_eval= %Q|"VSOJPNS@HAWH.M".ts.zero_add "VSOJPNS@HAWK.M".ts|
  "VSOCANNS@HAW.M".ts_eval= %Q|"VSOCANNS@HAWH.M".ts + "VSOCANNS@HAWK.M".ts|
  "RMRVNS@HON.Q".ts_eval= %Q|"RMRVNS@HON.M".ts.aggregate(:quarter, :average)|
  "OCUP%NS@MAU.Q".ts_eval= %Q|"OCUP%NS@MAU.M".ts.aggregate(:quarter, :average)|
  "RMRVNS@MAU.Q".ts_eval= %Q|"RMRVNS@MAU.M".ts.aggregate(:quarter, :average)|
  "PCHSFUGSU@HON.Q".ts_eval= %Q|'PCHSFUGSU@HON.S'.ts.interpolate :quarter, :linear|
  "PCHSHF@HON.Q".ts_eval= %Q|'PCHSHF@HON.S'.ts.interpolate :quarter, :linear|
  "PCAP@HON.Q".ts_eval= %Q|'PCAP@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRMF@HON.Q".ts_eval= %Q|'PCTRMF@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRGSPR@HON.Q".ts_eval= %Q|'PCTRGSPR@HON.S'.ts.interpolate :quarter, :linear|
  "PCRE@HON.Q".ts_eval= %Q|'PCRE@HON.S'.ts.interpolate :quarter, :linear|
  "PCED@HON.Q".ts_eval= %Q|'PCED@HON.S'.ts.interpolate :quarter, :linear|
  "PCEN@HON.Q".ts_eval= %Q|'PCEN@HON.S'.ts.interpolate :quarter, :linear|
  "INFCORE@HON.Q".ts_eval= %Q|"PC_FDEN@HON.Q".ts.annualized_percentage_change|
  "AAPI@HI.A".ts_append_eval %Q|"AAPI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AA@MAU.A".ts_append_eval %Q|"AA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANVG@HI.A".ts_append_eval %Q|"ANVG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCMNDRPM@HI.A".ts_append_eval %Q|"YCMNDRPM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFB@HI.A".ts_append_eval %Q|"YCMNDRFB@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMI@HI.A".ts_append_eval %Q|"YCMI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPA@HI.A".ts_append_eval %Q|"YCMNNDPA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCWT@HI.A".ts_append_eval %Q|"YCWT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMS@HI.A".ts_append_eval %Q|"YCRTMS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "ANVG@HON.A".ts_append_eval %Q|"ANVG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "ANCF@HON.A".ts_append_eval %Q|"ANCF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCMC@HON.A".ts_append_eval %Q|"AVCMC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCTR@HON.A".ts_append_eval %Q|"AVCTR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVC@HON   .A".ts_append_eval %Q|"AVC@HON   .A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCPI@KAU.A".ts_append_eval %Q|"AVCPI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFR@KAU.A".ts_append_eval %Q|"AVCFR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCCF@KAU.A".ts_append_eval %Q|"AVCCF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCMC@KAU.A".ts_append_eval %Q|"AVCMC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCTR@KAU.A".ts_append_eval %Q|"AVCTR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCSU@MAU.A".ts_append_eval %Q|"AVCSU@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCPI@MAU.A".ts_append_eval %Q|"AVCPI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCVG@MAU.A".ts_append_eval %Q|"AVCVG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVCFR@MAU.A".ts_append_eval %Q|"AVCFR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLHG@HI.A".ts_append_eval %Q|"AVLHG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLEG@HI.A".ts_append_eval %Q|"AVLEG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVA@HI.A".ts_append_eval %Q|"AVA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLA@HI.A".ts_append_eval %Q|"AVLA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVA@HAW.A".ts_append_eval %Q|"AVA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLA@HAW.A".ts_append_eval %Q|"AVLA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AV@HAW.A".ts_append_eval %Q|"AV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AGP@HAW.A".ts_append_eval %Q|"AGP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLCT@HON.A".ts_append_eval %Q|"AVLCT@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLHG@HON.A".ts_append_eval %Q|"AVLHG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLML@HON.A".ts_append_eval %Q|"AVLML@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLEG@HON.A".ts_append_eval %Q|"AVLEG@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVL@HON.A".ts_append_eval %Q|"AVL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLA@HON.A".ts_append_eval %Q|"AVLA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AV@HON.A".ts_append_eval %Q|"AV@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AGP@HON.A".ts_append_eval %Q|"AGP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLCT@KAU.A".ts_append_eval %Q|"AVLCT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLML@KAU.A".ts_append_eval %Q|"AVLML@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVA@KAU.A".ts_append_eval %Q|"AVA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLCT@MAU.A".ts_append_eval %Q|"AVLCT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLHG@MAU.A".ts_append_eval %Q|"AVLHG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLML@MAU.A".ts_append_eval %Q|"AVLML@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLEG@MAU.A".ts_append_eval %Q|"AVLEG@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVL@MAU.A".ts_append_eval %Q|"AVL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AVLA@MAU.A".ts_append_eval %Q|"AVLA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AV@MAU.A".ts_append_eval %Q|"AV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "AGP@MAU.A".ts_append_eval %Q|"AGP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/agriculture/AgricultureForNewDB.xls"|
  "YCIFDP@HI.A".ts_append_eval %Q|"YCIFDP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFOT@HI.A".ts_append_eval %Q|"YCAGFFOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMIMI@HI.A".ts_append_eval %Q|"YCMIMI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMISP@HI.A".ts_append_eval %Q|"YCMISP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTBL@HI.A".ts_append_eval %Q|"YCCTBL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTSP@HI.A".ts_append_eval %Q|"YCCTSP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFI@HI.A".ts_append_eval %Q|"YCFI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIMO@HI.A".ts_append_eval %Q|"YCFIMO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFICR@HI.A".ts_append_eval %Q|"YCFICR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFISE@HI.A".ts_append_eval %Q|"YCFISE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIIN@HI.A".ts_append_eval %Q|"YCFIIN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YWAGE@HON.A".ts_append_eval %Q|"YWAGE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YWAGE@HON.A".ts_append_eval %Q|"YWAGE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLAB@HON.A".ts_append_eval %Q|"YOTLAB@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YOTLAB@HON.A".ts_append_eval %Q|"YOTLAB@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCMI@HON.A".ts_append_eval %Q|"YCMI@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMC@HON.A".ts_append_eval %Q|"YCMNDRMC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDREL@HON.A".ts_append_eval %Q|"YCMNDREL@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFR@HON.A".ts_append_eval %Q|"YCMNDRFR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNND@HON.A".ts_append_eval %Q|"YCMNND@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXP@HON.A".ts_append_eval %Q|"YCMNNDXP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPA@HON.A".ts_append_eval %Q|"YCMNNDPA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFR@HON.A".ts_append_eval %Q|"YCRTFR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGA@HON.A".ts_append_eval %Q|"YCRTGA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGM@HON.A".ts_append_eval %Q|"YCRTGM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSP@HON.A".ts_append_eval %Q|"YCTWSP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWWH@HON.A".ts_append_eval %Q|"YCTWWH@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFTC@HON.A".ts_append_eval %Q|"YCIFTC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAVR@KAU.A".ts_append_eval %Q|"YCAVR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDFD@KAU.A".ts_append_eval %Q|"YCMNNDFD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXM@KAU.A".ts_append_eval %Q|"YCMNNDXM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXP@KAU.A".ts_append_eval %Q|"YCMNNDXP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDAP@KAU.A".ts_append_eval %Q|"YCMNNDAP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDLT@KAU.A".ts_append_eval %Q|"YCMNNDLT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPA@KAU.A".ts_append_eval %Q|"YCMNNDPA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPR@KAU.A".ts_append_eval %Q|"YCMNNDPR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPT@KAU.A".ts_append_eval %Q|"YCMNNDPT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDCH@KAU.A".ts_append_eval %Q|"YCMNNDCH@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPL@KAU.A".ts_append_eval %Q|"YCMNNDPL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTFR@KAU.A".ts_append_eval %Q|"YCRTFR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTEL@KAU.A".ts_append_eval %Q|"YCRTEL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTBL@KAU.A".ts_append_eval %Q|"YCRTBL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTHC@KAU.A".ts_append_eval %Q|"YCRTHC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGA@KAU.A".ts_append_eval %Q|"YCRTGA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTCL@KAU.A".ts_append_eval %Q|"YCRTCL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGM@KAU.A".ts_append_eval %Q|"YCRTGM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMS@KAU.A".ts_append_eval %Q|"YCRTMS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTW@KAU.A".ts_append_eval %Q|"YCTW@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTR@KAU.A".ts_append_eval %Q|"YCTWTR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTG@KAU.A".ts_append_eval %Q|"YCTWTG@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWPL@KAU.A".ts_append_eval %Q|"YCTWPL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSP@KAU.A".ts_append_eval %Q|"YCTWSP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWWH@KAU.A".ts_append_eval %Q|"YCTWWH@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIF@KAU.A".ts_append_eval %Q|"YCIF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFMP@KAU.A".ts_append_eval %Q|"YCIFMP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFIT@KAU.A".ts_append_eval %Q|"YCIFIT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFTC@KAU.A".ts_append_eval %Q|"YCIFTC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFDP@KAU.A".ts_append_eval %Q|"YCIFDP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFOT@KAU.A".ts_append_eval %Q|"YCIFOT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFI@KAU.A".ts_append_eval %Q|"YCFI@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIMO@KAU.A".ts_append_eval %Q|"YCFIMO@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIIN@KAU.A".ts_append_eval %Q|"YCFIIN@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIOT@KAU.A".ts_append_eval %Q|"YCFIOT@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRE@KAU.A".ts_append_eval %Q|"YCRE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERE@KAU.A".ts_append_eval %Q|"YCRERE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRELE@KAU.A".ts_append_eval %Q|"YCRELE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCPS@KAU.A".ts_append_eval %Q|"YCPS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMA@KAU.A".ts_append_eval %Q|"YCMA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAD@KAU.A".ts_append_eval %Q|"YCAD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADAD@KAU.A".ts_append_eval %Q|"YCADAD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADWM@KAU.A".ts_append_eval %Q|"YCADWM@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCED@KAU.A".ts_append_eval %Q|"YCED@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHC@KAU.A".ts_append_eval %Q|"YCHC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCHO@KAU.A".ts_append_eval %Q|"YCHCHO@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCNR@KAU.A".ts_append_eval %Q|"YCHCNR@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCSO@KAU.A".ts_append_eval %Q|"YCHCSO@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAE@KAU.A".ts_append_eval %Q|"YCAE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEPF@KAU.A".ts_append_eval %Q|"YCAEPF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEMU@KAU.A".ts_append_eval %Q|"YCAEMU@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFAC@KAU.A".ts_append_eval %Q|"YCAFAC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFFD@KAU.A".ts_append_eval %Q|"YCAFFD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOS@KAU.A".ts_append_eval %Q|"YCOS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSRP@KAU.A".ts_append_eval %Q|"YCOSRP@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSMA@KAU.A".ts_append_eval %Q|"YCOSMA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSHH@KAU.A".ts_append_eval %Q|"YCOSHH@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGV@KAU.A".ts_append_eval %Q|"YCGV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVFD@KAU.A".ts_append_eval %Q|"YCGVFD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_GVSL@KAU.A".ts_append_eval %Q|"YC_GVSL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVST@KAU.A".ts_append_eval %Q|"YCGVST@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVLC@KAU.A".ts_append_eval %Q|"YCGVLC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC@MAU.A".ts_append_eval %Q|"YC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YOTLABPEN@MAU.A".ts_append_eval %Q|"YOTLABPEN@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YCAVR@MAU.A".ts_append_eval %Q|"YCAVR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFA@MAU.A".ts_append_eval %Q|"YCAGFA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAGFFFS@MAU.A".ts_append_eval %Q|"YCAGFFFS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMI@MAU.A".ts_append_eval %Q|"YCMI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCUT@MAU.A".ts_append_eval %Q|"YCUT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCT@MAU.A".ts_append_eval %Q|"YCCT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTBL@MAU.A".ts_append_eval %Q|"YCCTBL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTHV@MAU.A".ts_append_eval %Q|"YCCTHV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCCTSP@MAU.A".ts_append_eval %Q|"YCCTSP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMN@MAU.A".ts_append_eval %Q|"YCMN@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDR@MAU.A".ts_append_eval %Q|"YCMNDR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRWD@MAU.A".ts_append_eval %Q|"YCMNDRWD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRPM@MAU.A".ts_append_eval %Q|"YCMNDRPM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFB@MAU.A".ts_append_eval %Q|"YCMNDRFB@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMC@MAU.A".ts_append_eval %Q|"YCMNDRMC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRCM@MAU.A".ts_append_eval %Q|"YCMNDRCM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDREL@MAU.A".ts_append_eval %Q|"YCMNDREL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMV@MAU.A".ts_append_eval %Q|"YCMNDRMV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRTR@MAU.A".ts_append_eval %Q|"YCMNDRTR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRFR@MAU.A".ts_append_eval %Q|"YCMNDRFR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNDRMS@MAU.A".ts_append_eval %Q|"YCMNDRMS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNND@MAU.A".ts_append_eval %Q|"YCMNND@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDFD@MAU.A".ts_append_eval %Q|"YCMNNDFD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDXP@MAU.A".ts_append_eval %Q|"YCMNNDXP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDAP@MAU.A".ts_append_eval %Q|"YCMNNDAP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPA@MAU.A".ts_append_eval %Q|"YCMNNDPA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPR@MAU.A".ts_append_eval %Q|"YCMNNDPR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDPT@MAU.A".ts_append_eval %Q|"YCMNNDPT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMNNDCH@MAU.A".ts_append_eval %Q|"YCMNNDCH@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRT@MAU.A".ts_append_eval %Q|"YCRT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTMV@MAU.A".ts_append_eval %Q|"YCRTMV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTEL@MAU.A".ts_append_eval %Q|"YCRTEL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTHC@MAU.A".ts_append_eval %Q|"YCRTHC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGA@MAU.A".ts_append_eval %Q|"YCRTGA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTCL@MAU.A".ts_append_eval %Q|"YCRTCL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTSP@MAU.A".ts_append_eval %Q|"YCRTSP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTGM@MAU.A".ts_append_eval %Q|"YCRTGM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRTOT@MAU.A".ts_append_eval %Q|"YCRTOT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTW@MAU.A".ts_append_eval %Q|"YCTW@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWTR@MAU.A".ts_append_eval %Q|"YCTWTR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWPL@MAU.A".ts_append_eval %Q|"YCTWPL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWSP@MAU.A".ts_append_eval %Q|"YCTWSP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWCU@MAU.A".ts_append_eval %Q|"YCTWCU@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCTWWH@MAU.A".ts_append_eval %Q|"YCTWWH@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIF@MAU.A".ts_append_eval %Q|"YCIF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFMP@MAU.A".ts_append_eval %Q|"YCIFMP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFBC@MAU.A".ts_append_eval %Q|"YCIFBC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFIT@MAU.A".ts_append_eval %Q|"YCIFIT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFTC@MAU.A".ts_append_eval %Q|"YCIFTC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFDP@MAU.A".ts_append_eval %Q|"YCIFDP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCIFOT@MAU.A".ts_append_eval %Q|"YCIFOT@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFI@MAU.A".ts_append_eval %Q|"YCFI@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFICR@MAU.A".ts_append_eval %Q|"YCFICR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFISE@MAU.A".ts_append_eval %Q|"YCFISE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCFIIN@MAU.A".ts_append_eval %Q|"YCFIIN@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRE@MAU.A".ts_append_eval %Q|"YCRE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRERE@MAU.A".ts_append_eval %Q|"YCRERE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCRELE@MAU.A".ts_append_eval %Q|"YCRELE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCPS@MAU.A".ts_append_eval %Q|"YCPS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCMA@MAU.A".ts_append_eval %Q|"YCMA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADAD@MAU.A".ts_append_eval %Q|"YCADAD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCADWM@MAU.A".ts_append_eval %Q|"YCADWM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCED@MAU.A".ts_append_eval %Q|"YCED@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCAM@MAU.A".ts_append_eval %Q|"YCHCAM@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCHO@MAU.A".ts_append_eval %Q|"YCHCHO@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCNR@MAU.A".ts_append_eval %Q|"YCHCNR@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCHCSO@MAU.A".ts_append_eval %Q|"YCHCSO@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAE@MAU.A".ts_append_eval %Q|"YCAE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEPF@MAU.A".ts_append_eval %Q|"YCAEPF@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAEMU@MAU.A".ts_append_eval %Q|"YCAEMU@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAERE@MAU.A".ts_append_eval %Q|"YCAERE@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFAC@MAU.A".ts_append_eval %Q|"YCAFAC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCAFFD@MAU.A".ts_append_eval %Q|"YCAFFD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOS@MAU.A".ts_append_eval %Q|"YCOS@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSRP@MAU.A".ts_append_eval %Q|"YCOSRP@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSPL@MAU.A".ts_append_eval %Q|"YCOSPL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCOSMA@MAU.A".ts_append_eval %Q|"YCOSMA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGV@MAU.A".ts_append_eval %Q|"YCGV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVFD@MAU.A".ts_append_eval %Q|"YCGVFD@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YC_GVSL@MAU.A".ts_append_eval %Q|"YC_GVSL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YCGVLC@MAU.A".ts_append_eval %Q|"YCGVLC@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/com_upd_NEW.xls"|
  "YS_PR@HI.A".ts_append_eval %Q|"YS_PR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAGFA@HI.A".ts_append_eval %Q|"YSAGFA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMIOG@HI.A".ts_append_eval %Q|"YSMIOG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMIMI@HI.A".ts_append_eval %Q|"YSMIMI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSCT@HI.A".ts_append_eval %Q|"YSCT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMN@HI.A".ts_append_eval %Q|"YSMN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDR@HI.A".ts_append_eval %Q|"YSMNDR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRWD@HI.A".ts_append_eval %Q|"YSMNDRWD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRPM@HI.A".ts_append_eval %Q|"YSMNDRPM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRMC@HI.A".ts_append_eval %Q|"YSMNDRMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRCM@HI.A".ts_append_eval %Q|"YSMNDRCM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YLRTHC@HAW.A".ts_append_eval %Q|"YLRTHC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSMNDREL@HI.A".ts_append_eval %Q|"YSMNDREL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRMV@HI.A".ts_append_eval %Q|"YSMNDRMV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRTR@HI.A".ts_append_eval %Q|"YSMNDRTR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRFR@HI.A".ts_append_eval %Q|"YSMNDRFR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNDRMS@HI.A".ts_append_eval %Q|"YSMNDRMS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSIFDP@HI.A".ts_append_eval %Q|"YSIFDP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSFIMC@HI.A".ts_append_eval %Q|"YSFIMC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSFISE@HI.A".ts_append_eval %Q|"YSFISE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSFIOT@HI.A".ts_append_eval %Q|"YSFIOT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSRERL@HI.A".ts_append_eval %Q|"YSRERL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSPSCO@HI.A".ts_append_eval %Q|"YSPSCO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSPSOS@HI.A".ts_append_eval %Q|"YSPSOS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSADWM@HI.A".ts_append_eval %Q|"YSADWM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSED@HI.A".ts_append_eval %Q|"YSED@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSHC@HI.A".ts_append_eval %Q|"YSHC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSHCAM@HI.A".ts_append_eval %Q|"YSHCAM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSHCHO@HI.A".ts_append_eval %Q|"YSHCHO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSHCSO@HI.A".ts_append_eval %Q|"YSHCSO@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAEPF@HI.A".ts_append_eval %Q|"YSAEPF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAERE@HI.A".ts_append_eval %Q|"YSAERE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAF@HI.A".ts_append_eval %Q|"YSAF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAFAC@HI.A".ts_append_eval %Q|"YSAFAC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSGV@HI.A".ts_append_eval %Q|"YSGV@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSGVFD@HI.A".ts_append_eval %Q|"YSGVFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YS_GVSL@HI.A".ts_append_eval %Q|"YS_GVSL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YS@HI.A".ts_append_eval %Q|"YS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAG@HI.A".ts_append_eval %Q|"YSAG@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAGFF@HI.A".ts_append_eval %Q|"YSAGFF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMI@HI.A".ts_append_eval %Q|"YSMI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDAP@HI.A".ts_append_eval %Q|"YSMNNDAP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDPA@HI.A".ts_append_eval %Q|"YSMNNDPA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDPT@HI.A".ts_append_eval %Q|"YSMNNDPT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDCH@HI.A".ts_append_eval %Q|"YSMNNDCH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMNNDPL@HI.A".ts_append_eval %Q|"YSMNNDPL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSWT@HI.A".ts_append_eval %Q|"YSWT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSRT@HI.A".ts_append_eval %Q|"YSRT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTW@HI.A".ts_append_eval %Q|"YSTW@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWTA@HI.A".ts_append_eval %Q|"YSTWTA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWTW@HI.A".ts_append_eval %Q|"YSTWTW@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWPL@HI.A".ts_append_eval %Q|"YSTWPL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSTWWH@HI.A".ts_append_eval %Q|"YSTWWH@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSIF@HI.A".ts_append_eval %Q|"YSIF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSIFMP@HI.A".ts_append_eval %Q|"YSIFMP@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSIFBC@HI.A".ts_append_eval %Q|"YSIFBC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSFIIN@HI.A".ts_append_eval %Q|"YSFIIN@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSRE@HI.A".ts_append_eval %Q|"YSRE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSRERE@HI.A".ts_append_eval %Q|"YSRERE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSPSLS@HI.A".ts_append_eval %Q|"YSPSLS@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSMA@HI.A".ts_append_eval %Q|"YSMA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSAD@HI.A".ts_append_eval %Q|"YSAD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YSADAD@HI.A".ts_append_eval %Q|"YSADAD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/gsp_upd_NEW.xls"|
  "YLAGFA@HI.Q".ts_append_eval %Q|"YLAGFA@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YLAGFA@HI.Q".ts_append_eval %Q|"YLAGFA@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YL_NF@HI.Q".ts_append_eval %Q|"YL_NF@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YL_NF@HI.Q".ts_append_eval %Q|"YL_NF@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLIF@HON.A".ts_append_eval %Q|"YLIF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLIF@HON.A".ts_append_eval %Q|"YLIF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "Y@HAW.A".ts_append_eval %Q|"Y@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "Y@HAW.A".ts_append_eval %Q|"Y@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA@HAW.A".ts_append_eval %Q|"NRBEA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "NRBEA@HAW.A".ts_append_eval %Q|"NRBEA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YTRNSF@HAW.A".ts_append_eval %Q|"YTRNSF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YTRNSF@HAW.A".ts_append_eval %Q|"YTRNSF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YWAGE@HAW.A".ts_append_eval %Q|"YWAGE@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YWAGE@HAW.A".ts_append_eval %Q|"YWAGE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLAB@HAW.A".ts_append_eval %Q|"YOTLAB@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YOTLAB@HAW.A".ts_append_eval %Q|"YOTLAB@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFA@HAW.A".ts_append_eval %Q|"YLAGFA@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YLAGFA@HAW.A".ts_append_eval %Q|"YLAGFA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTGA@HAW.A".ts_append_eval %Q|"YLRTGA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTCL@HAW.A".ts_append_eval %Q|"YLRTCL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRTSP@HAW.A".ts_append_eval %Q|"YLRTSP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIF@HAW.A".ts_append_eval %Q|"YLIF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMA@HAW.A".ts_append_eval %Q|"YLMA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSMA@HAW.A".ts_append_eval %Q|"YLOSMA@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSHH@HAW.A".ts_append_eval %Q|"YLOSHH@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGV@HAW.A".ts_append_eval %Q|"YLGV@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YLGV@HAW.A".ts_append_eval %Q|"YLGV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVFD@HAW.A".ts_append_eval %Q|"YLGVFD@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YLGVFD@HAW.A".ts_append_eval %Q|"YLGVFD@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_GVSL@HAW.A".ts_append_eval %Q|"YL_GVSL@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YL_GVSL@HAW.A".ts_append_eval %Q|"YL_GVSL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVLC@HAW.A".ts_append_eval %Q|"YLGVLC@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YLGVLC@HAW.A".ts_append_eval %Q|"YLGVLC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA@MAU.A".ts_append_eval %Q|"NRBEA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
  "NRBEA@MAU.A".ts_append_eval %Q|"NRBEA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLABSS@MAU.A".ts_append_eval %Q|"YOTLABSS@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFA@MAU.A".ts_append_eval %Q|"YLAGFA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
  "YLAGFA@MAU.A".ts_append_eval %Q|"YLAGFA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDXP@MAU.A".ts_append_eval %Q|"YLMNNDXP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDAP@MAU.A".ts_append_eval %Q|"YLMNNDAP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDLT@MAU.A".ts_append_eval %Q|"YLMNNDLT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPA@MAU.A".ts_append_eval %Q|"YLMNNDPA@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPR@MAU.A".ts_append_eval %Q|"YLMNNDPR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDPT@MAU.A".ts_append_eval %Q|"YLMNNDPT@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNNDCH@MAU.A".ts_append_eval %Q|"YLMNNDCH@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADAD@MAU.A".ts_append_eval %Q|"YLADAD@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADWM@MAU.A".ts_append_eval %Q|"YLADWM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCAM@MAU.A".ts_append_eval %Q|"YLHCAM@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCHO@MAU.A".ts_append_eval %Q|"YLHCHO@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCNR@MAU.A".ts_append_eval %Q|"YLHCNR@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHCSO@MAU.A".ts_append_eval %Q|"YLHCSO@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEPF@MAU.A".ts_append_eval %Q|"YLAEPF@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEMU@MAU.A".ts_append_eval %Q|"YLAEMU@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAERE@MAU.A".ts_append_eval %Q|"YLAERE@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGV@MAU.A".ts_append_eval %Q|"YLGV@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
  "YLGV@MAU.A".ts_append_eval %Q|"YLGV@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_GVSL@MAU.A".ts_append_eval %Q|"YL_GVSL@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "MAU"|
  "YL_GVSL@MAU.A".ts_append_eval %Q|"YL_GVSL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "Y@KAU.A".ts_append_eval %Q|"Y@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "Y@KAU.A".ts_append_eval %Q|"Y@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA@KAU.A".ts_append_eval %Q|"NRBEA@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "NRBEA@KAU.A".ts_append_eval %Q|"NRBEA@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSEC@KAU.A".ts_append_eval %Q|"YSOCSEC@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "YSOCSEC@KAU.A".ts_append_eval %Q|"YSOCSEC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YDIV@KAU.A".ts_append_eval %Q|"YDIV@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "YDIV@KAU.A".ts_append_eval %Q|"YDIV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YWAGE@KAU.A".ts_append_eval %Q|"YWAGE@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "YWAGE@KAU.A".ts_append_eval %Q|"YWAGE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YOTLAB@KAU.A".ts_append_eval %Q|"YOTLAB@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "YOTLAB@KAU.A".ts_append_eval %Q|"YOTLAB@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRCM@KAU.A".ts_append_eval %Q|"YLMNDRCM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDREL@KAU.A".ts_append_eval %Q|"YLMNDREL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMV@KAU.A".ts_append_eval %Q|"YLMNDRMV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRTR@KAU.A".ts_append_eval %Q|"YLMNDRTR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFR@KAU.A".ts_append_eval %Q|"YLMNDRFR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIMO@KAU.A".ts_append_eval %Q|"YLFIMO@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFICR@KAU.A".ts_append_eval %Q|"YLFICR@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFISE@KAU.A".ts_append_eval %Q|"YLFISE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIIN@KAU.A".ts_append_eval %Q|"YLFIIN@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIOT@KAU.A".ts_append_eval %Q|"YLFIOT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRE@KAU.A".ts_append_eval %Q|"YLRE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERE@KAU.A".ts_append_eval %Q|"YLRERE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERL@KAU.A".ts_append_eval %Q|"YLRERL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRELE@KAU.A".ts_append_eval %Q|"YLRELE@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLADAD@KAU.A".ts_append_eval %Q|"YLADAD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVST@KAU.A".ts_append_eval %Q|"YLGVST@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
  "YLGVST@KAU.A".ts_append_eval %Q|"YLGVST@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YP&@HI.Q".ts_append_eval %Q|"YP&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@HI.Q".ts_append_eval %Q|"YLP&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@HI.Q".ts_append_eval %Q|"YRESADJ&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YNETR&@HI.Q".ts_append_eval %Q|"YNETR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YV&@HI.Q".ts_append_eval %Q|"YV&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTRNSFUI&@HI.Q".ts_append_eval %Q|"YTRNSFUI&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTRNSFOT&@HI.Q".ts_append_eval %Q|"YTRNSFOT&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YWAGE&@HI.Q".ts_append_eval %Q|"YWAGE&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YOTLAB&@HI.Q".ts_append_eval %Q|"YOTLAB&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROP&@HI.Q".ts_append_eval %Q|"YPROP&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPFA&@HI.Q".ts_append_eval %Q|"YPROPFA&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@HI.Q".ts_append_eval %Q|"YLPAGFA&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@HI.Q".ts_append_eval %Q|"YL_NF&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_PR&@HI.Q".ts_append_eval %Q|"YL_PR&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPG&@HI.Q".ts_append_eval %Q|"YLPG&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@HI.Q".ts_append_eval %Q|"YLPGFC&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFM&@HI.Q".ts_append_eval %Q|"YLPGFM&@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMD&@HI.A".ts_append_eval %Q|"YLPMD&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDWD&@HI.A".ts_append_eval %Q|"YLPMDWD&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFR&@HI.A".ts_append_eval %Q|"YLPMDFR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDST&@HI.A".ts_append_eval %Q|"YLPMDST&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDPM&@HI.A".ts_append_eval %Q|"YLPMDPM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFB&@HI.A".ts_append_eval %Q|"YLPMDFB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMC&@HI.A".ts_append_eval %Q|"YLPMDMC&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDTR&@HI.A".ts_append_eval %Q|"YLPMDTR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMS&@HI.A".ts_append_eval %Q|"YLPMDMS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMN&@HI.A".ts_append_eval %Q|"YLPMN&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNFD&@HI.A".ts_append_eval %Q|"YLPMNFD&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNXM&@HI.A".ts_append_eval %Q|"YLPMNXM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNAP&@HI.A".ts_append_eval %Q|"YLPMNAP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPA&@HI.A".ts_append_eval %Q|"YLPMNPA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNCH&@HI.A".ts_append_eval %Q|"YLPMNCH&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNLT&@HI.A".ts_append_eval %Q|"YLPMNLT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRET&@HI.A".ts_append_eval %Q|"YLPTRET&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTROT&@HI.A".ts_append_eval %Q|"YLPTROT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIR&@HI.A".ts_append_eval %Q|"YLPFIR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRDP&@HI.A".ts_append_eval %Q|"YLPFIRDP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIROF&@HI.A".ts_append_eval %Q|"YLPFIROF&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRSE&@HI.A".ts_append_eval %Q|"YLPFIRSE&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIC&@HI.A".ts_append_eval %Q|"YLPFIRIC&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIA&@HI.A".ts_append_eval %Q|"YLPFIRIA&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRRE&@HI.A".ts_append_eval %Q|"YLPFIRRE&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRCR&@HI.A".ts_append_eval %Q|"YLPFIRCR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRHD&@HI.A".ts_append_eval %Q|"YLPFIRHD&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSV&@HI.A".ts_append_eval %Q|"YLPSV&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHL&@HI.A".ts_append_eval %Q|"YLPSVHL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPS&@HI.A".ts_append_eval %Q|"YLPSVPS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPH&@HI.A".ts_append_eval %Q|"YLPSVPH&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAU&@HI.A".ts_append_eval %Q|"YLPSVAU&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMR&@HI.A".ts_append_eval %Q|"YLPSVMR&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAM&@HI.A".ts_append_eval %Q|"YLPSVAM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMO&@HI.A".ts_append_eval %Q|"YLPSVMO&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHE&@HI.A".ts_append_eval %Q|"YLPSVHE&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVLG&@HI.A".ts_append_eval %Q|"YLPSVLG&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVED&@HI.A".ts_append_eval %Q|"YLPSVED&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMU&@HI.A".ts_append_eval %Q|"YLPSVMU&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMB&@HI.A".ts_append_eval %Q|"YLPSVMB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVEN&@HI.A".ts_append_eval %Q|"YLPSVEN&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMS&@HI.A".ts_append_eval %Q|"YLPSVMS&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPG&@HI.A".ts_append_eval %Q|"YLPG&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@HI.A".ts_append_eval %Q|"YLPGFC&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFM&@HI.A".ts_append_eval %Q|"YLPGFM&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGSL&@HI.A".ts_append_eval %Q|"YLPGSL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGST&@HI.A".ts_append_eval %Q|"YLPGST&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGL&@HI.A".ts_append_eval %Q|"YLPGL&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YP&@HON.A".ts_append_eval %Q|"YP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NRBEA&@HON.A".ts_append_eval %Q|"NRBEA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMI&@HON.A".ts_append_eval %Q|"YLPMI&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPC&@HON.A".ts_append_eval %Q|"YLPC&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCGB&@HON.A".ts_append_eval %Q|"YLPCGB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCHV&@HON.A".ts_append_eval %Q|"YLPCHV&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCST&@HON.A".ts_append_eval %Q|"YLPCST&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMD&@HON.A".ts_append_eval %Q|"YLPMD&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDWD&@HON.A".ts_append_eval %Q|"YLPMDWD&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFR&@HON.A".ts_append_eval %Q|"YLPMDFR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDST&@HON.A".ts_append_eval %Q|"YLPMDST&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDPM&@HON.A".ts_append_eval %Q|"YLPMDPM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDFB&@HON.A".ts_append_eval %Q|"YLPMDFB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMC&@HON.A".ts_append_eval %Q|"YLPMDMC&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMV&@HON.A".ts_append_eval %Q|"YLPMDMV&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDTR&@HON.A".ts_append_eval %Q|"YLPMDTR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDIS&@HON.A".ts_append_eval %Q|"YLPMDIS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMS&@HON.A".ts_append_eval %Q|"YLPMDMS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDOR&@HON.A".ts_append_eval %Q|"YLPMDOR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNFD&@HON.A".ts_append_eval %Q|"YLPMNFD&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNTB&@HON.A".ts_append_eval %Q|"YLPMNTB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNXM&@HON.A".ts_append_eval %Q|"YLPMNXM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNAP&@HON.A".ts_append_eval %Q|"YLPMNAP&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPA&@HON.A".ts_append_eval %Q|"YLPMNPA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPR&@HON.A".ts_append_eval %Q|"YLPMNPR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNCH&@HON.A".ts_append_eval %Q|"YLPMNCH&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPT&@HON.A".ts_append_eval %Q|"YLPMNPT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNRB&@HON.A".ts_append_eval %Q|"YLPMNRB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNLT&@HON.A".ts_append_eval %Q|"YLPMNLT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPR&@HON.A".ts_append_eval %Q|"YLPR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTR&@HON.A".ts_append_eval %Q|"YLPRTR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTT&@HON.A".ts_append_eval %Q|"YLPRTT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTW&@HON.A".ts_append_eval %Q|"YLPRTW&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPROT&@HON.A".ts_append_eval %Q|"YLPROT&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTW&@HON.A".ts_append_eval %Q|"YLPTW&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRHD&@HON.A".ts_append_eval %Q|"YLPFIRHD&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPS&@HON.A".ts_append_eval %Q|"YLPSVPS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPH&@HON.A".ts_append_eval %Q|"YLPSVPH&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVBS&@HON.A".ts_append_eval %Q|"YLPSVBS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAU&@HON.A".ts_append_eval %Q|"YLPSVAU&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMR&@HON.A".ts_append_eval %Q|"YLPSVMR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVAM&@HON.A".ts_append_eval %Q|"YLPSVAM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMO&@HON.A".ts_append_eval %Q|"YLPSVMO&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHE&@HON.A".ts_append_eval %Q|"YLPSVHE&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVLG&@HON.A".ts_append_eval %Q|"YLPSVLG&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVED&@HON.A".ts_append_eval %Q|"YLPSVED&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVSO&@HON.A".ts_append_eval %Q|"YLPSVSO&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMU&@HON.A".ts_append_eval %Q|"YLPSVMU&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMB&@HON.A".ts_append_eval %Q|"YLPSVMB&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMS&@HON.A".ts_append_eval %Q|"YLPSVMS&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPG&@HON.A".ts_append_eval %Q|"YLPG&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@HON.A".ts_append_eval %Q|"YLPGFC&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFM&@HON.A".ts_append_eval %Q|"YLPGFM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGSL&@HON.A".ts_append_eval %Q|"YLPGSL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGST&@HON.A".ts_append_eval %Q|"YLPGST&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGL&@HON.A".ts_append_eval %Q|"YLPGL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YP&@HAW.A".ts_append_eval %Q|"YP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NRBEA&@HAW.A".ts_append_eval %Q|"NRBEA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPCBEA&@HAW.A".ts_append_eval %Q|"YPCBEA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@HAW.A".ts_append_eval %Q|"YLP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@HAW.A".ts_append_eval %Q|"YTWPER&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@HAW.A".ts_append_eval %Q|"YRESADJ&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YNETR&@HAW.A".ts_append_eval %Q|"YNETR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@HAW.A".ts_append_eval %Q|"YDIR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YV&@HAW.A".ts_append_eval %Q|"YV&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YWAGE&@HAW.A".ts_append_eval %Q|"YWAGE&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YOTLAB&@HAW.A".ts_append_eval %Q|"YOTLAB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROP&@HAW.A".ts_append_eval %Q|"YPROP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFF&@HAW.A".ts_append_eval %Q|"YLPAGFF&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPC&@HAW.A".ts_append_eval %Q|"YLPC&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDEL&@HAW.A".ts_append_eval %Q|"YLPMDEL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMV&@HAW.A".ts_append_eval %Q|"YLPMDMV&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDTR&@HAW.A".ts_append_eval %Q|"YLPMDTR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDIS&@HAW.A".ts_append_eval %Q|"YLPMDIS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMDMS&@HAW.A".ts_append_eval %Q|"YLPMDMS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNFD&@HAW.A".ts_append_eval %Q|"YLPMNFD&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNTB&@HAW.A".ts_append_eval %Q|"YLPMNTB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNXM&@HAW.A".ts_append_eval %Q|"YLPMNXM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNAP&@HAW.A".ts_append_eval %Q|"YLPMNAP&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPA&@HAW.A".ts_append_eval %Q|"YLPMNPA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPR&@HAW.A".ts_append_eval %Q|"YLPMNPR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPT&@HAW.A".ts_append_eval %Q|"YLPMNPT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNRB&@HAW.A".ts_append_eval %Q|"YLPMNRB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNLT&@HAW.A".ts_append_eval %Q|"YLPMNLT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTR&@HAW.A".ts_append_eval %Q|"YLPRTR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTT&@HAW.A".ts_append_eval %Q|"YLPRTT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPROT&@HAW.A".ts_append_eval %Q|"YLPROT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRLT&@HAW.A".ts_append_eval %Q|"YLPRLT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTA&@HAW.A".ts_append_eval %Q|"YLPRTA&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRPL&@HAW.A".ts_append_eval %Q|"YLPRPL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRSV&@HAW.A".ts_append_eval %Q|"YLPRSV&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRCM&@HAW.A".ts_append_eval %Q|"YLPRCM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRUT&@HAW.A".ts_append_eval %Q|"YLPRUT&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRBL&@HAW.A".ts_append_eval %Q|"YLPTRBL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRGM&@HAW.A".ts_append_eval %Q|"YLPTRGM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHE&@HAW.A".ts_append_eval %Q|"YLPSVHE&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVLG&@HAW.A".ts_append_eval %Q|"YLPSVLG&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVED&@HAW.A".ts_append_eval %Q|"YLPSVED&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVSO&@HAW.A".ts_append_eval %Q|"YLPSVSO&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMU&@HAW.A".ts_append_eval %Q|"YLPSVMU&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVMB&@HAW.A".ts_append_eval %Q|"YLPSVMB&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVEN&@HAW.A".ts_append_eval %Q|"YLPSVEN&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPG&@HAW.A".ts_append_eval %Q|"YLPG&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@HAW.A".ts_append_eval %Q|"YLPGFC&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFM&@HAW.A".ts_append_eval %Q|"YLPGFM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGSL&@HAW.A".ts_append_eval %Q|"YLPGSL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGST&@HAW.A".ts_append_eval %Q|"YLPGST&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGL&@HAW.A".ts_append_eval %Q|"YLPGL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YP&@MAU.A".ts_append_eval %Q|"YP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NRBEA&@MAU.A".ts_append_eval %Q|"NRBEA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPCBEA&@MAU.A".ts_append_eval %Q|"YPCBEA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@MAU.A".ts_append_eval %Q|"YLP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@MAU.A".ts_append_eval %Q|"YTWPER&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@MAU.A".ts_append_eval %Q|"YRESADJ&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YNETR&@MAU.A".ts_append_eval %Q|"YNETR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@MAU.A".ts_append_eval %Q|"YDIR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YV&@MAU.A".ts_append_eval %Q|"YV&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YWAGE&@MAU.A".ts_append_eval %Q|"YWAGE&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YOTLAB&@MAU.A".ts_append_eval %Q|"YOTLAB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROP&@MAU.A".ts_append_eval %Q|"YPROP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPFA&@MAU.A".ts_append_eval %Q|"YPROPFA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPNF&@MAU.A".ts_append_eval %Q|"YPROPNF&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@MAU.A".ts_append_eval %Q|"YLPAGFA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@MAU.A".ts_append_eval %Q|"YL_NF&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_PR&@MAU.A".ts_append_eval %Q|"YL_PR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFF&@MAU.A".ts_append_eval %Q|"YLPAGFFF&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFO&@MAU.A".ts_append_eval %Q|"YLPAGFFFFO&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFS&@MAU.A".ts_append_eval %Q|"YLPAGFFFFS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPC&@MAU.A".ts_append_eval %Q|"YLPC&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMD&@MAU.A".ts_append_eval %Q|"YLPMD&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNFD&@MAU.A".ts_append_eval %Q|"YLPMNFD&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNTB&@MAU.A".ts_append_eval %Q|"YLPMNTB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNXM&@MAU.A".ts_append_eval %Q|"YLPMNXM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPA&@MAU.A".ts_append_eval %Q|"YLPMNPA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPR&@MAU.A".ts_append_eval %Q|"YLPMNPR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNCH&@MAU.A".ts_append_eval %Q|"YLPMNCH&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNPT&@MAU.A".ts_append_eval %Q|"YLPMNPT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNRB&@MAU.A".ts_append_eval %Q|"YLPMNRB&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNLT&@MAU.A".ts_append_eval %Q|"YLPMNLT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPR&@MAU.A".ts_append_eval %Q|"YLPR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTR&@MAU.A".ts_append_eval %Q|"YLPRTR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTT&@MAU.A".ts_append_eval %Q|"YLPRTT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTW&@MAU.A".ts_append_eval %Q|"YLPRTW&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPROT&@MAU.A".ts_append_eval %Q|"YLPROT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRLT&@MAU.A".ts_append_eval %Q|"YLPRLT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTA&@MAU.A".ts_append_eval %Q|"YLPRTA&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRPL&@MAU.A".ts_append_eval %Q|"YLPRPL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRSV&@MAU.A".ts_append_eval %Q|"YLPRSV&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRCM&@MAU.A".ts_append_eval %Q|"YLPRCM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRUT&@MAU.A".ts_append_eval %Q|"YLPRUT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTW&@MAU.A".ts_append_eval %Q|"YLPTW&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRBL&@MAU.A".ts_append_eval %Q|"YLPTRBL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRGM&@MAU.A".ts_append_eval %Q|"YLPTRGM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFD&@MAU.A".ts_append_eval %Q|"YLPTRFD&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAT&@MAU.A".ts_append_eval %Q|"YLPTRAT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAP&@MAU.A".ts_append_eval %Q|"YLPTRAP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFR&@MAU.A".ts_append_eval %Q|"YLPTRFR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRET&@MAU.A".ts_append_eval %Q|"YLPTRET&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTROT&@MAU.A".ts_append_eval %Q|"YLPTROT&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRDP&@MAU.A".ts_append_eval %Q|"YLPFIRDP&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIROF&@MAU.A".ts_append_eval %Q|"YLPFIROF&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRSE&@MAU.A".ts_append_eval %Q|"YLPFIRSE&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVHE&@MAU.A".ts_append_eval %Q|"YLPSVHE&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFM&@MAU.A".ts_append_eval %Q|"YLPGFM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGSL&@MAU.A".ts_append_eval %Q|"YLPGSL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGST&@MAU.A".ts_append_eval %Q|"YLPGST&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGL&@MAU.A".ts_append_eval %Q|"YLPGL&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YP&@KAU.A".ts_append_eval %Q|"YP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NRBEA&@KAU.A".ts_append_eval %Q|"NRBEA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPCBEA&@KAU.A".ts_append_eval %Q|"YPCBEA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLP&@KAU.A".ts_append_eval %Q|"YLP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YTWPER&@KAU.A".ts_append_eval %Q|"YTWPER&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YRESADJ&@KAU.A".ts_append_eval %Q|"YRESADJ&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YNETR&@KAU.A".ts_append_eval %Q|"YNETR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YDIR&@KAU.A".ts_append_eval %Q|"YDIR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YV&@KAU.A".ts_append_eval %Q|"YV&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YWAGE&@KAU.A".ts_append_eval %Q|"YWAGE&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YOTLAB&@KAU.A".ts_append_eval %Q|"YOTLAB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROP&@KAU.A".ts_append_eval %Q|"YPROP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPFA&@KAU.A".ts_append_eval %Q|"YPROPFA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YPROPNF&@KAU.A".ts_append_eval %Q|"YPROPNF&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFA&@KAU.A".ts_append_eval %Q|"YLPAGFA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_NF&@KAU.A".ts_append_eval %Q|"YL_NF&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YL_PR&@KAU.A".ts_append_eval %Q|"YL_PR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFA&@KAU.A".ts_append_eval %Q|"YLPAGFFA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFF&@KAU.A".ts_append_eval %Q|"YLPAGFFF&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFO&@KAU.A".ts_append_eval %Q|"YLPAGFFFFO&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFFS&@KAU.A".ts_append_eval %Q|"YLPAGFFFFS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFFFOT&@KAU.A".ts_append_eval %Q|"YLPAGFFFOT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIMT&@KAU.A".ts_append_eval %Q|"YLPMIMT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMICO&@KAU.A".ts_append_eval %Q|"YLPMICO&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMIOL&@KAU.A".ts_append_eval %Q|"YLPMIOL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCGB&@KAU.A".ts_append_eval %Q|"YLPCGB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCHV&@KAU.A".ts_append_eval %Q|"YLPCHV&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPCST&@KAU.A".ts_append_eval %Q|"YLPCST&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPM&@KAU.A".ts_append_eval %Q|"YLPM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMD&@KAU.A".ts_append_eval %Q|"YLPMD&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNAP&@KAU.A".ts_append_eval %Q|"YLPMNAP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPMNLT&@KAU.A".ts_append_eval %Q|"YLPMNLT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPR&@KAU.A".ts_append_eval %Q|"YLPR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTR&@KAU.A".ts_append_eval %Q|"YLPRTR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTW&@KAU.A".ts_append_eval %Q|"YLPRTW&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPROT&@KAU.A".ts_append_eval %Q|"YLPROT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRLT&@KAU.A".ts_append_eval %Q|"YLPRLT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRTA&@KAU.A".ts_append_eval %Q|"YLPRTA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRPL&@KAU.A".ts_append_eval %Q|"YLPRPL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRSV&@KAU.A".ts_append_eval %Q|"YLPRSV&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRCM&@KAU.A".ts_append_eval %Q|"YLPRCM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPRUT&@KAU.A".ts_append_eval %Q|"YLPRUT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTW&@KAU.A".ts_append_eval %Q|"YLPTW&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRBL&@KAU.A".ts_append_eval %Q|"YLPTRBL&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRGM&@KAU.A".ts_append_eval %Q|"YLPTRGM&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFD&@KAU.A".ts_append_eval %Q|"YLPTRFD&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAT&@KAU.A".ts_append_eval %Q|"YLPTRAT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRAP&@KAU.A".ts_append_eval %Q|"YLPTRAP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRFR&@KAU.A".ts_append_eval %Q|"YLPTRFR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTRET&@KAU.A".ts_append_eval %Q|"YLPTRET&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPTROT&@KAU.A".ts_append_eval %Q|"YLPTROT&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIR&@KAU.A".ts_append_eval %Q|"YLPFIR&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRDP&@KAU.A".ts_append_eval %Q|"YLPFIRDP&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIROF&@KAU.A".ts_append_eval %Q|"YLPFIROF&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIC&@KAU.A".ts_append_eval %Q|"YLPFIRIC&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRIA&@KAU.A".ts_append_eval %Q|"YLPFIRIA&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRRE&@KAU.A".ts_append_eval %Q|"YLPFIRRE&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPFIRHD&@KAU.A".ts_append_eval %Q|"YLPFIRHD&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPS&@KAU.A".ts_append_eval %Q|"YLPSVPS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVPH&@KAU.A".ts_append_eval %Q|"YLPSVPH&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPSVBS&@KAU.A".ts_append_eval %Q|"YLPSVBS&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "PCHSFUGS@HON.M".ts_append_eval %Q|"PCHSFUGS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCFB@HON.M".ts_append_eval %Q|"PCFB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PC_MD@HON.M".ts_append_eval %Q|"PC_MD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHSSHOW@HON.M".ts_append_eval %Q|"PCHSSHOW@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCED@HON.M".ts_append_eval %Q|"PCED@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHS@HON.M".ts_append_eval %Q|"PCHS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PC_EN@HON.M".ts_append_eval %Q|"PC_EN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCCMND_FD@HON.M".ts_append_eval %Q|"PCCMND_FD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCRE@HON.M".ts_append_eval %Q|"PCRE@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHSSH@HON.M".ts_append_eval %Q|"PCHSSH@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCTRGSRG@HON.M".ts_append_eval %Q|"PCTRGSRG@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHSHF@HON.M".ts_append_eval %Q|"PCHSHF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCFBFD@HON.M".ts_append_eval %Q|"PCFBFD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCTRMF@HON.M".ts_append_eval %Q|"PCTRMF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCFBFDBV@HON.M".ts_append_eval %Q|"PCFBFDBV@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCSV_MD@HON.M".ts_append_eval %Q|"PCSV_MD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCSV@HON.M".ts_append_eval %Q|"PCSV@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCCM_FB@HON.M".ts_append_eval %Q|"PCCM_FB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCAP@HON.M".ts_append_eval %Q|"PCAP@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCTRGSPR@HON.M".ts_append_eval %Q|"PCTRGSPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "PCHSSHRT@HON.M".ts_append_eval %Q|"PCHSSHRT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCCMND_FB@HON.S".ts_append_eval %Q|"PCCMND_FB@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCCMND_FD@HON.S".ts_append_eval %Q|"PCCMND_FD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCCMND@HON.S".ts_append_eval %Q|"PCCMND@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRGSMD@HON.S".ts_append_eval %Q|"PCTRGSMD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRGS@HON.S".ts_append_eval %Q|"PCTRGS@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRPR@HON.S".ts_append_eval %Q|"PCTRPR@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTR@HON.S".ts_append_eval %Q|"PCTR@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCHSSH@HON.S".ts_append_eval %Q|"PCHSSH@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PC_EN@HON.S".ts_append_eval %Q|"PC_EN@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "PCTRGSRG@HON.S".ts_append_eval %Q|"PCTRGSRG@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "EPSSA@HI.M".ts_append_eval %Q|"EPSSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "WH_TTUNS@HI.M".ts_append_eval %Q|"WH_TTUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "EEDSA@HI.M".ts_append_eval %Q|"EEDSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "WW_FINNS@HON.M".ts_append_eval %Q|"WW_FINNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "WHAFNS@HI.M".ts_append_eval %Q|"WHAFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "WW_TTUNS@HON.M".ts_append_eval %Q|"WW_TTUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
  "EGVFDOTNS&@HON.M".ts_append_eval %Q|"EGVFDOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "EMPLNS&@HI.M".ts_append_eval %Q|"EMPLNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ERTGMGRNS&@HI.M".ts_append_eval %Q|"ERTGMGRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ERTGMGRNS&@HON.M".ts_append_eval %Q|"ERTGMGRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ERTGMNS&@HI.M".ts_append_eval %Q|"ERTGMNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ESVENNS&@HI.M".ts_append_eval %Q|"ESVENNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ESVHCHONS&@HI.M".ts_append_eval %Q|"ESVHCHONS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "ETUCUCMNS&@HON.M".ts_append_eval %Q|"ETUCUCMNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
  "HRRT$FDNS&@HI.M".ts_append_eval %Q|"HRRT$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWFIDPNS&@HON.M".ts_append_eval %Q|"PWFIDPNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWMNNDPRNS&@HI.M".ts_append_eval %Q|"PWMNNDPRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "PWMNNS&@HI.M".ts_append_eval %Q|"PWMNNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
  "ECTSPNS@KAU.M".ts_append_eval %Q|"ECTSPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "EGVSTEDNS@KAU.M".ts_append_eval %Q|"EGVSTEDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "ERTFDNS@MAU.M".ts_append_eval %Q|"ERTFDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "KNRSDMLTNS@HI.Q".ts_append_eval %Q|"KNRSDMLTNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_q_new.xls"|
  "PMKBCON@HON.M".ts_append_eval %Q|"PMKBCON@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
  "YSOCSECEM@HI.Q".ts_append_eval %Q|"YSOCSECEM@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YSOCSECEM@HI.Q".ts_append_eval %Q|"YSOCSECEM@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YTRNSFUI@HI.Q".ts_append_eval %Q|"YTRNSFUI@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YTRNSFUI@HI.Q".ts_append_eval %Q|"YTRNSFUI@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YTRNSFOT@HI.Q".ts_append_eval %Q|"YTRNSFOT@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YTRNSFOT@HI.Q".ts_append_eval %Q|"YTRNSFOT@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YWAGE@HI.Q".ts_append_eval %Q|"YWAGE@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YWAGE@HI.Q".ts_append_eval %Q|"YWAGE@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YOTLAB@HI.Q".ts_append_eval %Q|"YOTLAB@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YOTLAB@HI.Q".ts_append_eval %Q|"YOTLAB@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YOTLABPEN@HI.Q".ts_append_eval %Q|"YOTLABPEN@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YOTLABPEN@HI.Q".ts_append_eval %Q|"YOTLABPEN@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YOTLABSS@HI.Q".ts_append_eval %Q|"YOTLABSS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YOTLABSS@HI.Q".ts_append_eval %Q|"YOTLABSS@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLGV@HI.Q".ts_append_eval %Q|"YLGV@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YLGV@HI.Q".ts_append_eval %Q|"YLGV@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLGVFD@HI.Q".ts_append_eval %Q|"YLGVFD@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YLGVFD@HI.Q".ts_append_eval %Q|"YLGVFD@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLGVML@HI.Q".ts_append_eval %Q|"YLGVML@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YLGVML@HI.Q".ts_append_eval %Q|"YLGVML@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YL_GVSL@HI.Q".ts_append_eval %Q|"YL_GVSL@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
  "YL_GVSL@HI.Q".ts_append_eval %Q|"YL_GVSL@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
  "YLMI@HI.A".ts_append_eval %Q|"YLMI@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLMI@HI.A".ts_append_eval %Q|"YLMI@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHC@HI.A".ts_append_eval %Q|"YLHC@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLHC@HI.A".ts_append_eval %Q|"YLHC@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_OT@HI.A".ts_append_eval %Q|"YL_OT@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YNETR@HON.A".ts_append_eval %Q|"YNETR@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YNETR@HON.A".ts_append_eval %Q|"YNETR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROP@HON.A".ts_append_eval %Q|"YPROP@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YPROP@HON.A".ts_append_eval %Q|"YPROP@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_NF@HON.A".ts_append_eval %Q|"YL_NF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YL_NF@HON.A".ts_append_eval %Q|"YL_NF@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRE@HON.A".ts_append_eval %Q|"YLRE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLRE@HON.A".ts_append_eval %Q|"YLRE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YNETR@HAW.A".ts_append_eval %Q|"YNETR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YNETR@HAW.A".ts_append_eval %Q|"YNETR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROP@HAW.A".ts_append_eval %Q|"YPROP@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YPROP@HAW.A".ts_append_eval %Q|"YPROP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YPROPNF@HAW.A".ts_append_eval %Q|"YPROPNF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YPROPNF@HAW.A".ts_append_eval %Q|"YPROPNF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_PR@HAW.A".ts_append_eval %Q|"YL_PR@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YL_PR@HAW.A".ts_append_eval %Q|"YL_PR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVML@HAW.A".ts_append_eval %Q|"YLGVML@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HAW"|
  "YLGVML@HAW.A".ts_append_eval %Q|"YLGVML@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "GDP_IIVP_R@JP.A".ts_append_eval %Q|"GDP_IIVP_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_CP_R@JP.A".ts_append_eval %Q|"GDP_CP_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_IFXG_R@JP.A".ts_append_eval %Q|"GDP_IFXG_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GNIPC@JP.A".ts_append_eval %Q|"GNIPC@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_NX_R@JP.A".ts_append_eval %Q|"GDP_NX_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_NX@JP.A".ts_append_eval %Q|"GDP_NX@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "IPMN@JP.M".ts_append_eval %Q|"IPMN@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "UR@JP.M".ts_append_eval %Q|"UR@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "CPINS@JP.M".ts_append_eval %Q|"CPINS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "CPICORENS@JP.M".ts_append_eval %Q|"CPICORENS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
  "TKEMPLNM_NS@JP.Q".ts_append_eval %Q|"TKEMPLNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IIVGNS@JP.Q".ts_append_eval %Q|"GDP_IIVGNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_CP_RNS@JP.Q".ts_append_eval %Q|"GDP_CP_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IM_R@JP.Q".ts_append_eval %Q|"GDP_IM_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_NX_R@JP.Q".ts_append_eval %Q|"GDP_NX_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCLMN_NS@JP.Q".ts_append_eval %Q|"TKBSCLMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCMNS@JP.Q".ts_append_eval %Q|"TKBSCMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IFXGNS@JP.Q".ts_append_eval %Q|"GDP_IFXGNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_RNS@JP.Q".ts_append_eval %Q|"GDP_RNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GNIDEF@JP.Q".ts_append_eval %Q|"GNIDEF@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKEMPANS@JP.Q".ts_append_eval %Q|"TKEMPANS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "GDP_IIVP@JP.Q".ts_append_eval %Q|"GDP_IIVP@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKEMPMNMNS@JP.Q".ts_append_eval %Q|"TKEMPMNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "TKBSCMNM_NS@JP.Q".ts_append_eval %Q|"TKBSCMNM_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
  "KVTCOM@KAU.A".ts_append_eval %Q|"KVTCOM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVLCOM@KAU.A".ts_append_eval %Q|"KVLCOM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVLAGR@KAU.A".ts_append_eval %Q|"KVLAGR@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVTHST@KAU.A".ts_append_eval %Q|"KVTHST@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVLHST@KAU.A".ts_append_eval %Q|"KVLHST@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KVL@KAU.A".ts_append_eval %Q|"KVL@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "RTTNS@KAU.A".ts_append_eval %Q|"RTTNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "KNAONR@HON.M".ts_append_eval %Q|"KNAONR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
  "TGRWTNS@KAU.A".ts_append_eval %Q|"TGRWTNS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "TGRSINS@KAU.A".ts_append_eval %Q|"TGRSINS@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
  "VSOOTANS@KAU.M".ts_append_eval %Q|"VSOOTANS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/seats_upd.xls"|
  "VRDCDMNS@HAW.M".ts_append_eval %Q|"VRDCDMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VRDCDMNS@MAU.M".ts_append_eval %Q|"VRDCDMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VRDCNS@MOL.M".ts_append_eval %Q|"VRDCNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VRDCDMNS@MOL.M".ts_append_eval %Q|"VRDCDMNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VRDCNS@KAU.M".ts_append_eval %Q|"VRDCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VRDCDMNS@KAU.M".ts_append_eval %Q|"VRDCDMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "GDP_CN_R@US.Q".ts_append_eval %Q|"GDP_CN_R@US.Q".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_q.xls"|
  "PC_SH@HON.Q".ts_eval= %Q|'PC_SH@HON.S'.ts.interpolate :quarter, :linear|
  "TGBCT@HON.Q".ts_append_eval %Q|"TGBCT@HON.Q".tsn.load_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls"|
  "TGBCT@HAW.Q".ts_append_eval %Q|"TGBCT@HAW.Q".tsn.load_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls"|
  "TGBCT@KAU.Q".ts_append_eval %Q|"TGBCT@KAU.Q".tsn.load_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls"|
  "TGBCT@MAU.Q".ts_append_eval %Q|"TGBCT@MAU.Q".tsn.load_sa_from "/Volumes/UHEROwork/data/tax/seasadj/sadata.xls"|
  "PCDM@HI.M".ts_append_eval %Q|"PCDM@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VDAYCAN@HI.M".ts_append_eval %Q|"VDAYCAN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTJP@HI.M".ts_append_eval %Q|"VEXPPTJP@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PC@HI.M".ts_append_eval %Q|"PC@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXP@HI.M".ts_append_eval %Q|"VEXP@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VISCRAIR@HI.M".ts_append_eval %Q|"VISCRAIR@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSDM@HI.M".ts_append_eval %Q|"VSDM@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTUSE@HI.M".ts_append_eval %Q|"VEXPPTUSE@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSO@HI.M".ts_append_eval %Q|"VSO@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTOT@HI.M".ts_append_eval %Q|"VEXPPTOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTCAN@HI.M".ts_append_eval %Q|"VEXPPTCAN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSODM@HI.M".ts_append_eval %Q|"VSODM@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPDUSE@HI.M".ts_append_eval %Q|"VEXPPDUSE@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PMKRCONNS@KAU.A".ts_eval= %Q|"PMKRCONNS@KAU.Q".ts.aggregate(:year, :average)|
  "PMKRCON@MAU.Q".ts_append_eval %Q|"PMKRCON@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "PMKRSGF@HI.Q".ts_append_eval %Q|"PMKRSGF@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_hist.xls"|
  "EIF@HI.M".ts_eval= %Q|"EIF@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls"|
  "EIFNS@HI.M".ts_append_eval %Q|"EIFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|

  "EIF@HI.M".ts_eval= %Q|"EIF@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  "PCSV_RN@HON.M".ts_append_eval %Q|"PCSV_RN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
  "NDF@HON.A".ts_append_eval %Q|"NDF@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "PC_MD@HON.Q".ts_eval= %Q|'PC_MD@HON.S'.ts.interpolate :quarter, :linear|
  "YLPSVBS&@HAW.A".ts_append_eval %Q|"YLPSVBS&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPAGFF&@HON.A".ts_append_eval %Q|"YLPAGFF&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "NDF@KAU.A".ts_append_eval %Q|"NDF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "VEXPUSENS@HI.M".ts_append_eval %Q|"VEXPUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "NRCNM@HON.A".ts_append_eval %Q|"NRCNM@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
  "YL_NF@HI.A".ts_append_eval %Q|"YL_NF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YL_NF@HI.A".ts_append_eval %Q|"YL_NF@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_PR@HI.A".ts_append_eval %Q|"YL_PR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YL_PR@HI.A".ts_append_eval %Q|"YL_PR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRFR@HI.A".ts_append_eval %Q|"YLMNDRFR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMS@HI.A".ts_append_eval %Q|"YLMNDRMS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLWT@HI.A".ts_append_eval %Q|"YLWT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRT@HI.A".ts_append_eval %Q|"YLRT@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERE@HI.A".ts_append_eval %Q|"YLRERE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERL@HI.A".ts_append_eval %Q|"YLRERL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRELE@HI.A".ts_append_eval %Q|"YLRELE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMA@HI.A".ts_append_eval %Q|"YLMA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOS@HI.A".ts_append_eval %Q|"YLOS@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVFD@HI.A".ts_append_eval %Q|"YLGVFD@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGVFD@HI.A".ts_append_eval %Q|"YLGVFD@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLGVML@HI.A".ts_append_eval %Q|"YLGVML@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLGVML@HI.A".ts_append_eval %Q|"YLGVML@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YL_GVSL@HI.A".ts_append_eval %Q|"YL_GVSL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YL_GVSL@HI.A".ts_append_eval %Q|"YL_GVSL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECPR@HON.A".ts_append_eval %Q|"YSOCSECPR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECEM@HON.A".ts_append_eval %Q|"YSOCSECEM@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRTR@HON.A".ts_append_eval %Q|"YLMNDRTR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIMO@HON.A".ts_append_eval %Q|"YLFIMO@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFICR@HON.A".ts_append_eval %Q|"YLFICR@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIIN@HON.A".ts_append_eval %Q|"YLFIIN@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFIOT@HON.A".ts_append_eval %Q|"YLFIOT@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLRERE@HON.A".ts_append_eval %Q|"YLRERE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAE@HON.A".ts_append_eval %Q|"YLAE@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLAE@HON.A".ts_append_eval %Q|"YLAE@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAFFD@HON.A".ts_append_eval %Q|"YLAFFD@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "YLAFFD@HON.A".ts_append_eval %Q|"YLAFFD@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOSHH@HON.A".ts_append_eval %Q|"YLOSHH@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMV@HAW.A".ts_append_eval %Q|"YLMNDRMV@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRTR@HAW.A".ts_append_eval %Q|"YLMNDRTR@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDRMS@HAW.A".ts_append_eval %Q|"YLMNDRMS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWPL@HAW.A".ts_append_eval %Q|"YLTWPL@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLTWSC@HAW.A".ts_append_eval %Q|"YLTWSC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLIFIT@HAW.A".ts_append_eval %Q|"YLIFIT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFI@HAW.A".ts_append_eval %Q|"YLFI@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLFISE@HAW.A".ts_append_eval %Q|"YLFISE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLHC@HAW.A".ts_append_eval %Q|"YLHC@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAE@HAW.A".ts_append_eval %Q|"YLAE@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLOS@HAW.A".ts_append_eval %Q|"YLOS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAGFFSP@MAU.A".ts_append_eval %Q|"YLAGFFSP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIOG@MAU.A".ts_append_eval %Q|"YLMIOG@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMIMI@MAU.A".ts_append_eval %Q|"YLMIMI@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMISP@MAU.A".ts_append_eval %Q|"YLMISP@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLCTBL@MAU.A".ts_append_eval %Q|"YLCTBL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAEMU@KAU.A".ts_append_eval %Q|"YLAEMU@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAF@KAU.A".ts_append_eval %Q|"YLAF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "PCCM_FD@HON.S".ts_append_eval %Q|"PCCM_FD@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "KRCONNS_NMC@HON.Q".ts_append_eval %Q|"KRCONNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
  "KRSGFNS_NMC@KAU.Q".ts_append_eval %Q|"KRSGFNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
  "PCSV_RN@HON.S".ts_append_eval %Q|"PCSV_RN@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
  "YL@HI.A".ts_append_eval %Q|"YL@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YL@HI.A".ts_append_eval %Q|"YL@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECPR@HI.A".ts_append_eval %Q|"YSOCSECPR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YSOCSECPR@HI.A".ts_append_eval %Q|"YSOCSECPR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YSOCSECEM@HI.A".ts_append_eval %Q|"YSOCSECEM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YSOCSECEM@HI.A".ts_append_eval %Q|"YSOCSECEM@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLMNDR@HI.A".ts_append_eval %Q|"YLMNDR@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPG&@KAU.A".ts_append_eval %Q|"YLPG&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "YLPGFC&@KAU.A".ts_append_eval %Q|"YLPGFC&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "RTFCNS@KAU.A".ts_append_eval %Q|"RTFCNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
  "Y@HI.A".ts_append_eval %Q|"Y@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "Y@HI.A".ts_append_eval %Q|"Y@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YRESADJ@HI.A".ts_append_eval %Q|"YRESADJ@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YRESADJ@HI.A".ts_append_eval %Q|"YRESADJ@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLAE@HI.A".ts_append_eval %Q|"YLAE@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
  "YLAE@HI.A".ts_append_eval %Q|"YLAE@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "NRBEA@HON.A".ts_append_eval %Q|"NRBEA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
  "NRBEA@HON.A".ts_append_eval %Q|"NRBEA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
  "YLPSVSO&@HI.A".ts_append_eval %Q|"YLPSVSO&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "VISJPNS@MAU.M".ts_append_eval %Q|"VISJPNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISJPNS@HON.M".ts_append_eval %Q|"VISJPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "GDP_R@JP.A".ts_append_eval %Q|"GDP_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDP_INRP@JP.A".ts_append_eval %Q|"GDP_INRP@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "GDPPC@JP.A".ts_append_eval %Q|"GDPPC@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
  "YPROPFA&@HON.A".ts_append_eval %Q|"YPROPFA&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
  "ERTFDGSNS@HAW.M".ts_append_eval %Q|"ERTFDGSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "E_PRSVCPRNS@KAU.M".ts_append_eval %Q|"E_PRSVCPRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "ERTGMDSNS@KAU.M".ts_append_eval %Q|"ERTGMDSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
  "VADMCRNS@HI.M".ts_append_eval %Q|"VADMCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VACRBBNS@HI.M".ts_append_eval %Q|"VACRBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VSITSCHNS@MAU.M".ts_append_eval %Q|"VSITSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
  "VPDMEDUNS@HI.M".ts_append_eval %Q|"VPDMEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "VSTITINDNS@HI.M".ts_append_eval %Q|"VSTITINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "VSTUSWFTNS@HI.M".ts_append_eval %Q|"VSTUSWFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "VISDMENCNS@HI.M".ts_append_eval %Q|"VISDMENCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VISDMESCNS@HI.M".ts_append_eval %Q|"VISDMESCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSJPNS@HAW.M".ts_append_eval %Q|"VRLSJPNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "VRLSCANNS@HAW.M".ts_append_eval %Q|"VRLSCANNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
  "OCUP%NS@HI.Q".ts_eval= %Q|"OCUP%NS@HI.M".ts.aggregate(:quarter, :average)|
  "RMRVNS@KAU.Q".ts_eval= %Q|"RMRVNS@KAU.M".ts.aggregate(:quarter, :average)|
  "PCFB@HON.Q".ts_eval= %Q|'PCFB@HON.S'.ts.interpolate :quarter, :linear|
  "PCHS@HON.Q".ts_eval= %Q|'PCHS@HON.S'.ts.interpolate :quarter, :linear|
  "PCHSFU@HON.Q".ts_eval= %Q|'PCHSFU@HON.S'.ts.interpolate :quarter, :linear|
  "PCHSFUGS@HON.Q".ts_eval= %Q|'PCHSFUGS@HON.S'.ts.interpolate :quarter, :linear|
  "PCHSFUGS@HON.Q".ts_append_eval %Q|"PCHSFUGS@HON.M".ts.aggregate(:quarter, :average)|
  "PCHSFUGSE@HON.Q".ts_eval= %Q|'PCHSFUGSE@HON.S'.ts.interpolate :quarter, :linear|
  
  "PCHSFUGSE@HON.M".ts_append_eval %Q|"PCHSFUGSE@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
    "PCHSFUGSE@HON.Q".ts_append_eval %Q|"PCHSFUGSE@HON.M".ts.aggregate(:quarter, :average)|
    "PCMD@HON.Q".ts_eval= %Q|'PCMD@HON.S'.ts.interpolate :quarter, :linear|
    "PCCM@HON.Q".ts_eval= %Q|'PCCM@HON.S'.ts.interpolate :quarter, :linear|
    "PCCM_FD@HON.Q".ts_eval= %Q|'PCCM_FD@HON.S'.ts.interpolate :quarter, :linear|
    "PCCM_FB@HON.Q".ts_eval= %Q|'PCCM_FB@HON.S'.ts.interpolate :quarter, :linear|
    "PCCMND@HON.Q".ts_eval= %Q|'PCCMND@HON.S'.ts.interpolate :quarter, :linear|
    "PCCMND_FD@HON.Q".ts_eval= %Q|'PCCMND_FD@HON.S'.ts.interpolate :quarter, :linear|
    "PCCMND_FB@HON.Q".ts_eval= %Q|'PCCMND_FB@HON.S'.ts.interpolate :quarter, :linear|
    "PCSV_RN@HON.Q".ts_eval= %Q|'PCSV_RN@HON.S'.ts.interpolate :quarter, :linear|
    "Y@HI.Q".ts_append_eval %Q|"Y@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
    "Y@HI.Q".ts_append_eval %Q|"Y@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
    "YL@HI.Q".ts_append_eval %Q|"YL@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
    "YL@HI.Q".ts_append_eval %Q|"YL@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
    "YPROPFA@HI.Q".ts_append_eval %Q|"YPROPFA@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls"|
    "YPROPFA@HI.Q".ts_append_eval %Q|"YPROPFA@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
    "YLHC@HON.A".ts_append_eval %Q|"YLHC@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
    "YLHC@HON.A".ts_append_eval %Q|"YLHC@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YL_NF@KAU.A".ts_append_eval %Q|"YL_NF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
    "YL_NF@KAU.A".ts_append_eval %Q|"YL_NF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "ERTFDGSNS@KAU.M".ts_append_eval %Q|"ERTFDGSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_PRSVCPRNS@MAU.M".ts_append_eval %Q|"E_PRSVCPRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ERTFDGSNS@MAU.M".ts_append_eval %Q|"ERTFDGSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "PMKRCONNS@HAW.Q".ts_append_eval %Q|"PMKRCONNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
    "YLMNNDPL@MAU.A".ts_append_eval %Q|"YLMNNDPL@MAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLRTMS@HAW.A".ts_append_eval %Q|"YLRTMS@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLMNNDFD@KAU.A".ts_append_eval %Q|"YLMNNDFD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLMNNDBV@KAU.A".ts_append_eval %Q|"YLMNNDBV@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLMNNDXM@KAU.A".ts_append_eval %Q|"YLMNNDXM@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLMNNDAP@KAU.A".ts_append_eval %Q|"YLMNNDAP@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLRTHC@KAU.A".ts_append_eval %Q|"YLRTHC@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "YLUT@KAU.A".ts_append_eval %Q|"YLUT@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
    "PC@HON.M".ts_append_eval %Q|"PC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
    "PC@HON.M".ts_append_eval %Q|"PC@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EFINS@HAW.M".ts_append_eval %Q|"EFINS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EFINS@HAW.M".ts_append_eval %Q|"EFINS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EPSNS@HAW.M".ts_append_eval %Q|"EPSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EHCNS@HAW.M".ts_append_eval %Q|"EHCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EHCNS@HAW.M".ts_append_eval %Q|"EHCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAFNS@HAW.M".ts_append_eval %Q|"EAFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EAFNS@HAW.M".ts_append_eval %Q|"EAFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAFFDNS@HAW.M".ts_append_eval %Q|"EAFFDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EAFFDNS@HAW.M".ts_append_eval %Q|"EAFFDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVFDNS@HAW.M".ts_append_eval %Q|"EGVFDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVFDNS@HAW.M".ts_append_eval %Q|"EGVFDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVSTNS@HAW.M".ts_append_eval %Q|"EGVSTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVSTNS@HAW.M".ts_append_eval %Q|"EGVSTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVLCNS@HAW.M".ts_append_eval %Q|"EGVLCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVLCNS@HAW.M".ts_append_eval %Q|"EGVLCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAGNS@HAW.M".ts_append_eval %Q|"EAGNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EAGNS@HAW.M".ts_append_eval %Q|"EAGNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_NFNS@KAU.M".ts_append_eval %Q|"E_NFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_NFNS@KAU.M".ts_append_eval %Q|"E_NFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_NFNS@MAU.M".ts_append_eval %Q|"E_NFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_NFNS@MAU.M".ts_append_eval %Q|"E_NFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_PRNS@MAU.M".ts_append_eval %Q|"E_PRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_PRNS@MAU.M".ts_append_eval %Q|"E_PRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ECTNS@MAU.M".ts_append_eval %Q|"ECTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "ECTNS@MAU.M".ts_append_eval %Q|"ECTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EMNNS@MAU.M".ts_append_eval %Q|"EMNNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EMNNS@MAU.M".ts_append_eval %Q|"EMNNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_SVCPRNS@MAU.M".ts_append_eval %Q|"E_SVCPRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_SVCPRNS@MAU.M".ts_append_eval %Q|"E_SVCPRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_TUNS@MAU.M".ts_append_eval %Q|"E_TUNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_TUNS@MAU.M".ts_append_eval %Q|"E_TUNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EMNNS@HI.M".ts_append_eval %Q|"EMNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EMNNS@HI.M".ts_append_eval %Q|"EMNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_SVCPRNS@HI.M".ts_append_eval %Q|"E_SVCPRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_SVCPRNS@HI.M".ts_append_eval %Q|"E_SVCPRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMNNS@HON.M".ts_append_eval %Q|"EMNNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EMNNS@HON.M".ts_append_eval %Q|"EMNNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_SVCPRNS@HON.M".ts_append_eval %Q|"E_SVCPRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_SVCPRNS@HON.M".ts_append_eval %Q|"E_SVCPRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EAGNS@HON.M".ts_append_eval %Q|"EAGNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EAGNS@HON.M".ts_append_eval %Q|"EAGNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_SVCPRNS@HAW.M".ts_append_eval %Q|"E_SVCPRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_SVCPRNS@HAW.M".ts_append_eval %Q|"E_SVCPRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_TTUNS@HAW.M".ts_append_eval %Q|"E_TTUNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_TTUNS@HAW.M".ts_append_eval %Q|"E_TTUNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EWTNS@HAW.M".ts_append_eval %Q|"EWTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EIFNS@HAW.M".ts_append_eval %Q|"EIFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EADNS@HAW.M".ts_append_eval %Q|"EADNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVNS@HAW.M".ts_append_eval %Q|"EGVNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVNS@HAW.M".ts_append_eval %Q|"EGVNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EMNDRNS@KAU.M".ts_append_eval %Q|"EMNDRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EMNNDNS@KAU.M".ts_append_eval %Q|"EMNNDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_SVCPRNS@KAU.M".ts_append_eval %Q|"E_SVCPRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_SVCPRNS@KAU.M".ts_append_eval %Q|"E_SVCPRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_TTUNS@KAU.M".ts_append_eval %Q|"E_TTUNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_TTUNS@KAU.M".ts_append_eval %Q|"E_TTUNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ERTFDNS@KAU.M".ts_append_eval %Q|"ERTFDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ERTGMNS@KAU.M".ts_append_eval %Q|"ERTGMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_FIRNS@KAU.M".ts_append_eval %Q|"E_FIRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_FIRNS@KAU.M".ts_append_eval %Q|"E_FIRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EPSNS@KAU.M".ts_append_eval %Q|"EPSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EADNS@KAU.M".ts_append_eval %Q|"EADNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EOSNS@KAU.M".ts_append_eval %Q|"EOSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVNS@KAU.M".ts_append_eval %Q|"EGVNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVNS@KAU.M".ts_append_eval %Q|"EGVNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVSTNS@KAU.M".ts_append_eval %Q|"EGVSTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVSTNS@KAU.M".ts_append_eval %Q|"EGVSTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAGNS@KAU.M".ts_append_eval %Q|"EAGNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EAGNS@KAU.M".ts_append_eval %Q|"EAGNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_GDSPRNS@MAU.M".ts_append_eval %Q|"E_GDSPRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_GDSPRNS@MAU.M".ts_append_eval %Q|"E_GDSPRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_FIRNS@MAU.M".ts_append_eval %Q|"E_FIRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_FIRNS@MAU.M".ts_append_eval %Q|"E_FIRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_PBSNS@MAU.M".ts_append_eval %Q|"E_PBSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EPSNS@MAU.M".ts_append_eval %Q|"EPSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_EDHCNS@MAU.M".ts_append_eval %Q|"E_EDHCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EEDNS@MAU.M".ts_append_eval %Q|"EEDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_LHNS@MAU.M".ts_append_eval %Q|"E_LHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAENS@MAU.M".ts_append_eval %Q|"EAENS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EOSNS@MAU.M".ts_append_eval %Q|"EOSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVSTNS@MAU.M".ts_append_eval %Q|"EGVSTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVSTNS@MAU.M".ts_append_eval %Q|"EGVSTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVNS@HI.M".ts_append_eval %Q|"EGVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHIFNS@HON.M".ts_append_eval %Q|"WHIFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ETWNS@HI.M".ts_append_eval %Q|"ETWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WWRTNS@HON.M".ts_append_eval %Q|"WWRTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EWTNS@HI.M".ts_append_eval %Q|"EWTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EADESNS@HON.M".ts_append_eval %Q|"EADESNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVLCNS@HI.M".ts_append_eval %Q|"EGVLCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVLCNS@HI.M".ts_append_eval %Q|"EGVLCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMPLNS@HON.M".ts_append_eval %Q|"EMPLNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_LHSA@HI.M".ts_append_eval %Q|"E_LHSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_TTUSA@HI.M".ts_append_eval %Q|"E_TTUSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_TTUSA@HI.M".ts_append_eval %Q|"E_TTUSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_PRNS@HON.M".ts_append_eval %Q|"E_PRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_PRNS@HON.M".ts_append_eval %Q|"E_PRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWMNNS@HON.M".ts_append_eval %Q|"WWMNNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHRTNS@HON.M".ts_append_eval %Q|"WHRTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWAFFDNS@HON.M".ts_append_eval %Q|"WWAFFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_GDSPRNS@HI.M".ts_append_eval %Q|"E_GDSPRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_GDSPRNS@HI.M".ts_append_eval %Q|"E_GDSPRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTGMNS@HI.M".ts_append_eval %Q|"ERTGMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WHRTNS@HI.M".ts_append_eval %Q|"WHRTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWCTNS@HON.M".ts_append_eval %Q|"WWCTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "URNS@HAW.M".ts_append_eval %Q|"URNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTCLNS@HI.M".ts_append_eval %Q|"ERTCLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVLCNS@HON.M".ts_append_eval %Q|"EGVLCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVLCNS@HON.M".ts_append_eval %Q|"EGVLCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMPLNS@MAU.M".ts_append_eval %Q|"EMPLNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EWTSA@HI.M".ts_append_eval %Q|"EWTSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EAFSA@HI.M".ts_append_eval %Q|"EAFSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWWTNS@HON.M".ts_append_eval %Q|"WWWTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVFDDDNS@HON.M".ts_append_eval %Q|"EGVFDDDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVSTNS@HI.M".ts_append_eval %Q|"EGVSTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVSTNS@HI.M".ts_append_eval %Q|"EGVSTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHMNNS@HON.M".ts_append_eval %Q|"WHMNNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVSTSA@HI.M".ts_append_eval %Q|"EGVSTSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHCTNS@HI.M".ts_append_eval %Q|"WHCTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMNDRNS@HON.M".ts_append_eval %Q|"EMNDRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_PBSSA@HI.M".ts_append_eval %Q|"E_PBSSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "LFNS@KAU.M".ts_append_eval %Q|"LFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EADESNS@HI.M".ts_append_eval %Q|"EADESNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVFDSPNS@HI.M".ts_append_eval %Q|"EGVFDSPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WHCTNS@HON.M".ts_append_eval %Q|"WHCTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTGMDSNS@HON.M".ts_append_eval %Q|"ERTGMDSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "LFNS@HI.M".ts_append_eval %Q|"LFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHWTNS@HON.M".ts_append_eval %Q|"WHWTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_PRNS@HI.M".ts_append_eval %Q|"E_PRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_PRNS@HI.M".ts_append_eval %Q|"E_PRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVFDDDNS@HI.M".ts_append_eval %Q|"EGVFDDDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_NFNS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHMNNS@HI.M".ts_append_eval %Q|"WHMNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTFDNS@HI.M".ts_append_eval %Q|"ERTFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WHAFNS@HON.M".ts_append_eval %Q|"WHAFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EAFFDRSNS@HON.M".ts_append_eval %Q|"EAFFDRSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EPSNS@HON.M".ts_append_eval %Q|"EPSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EFINS@HON.M".ts_append_eval %Q|"EFINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EFINS@HON.M".ts_append_eval %Q|"EFINS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ECTSPNS@HON.M".ts_append_eval %Q|"ECTSPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EHCHONS@HI.M".ts_append_eval %Q|"EHCHONS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ECTSPNS@HI.M".ts_append_eval %Q|"ECTSPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_FIRSA@HI.M".ts_append_eval %Q|"E_FIRSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWAFACNS@HI.M".ts_append_eval %Q|"WWAFACNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_GDSPRNS@HON.M".ts_append_eval %Q|"E_GDSPRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "E_GDSPRNS@HON.M".ts_append_eval %Q|"E_GDSPRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVSA@HI.M".ts_append_eval %Q|"EGVSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVFDNS@HON.M".ts_append_eval %Q|"EGVFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EGVFDNS@HON.M".ts_append_eval %Q|"EGVFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "URNS@HON.M".ts_append_eval %Q|"URNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EFINS@HI.M".ts_append_eval %Q|"EFINS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EFINS@HI.M".ts_append_eval %Q|"EFINS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMPLNS@KAU.M".ts_append_eval %Q|"EMPLNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EAESA@HI.M".ts_append_eval %Q|"EAESA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ETWNS@HON.M".ts_append_eval %Q|"ETWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WWCTNS@HI.M".ts_append_eval %Q|"WWCTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTGMNS@HON.M".ts_append_eval %Q|"ERTGMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EAFFDRSNS@HI.M".ts_append_eval %Q|"EAFFDRSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EMNNDNS@HI.M".ts_append_eval %Q|"EMNNDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVSTEDNS@HI.M".ts_append_eval %Q|"EGVSTEDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WWAFFDNS@HI.M".ts_append_eval %Q|"WWAFFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EGVFDSPNS@HON.M".ts_append_eval %Q|"EGVFDSPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "URNS@MAU.M".ts_append_eval %Q|"URNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WHAFACNS@HI.M".ts_append_eval %Q|"WHAFACNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WW_FINNS@HI.M".ts_append_eval %Q|"WW_FINNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTCLNS@HON.M".ts_append_eval %Q|"ERTCLNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WWAFACNS@HON.M".ts_append_eval %Q|"WWAFACNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EIFNS@HON.M".ts_append_eval %Q|"EIFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EMNNDNS@HON.M".ts_append_eval %Q|"EMNNDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "WW_TTUNS@HI.M".ts_append_eval %Q|"WW_TTUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EED12NS@HON.M".ts_append_eval %Q|"EED12NS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "EGVNS@HON.M".ts_append_eval %Q|"EGVNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTGMDSNS@HI.M".ts_append_eval %Q|"ERTGMDSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "E_NFSA@HI.M".ts_append_eval %Q|"E_NFSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWRTNS@HI.M".ts_append_eval %Q|"WWRTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "E_EDHCSA@HI.M".ts_append_eval %Q|"E_EDHCSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "URNS@HI.M".ts_append_eval %Q|"URNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WWIFNS@HI.M".ts_append_eval %Q|"WWIFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WH_FINNS@HON.M".ts_append_eval %Q|"WH_FINNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "EHCNS@HON.M".ts_append_eval %Q|"EHCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
    "EHCNS@HON.M".ts_append_eval %Q|"EHCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WH_TTUNS@HON.M".ts_append_eval %Q|"WH_TTUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "WH_FINNS@HI.M".ts_append_eval %Q|"WH_FINNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
    "ERTFDGSNS@HI.M".ts_append_eval %Q|"ERTFDGSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
    "ECTNS&@HON.M".ts_append_eval %Q|"ECTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EFIDPNS&@HI.M".ts_append_eval %Q|"EFIDPNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EFINS&@HI.M".ts_append_eval %Q|"EFINS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EGVFDNS&@HI.M".ts_append_eval %Q|"EGVFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EGVFDOTNS&@HI.M".ts_append_eval %Q|"EGVFDOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EGVLCNS&@HI.M".ts_append_eval %Q|"EGVLCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
    "EGVLCNS&@MAU.M".ts_append_eval %Q|"EGVLCNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
     "EGVNS&@HI.M".ts_append_eval %Q|"EGVNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EGVNS&@MAU.M".ts_append_eval %Q|"EGVNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
     "EGVSTNS&@HI.M".ts_append_eval %Q|"EGVSTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EGVSTNS&@MAU.M".ts_append_eval %Q|"EGVSTNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
     "EMNDROTNS&@HI.M".ts_append_eval %Q|"EMNDROTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNDRSTNS&@HI.M".ts_append_eval %Q|"EMNDRSTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNDRWDNS&@HI.M".ts_append_eval %Q|"EMNDRWDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNDRWDNS&@HON.M".ts_append_eval %Q|"EMNDRWDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNNDFDNS&@HI.M".ts_append_eval %Q|"EMNNDFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNNDFDNS&@HON.M".ts_append_eval %Q|"EMNNDFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNNDFDSNS&@HON.M".ts_append_eval %Q|"EMNNDFDSNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNNDOTNS&@HON.M".ts_append_eval %Q|"EMNNDOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMNNDPRNS&@HON.M".ts_append_eval %Q|"EMNNDPRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "EMPLNS&@MAU.M".ts_append_eval %Q|"EMPLNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ENS&@HI.M".ts_append_eval %Q|"ENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ENS&@HON.M".ts_append_eval %Q|"ENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ENS&@KAU.M".ts_append_eval %Q|"ENS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ENS&@MAU.M".ts_append_eval %Q|"ENS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ERTCLNS&@HI.M".ts_append_eval %Q|"ERTCLNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ERTCLNS&@HON.M".ts_append_eval %Q|"ERTCLNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ERTGMNS&@HON.M".ts_append_eval %Q|"ERTGMNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVACNS&@HI.M".ts_append_eval %Q|"ESVACNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVBSNS&@HI.M".ts_append_eval %Q|"ESVBSNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVENNS&@HON.M".ts_append_eval %Q|"ESVENNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVENNS&@KAU.M".ts_append_eval %Q|"ESVENNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVENNS&@MAU.M".ts_append_eval %Q|"ESVENNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVHCNS&@HI.M".ts_append_eval %Q|"ESVHCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVHCOTNS&@HI.M".ts_append_eval %Q|"ESVHCOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ESVNS&@HI.M".ts_append_eval %Q|"ESVNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUNS&@HI.M".ts_append_eval %Q|"ETUCUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUNS&@HON.M".ts_append_eval %Q|"ETUCUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUNS&@KAU.M".ts_append_eval %Q|"ETUCUNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUNS&@MAU.M".ts_append_eval %Q|"ETUCUNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUUTNS&@HI.M".ts_append_eval %Q|"ETUCUUTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUCUUTNS&@HON.M".ts_append_eval %Q|"ETUCUUTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUTWOTNS&@HI.M".ts_append_eval %Q|"ETUTWOTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUTWOTNS&@HON.M".ts_append_eval %Q|"ETUTWOTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUTWTANS&@HI.M".ts_append_eval %Q|"ETUTWTANS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "ETUTWTANS&@HON.M".ts_append_eval %Q|"ETUTWTANS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_GDSNS&@HI.M".ts_append_eval %Q|"E_GDSNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_GDSNS&@HON.M".ts_append_eval %Q|"E_GDSNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_GVFDDFNS&@HON.M".ts_append_eval %Q|"E_GVFDDFNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_GVFDNDNS&@HON.M".ts_append_eval %Q|"E_GVFDNDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_NFNS&@HAW.M".ts_append_eval %Q|"E_NFNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_NFNS&@HI.M".ts_append_eval %Q|"E_NFNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_NFNS&@HON.M".ts_append_eval %Q|"E_NFNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_NFNS&@KAU.M".ts_append_eval %Q|"E_NFNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "E_NFNS&@MAU.M".ts_append_eval %Q|"E_NFNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRCTNS&@HI.M".ts_append_eval %Q|"HRCTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRCTNS&@HON.M".ts_append_eval %Q|"HRCTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDFDNS&@HI.M".ts_append_eval %Q|"HRMNNDFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDFDNS&@HON.M".ts_append_eval %Q|"HRMNNDFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDPRNS&@HI.M".ts_append_eval %Q|"HRMNNDPRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDPRNS&@HON.M".ts_append_eval %Q|"HRMNNDPRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDTXNS&@HI.M".ts_append_eval %Q|"HRMNNDTXNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
     "HRMNNDTXNS&@HON.M".ts_append_eval %Q|"HRMNNDTXNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRMNNS&@HI.M".ts_append_eval %Q|"HRMNNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRMNNS&@HON.M".ts_append_eval %Q|"HRMNNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRRT$FDNS&@HON.M".ts_append_eval %Q|"HRRT$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRSVACLCNS&@HON.M".ts_append_eval %Q|"HRSVACLCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRSVACNS&@HI.M".ts_append_eval %Q|"HRSVACNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRSVACNS&@HON.M".ts_append_eval %Q|"HRSVACNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "YTRNSF@KAU.A".ts_append_eval %Q|"YTRNSF@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
     "YTRNSF@KAU.A".ts_append_eval %Q|"YTRNSF@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
     "YLGVFD@KAU.A".ts_append_eval %Q|"YLGVFD@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
     "YLGVFD@KAU.A".ts_append_eval %Q|"YLGVFD@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
     "YLGVML@KAU.A".ts_append_eval %Q|"YLGVML@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
     "YLGVML@KAU.A".ts_append_eval %Q|"YLGVML@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
     "YLPMNTB&@HI.A".ts_append_eval %Q|"YLPMNTB&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "HRTUCUNS&@HI.M".ts_append_eval %Q|"HRTUCUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRTUCUNS&@HON.M".ts_append_eval %Q|"HRTUCUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRWTNS&@HI.M".ts_append_eval %Q|"HRWTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HRWTNS&@HON.M".ts_append_eval %Q|"HRWTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HR_TR$FDNS&@HI.M".ts_append_eval %Q|"HR_TR$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HR_TR$FDNS&@HON.M".ts_append_eval %Q|"HR_TR$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HR_TRADENS&@HI.M".ts_append_eval %Q|"HR_TRADENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "HR_TRADENS&@HON.M".ts_append_eval %Q|"HR_TRADENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "LFNS&@HAW.M".ts_append_eval %Q|"LFNS&@HAW.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "LFNS&@HI.M".ts_append_eval %Q|"LFNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "LFNS&@HON.M".ts_append_eval %Q|"LFNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "LFNS&@KAU.M".ts_append_eval %Q|"LFNS&@KAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "LFNS&@MAU.M".ts_append_eval %Q|"LFNS&@MAU.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWCTNS&@HI.M".ts_append_eval %Q|"PWCTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWCTNS&@HON.M".ts_append_eval %Q|"PWCTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWMNNDFDNS&@HI.M".ts_append_eval %Q|"PWMNNDFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWMNNDFDNS&@HON.M".ts_append_eval %Q|"PWMNNDFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWRTNS&@HI.M".ts_append_eval %Q|"PWRTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "PWRTNS&@HON.M".ts_append_eval %Q|"PWRTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "URNS&@HI.M".ts_append_eval %Q|"URNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "URNS&@HON.M".ts_append_eval %Q|"URNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHCTNS&@HI.M".ts_append_eval %Q|"WHCTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNDFDNS&@HI.M".ts_append_eval %Q|"WHMNNDFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNDFDNS&@HON.M".ts_append_eval %Q|"WHMNNDFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNDPRNS&@HI.M".ts_append_eval %Q|"WHMNNDPRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNDTXNS&@HI.M".ts_append_eval %Q|"WHMNNDTXNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNDTXNS&@HON.M".ts_append_eval %Q|"WHMNNDTXNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNS&@HI.M".ts_append_eval %Q|"WHMNNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHMNNS&@HON.M".ts_append_eval %Q|"WHMNNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHRT$FDNS&@HON.M".ts_append_eval %Q|"WHRT$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHRTFDNS&@HI.M".ts_append_eval %Q|"WHRTFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHRTNS&@HON.M".ts_append_eval %Q|"WHRTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHSVACLCNS&@HI.M".ts_append_eval %Q|"WHSVACLCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHSVACLCNS&@HON.M".ts_append_eval %Q|"WHSVACLCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHSVACNS&@HI.M".ts_append_eval %Q|"WHSVACNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHSVACNS&@HON.M".ts_append_eval %Q|"WHSVACNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHTUCUNS&@HI.M".ts_append_eval %Q|"WHTUCUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHTUCUNS&@HON.M".ts_append_eval %Q|"WHTUCUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WHWTNS&@HI.M".ts_append_eval %Q|"WHWTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "E_FIRNS@HAW.M".ts_append_eval %Q|"E_FIRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "E_FIRNS@HAW.M".ts_append_eval %Q|"E_FIRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EGVFDDDNS@HAW.M".ts_append_eval %Q|"EGVFDDDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "PMKBSGF@HON.M".ts_append_eval %Q|"PMKBSGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/hbr/update/hbr_upd_m.csv"|
     "YL_GVSL@KAU.A".ts_append_eval %Q|"YL_GVSL@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "KAU"|
     "YL_GVSL@KAU.A".ts_append_eval %Q|"YL_GVSL@KAU.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
     "IPNS@JP.M".ts_append_eval %Q|"IPNS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
     "IPMNNS@JP.M".ts_append_eval %Q|"IPMNNS@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
     "TKEMPS_NS@JP.Q".ts_append_eval %Q|"TKEMPS_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
     "GDP_EX_R@JP.Q".ts_append_eval %Q|"GDP_EX_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
     "TKBSCMNMNS@JP.Q".ts_append_eval %Q|"TKBSCMNMNS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
     "GDP_IFXG_R@JP.Q".ts_append_eval %Q|"GDP_IFXG_R@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
     "TKBSCAMN_NS@JP.Q".ts_append_eval %Q|"TKBSCAMN_NS@JP.Q".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_q.xls"|
     "KNNPBU@HON.M".ts_append_eval %Q|"KNNPBU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "KNNSHD@HON.M".ts_append_eval %Q|"KNNSHD@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "KNNSTR@HON.M".ts_append_eval %Q|"KNNSTR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "KNN@HON.M".ts_append_eval %Q|"KNN@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "KNASGF@HON.M".ts_append_eval %Q|"KNASGF@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "KVNGPB@HON.M".ts_append_eval %Q|"KVNGPB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/permits/update/permits_upd.xls"|
     "VRDCITNS@HON.M".ts_append_eval %Q|"VRDCITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCNS@HAW.M".ts_append_eval %Q|"VRDCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@HAW.M".ts_append_eval %Q|"VRDCITNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCNS@MAU.M".ts_append_eval %Q|"VRDCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@MAU.M".ts_append_eval %Q|"VRDCITNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCNS@MAUI.M".ts_append_eval %Q|"VRDCNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCDMNS@MAUI.M".ts_append_eval %Q|"VRDCDMNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@MAUI.M".ts_append_eval %Q|"VRDCITNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@MOL.M".ts_append_eval %Q|"VRDCITNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCNS@LAN.M".ts_append_eval %Q|"VRDCNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCDMNS@LAN.M".ts_append_eval %Q|"VRDCDMNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@LAN.M".ts_append_eval %Q|"VRDCITNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VRDCITNS@KAU.M".ts_append_eval %Q|"VRDCITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAHTNS@HI.M".ts_append_eval %Q|"VAHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAHTOLNS@HI.M".ts_append_eval %Q|"VAHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACNNS@HI.M".ts_append_eval %Q|"VACNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITTSNS@HI.M".ts_append_eval %Q|"VAITTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "YLPTRAT&@HI.A".ts_append_eval %Q|"YLPTRAT&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "YLPTRAP&@HI.A".ts_append_eval %Q|"YLPTRAP&@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "YLPMDFB&@KAU.A".ts_append_eval %Q|"YLPMDFB&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "YLPMDMV&@KAU.A".ts_append_eval %Q|"YLPMDMV&@KAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "ERTNS@HAW.M".ts_append_eval %Q|"ERTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "E_EDHCNS@HAW.M".ts_append_eval %Q|"E_EDHCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "E_LHNS@HAW.M".ts_append_eval %Q|"E_LHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EIFNS@KAU.M".ts_append_eval %Q|"EIFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EMNDRNS@MAU.M".ts_append_eval %Q|"EMNDRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EMNNDNS@MAU.M".ts_append_eval %Q|"EMNNDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EMNDRNS@HAW.M".ts_append_eval %Q|"EMNDRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "ETWTANS@HAW.M".ts_append_eval %Q|"ETWTANS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "UICNS@KONA.W".ts_append_eval %Q|"UICNS@KONA.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@HAW.W".ts_append_eval %Q|"UICNS@HAW.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@WLKU.W".ts_append_eval %Q|"UICNS@WLKU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@MOLK.W".ts_append_eval %Q|"UICNS@MOLK.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@MAU.W".ts_append_eval %Q|"UICNS@MAU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@KAU.W".ts_append_eval %Q|"UICNS@KAU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@OT.W".ts_append_eval %Q|"UICNS@OT.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@HI.W".ts_append_eval %Q|"UICNS@HI.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "VISUSWNS@HON.M".ts_append_eval %Q|"VISUSWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISJPNS@LAN.M".ts_append_eval %Q|"VISJPNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSWNS@MAU.M".ts_append_eval %Q|"VISUSWNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "KVTAPT@KAU.A".ts_append_eval %Q|"KVTAPT@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
     "ROMISNS@KAU.A".ts_append_eval %Q|"ROMISNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
     "WHWTNS&@HON.M".ts_append_eval %Q|"WHWTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WH_TR$FDNS&@HI.M".ts_append_eval %Q|"WH_TR$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WH_TR$FDNS&@HON.M".ts_append_eval %Q|"WH_TR$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WH_TRADENS&@HI.M".ts_append_eval %Q|"WH_TRADENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WH_TRADENS&@HON.M".ts_append_eval %Q|"WH_TRADENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWCTNS&@HI.M".ts_append_eval %Q|"WWCTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWCTNS&@HON.M".ts_append_eval %Q|"WWCTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWFIDPNS&@HI.M".ts_append_eval %Q|"WWFIDPNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWFIDPNS&@HON.M".ts_append_eval %Q|"WWFIDPNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDFDNS&@HI.M".ts_append_eval %Q|"WWMNNDFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDFDNS&@HON.M".ts_append_eval %Q|"WWMNNDFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDPRNS&@HI.M".ts_append_eval %Q|"WWMNNDPRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDPRNS&@HON.M".ts_append_eval %Q|"WWMNNDPRNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDTXNS&@HI.M".ts_append_eval %Q|"WWMNNDTXNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNDTXNS&@HON.M".ts_append_eval %Q|"WWMNNDTXNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNS&@HI.M".ts_append_eval %Q|"WWMNNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWMNNS&@HON.M".ts_append_eval %Q|"WWMNNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRT$FDNS&@HI.M".ts_append_eval %Q|"WWRT$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRT$FDNS&@HON.M".ts_append_eval %Q|"WWRT$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRTFDNS&@HI.M".ts_append_eval %Q|"WWRTFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRTFDNS&@HON.M".ts_append_eval %Q|"WWRTFDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRTNS&@HI.M".ts_append_eval %Q|"WWRTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWRTNS&@HON.M".ts_append_eval %Q|"WWRTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWSVACLCNS&@HI.M".ts_append_eval %Q|"WWSVACLCNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWSVACLCNS&@HON.M".ts_append_eval %Q|"WWSVACLCNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWSVACNS&@HI.M".ts_append_eval %Q|"WWSVACNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWSVACNS&@HON.M".ts_append_eval %Q|"WWSVACNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWTUCUNS&@HI.M".ts_append_eval %Q|"WWTUCUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWTUCUNS&@HON.M".ts_append_eval %Q|"WWTUCUNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWWTNS&@HI.M".ts_append_eval %Q|"WWWTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WWWTNS&@HON.M".ts_append_eval %Q|"WWWTNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WW_TR$FDNS&@HI.M".ts_append_eval %Q|"WW_TR$FDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WW_TR$FDNS&@HON.M".ts_append_eval %Q|"WW_TR$FDNS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WW_TRADENS&@HI.M".ts_append_eval %Q|"WW_TRADENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "WW_TRADENS&@HON.M".ts_append_eval %Q|"WW_TRADENS&@HON.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA2.xls"|
     "KPPRVADDNS@HAW.M".ts_append_eval %Q|"KPPRVADDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVCOMNS@HI.M".ts_append_eval %Q|"KPPRVCOMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVRSDNS@HAW.M".ts_append_eval %Q|"KPPRVRSDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVNS@HI.M".ts_append_eval %Q|"KPPRVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVNS@HON.M".ts_append_eval %Q|"KPPRVNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVRSDNS@HI.M".ts_append_eval %Q|"KPPRVRSDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
     "KPPRVRSDNS@HI.M".ts_append_eval %Q|"KPPRVRSDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVNS@HAW.M".ts_append_eval %Q|"KPPRVNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "PICTSGFNS@US.M".ts_append_eval %Q|"PICTSGFNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVADDNS@HI.M".ts_append_eval %Q|"KPPRVADDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "KPPRVCOMNS@KAU.M".ts_append_eval %Q|"KPPRVCOMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
     "ECTNS@HI.M".ts_append_eval %Q|"ECTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "ECTNS@HI.M".ts_append_eval %Q|"ECTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "E_TUNS@HI.M".ts_append_eval %Q|"E_TUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "E_TUNS@HI.M".ts_append_eval %Q|"E_TUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EUTNS@HI.M".ts_append_eval %Q|"EUTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "ETWTANS@HI.M".ts_append_eval %Q|"ETWTANS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EIFTCNS@HI.M".ts_append_eval %Q|"EIFTCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "ERENS@HI.M".ts_append_eval %Q|"ERENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "ERENS@HI.M".ts_append_eval %Q|"ERENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "E_PBSNS@HI.M".ts_append_eval %Q|"E_PBSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "E_EDHCNS@HI.M".ts_append_eval %Q|"E_EDHCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EEDNS@HI.M".ts_append_eval %Q|"EEDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EHCAMNS@HI.M".ts_append_eval %Q|"EHCAMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EAENS@HI.M".ts_append_eval %Q|"EAENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EAFNS@HI.M".ts_append_eval %Q|"EAFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFNS@HI.M".ts_append_eval %Q|"EAFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EAFACNS@HI.M".ts_append_eval %Q|"EAFACNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFACNS@HI.M".ts_append_eval %Q|"EAFACNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EAFFDNS@HI.M".ts_append_eval %Q|"EAFFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFFDNS@HI.M".ts_append_eval %Q|"EAFFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EOSNS@HI.M".ts_append_eval %Q|"EOSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EGVFDNS@HI.M".ts_append_eval %Q|"EGVFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EGVFDNS@HI.M".ts_append_eval %Q|"EGVFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "E_NFNS@HON.M".ts_append_eval %Q|"E_NFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "ECTNS@HON.M".ts_append_eval %Q|"ECTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "ECTNS@HON.M".ts_append_eval %Q|"ECTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EIFTCNS@HON.M".ts_append_eval %Q|"EIFTCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "E_PBSNS@HON.M".ts_append_eval %Q|"E_PBSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EADNS@HON.M".ts_append_eval %Q|"EADNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "E_EDHCNS@HON.M".ts_append_eval %Q|"E_EDHCNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EHCHONS@HON.M".ts_append_eval %Q|"EHCHONS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "E_LHNS@HON.M".ts_append_eval %Q|"E_LHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EAFACNS@HON.M".ts_append_eval %Q|"EAFACNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFACNS@HON.M".ts_append_eval %Q|"EAFACNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EAFFDNS@HON.M".ts_append_eval %Q|"EAFFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFFDNS@HON.M".ts_append_eval %Q|"EAFFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EOSNS@HON.M".ts_append_eval %Q|"EOSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "EGVSTEDNS@HON.M".ts_append_eval %Q|"EGVSTEDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "ECTNS@HAW.M".ts_append_eval %Q|"ECTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "ECTNS@HAW.M".ts_append_eval %Q|"ECTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "ECTNS@KAU.M".ts_append_eval %Q|"ECTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "ECTNS@KAU.M".ts_append_eval %Q|"ECTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "EAFNS@MAU.M".ts_append_eval %Q|"EAFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
     "EAFNS@MAU.M".ts_append_eval %Q|"EAFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
     "YXR@JP.M".ts_append_eval %Q|"YXR@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
     "R@JP.M".ts_append_eval %Q|"R@JP.M".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_m.xls"|
     "VACNOLNS@HI.M".ts_append_eval %Q|"VACNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VATSNS@HI.M".ts_append_eval %Q|"VATSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VATSOLNS@HI.M".ts_append_eval %Q|"VATSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRNS@HI.M".ts_append_eval %Q|"VACRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAFRNS@HI.M".ts_append_eval %Q|"VAFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VABBNS@HI.M".ts_append_eval %Q|"VABBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAOTNS@HI.M".ts_append_eval %Q|"VAOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMHTNS@HI.M".ts_append_eval %Q|"VADMHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMHTOLNS@HI.M".ts_append_eval %Q|"VADMHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMCNNS@HI.M".ts_append_eval %Q|"VADMCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMCNOLNS@HI.M".ts_append_eval %Q|"VADMCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMTSNS@HI.M".ts_append_eval %Q|"VADMTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMTSOLNS@HI.M".ts_append_eval %Q|"VADMTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMBBNS@HI.M".ts_append_eval %Q|"VADMBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VADMOTNS@HI.M".ts_append_eval %Q|"VADMOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITHTNS@HI.M".ts_append_eval %Q|"VAITHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITHTOLNS@HI.M".ts_append_eval %Q|"VAITHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITCNNS@HI.M".ts_append_eval %Q|"VAITCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITCNOLNS@HI.M".ts_append_eval %Q|"VAITCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITTSOLNS@HI.M".ts_append_eval %Q|"VAITTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITCRNS@HI.M".ts_append_eval %Q|"VAITCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAITFRNS@HI.M".ts_append_eval %Q|"VAITFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWHTNS@HI.M".ts_append_eval %Q|"VAUSWHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWHTOLNS@HI.M".ts_append_eval %Q|"VAUSWHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWCNNS@HI.M".ts_append_eval %Q|"VAUSWCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWCNOLNS@HI.M".ts_append_eval %Q|"VAUSWCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWTSNS@HI.M".ts_append_eval %Q|"VAUSWTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWTSOLNS@HI.M".ts_append_eval %Q|"VAUSWTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWFRNS@HI.M".ts_append_eval %Q|"VAUSWFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSWBBNS@HI.M".ts_append_eval %Q|"VAUSWBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSEHTOLNS@HI.M".ts_append_eval %Q|"VAUSEHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSECNNS@HI.M".ts_append_eval %Q|"VAUSECNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSECNOLNS@HI.M".ts_append_eval %Q|"VAUSECNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSETSNS@HI.M".ts_append_eval %Q|"VAUSETSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSETSOLNS@HI.M".ts_append_eval %Q|"VAUSETSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSECRNS@HI.M".ts_append_eval %Q|"VAUSECRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSEFRNS@HI.M".ts_append_eval %Q|"VAUSEFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSEBBNS@HI.M".ts_append_eval %Q|"VAUSEBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAUSEOTNS@HI.M".ts_append_eval %Q|"VAUSEOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPHTNS@HI.M".ts_append_eval %Q|"VAJPHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPHTOLNS@HI.M".ts_append_eval %Q|"VAJPHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPCNNS@HI.M".ts_append_eval %Q|"VAJPCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPCNOLNS@HI.M".ts_append_eval %Q|"VAJPCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPTSNS@HI.M".ts_append_eval %Q|"VAJPTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPTSOLNS@HI.M".ts_append_eval %Q|"VAJPTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPCRNS@HI.M".ts_append_eval %Q|"VAJPCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPFRNS@HI.M".ts_append_eval %Q|"VAJPFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPBBNS@HI.M".ts_append_eval %Q|"VAJPBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VAJPOTNS@HI.M".ts_append_eval %Q|"VAJPOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANHTNS@HI.M".ts_append_eval %Q|"VACANHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANHTOLNS@HI.M".ts_append_eval %Q|"VACANHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANCNNS@HI.M".ts_append_eval %Q|"VACANCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANCNOLNS@HI.M".ts_append_eval %Q|"VACANCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANTSNS@HI.M".ts_append_eval %Q|"VACANTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANTSOLNS@HI.M".ts_append_eval %Q|"VACANTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANCRNS@HI.M".ts_append_eval %Q|"VACANCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANFRNS@HI.M".ts_append_eval %Q|"VACANFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANBBNS@HI.M".ts_append_eval %Q|"VACANBBNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACANOTNS@HI.M".ts_append_eval %Q|"VACANOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRHTNS@HI.M".ts_append_eval %Q|"VACRHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRHTOLNS@HI.M".ts_append_eval %Q|"VACRHTOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRCNNS@HI.M".ts_append_eval %Q|"VACRCNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRCNOLNS@HI.M".ts_append_eval %Q|"VACRCNOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRTSNS@HI.M".ts_append_eval %Q|"VACRTSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRTSOLNS@HI.M".ts_append_eval %Q|"VACRTSOLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRFRNS@HI.M".ts_append_eval %Q|"VACRFRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACROTNS@HI.M".ts_append_eval %Q|"VACROTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VACRCROLNS@HI.M".ts_append_eval %Q|"VACRCROLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "OCUP%NS@HAW.M".ts_append_eval %Q|"OCUP%NS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "PRMNS@HI.M".ts_append_eval %Q|"PRMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "PRMNS@HON.M".ts_append_eval %Q|"PRMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "PRMNS@KAU.M".ts_append_eval %Q|"PRMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "PRMNS@MAU.M".ts_append_eval %Q|"PRMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "RMRVNS@HI.M".ts_append_eval %Q|"RMRVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "RMRVNS@HAW.M".ts_append_eval %Q|"RMRVNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSNS@HI.M".ts_append_eval %Q|"VSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSSCHNS@HI.M".ts_append_eval %Q|"VSSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCHTNS@HI.M".ts_append_eval %Q|"VSCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMNS@HI.M".ts_append_eval %Q|"VSDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSESCHNS@HI.M".ts_append_eval %Q|"VSUSESCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMCHTNS@HI.M".ts_append_eval %Q|"VSDMCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITNS@HI.M".ts_append_eval %Q|"VSITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITSCHNS@HI.M".ts_append_eval %Q|"VSITSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSJPSCHNS@HI.M".ts_append_eval %Q|"VSJPSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCANSCHNS@HI.M".ts_append_eval %Q|"VSCANSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSOTASCHNS@HI.M".ts_append_eval %Q|"VSOTASCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSAUSSCHNS@HI.M".ts_append_eval %Q|"VSAUSSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSOTSCHNS@HI.M".ts_append_eval %Q|"VSOTSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITCHTNS@HI.M".ts_append_eval %Q|"VSITCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSNS@HON.M".ts_append_eval %Q|"VSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSSCHNS@HON.M".ts_append_eval %Q|"VSSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCHTNS@HON.M".ts_append_eval %Q|"VSCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMNS@HON.M".ts_append_eval %Q|"VSDMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMSCHNS@HON.M".ts_append_eval %Q|"VSDMSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSWSCHNS@HON.M".ts_append_eval %Q|"VSUSWSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSESCHNS@HON.M".ts_append_eval %Q|"VSUSESCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMCHTNS@HON.M".ts_append_eval %Q|"VSDMCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITNS@HON.M".ts_append_eval %Q|"VSITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITSCHNS@HON.M".ts_append_eval %Q|"VSITSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSJPSCHNS@HON.M".ts_append_eval %Q|"VSJPSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCANSCHNS@HON.M".ts_append_eval %Q|"VSCANSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSOTASCHNS@HON.M".ts_append_eval %Q|"VSOTASCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSAUSSCHNS@HON.M".ts_append_eval %Q|"VSAUSSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSOTSCHNS@HON.M".ts_append_eval %Q|"VSOTSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITCHTNS@HON.M".ts_append_eval %Q|"VSITCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSNS@MAU.M".ts_append_eval %Q|"VSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSSCHNS@MAU.M".ts_append_eval %Q|"VSSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCHTNS@MAU.M".ts_append_eval %Q|"VSCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMNS@MAU.M".ts_append_eval %Q|"VSDMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMSCHNS@MAU.M".ts_append_eval %Q|"VSDMSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSWSCHNS@MAU.M".ts_append_eval %Q|"VSUSWSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSESCHNS@MAU.M".ts_append_eval %Q|"VSUSESCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMCHTNS@MAU.M".ts_append_eval %Q|"VSDMCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITNS@MAU.M".ts_append_eval %Q|"VSITNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSJPSCHNS@MAU.M".ts_append_eval %Q|"VSJPSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCANSCHNS@MAU.M".ts_append_eval %Q|"VSCANSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSOTASCHNS@MAU.M".ts_append_eval %Q|"VSOTASCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSAUSSCHNS@MAU.M".ts_append_eval %Q|"VSAUSSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSNS@HAW.M".ts_append_eval %Q|"VSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSSCHNS@HAW.M".ts_append_eval %Q|"VSSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCHTNS@HAW.M".ts_append_eval %Q|"VSCHTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMNS@HAW.M".ts_append_eval %Q|"VSDMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMSCHNS@HAW.M".ts_append_eval %Q|"VSDMSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSWSCHNS@HAW.M".ts_append_eval %Q|"VSUSWSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMCHTNS@HAW.M".ts_append_eval %Q|"VSDMCHTNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITNS@HAW.M".ts_append_eval %Q|"VSITNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITSCHNS@HAW.M".ts_append_eval %Q|"VSITSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSJPSCHNS@HAW.M".ts_append_eval %Q|"VSJPSCHNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSNS@KAU.M".ts_append_eval %Q|"VSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSSCHNS@KAU.M".ts_append_eval %Q|"VSSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSCHTNS@KAU.M".ts_append_eval %Q|"VSCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMNS@KAU.M".ts_append_eval %Q|"VSDMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMSCHNS@KAU.M".ts_append_eval %Q|"VSDMSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSWSCHNS@KAU.M".ts_append_eval %Q|"VSUSWSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSUSESCHNS@KAU.M".ts_append_eval %Q|"VSUSESCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSDMCHTNS@KAU.M".ts_append_eval %Q|"VSDMCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
     "VSITNS@KAU.M".ts_append_eval %Q|"VSITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSITSCHNS@KAU.M".ts_append_eval %Q|"VSITSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSJPSCHNS@KAU.M".ts_append_eval %Q|"VSJPSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSCANSCHNS@KAU.M".ts_append_eval %Q|"VSCANSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSOTASCHNS@KAU.M".ts_append_eval %Q|"VSOTASCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSAUSSCHNS@KAU.M".ts_append_eval %Q|"VSAUSSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSOTSCHNS@KAU.M".ts_append_eval %Q|"VSOTSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSITCHTNS@KAU.M".ts_append_eval %Q|"VSITCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPFUNNS@HI.M".ts_append_eval %Q|"VPFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCNVNS@HI.M".ts_append_eval %Q|"VPCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPBUSNS@HI.M".ts_append_eval %Q|"VPBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPRELNS@HI.M".ts_append_eval %Q|"VPRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPGOVNS@HI.M".ts_append_eval %Q|"VPGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPEDUNS@HI.M".ts_append_eval %Q|"VPEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPSPTNS@HI.M".ts_append_eval %Q|"VPSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMFUNNS@HI.M".ts_append_eval %Q|"VPDMFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMCNVNS@HI.M".ts_append_eval %Q|"VPDMCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMBUSNS@HI.M".ts_append_eval %Q|"VPDMBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMRELNS@HI.M".ts_append_eval %Q|"VPDMRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMGOVNS@HI.M".ts_append_eval %Q|"VPDMGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPDMSPTNS@HI.M".ts_append_eval %Q|"VPDMSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITCNVNS@HI.M".ts_append_eval %Q|"VPITCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITBUSNS@HI.M".ts_append_eval %Q|"VPITBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITRELNS@HI.M".ts_append_eval %Q|"VPITRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITGOVNS@HI.M".ts_append_eval %Q|"VPITGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITEDUNS@HI.M".ts_append_eval %Q|"VPITEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPITSPTNS@HI.M".ts_append_eval %Q|"VPITSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWFUNNS@HI.M".ts_append_eval %Q|"VPUSWFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWCNVNS@HI.M".ts_append_eval %Q|"VPUSWCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWBUSNS@HI.M".ts_append_eval %Q|"VPUSWBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWRELNS@HI.M".ts_append_eval %Q|"VPUSWRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWGOVNS@HI.M".ts_append_eval %Q|"VPUSWGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWEDUNS@HI.M".ts_append_eval %Q|"VPUSWEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSWSPTNS@HI.M".ts_append_eval %Q|"VPUSWSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSEFUNNS@HI.M".ts_append_eval %Q|"VPUSEFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSECNVNS@HI.M".ts_append_eval %Q|"VPUSECNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSEBUSNS@HI.M".ts_append_eval %Q|"VPUSEBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSERELNS@HI.M".ts_append_eval %Q|"VPUSERELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSEGOVNS@HI.M".ts_append_eval %Q|"VPUSEGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSEEDUNS@HI.M".ts_append_eval %Q|"VPUSEEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPUSESPTNS@HI.M".ts_append_eval %Q|"VPUSESPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPFUNNS@HI.M".ts_append_eval %Q|"VPJPFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPCNVNS@HI.M".ts_append_eval %Q|"VPJPCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPBUSNS@HI.M".ts_append_eval %Q|"VPJPBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPRELNS@HI.M".ts_append_eval %Q|"VPJPRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPGOVNS@HI.M".ts_append_eval %Q|"VPJPGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPEDUNS@HI.M".ts_append_eval %Q|"VPJPEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPJPSPTNS@HI.M".ts_append_eval %Q|"VPJPSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANFUNNS@HI.M".ts_append_eval %Q|"VPCANFUNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANCNVNS@HI.M".ts_append_eval %Q|"VPCANCNVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANBUSNS@HI.M".ts_append_eval %Q|"VPCANBUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANRELNS@HI.M".ts_append_eval %Q|"VPCANRELNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANGOVNS@HI.M".ts_append_eval %Q|"VPCANGOVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANEDUNS@HI.M".ts_append_eval %Q|"VPCANEDUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VPCANSPTNS@HI.M".ts_append_eval %Q|"VPCANSPTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTFTNS@HI.M".ts_append_eval %Q|"VSTFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTRPNS@HI.M".ts_append_eval %Q|"VSTRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTNTNS@HI.M".ts_append_eval %Q|"VSTNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTGRPNS@HI.M".ts_append_eval %Q|"VSTGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTNGRNS@HI.M".ts_append_eval %Q|"VSTNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTPCKNS@HI.M".ts_append_eval %Q|"VSTPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTNPCNS@HI.M".ts_append_eval %Q|"VSTNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTINDNS@HI.M".ts_append_eval %Q|"VSTINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMFTNS@HI.M".ts_append_eval %Q|"VSTDMFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMRPNS@HI.M".ts_append_eval %Q|"VSTDMRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMNTNS@HI.M".ts_append_eval %Q|"VSTDMNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMGRPNS@HI.M".ts_append_eval %Q|"VSTDMGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMNGRNS@HI.M".ts_append_eval %Q|"VSTDMNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMPCKNS@HI.M".ts_append_eval %Q|"VSTDMPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMNPCNS@HI.M".ts_append_eval %Q|"VSTDMNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTDMINDNS@HI.M".ts_append_eval %Q|"VSTDMINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITFTNS@HI.M".ts_append_eval %Q|"VSTITFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITRPNS@HI.M".ts_append_eval %Q|"VSTITRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITNTNS@HI.M".ts_append_eval %Q|"VSTITNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITGRPNS@HI.M".ts_append_eval %Q|"VSTITGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITNGRNS@HI.M".ts_append_eval %Q|"VSTITNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITPCKNS@HI.M".ts_append_eval %Q|"VSTITPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTITNPCNS@HI.M".ts_append_eval %Q|"VSTITNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWRPNS@HI.M".ts_append_eval %Q|"VSTUSWRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWNTNS@HI.M".ts_append_eval %Q|"VSTUSWNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWGRPNS@HI.M".ts_append_eval %Q|"VSTUSWGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWNGRNS@HI.M".ts_append_eval %Q|"VSTUSWNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWPCKNS@HI.M".ts_append_eval %Q|"VSTUSWPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWNPCNS@HI.M".ts_append_eval %Q|"VSTUSWNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSWINDNS@HI.M".ts_append_eval %Q|"VSTUSWINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSEFTNS@HI.M".ts_append_eval %Q|"VSTUSEFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSERPNS@HI.M".ts_append_eval %Q|"VSTUSERPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSENTNS@HI.M".ts_append_eval %Q|"VSTUSENTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSEGRPNS@HI.M".ts_append_eval %Q|"VSTUSEGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSENGRNS@HI.M".ts_append_eval %Q|"VSTUSENGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSEPCKNS@HI.M".ts_append_eval %Q|"VSTUSEPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSENPCNS@HI.M".ts_append_eval %Q|"VSTUSENPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTUSEINDNS@HI.M".ts_append_eval %Q|"VSTUSEINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPFTNS@HI.M".ts_append_eval %Q|"VSTJPFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPRPNS@HI.M".ts_append_eval %Q|"VSTJPRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPNTNS@HI.M".ts_append_eval %Q|"VSTJPNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPGRPNS@HI.M".ts_append_eval %Q|"VSTJPGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPNGRNS@HI.M".ts_append_eval %Q|"VSTJPNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPPCKNS@HI.M".ts_append_eval %Q|"VSTJPPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPNPCNS@HI.M".ts_append_eval %Q|"VSTJPNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTJPINDNS@HI.M".ts_append_eval %Q|"VSTJPINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANFTNS@HI.M".ts_append_eval %Q|"VSTCANFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANRPNS@HI.M".ts_append_eval %Q|"VSTCANRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANNTNS@HI.M".ts_append_eval %Q|"VSTCANNTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANGRPNS@HI.M".ts_append_eval %Q|"VSTCANGRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANNGRNS@HI.M".ts_append_eval %Q|"VSTCANNGRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANPCKNS@HI.M".ts_append_eval %Q|"VSTCANPCKNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANNPCNS@HI.M".ts_append_eval %Q|"VSTCANNPCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCANINDNS@HI.M".ts_append_eval %Q|"VSTCANINDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCRFTNS@HI.M".ts_append_eval %Q|"VSTCRFTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VSTCRRPNS@HI.M".ts_append_eval %Q|"VSTCRRPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VEXPJPNS@HI.M".ts_append_eval %Q|"VEXPJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VEXPNS@LAN.M".ts_append_eval %Q|"VEXPNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "VISUSNS@HI.M".ts_append_eval %Q|"VISUSENS@HI.M".ts + "VISUSWNS@HI.M".ts|
     "VISUSNS@HI.M".ts_append_eval %Q|"VISUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
     "NTCRNS@HI.M".ts_append_eval %Q|"NTCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSWDMNS@HI.M".ts_append_eval %Q|"VISUSWDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSWITNS@HI.M".ts_append_eval %Q|"VISUSWITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSEDMNS@HI.M".ts_append_eval %Q|"VISUSEDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSEITNS@HI.M".ts_append_eval %Q|"VISUSEITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISJPDMNS@HI.M".ts_append_eval %Q|"VISJPDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISJPITNS@HI.M".ts_append_eval %Q|"VISJPITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCANDMNS@HI.M".ts_append_eval %Q|"VISCANDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCANITNS@HI.M".ts_append_eval %Q|"VISCANITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSDMNS@HI.M".ts_append_eval %Q|"VISUSDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMPCFNS@HI.M".ts_append_eval %Q|"VISDMPCFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMCANS@HI.M".ts_append_eval %Q|"VISDMCANS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMORNS@HI.M".ts_append_eval %Q|"VISDMORNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMWANS@HI.M".ts_append_eval %Q|"VISDMWANS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMMTNNS@HI.M".ts_append_eval %Q|"VISDMMTNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMWNCNS@HI.M".ts_append_eval %Q|"VISDMWNCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMWSCNS@HI.M".ts_append_eval %Q|"VISDMWSCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMTXNS@HI.M".ts_append_eval %Q|"VISDMTXNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMMATNS@HI.M".ts_append_eval %Q|"VISDMMATNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMNJNS@HI.M".ts_append_eval %Q|"VISDMNJNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMNYNS@HI.M".ts_append_eval %Q|"VISDMNYNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMSATNS@HI.M".ts_append_eval %Q|"VISDMSATNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMEURNS@HI.M".ts_append_eval %Q|"VISDMEURNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISI1NS@HI.M".ts_append_eval %Q|"VISI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISIMNS@HI.M".ts_append_eval %Q|"VISIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVNS@HI.M".ts_append_eval %Q|"NAIVNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMI1NS@HI.M".ts_append_eval %Q|"VISDMI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMIMNS@HI.M".ts_append_eval %Q|"VISDMIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVDMNS@HI.M".ts_append_eval %Q|"NAIVDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISITI1NS@HI.M".ts_append_eval %Q|"VISITI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISITIMNS@HI.M".ts_append_eval %Q|"VISITIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVITNS@HI.M".ts_append_eval %Q|"NAIVITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSWI1NS@HI.M".ts_append_eval %Q|"VISUSWI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSWIMNS@HI.M".ts_append_eval %Q|"VISUSWIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVUSWNS@HI.M".ts_append_eval %Q|"NAIVUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSEI1NS@HI.M".ts_append_eval %Q|"VISUSEI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSEIMNS@HI.M".ts_append_eval %Q|"VISUSEIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVUSENS@HI.M".ts_append_eval %Q|"NAIVUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISJPI1NS@HI.M".ts_append_eval %Q|"VISJPI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISJPIMNS@HI.M".ts_append_eval %Q|"VISJPIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVJPNS@HI.M".ts_append_eval %Q|"NAIVJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCANI1NS@HI.M".ts_append_eval %Q|"VISCANI1NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCANIMNS@HI.M".ts_append_eval %Q|"VISCANIMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "NAIVCANNS@HI.M".ts_append_eval %Q|"NAIVCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMNS@HON.M".ts_append_eval %Q|"VISDMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCANNS@HAW.M".ts_append_eval %Q|"VISCANNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISDMNS@MAU.M".ts_append_eval %Q|"VISDMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCRNS@MAU.M".ts_append_eval %Q|"VISCRNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISITNS@KAU.M".ts_append_eval %Q|"VISITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISUSENS@KAU.M".ts_append_eval %Q|"VISUSENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYUSWNS@HI.M".ts_append_eval %Q|"VDAYUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYCRNS@HI.M".ts_append_eval %Q|"VDAYCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYUSWNS@HON.M".ts_append_eval %Q|"VDAYUSWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYCANNS@HON.M".ts_append_eval %Q|"VDAYCANNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYJPNS@MAUI.M".ts_append_eval %Q|"VDAYJPNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VDAYCANNS@LAN.M".ts_append_eval %Q|"VDAYCANNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSNS@HI.M".ts_append_eval %Q|"VRLSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@HI.M".ts_append_eval %Q|"VRLSDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@HI.M".ts_append_eval %Q|"VRLSITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@HI.M".ts_append_eval %Q|"VRLSUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@HI.M".ts_append_eval %Q|"VRLSUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSJPNS@HI.M".ts_append_eval %Q|"VRLSJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSCANNS@HI.M".ts_append_eval %Q|"VRLSCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSOTNS@HI.M".ts_append_eval %Q|"VRLSOTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VLOSCRNS@HI.M".ts_append_eval %Q|"VLOSCRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VLOSCRBFNS@HI.M".ts_append_eval %Q|"VLOSCRBFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VLOSCRDRNS@HI.M".ts_append_eval %Q|"VLOSCRDRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VLOSCRAFNS@HI.M".ts_append_eval %Q|"VLOSCRAFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@HON.M".ts_append_eval %Q|"VRLSDMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@HON.M".ts_append_eval %Q|"VRLSITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@HON.M".ts_append_eval %Q|"VRLSUSWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@HON.M".ts_append_eval %Q|"VRLSUSENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSJPNS@HON.M".ts_append_eval %Q|"VRLSJPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSCANNS@HON.M".ts_append_eval %Q|"VRLSCANNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@HAW.M".ts_append_eval %Q|"VRLSDMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@HAW.M".ts_append_eval %Q|"VRLSITNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@HAW.M".ts_append_eval %Q|"VRLSUSWNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@HAW.M".ts_append_eval %Q|"VRLSUSENS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@MAUI.M".ts_append_eval %Q|"VRLSDMNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@MAUI.M".ts_append_eval %Q|"VRLSITNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@MAUI.M".ts_append_eval %Q|"VRLSUSWNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@MAUI.M".ts_append_eval %Q|"VRLSUSENS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSCANNS@MAUI.M".ts_append_eval %Q|"VRLSCANNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSNS@MOL.M".ts_append_eval %Q|"VRLSNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@MOL.M".ts_append_eval %Q|"VRLSDMNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@MOL.M".ts_append_eval %Q|"VRLSITNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@MOL.M".ts_append_eval %Q|"VRLSUSWNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@MOL.M".ts_append_eval %Q|"VRLSUSENS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSJPNS@MOL.M".ts_append_eval %Q|"VRLSJPNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSCANNS@MOL.M".ts_append_eval %Q|"VRLSCANNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@LAN.M".ts_append_eval %Q|"VRLSDMNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSITNS@LAN.M".ts_append_eval %Q|"VRLSITNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSWNS@LAN.M".ts_append_eval %Q|"VRLSUSWNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSUSENS@LAN.M".ts_append_eval %Q|"VRLSUSENS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSJPNS@LAN.M".ts_append_eval %Q|"VRLSJPNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSCANNS@LAN.M".ts_append_eval %Q|"VRLSCANNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSNS@KAU.M".ts_append_eval %Q|"VRLSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VRLSDMNS@KAU.M".ts_append_eval %Q|"VRLSDMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "E_LHNS@US.M".ts_append_eval %Q|"E_LHNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMPLNS@CA.M".ts_append_eval %Q|"EMPLNS@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMNDRNS@US.M".ts_append_eval %Q|"EMNDRNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EHCNS@US.M".ts_append_eval %Q|"EHCNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGV@US.M".ts_append_eval %Q|"EGV@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMPLNS@US.M".ts_append_eval %Q|"EMPLNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_LH@US.M".ts_append_eval %Q|"E_LH@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVLC@US.M".ts_append_eval %Q|"EGVLC@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAFNS@US.M".ts_append_eval %Q|"EAFNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_PBS@US.M".ts_append_eval %Q|"E_PBS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_NFNS@US.M".ts_append_eval %Q|"E_NFNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EEDNS@US.M".ts_append_eval %Q|"EEDNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YPCDPI_R@US.M".ts_append_eval %Q|"YPCDPI_R@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "UR@CA.M".ts_append_eval %Q|"UR@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "RAAANS@US.M".ts_append_eval %Q|"RAAANS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "M2@US.M".ts_append_eval %Q|"M2@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "LF@US.M".ts_append_eval %Q|"LF@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_SVCPRNS@US.M".ts_append_eval %Q|"E_SVCPRNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_PRNS@US.M".ts_append_eval %Q|"E_PRNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_GDSPRNS@US.M".ts_append_eval %Q|"E_GDSPRNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVST@US.M".ts_append_eval %Q|"EGVST@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_EDHCNS@US.M".ts_append_eval %Q|"E_EDHCNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVFD@US.M".ts_append_eval %Q|"EGVFD@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "UR@US.M".ts_append_eval %Q|"UR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_PBSNS@US.M".ts_append_eval %Q|"E_PBSNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_FIRNS@US.M".ts_append_eval %Q|"E_FIRNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "CPI@US.M".ts_append_eval %Q|"CPI@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_EDHC@US.M".ts_append_eval %Q|"E_EDHC@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "RILGFCY10@US.M".ts_append_eval %Q|"RILGFCY10@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "PCE@US.M".ts_append_eval %Q|"PCE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_PR@US.M".ts_append_eval %Q|"E_PR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVFDNS@US.M".ts_append_eval %Q|"EGVFDNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EXUSEU@US.M".ts_append_eval %Q|"EXUSEU@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMA@US.M".ts_append_eval %Q|"EMA@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMN@US.M".ts_append_eval %Q|"EMN@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YDPI_R@US.M".ts_append_eval %Q|"YDPI_R@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "M2NS@US.M".ts_append_eval %Q|"M2NS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMNNDNS@US.M".ts_append_eval %Q|"EMNNDNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVSTNS@US.M".ts_append_eval %Q|"EGVSTNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EPSNS@US.M".ts_append_eval %Q|"EPSNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ERENS@US.M".ts_append_eval %Q|"ERENS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "UMCSENT@US.M".ts_append_eval %Q|"UMCSENT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "PCECORE@US.M".ts_append_eval %Q|"PCECORE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_GDSPR@US.M".ts_append_eval %Q|"E_GDSPR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ETWNS@US.M".ts_append_eval %Q|"ETWNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVLCNS@US.M".ts_append_eval %Q|"EGVLCNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ENF@CA.M".ts_append_eval %Q|"ENF@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "Y@US.M".ts_append_eval %Q|"Y@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_TTU@US.M".ts_append_eval %Q|"E_TTU@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "CPINS@US.M".ts_append_eval %Q|"CPINS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ERTNS@US.M".ts_append_eval %Q|"ERTNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EOSNS@US.M".ts_append_eval %Q|"EOSNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EUT@US.M".ts_append_eval %Q|"EUT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ERE@US.M".ts_append_eval %Q|"ERE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EGVNS@US.M".ts_append_eval %Q|"EGVNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YCE@US.M".ts_append_eval %Q|"YCE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAFAC@US.M".ts_append_eval %Q|"EAFAC@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMINS@US.M".ts_append_eval %Q|"EMINS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAD@US.M".ts_append_eval %Q|"EAD@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAFACNS@US.M".ts_append_eval %Q|"EAFACNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YLPTR&@MAU.A".ts_append_eval %Q|"YLPTR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
     "EED@US.M".ts_append_eval %Q|"EED@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ERT@US.M".ts_append_eval %Q|"ERT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_FIR@US.M".ts_append_eval %Q|"E_FIR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EFINS@US.M".ts_append_eval %Q|"EFINS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YPCDPI@US.M".ts_append_eval %Q|"YPCDPI@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "URNS@US.M".ts_append_eval %Q|"URNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "URNS@CA.M".ts_append_eval %Q|"URNS@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "LFNS@US.M".ts_append_eval %Q|"LFNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EIF@US.M".ts_append_eval %Q|"EIF@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMNNS@US.M".ts_append_eval %Q|"EMNNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAENS@US.M".ts_append_eval %Q|"EAENS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_SVCPR@US.M".ts_append_eval %Q|"E_SVCPR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EOS@US.M".ts_append_eval %Q|"EOS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EFI@US.M".ts_append_eval %Q|"EFI@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMNDR@US.M".ts_append_eval %Q|"EMNDR@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EWTNS@US.M".ts_append_eval %Q|"EWTNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EAFFD@US.M".ts_append_eval %Q|"EAFFD@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ECTNS@US.M".ts_append_eval %Q|"ECTNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EUTNS@US.M".ts_append_eval %Q|"EUTNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "YDPI@US.M".ts_append_eval %Q|"YDPI@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_NF@US.M".ts_append_eval %Q|"E_NF@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMI@US.M".ts_append_eval %Q|"EMI@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EADNS@US.M".ts_append_eval %Q|"EADNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EPS@US.M".ts_append_eval %Q|"EPS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "HOUST@US.M".ts_append_eval %Q|"HOUST@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ENFNS@CA.M".ts_append_eval %Q|"ENFNS@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EWT@US.M".ts_append_eval %Q|"EWT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "E_TTUNS@US.M".ts_append_eval %Q|"E_TTUNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMPL@CA.M".ts_append_eval %Q|"EMPL@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMNND@US.M".ts_append_eval %Q|"EMNND@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EIFNS@US.M".ts_append_eval %Q|"EIFNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ETW@US.M".ts_append_eval %Q|"ETW@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "STKNS@US.M".ts_append_eval %Q|"STKNS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "LFNS@CA.M".ts_append_eval %Q|"LFNS@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "CPICORENS@US.M".ts_append_eval %Q|"CPICORENS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "ECT@US.M".ts_append_eval %Q|"ECT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "EMANS@US.M".ts_append_eval %Q|"EMANS@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
     "UICINS@HON.W".ts_append_eval %Q|"UICINS@HON.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@HILO.W".ts_append_eval %Q|"UICINS@HILO.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@KONA.W".ts_append_eval %Q|"UICINS@KONA.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@HAW.W".ts_append_eval %Q|"UICINS@HAW.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@WLKU.W".ts_append_eval %Q|"UICINS@WLKU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@MOLK.W".ts_append_eval %Q|"UICINS@MOLK.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@MAU.W".ts_append_eval %Q|"UICINS@MAU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@KAU.W".ts_append_eval %Q|"UICINS@KAU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@OT.W".ts_append_eval %Q|"UICINS@OT.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICINS@HI.W".ts_append_eval %Q|"UICINS@HI.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@HONO.W".ts_append_eval %Q|"UICNS@HONO.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@KANE.W".ts_append_eval %Q|"UICNS@KANE.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@WPHU.W".ts_append_eval %Q|"UICNS@WPHU.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@HON.W".ts_append_eval %Q|"UICNS@HON.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "UICNS@HILO.W".ts_append_eval %Q|"UICNS@HILO.W".tsn.load_from "/Volumes/UHEROwork/data/misc/uiclaims/update/uiclaims_upd.xls"|
     "LFNS@HON.M".ts_append_eval %Q|"LFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
     "PCHSSHOW@HON.Q".ts_eval= %Q|'PCHSSHOW@HON.S'.ts.interpolate :quarter, :linear|
     "VISDMNWENS@HI.M".ts_append_eval %Q|"VISDMNWENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
     "VISCAN@HI.M".ts_append_eval %Q|"VISCAN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VISUSW@HI.M".ts_append_eval %Q|"VISUSW@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VISUSE@HI.M".ts_append_eval %Q|"VISUSE@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VISCR@HI.M".ts_append_eval %Q|"VISCR@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPDUS@HI.M".ts_append_eval %Q|"VEXPPDUS@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPOT@HI.M".ts_append_eval %Q|"VEXPOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "OCUP%@HI.M".ts_append_eval %Q|"OCUP%@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "PRM@HI.M".ts_append_eval %Q|"PRM@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPTUSW@HI.M".ts_append_eval %Q|"VEXPPTUSW@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPDOT@HI.M".ts_append_eval %Q|"VEXPPDOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPUSE@HI.M".ts_append_eval %Q|"VEXPUSE@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VS@HI.M".ts_append_eval %Q|"VS@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "RMRV@HI.M".ts_append_eval %Q|"RMRV@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VDAYUSW@HI.M".ts_append_eval %Q|"VDAYUSW@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPDCAN@HI.M".ts_append_eval %Q|"VEXPPDCAN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPDJP@HI.M".ts_append_eval %Q|"VEXPPDJP@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPT@HI.M".ts_append_eval %Q|"VEXPPT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPPDUSW@HI.M".ts_append_eval %Q|"VEXPPDUSW@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPCAN@HI.M".ts_append_eval %Q|"VEXPCAN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VEXPUSW@HI.M".ts_append_eval %Q|"VEXPUSW@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
     "VDAYITNS@HON.M".ts_eval= %Q|"VISITNS@HON.M".ts * "VRLSITNS@HON.M".ts|
     "VDAYDMNS@HON.M".ts_eval= %Q|"VISDMNS@HON.M".ts * "VRLSDMNS@HON.M".ts|
     "VDAYDMNS@HAW.M".ts_eval= %Q|"VISDMNS@HAW.M".ts * "VRLSDMNS@HAW.M".ts|
     "VDAYITNS@KAU.M".ts_eval= %Q|"VISITNS@KAU.M".ts * "VRLSITNS@KAU.M".ts|
     "VRLSUSWNS@MAU.M".ts_eval= %Q|("VRLSUSWNS@MAUI.M".ts * "VISUSWNS@MAUI.M".ts + "VRLSUSWNS@MOL.M".ts * "VISUSWNS@MOL.M".ts + "VRLSUSWNS@LAN.M".ts * "VISUSWNS@LAN.M".ts) / "VISUSWNS@MAU.M".ts|
     "VDAYUSWNS@MAU.M".ts_eval= %Q|"VRLSUSWNS@MAU.M".ts * "VISUSWNS@MAU.M".ts|
     "VDAYDMNS@MAUI.M".ts_eval= %Q|"VISDMNS@MAUI.M".ts * "VRLSDMNS@MAUI.M".ts|
     "VDAYITNS@MAUI.M".ts_eval= %Q|"VISITNS@MAUI.M".ts * "VRLSITNS@MAUI.M".ts|
     "VDAYITNS@MOL.M".ts_eval= %Q|"VISITNS@MOL.M".ts * "VRLSITNS@MOL.M".ts|
     "VDAYITNS@LAN.M".ts_eval= %Q|"VISITNS@LAN.M".ts * "VRLSITNS@LAN.M".ts|
     "E_TTU@HI.M".ts_append_eval %Q|"E_TTUSA@HI.M".ts|
     "E_EDHC@HI.M".ts_append_eval %Q|"E_EDHCSA@HI.M".ts|
     "E_LH@HI.M".ts_append_eval %Q|"E_LHSA@HI.M".ts|
     "E_FIR@HI.M".ts_append_eval %Q|"E_FIRSA@HI.M".ts|
     "E_PBS@HI.M".ts_append_eval %Q|"E_PBSSA@HI.M".ts|
     "VRLSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
     "VLOSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
     "VISCRAIRNS@HON.M".ts_eval= %Q|"VISCRNS@HON.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
     "VISCRAIRNS@HAW.M".ts_eval= %Q|"VISCRNS@HAW.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
     "VISCRAIRNS@KAU.M".ts_eval= %Q|"VISCRNS@KAU.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
     "VISCRAIRNS@MAU.M".ts_eval= %Q|"VISCRNS@MAU.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
     "VDAYCRAIRNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts / "VLOSCRAIRNS@HI.M".ts|
     "VDAYCRAIRNS@HON.M".ts_eval= %Q|"VISCRAIRNS@HON.M".ts * "VLOSCRNS@HI.M".ts / 4|
     "VDAYCRAIRNS@HAW.M".ts_eval= %Q|"VISCRAIRNS@HAW.M".ts * "VLOSCRNS@HI.M".ts / 4|
     "VDAYCRAIRNS@KAU.M".ts_eval= %Q|"VISCRAIRNS@KAU.M".ts * "VLOSCRNS@HI.M".ts / 4|
     "VDAYCRAIRNS@MAU.M".ts_eval= %Q|"VISCRAIRNS@MAU.M".ts * "VLOSCRNS@HI.M".ts / 4|
     "VDAYCRBFNS@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCRBFNS@HI.M".ts|
     "VEXPPTNS@KAU.M".ts_append_eval %Q|"VEXPNS@KAU.M".ts / "VISNS@KAU.M".ts*1000|







    # getting NaN values
    "VLOSJPNS@LAN.M".ts_eval= %Q|"VDAYJPNS@LAN.M".ts / "VISJPNS@LAN.M".ts|










   "VLOSUSENS@LAN.M".ts_eval= %Q|"VDAYUSENS@LAN.M".ts / "VISUSENS@LAN.M".ts|
   "VLOSUSWNS@MAU.M".ts_eval= %Q|"VDAYUSWNS@MAU.M".ts / "VISUSWNS@MAU.M".ts|
   "VLOSDMNS@HON.M".ts_eval= %Q|"VDAYDMNS@HON.M".ts / "VISDMNS@HON.M".ts|
   "VLOSITNS@HON.M".ts_eval= %Q|"VDAYITNS@HON.M".ts / "VISITNS@HON.M".ts|
   "EMN@HI.M".ts_eval= %Q|"EMN@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/sadata.xls"|
   "EMN@HI.M".ts_eval= %Q|"EMN@HI.M".ts.apply_seasonal_adjustment :multiplicative|
   "EGV@HI.M".ts_append_eval %Q|"EGVSA@HI.M".ts|
   "EGVST@HI.M".ts_append_eval %Q|"EGVSTSA@HI.M".ts|
   "EGVLC@HI.M".ts_append_eval %Q|"EGVLCSA@HI.M".ts|
   "KRSGFNS@HI.Q".ts_append_eval %Q|"KRSGFNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "KRCONNS@HI.Q".ts_append_eval %Q|"KRCONNS@HI.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "VEXPPTNS@HI.M".ts_append_eval %Q|"VEXPNS@HI.M".ts / "VISNS@HI.M".ts*1000|
   "VEXPPTUSENS@HI.M".ts_append_eval %Q|"VEXPUSENS@HI.M".ts / "VISUSENS@HI.M".ts*1000|
   "VEXPPTCANNS@HI.M".ts_append_eval %Q|"VEXPCANNS@HI.M".ts / "VISCANNS@HI.M".ts*1000|
   "VISUSNS@LAN.M".ts_append_eval %Q|"VISUSENS@LAN.M".ts + "VISUSWNS@LAN.M".ts|
   "VISUSNS@LAN.M".ts_append_eval %Q|"VISUSNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VISUSNS@MOL.M".ts_append_eval %Q|"VISUSENS@MOL.M".ts + "VISUSWNS@MOL.M".ts|
   "VISUSNS@MOL.M".ts_append_eval %Q|"VISUSNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VEXPNS@MAU.M".ts_append_eval %Q|"VEXPNS@MAUI.M".ts + "VEXPNS@LAN.M".ts + "VEXPNS@MOL.M".ts|
   "KPPRVRSDNS@HON.M".ts_append_eval %Q|"KPPRVRSDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_hist_m.xls "|
   "KPPRVRSDNS@HON.M".ts_append_eval %Q|"KPPRVRSDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "VISNS@HAW.M".ts_append_eval %Q|"VISNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISNS@MAUI.M".ts_append_eval %Q|"VISNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYNS@HON.M".ts_eval= %Q|"VDAYDMNS@HON.M".ts + "VDAYITNS@HON.M".ts|
   "VISDM@HI.M".ts_append_eval %Q|"VISDM@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VISUS@HI.M".ts_append_eval %Q|"VISDM@HI.M".ts.apply_seasonal_adjustment :multiplicative|
   "VISUS@HI.M".ts_append_eval %Q|"VISUS@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VISUS@HI.M".ts_append_eval %Q|"VISUS@HI.M".ts.apply_seasonal_adjustment :additive|
   "KPPRVNS@MAU.M".ts_append_eval %Q|"KPPRVNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KBCON@HON.M".ts_append_eval %Q|"KBCON@HON.M".tsn.load_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls", "sadata"|
   "KBSGF@HON.M".ts_append_eval %Q|"KBSGF@HON.M".tsn.load_sa_from "/Volumes/UHEROwork/data/misc/hbr/seasadj/sadata.xls", "sadata"|
   "VISDM@HON.M".ts_eval= %Q|"VISDM@HI.M".ts.mc_ma_county_share_for("HON")|
   "VISDM@HAW.M".ts_eval= %Q|"VISDM@HI.M".ts.mc_ma_county_share_for("HAW")|
   "VISDM@MAU.M".ts_eval= %Q|"VISDM@HI.M".ts.mc_ma_county_share_for("MAU")|
   "YLPSVBS&@MAU.A".ts_append_eval %Q|"YLPSVBS&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "EED@HI.M".ts_append_eval %Q|"EEDSA@HI.M".ts|
   "VLOSITNS@KAU.M".ts_eval= %Q|"VDAYITNS@KAU.M".ts / "VISITNS@KAU.M".ts|
   "ERTFDNS&@HON.M".ts_append_eval %Q|"ERTFDNS&@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EAGNS&@HON.M".ts_append_eval %Q|"EAGNS&@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ECTNS&@HAW.M".ts_append_eval %Q|"ECTNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNS&@HAW.M".ts_append_eval %Q|"EMNNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNDRNS&@HAW.M".ts_append_eval %Q|"EMNDRNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNDNS&@HAW.M".ts_append_eval %Q|"EMNNDNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUNS&@HAW.M".ts_append_eval %Q|"ETUNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUTWNS&@HAW.M".ts_append_eval %Q|"ETUTWNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "E_TRADENS&@HAW.M".ts_append_eval %Q|"E_TRADENS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EWTNS&@HAW.M".ts_append_eval %Q|"EWTNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTNS&@HAW.M".ts_append_eval %Q|"ERTNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTFDNS&@HAW.M".ts_append_eval %Q|"ERTFDNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EFINS&@HAW.M".ts_append_eval %Q|"EFINS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVNS&@HAW.M".ts_append_eval %Q|"ESVNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVBSNS&@HAW.M".ts_append_eval %Q|"ESVBSNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVHCNS&@HAW.M".ts_append_eval %Q|"ESVHCNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVACNS&@HAW.M".ts_append_eval %Q|"ESVACNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVNS&@HAW.M".ts_append_eval %Q|"EGVNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVFDNS&@HAW.M".ts_append_eval %Q|"EGVFDNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVSTNS&@HAW.M".ts_append_eval %Q|"EGVSTNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVLCNS&@HAW.M".ts_append_eval %Q|"EGVLCNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EAGNS&@HAW.M".ts_append_eval %Q|"EAGNS&@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ECTNS&@MAU.M".ts_append_eval %Q|"ECTNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNS&@MAU.M".ts_append_eval %Q|"EMNNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNDRNS&@MAU.M".ts_append_eval %Q|"EMNDRNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNDNS&@MAU.M".ts_append_eval %Q|"EMNNDNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUNS&@MAU.M".ts_append_eval %Q|"ETUNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUTWNS&@MAU.M".ts_append_eval %Q|"ETUTWNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "E_TRADENS&@MAU.M".ts_append_eval %Q|"E_TRADENS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EWTNS&@MAU.M".ts_append_eval %Q|"EWTNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTNS&@MAU.M".ts_append_eval %Q|"ERTNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTFDNS&@MAU.M".ts_append_eval %Q|"ERTFDNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNDRNS&@KAU.M".ts_append_eval %Q|"EMNDRNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNDNS&@KAU.M".ts_append_eval %Q|"EMNNDNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EMNNS&@KAU.M".ts_append_eval %Q|"EMNNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUNS&@KAU.M".ts_append_eval %Q|"ETUNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ETUTWNS&@KAU.M".ts_append_eval %Q|"ETUTWNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "E_TRADENS&@KAU.M".ts_append_eval %Q|"E_TRADENS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EWTNS&@KAU.M".ts_append_eval %Q|"EWTNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTNS&@KAU.M".ts_append_eval %Q|"ERTNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ERTFDNS&@KAU.M".ts_append_eval %Q|"ERTFDNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EFINS&@KAU.M".ts_append_eval %Q|"EFINS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVNS&@KAU.M".ts_append_eval %Q|"ESVNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVBSNS&@KAU.M".ts_append_eval %Q|"ESVBSNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVHCNS&@KAU.M".ts_append_eval %Q|"ESVHCNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVACNS&@KAU.M".ts_append_eval %Q|"ESVACNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVNS&@KAU.M".ts_append_eval %Q|"EGVNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVFDNS&@KAU.M".ts_append_eval %Q|"EGVFDNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVSTNS&@KAU.M".ts_append_eval %Q|"EGVSTNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVLCNS&@KAU.M".ts_append_eval %Q|"EGVLCNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EAGNS&@KAU.M".ts_append_eval %Q|"EAGNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "VIS@HAW.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HAW","VIS")|



   "PC_ANNUAL@HON.M".ts_eval= %Q|"PC_ANNUAL@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "KRSGFNS_NMC@HON.Q".ts_append_eval %Q|"KRSGFNS@HON.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "KRCONNS_NMC@MAU.Q".ts_append_eval %Q|"KRCONNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "KRCONNS_NMC@KAU.Q".ts_append_eval %Q|"KRCONNS@KAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "KRCONNS_NMC@HAW.Q".ts_append_eval %Q|"KRCONNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "KRSGFNS_NMC@MAU.Q".ts_append_eval %Q|"KRSGFNS@MAU.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
    "PCFBFDAW@HON.S".ts_append_eval %Q|"PCFBFDAW@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
    "PCOT@HON.S".ts_append_eval %Q|"PCOT@HON.S".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_s.xls"|
   "VISDMNS@LAN.M".ts_append_eval %Q|"VISDMNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "LFNS@MAU.M".ts_append_eval %Q|"LFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "VISITNS@HI.M".ts_append_eval %Q|"VISITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "OCUP%NS@HON.M".ts_append_eval %Q|"OCUP%NS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "NDEAM@HI.A".ts_append_eval %Q|"NDEAM@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "VXBU@HI.A".ts_append_eval %Q|"VXBU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|
   "TGBSUNS@HON.A".ts_append_eval %Q|"TGBSUNS@HON.A".tsn.load_from "/Volumes/UHEROwork/data/tax/update/tax_hist.xls"|
   "YPCBEA@HON.A".ts_append_eval %Q|"YPCBEA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HON"|
   "YPCBEA@HON.A".ts_append_eval %Q|"YPCBEA@HON.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "GDPPC@US.A".ts_append_eval %Q|"GDPPC@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
   "GDP_CN@US.A".ts_append_eval %Q|"GDP_CN@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
   "GDP_CN_R@US.A".ts_append_eval %Q|"GDP_CN_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
   "GDPDEF@US.A".ts_append_eval %Q|"GDPDEF@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
   "NDF@HAW.A".ts_append_eval %Q|"NDF@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "N@JP.A".ts_append_eval %Q|"N@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "NDF@HI.A".ts_append_eval %Q|"NDF@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NBIR@HI.A".ts_append_eval %Q|"NBIR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDEA@HON.A".ts_append_eval %Q|"NDEA@HON.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "NDEA@MAU.A".ts_append_eval %Q|"NDEA@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/census/update/census_upd_reformatted.xls"|
   "YLPM&@HAW.A".ts_append_eval %Q|"YLPM&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMN&@HON.A".ts_append_eval %Q|"YLPMN&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVHL&@HON.A".ts_append_eval %Q|"YLPSVHL&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "TRMS@HAW.A".ts_append_eval %Q|"TRMS@HAW.A".tsn.load_from "   /Volumes/UHEROwork/data/tour/update/TRMS.xls"|
   "YLPR&@HAW.A".ts_append_eval %Q|"YLPR&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSV&@MAU.A".ts_append_eval %Q|"YLPSV&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVHL&@HAW.A".ts_append_eval %Q|"YLPSVHL&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPM&@MAU.A".ts_append_eval %Q|"YLPM&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPTR&@HON.A".ts_append_eval %Q|"YLPTR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPMD&@HAW.A".ts_append_eval %Q|"YLPMD&@HAW.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "TRMS@HI.A".ts_append_eval %Q|"TRMS@HI.A".tsn.load_from "   /Volumes/UHEROwork/data/tour/update/TRMS.xls"|
   "VISCANNS@LAN.M".ts_append_eval %Q|"VISCANNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISNS@MAU.M".ts_append_eval %Q|"VISNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISNS@HON.M".ts_append_eval %Q|"VISNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSENS@HAW.M".ts_append_eval %Q|"VDAYUSENS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYNS@HI.M".ts_append_eval %Q|"VDAYNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISDMNS@KAU.M".ts_append_eval %Q|"VISDMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISJPNS@MOL.M".ts_append_eval %Q|"VISJPNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSWNS@MOL.M".ts_append_eval %Q|"VDAYUSWNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "EMPLNS@HAW.M".ts_append_eval %Q|"EMPLNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "URNS@KAU.M".ts_append_eval %Q|"URNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "VISITNS@HAW.M".ts_append_eval %Q|"VISITNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSENS@HI.M".ts_append_eval %Q|"VDAYUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISNS@LAN.M".ts_append_eval %Q|"VISNS@LAN.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISJPNS@KAU.M".ts_append_eval %Q|"VISJPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYJPNS@HAW.M".ts_append_eval %Q|"VDAYJPNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSWNS@KAU.M".ts_append_eval %Q|"VDAYUSWNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSENS@MOL.M".ts_append_eval %Q|"VDAYUSENS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYCANNS@HI.M".ts_append_eval %Q|"VDAYCANNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "EMPLNS@HI.M".ts_append_eval %Q|"EMPLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "LFNS@HAW.M".ts_append_eval %Q|"LFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "VISJPNS@HI.M".ts_append_eval %Q|"VISJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISNS@MOL.M".ts_append_eval %Q|"VISNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSENS@HON.M".ts_append_eval %Q|"VDAYUSENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VRDCITNS@HI.M".ts_append_eval %Q|"VRDCITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VDAYJPNS@HI.M".ts_append_eval %Q|"VDAYJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VRDCUSWNS@HI.M".ts_append_eval %Q|"VRDCUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VISUSENS@MAUI.M".ts_append_eval %Q|"VISUSENS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISCANNS@MAU.M".ts_append_eval %Q|"VISCANNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "KVLSFM@KAU.A".ts_append_eval %Q|"KVLSFM@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVTIND@KAU.A".ts_append_eval %Q|"KVTIND@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVTAGR@KAU.A".ts_append_eval %Q|"KVTAGR@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVTCSV@KAU.A".ts_append_eval %Q|"KVTCSV@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVLCSV@KAU.A".ts_append_eval %Q|"KVLCSV@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVICSV@KAU.A".ts_append_eval %Q|"KVICSV@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVTHTL@KAU.A".ts_append_eval %Q|"KVTHTL@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVLHTL@KAU.A".ts_append_eval %Q|"KVLHTL@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "KVIHTL@KAU.A".ts_append_eval %Q|"KVIHTL@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "RTPSNS@KAU.A".ts_append_eval %Q|"RTPSNS@KAU.A".tsn.load_from "   /Volumes/UHEROwork/data/Kauai/update/Kauai.xls"|
   "GDP_IRSP@JP.A".ts_append_eval %Q|"GDP_IRSP@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "GDP_IM_R@JP.A".ts_append_eval %Q|"GDP_IM_R@JP.A".tsn.load_from "/Volumes/UHEROwork/data/japan/update/jp_upd_a.xls"|
   "YLAGFA@HI.A".ts_append_eval %Q|"YLAGFA@HI.A".tsn.load_from "/Volumes/UHEROwork/data/bea/update/inc_hist.xls", "HI"|
   "YLAGFA@HI.A".ts_append_eval %Q|"YLAGFA@HI.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLAGFF@HAW.A".ts_append_eval %Q|"YLAGFF@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLMI@HAW.A".ts_append_eval %Q|"YLMI@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "ECTSA@HI.M".ts_append_eval %Q|"ECTSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EAFFDRSNS@HAW.M".ts_append_eval %Q|"EAFFDRSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTCLNS@HAW.M".ts_append_eval %Q|"ERTCLNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "VISJPNS@HAW.M".ts_append_eval %Q|"VISJPNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISCANNS@HON.M".ts_append_eval %Q|"VISCANNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VRDCUSENS@HI.M".ts_append_eval %Q|"VRDCUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "VDAYCANNS@KAU.M".ts_append_eval %Q|"VDAYCANNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VISDMNS@MOL.M".ts_append_eval %Q|"VISDMNS@MOL.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYUSWNS@HAW.M".ts_append_eval %Q|"VDAYUSWNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VRDCJPNS@HI.M".ts_append_eval %Q|"VRDCJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "WHAFACNS@HON.M".ts_append_eval %Q|"WHAFACNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WWAFNS@HON.M".ts_append_eval %Q|"WWAFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WWIFNS@HON.M".ts_append_eval %Q|"WWIFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WHIFNS@HI.M".ts_append_eval %Q|"WHIFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WWMNNS@HI.M".ts_append_eval %Q|"WWMNNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WHAFFDNS@HI.M".ts_append_eval %Q|"WHAFFDNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WWAFNS@HI.M".ts_append_eval %Q|"WWAFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WHWTNS@HI.M".ts_append_eval %Q|"WHWTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "PCCMND_FB@HON.M".ts_append_eval %Q|"PCCMND_FB@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PRMNS@HAW.M".ts_append_eval %Q|"PRMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "OCUP%NS@KAU.M".ts_append_eval %Q|"OCUP%NS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd2.xls"|
   "PCCMDR@HON.M".ts_append_eval %Q|"PCCMDR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCOT@HON.M".ts_append_eval %Q|"PCOT@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "YLPRSV&@HON.A".ts_append_eval %Q|"YLPRSV&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPRCM&@HON.A".ts_append_eval %Q|"YLPRCM&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPFIRCR&@HON.A".ts_append_eval %Q|"YLPFIRCR&@HON.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "YLPSVMR&@MAU.A".ts_append_eval %Q|"YLPSVMR&@MAU.A".tsn.load_from "/Volumes/UHEROwork/data/bea/SIC/Copy_of_sic_income.xls"|
   "E_PRSVCPRNS@HAW.M".ts_append_eval %Q|"E_PRSVCPRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTCLNS@KAU.M".ts_append_eval %Q|"ERTCLNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVFDDDNS@MAU.M".ts_append_eval %Q|"EGVFDDDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "YLCT@HI.Q".ts_append_eval %Q|"YLCT@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "YLMN@HI.Q".ts_append_eval %Q|"YLMN@HI.Q".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_q_NEW.xls"|
   "PRM@HI.Q".ts_eval= %Q|"PRM@HI.M".ts.aggregate(:quarter, :average)|
   "PMKRSGFNS@HAW.Q".ts_append_eval %Q|"PMKRSGFNS@HAW.Q".tsn.load_from "/Volumes/UHEROwork/data/misc/prud/update/prud_upd.xls"|
   "YLAGFFSP@HAW.A".ts_append_eval %Q|"YLAGFFSP@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "YLRTOT@HAW.A".ts_append_eval %Q|"YLRTOT@HAW.A".tsn.load_from " /Volumes/UHEROwork/data/bea/update/inc_upd_a_NEW.xls"|
   "WHAFFDNS@HON.M".ts_append_eval %Q|"WHAFFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "WWWTNS@HI.M".ts_append_eval %Q|"WWWTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "KPPRVADDNS@KAU.M".ts_append_eval %Q|"KPPRVADDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVCOMNS@MAU.M".ts_append_eval %Q|"KPPRVCOMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVCOMNS@HON.M".ts_append_eval %Q|"KPPRVCOMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVADDNS@MAU.M".ts_append_eval %Q|"KPPRVADDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVADDNS@HON.M".ts_append_eval %Q|"KPPRVADDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVRSDNS@KAU.M".ts_append_eval %Q|"KPPRVRSDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVNS@KAU.M".ts_append_eval %Q|"KPPRVNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVCOMNS@HAW.M".ts_append_eval %Q|"KPPRVCOMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "KPPRVRSDNS@MAU.M".ts_append_eval %Q|"KPPRVRSDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/misc/const/update/const_upd_m_NEW.xls"|
   "VEXPUSWNS@HI.M".ts_append_eval %Q|"VEXPUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "IP@US.M".ts_append_eval %Q|"IP@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "CAPU@US.M".ts_append_eval %Q|"CAPU@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "POIL@US.M".ts_append_eval %Q|"POIL@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "LF@CA.M".ts_append_eval %Q|"LF@CA.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "INF@US.M".ts_append_eval %Q|"INF@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "N@US.M".ts_append_eval %Q|"N@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "YCE_R@US.M".ts_append_eval %Q|"YCE_R@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "INFCORE@US.M".ts_append_eval %Q|"INFCORE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "RFED@US.M".ts_append_eval %Q|"RFED@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "CPICORE@US.M".ts_append_eval %Q|"CPICORE@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "EMPL@US.M".ts_append_eval %Q|"EMPL@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "PCTRPR@HON.M".ts_append_eval %Q|"PCTRPR@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCCM@HON.M".ts_append_eval %Q|"PCCM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCHSFU@HON.M".ts_append_eval %Q|"PCHSFU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCTRGS@HON.M".ts_append_eval %Q|"PCTRGS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCHSFUGSU@HON.M".ts_append_eval %Q|"PCHSFUGSU@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "PCFBFDHM@HON.M".ts_append_eval %Q|"PCFBFDHM@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_cpi_upd_m.xls"|
   "EMNSA@HI.M".ts_append_eval %Q|"EMNSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "E_PBSNS@HAW.M".ts_append_eval %Q|"E_PBSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVSTEDNS@HAW.M".ts_append_eval %Q|"EGVSTEDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ETWTANS@MAU.M".ts_append_eval %Q|"ETWTANS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EIFTCNS@MAU.M".ts_append_eval %Q|"EIFTCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ECTNS&@HI.M".ts_append_eval %Q|"ECTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNS&@HI.M".ts_append_eval %Q|"EMNNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNDRNS&@HI.M".ts_append_eval %Q|"EMNDRNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EMNNDNS&@HI.M".ts_append_eval %Q|"EMNNDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUNS&@HI.M".ts_append_eval %Q|"ETUNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ETUTWNS&@HI.M".ts_append_eval %Q|"ETUTWNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "E_TRADENS&@HI.M".ts_append_eval %Q|"E_TRADENS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "EWTNS&@HI.M".ts_append_eval %Q|"EWTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ERTNS&@HI.M".ts_append_eval %Q|"ERTNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "ERTFDNS&@HI.M".ts_append_eval %Q|"ERTFDNS&@HI.M".tsn.load_from " /Volumes/UHEROwork/data/bls/SIC/DATA1.xls"|
   "VDAYNS@MAUI.M".ts_eval= %Q|"VDAYDMNS@MAUI.M".ts + "VDAYITNS@MAUI.M".ts|
   "VDAYUSNS@HON.M".ts_eval= %Q|"VDAYUSENS@HON.M".ts + "VDAYUSWNS@HON.M".ts|
   "ERT@HI.M".ts_append_eval %Q|"ERTSA@HI.M".ts|
   "EAF@HI.M".ts_append_eval %Q|"EAFSA@HI.M".ts|
   "VLOSJPNS@HI.M".ts_eval= %Q|"VDAYJPNS@HI.M".ts / "VISJPNS@HI.M".ts|
   "VLOSCANNS@HI.M".ts_eval= %Q|"VDAYCANNS@HI.M".ts / "VISCANNS@HI.M".ts|
   "VLOSUSENS@MAUI.M".ts_eval= %Q|"VDAYUSENS@MAUI.M".ts / "VISUSENS@MAUI.M".ts|
   "VLOSJPNS@MAUI.M".ts_eval= %Q|"VDAYJPNS@MAUI.M".ts / "VISJPNS@MAUI.M".ts|
   "VLOSCANNS@MAUI.M".ts_eval= %Q|"VDAYCANNS@MAUI.M".ts / "VISCANNS@MAUI.M".ts|
   "VLOSUSWNS@MOL.M".ts_eval= %Q|"VDAYUSWNS@MOL.M".ts / "VISUSWNS@MOL.M".ts|
   "VLOSUSENS@MOL.M".ts_eval= %Q|"VDAYUSENS@MOL.M".ts / "VISUSENS@MOL.M".ts|
   "VLOSJPNS@MOL.M".ts_eval= %Q|"VDAYJPNS@MOL.M".ts / "VISJPNS@MOL.M".ts|
   "VLOSCANNS@MOL.M".ts_eval= %Q|"VDAYCANNS@MOL.M".ts / "VISCANNS@MOL.M".ts|
   "VLOSUSWNS@LAN.M".ts_eval= %Q|"VDAYUSWNS@LAN.M".ts / "VISUSWNS@LAN.M".ts|
   "VLOSITNS@MOL.M".ts_eval= %Q|"VDAYITNS@MOL.M".ts / "VISITNS@MOL.M".ts|
   "VLOSITNS@LAN.M".ts_eval= %Q|"VDAYITNS@LAN.M".ts / "VISITNS@LAN.M".ts|
   "VEXPPTNS@MAU.M".ts_append_eval %Q|"VEXPNS@MAU.M".ts / "VISNS@MAU.M".ts*1000|
   "VDAYUSNS@MAUI.M".ts_eval= %Q|"VDAYUSENS@MAUI.M".ts + "VDAYUSWNS@MAUI.M".ts|
   "VDAYUSNS@LAN.M".ts_eval= %Q|"VDAYUSENS@LAN.M".ts + "VDAYUSWNS@LAN.M".ts|
   "VDAYUSNS@MOL.M".ts_eval= %Q|"VDAYUSENS@MOL.M".ts + "VDAYUSWNS@MOL.M".ts|
   "VEXPUSNS@HI.M".ts_append_eval %Q|"VEXPUSWNS@HI.M".ts + "VEXPUSENS@HI.M".ts|
   "VEXPPTUSNS@HI.M".ts_append_eval %Q|"VEXPUSNS@HI.M".ts / "VISUSNS@HI.M".ts*1000|
   "EAFACNS@HAW.M".ts_append_eval %Q|"EAFACNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFACNS@HAW.M".ts_append_eval %Q|"EAFACNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTFDNS@HAW.M".ts_append_eval %Q|"ERTFDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTGMNS@HAW.M".ts_append_eval %Q|"ERTGMNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTGMNS@MAU.M".ts_append_eval %Q|"ERTGMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EMPLSA@HI.M".ts_append_eval %Q|"EMPLSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EOSSA@HI.M".ts_append_eval %Q|"EOSSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "LFSA@HI.M".ts_append_eval %Q|"LFSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "URSA@HI.M".ts_append_eval %Q|"URSA@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "E_TTUNS@HI.M".ts_append_eval %Q|"E_TTUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TTUNS@HI.M".ts_append_eval %Q|"E_TTUNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTNS@HI.M".ts_append_eval %Q|"ERTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "E_FIRNS@HI.M".ts_append_eval %Q|"E_FIRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_FIRNS@HI.M".ts_append_eval %Q|"E_FIRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EPSNS@HI.M".ts_append_eval %Q|"EPSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EMANS@HI.M".ts_append_eval %Q|"EMANS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EADNS@HI.M".ts_append_eval %Q|"EADNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EAGNS@HI.M".ts_append_eval %Q|"EAGNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAGNS@HI.M".ts_append_eval %Q|"EAGNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_TTUNS@HON.M".ts_append_eval %Q|"E_TTUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TTUNS@HON.M".ts_append_eval %Q|"E_TTUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EWTNS@HON.M".ts_append_eval %Q|"EWTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "ERTNS@HON.M".ts_append_eval %Q|"ERTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "E_FIRNS@HON.M".ts_append_eval %Q|"E_FIRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_FIRNS@HON.M".ts_append_eval %Q|"E_FIRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERENS@HON.M".ts_append_eval %Q|"ERENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "ERENS@HON.M".ts_append_eval %Q|"ERENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EEDNS@HON.M".ts_append_eval %Q|"EEDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EAENS@HON.M".ts_append_eval %Q|"EAENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFNS@HON.M".ts_append_eval %Q|"EAFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFNS@HON.M".ts_append_eval %Q|"EAFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EGVSTNS@HON.M".ts_append_eval %Q|"EGVSTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVSTNS@HON.M".ts_append_eval %Q|"EGVSTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "E_NFNS@HAW.M".ts_append_eval %Q|"E_NFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_NFNS@HAW.M".ts_append_eval %Q|"E_NFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_PRNS@HAW.M".ts_append_eval %Q|"E_PRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_PRNS@HAW.M".ts_append_eval %Q|"E_PRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_GDSPRNS@HAW.M".ts_append_eval %Q|"E_GDSPRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_GDSPRNS@HAW.M".ts_append_eval %Q|"E_GDSPRNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EMNNS@HAW.M".ts_append_eval %Q|"EMNNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EMNNS@HAW.M".ts_append_eval %Q|"EMNNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_TUNS@HAW.M".ts_append_eval %Q|"E_TUNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TUNS@HAW.M".ts_append_eval %Q|"E_TUNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EEDNS@HAW.M".ts_append_eval %Q|"EEDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAENS@HAW.M".ts_append_eval %Q|"EAENS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_GDSPRNS@KAU.M".ts_append_eval %Q|"E_GDSPRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_GDSPRNS@KAU.M".ts_append_eval %Q|"E_GDSPRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EMNNS@KAU.M".ts_append_eval %Q|"EMNNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EMNNS@KAU.M".ts_append_eval %Q|"EMNNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EWTNS@KAU.M".ts_append_eval %Q|"EWTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTNS@KAU.M".ts_append_eval %Q|"ERTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_TUNS@KAU.M".ts_append_eval %Q|"E_TUNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TUNS@KAU.M".ts_append_eval %Q|"E_TUNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EFINS@KAU.M".ts_append_eval %Q|"EFINS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EFINS@KAU.M".ts_append_eval %Q|"EFINS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EEDNS@KAU.M".ts_append_eval %Q|"EEDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EHCNS@KAU.M".ts_append_eval %Q|"EHCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EHCNS@KAU.M".ts_append_eval %Q|"EHCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAENS@KAU.M".ts_append_eval %Q|"EAENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFNS@KAU.M".ts_append_eval %Q|"EAFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFNS@KAU.M".ts_append_eval %Q|"EAFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFACNS@KAU.M".ts_append_eval %Q|"EAFACNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFACNS@KAU.M".ts_append_eval %Q|"EAFACNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFFDNS@KAU.M".ts_append_eval %Q|"EAFFDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFFDNS@KAU.M".ts_append_eval %Q|"EAFFDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVFDNS@KAU.M".ts_append_eval %Q|"EGVFDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVFDNS@KAU.M".ts_append_eval %Q|"EGVFDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVLCNS@KAU.M".ts_append_eval %Q|"EGVLCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVLCNS@KAU.M".ts_append_eval %Q|"EGVLCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EWTNS@MAU.M".ts_append_eval %Q|"EWTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EFINS@MAU.M".ts_append_eval %Q|"EFINS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EFINS@MAU.M".ts_append_eval %Q|"EFINS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EADNS@MAU.M".ts_append_eval %Q|"EADNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|



   "EHCNS@MAU.M".ts_append_eval %Q|"EHCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EHCNS@MAU.M".ts_append_eval %Q|"EHCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFACNS@MAU.M".ts_append_eval %Q|"EAFACNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFACNS@MAU.M".ts_append_eval %Q|"EAFACNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFFDNS@MAU.M".ts_append_eval %Q|"EAFFDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAFFDNS@MAU.M".ts_append_eval %Q|"EAFFDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVNS@MAU.M".ts_append_eval %Q|"EGVNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVNS@MAU.M".ts_append_eval %Q|"EGVNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVFDNS@MAU.M".ts_append_eval %Q|"EGVFDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVFDNS@MAU.M".ts_append_eval %Q|"EGVFDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVLCNS@MAU.M".ts_append_eval %Q|"EGVLCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EGVLCNS@MAU.M".ts_append_eval %Q|"EGVLCNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAGNS@MAU.M".ts_append_eval %Q|"EAGNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EAGNS@MAU.M".ts_append_eval %Q|"EAGNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EMNDRNS@HI.M".ts_append_eval %Q|"EMNDRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_PRSVCPRNS@HI.M".ts_append_eval %Q|"E_PRSVCPRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EHCNS@HI.M".ts_append_eval %Q|"EHCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "EHCNS@HI.M".ts_append_eval %Q|"EHCNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EHCNRNS@HI.M".ts_append_eval %Q|"EHCNRNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EHCSOIFNS@HI.M".ts_append_eval %Q|"EHCSOIFNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_LHNS@HI.M".ts_append_eval %Q|"E_LHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_PRSVCPRNS@HON.M".ts_append_eval %Q|"E_PRSVCPRNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_TUNS@HON.M".ts_append_eval %Q|"E_TUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TUNS@HON.M".ts_append_eval %Q|"E_TUNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "ETWTANS@HON.M".ts_append_eval %Q|"ETWTANS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EMANS@HON.M".ts_append_eval %Q|"EMANS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_job_upd.xls"|
   "EMNNDNS@HAW.M".ts_append_eval %Q|"EMNNDNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EOSNS@HAW.M".ts_append_eval %Q|"EOSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_PRNS@KAU.M".ts_append_eval %Q|"E_PRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_PRNS@KAU.M".ts_append_eval %Q|"E_PRNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ETWTANS@KAU.M".ts_append_eval %Q|"ETWTANS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EIFTCNS@KAU.M".ts_append_eval %Q|"EIFTCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_PBSNS@KAU.M".ts_append_eval %Q|"E_PBSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_EDHCNS@KAU.M".ts_append_eval %Q|"E_EDHCNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_LHNS@KAU.M".ts_append_eval %Q|"E_LHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFFDRSNS@KAU.M".ts_append_eval %Q|"EAFFDRSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVFDDDNS@KAU.M".ts_append_eval %Q|"EGVFDDDNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "E_TTUNS@MAU.M".ts_append_eval %Q|"E_TTUNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/bls_histextend_date_format_correct.xls"|
   "E_TTUNS@MAU.M".ts_append_eval %Q|"E_TTUNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTNS@MAU.M".ts_append_eval %Q|"ERTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EIFNS@MAU.M".ts_append_eval %Q|"EIFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAFFDRSNS@MAU.M".ts_append_eval %Q|"EAFFDRSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EGVSTEDNS@MAU.M".ts_append_eval %Q|"EGVSTEDNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTFDGSNS@HON.M".ts_append_eval %Q|"ERTFDGSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ECTBLNS@HI.M".ts_append_eval %Q|"ECTBLNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "ERTFDNS@HON.M".ts_append_eval %Q|"ERTFDNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EHCSONS@HI.M".ts_append_eval %Q|"EHCSONS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EHCAMNS@HON.M".ts_append_eval %Q|"EHCAMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EED12NS@HI.M".ts_append_eval %Q|"EED12NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EAGNS&@HI.M".ts_append_eval %Q|"EAGNS&@HI.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EAGNS&@MAU.M".ts_append_eval %Q|"EAGNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ECTNS&@KAU.M".ts_append_eval %Q|"ECTNS&@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EGVFDNS&@MAU.M".ts_append_eval %Q|"EGVFDNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVACNS&@MAU.M".ts_append_eval %Q|"ESVACNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVBSNS&@MAU.M".ts_append_eval %Q|"ESVBSNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVHCNS&@MAU.M".ts_append_eval %Q|"ESVHCNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "ESVNS&@MAU.M".ts_append_eval %Q|"ESVNS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "EIFTCNS@HAW.M".ts_append_eval %Q|"EIFTCNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/hiwi_upd.xls"|
   "EFINS&@MAU.M".ts_append_eval %Q|"EFINS&@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/bls/update/SICHistory.xls"|
   "RMORT@US.M".ts_append_eval %Q|"RMORT@US.M".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_m.xls"|
   "VLOSCRNDNS@HI.M".ts_eval= %Q|"VLOSCRNS@HI.M".ts - "VLOSCRDRNS@HI.M".ts|
   "EAE@HI.M".ts_append_eval %Q|"EAESA@HI.M".ts|
   "ERE@HI.M".ts_append_eval %Q|"ERESA@HI.M".ts|
   "ERENS@MAU.M".ts_append_eval %Q|"E_FIRNS@MAU.M".ts - "EFINS@MAU.M".ts|
   "ERENS@HAW.M".ts_append_eval %Q|"E_FIRNS@HAW.M".ts - "EFINS@HAW.M".ts|
   "ERENS@KAU.M".ts_append_eval %Q|"E_FIRNS@KAU.M".ts - "EFINS@KAU.M".ts|
   
   
   
   
   "VDAY@HI.M".ts_append_eval %Q|"VDAY@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|




   "UR@HI.M".ts_eval= %Q|"URSA@HI.M".ts|
   "EGVFD@HI.M".ts_append_eval %Q|"EGVFDSA@HI.M".ts|
   "EPS@HI.M".ts_append_eval %Q|"EPSSA@HI.M".ts|
   "EMANS@KAU.M".ts_append_eval %Q|"E_PBSNS@KAU.M".ts - "EPSNS@KAU.M".ts - "EADNS@KAU.M".ts|
   "EMANS@HAW.M".ts_append_eval %Q|"E_PBSNS@HAW.M".ts - "EPSNS@HAW.M".ts - "EADNS@HAW.M".ts|
   "EMANS@MAU.M".ts_append_eval %Q|"E_PBSNS@MAU.M".ts - "EPSNS@MAU.M".ts - "EADNS@MAU.M".ts|
   "VISUSNS@HON.M".ts_append_eval %Q|"VISUSENS@HON.M".ts + "VISUSWNS@HON.M".ts|
   "VISUSNS@HON.M".ts_append_eval %Q|"VISUSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VISUSNS@HAW.M".ts_append_eval %Q|"VISUSENS@HAW.M".ts + "VISUSWNS@HAW.M".ts|
   "VISUSNS@HAW.M".ts_append_eval %Q|"VISUSNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VISUSNS@KAU.M".ts_append_eval %Q|"VISUSENS@KAU.M".ts + "VISUSWNS@KAU.M".ts|
   "VISUSNS@KAU.M".ts_append_eval %Q|"VISUSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "VISUSNS@MAU.M".ts_append_eval %Q|"VISUSENS@MAU.M".ts + "VISUSWNS@MAU.M".ts|
   "VISUSNS@MAU.M".ts_append_eval %Q|"VISUSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
   "ECT@HI.M".ts_append_eval %Q|"ECTSA@HI.M".ts|
   
   "EWT@HI.M".ts_append_eval %Q|"EWTSA@HI.M".ts|
   "EHC@HI.M".ts_append_eval %Q|"EHCSA@HI.M".ts|
   "VDAYUSNS@HI.M".ts_eval= %Q|"VDAYUSENS@HI.M".ts + "VDAYUSWNS@HI.M".ts|
   "VDAYUSNS@HAW.M".ts_eval= %Q|"VDAYUSENS@HAW.M".ts + "VDAYUSWNS@HAW.M".ts|
   "VDAYUSNS@KAU.M".ts_eval= %Q|"VDAYUSENS@KAU.M".ts + "VDAYUSWNS@KAU.M".ts|
   "VDAYITNS@HI.M".ts_append_eval %Q|"VDAYITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "VDAYDMNS@HI.M".ts_append_eval %Q|"VDAYDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd1.xls"|
   "E_TRADENS@HAW.M".ts_append_eval %Q|"EWTNS@HAW.M".ts + "ERTNS@HAW.M".ts|
   "ENS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".ts + "EAGNS@HI.M".ts|
   "E_TRADENS@HI.M".ts_append_eval %Q|"EWTNS@HI.M".ts + "ERTNS@HI.M".ts|
   "E_GVSLNS@HI.M".ts_append_eval %Q|"EGVNS@HI.M".ts - "EGVFDNS@HI.M".ts|
   "E_SVNS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".ts - ("ECTNS@HI.M".ts + "EMNNS@HI.M".ts + "E_TRADENS@HI.M".ts + "E_TUNS@HI.M".ts + "E_FIRNS@HI.M".ts + "EGVNS@HI.M".ts) |
   "E_ELSENS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".ts - ("ECTNS@HI.M".ts + "EMNNS@HI.M".ts + "E_TRADENS@HI.M".ts  + "E_TUNS@HI.M".ts + "E_FIRNS@HI.M".ts + "EAFNS@HI.M".ts + "EHCNS@HI.M".ts + "EGVNS@HI.M".ts)|
   "ENS@HON.M".ts_append_eval %Q|"E_NFNS@HON.M".ts + "EAGNS@HON.M".ts|
   "E_TRADENS@HON.M".ts_append_eval %Q|"EWTNS@HON.M".ts + "ERTNS@HON.M".ts|
   "E_GVSLNS@HON.M".ts_append_eval %Q|"EGVNS@HON.M".ts - "EGVFDNS@HON.M".ts|
   "E_SVNS@HON.M".ts_append_eval %Q|"E_NFNS@HON.M".ts - ("ECTNS@HON.M".ts + "EMNNS@HON.M".ts + "E_TRADENS@HON.M".ts + "E_TUNS@HON.M".ts + "E_FIRNS@HON.M".ts + "EGVNS@HON.M".ts) |
   "ENS@HAW.M".ts_append_eval %Q|"E_NFNS@HAW.M".ts + "EAGNS@HAW.M".ts|
   "E_GVSLNS@HAW.M".ts_append_eval %Q|"EGVNS@HAW.M".ts - "EGVFDNS@HAW.M".ts|
   "E_SVNS@HAW.M".ts_append_eval %Q|"E_NFNS@HAW.M".ts - ("ECTNS@HAW.M".ts + "EMNNS@HAW.M".ts + "E_TRADENS@HAW.M".ts + "E_TUNS@HAW.M".ts + "E_FIRNS@HAW.M".ts + "EGVNS@HAW.M".ts) |
   "ENS@MAU.M".ts_append_eval %Q|"E_NFNS@MAU.M".ts + "EAGNS@MAU.M".ts|
   "E_TRADENS@MAU.M".ts_append_eval %Q|"EWTNS@MAU.M".ts + "ERTNS@MAU.M".ts|
   "E_GVSLNS@MAU.M".ts_append_eval %Q|"EGVNS@MAU.M".ts - "EGVFDNS@MAU.M".ts|
   "E_SVNS@MAU.M".ts_append_eval %Q|"E_NFNS@MAU.M".ts - ("ECTNS@MAU.M".ts + "EMNNS@MAU.M".ts + "E_TRADENS@MAU.M".ts + "E_TUNS@MAU.M".ts + "E_FIRNS@MAU.M".ts + "EGVNS@MAU.M".ts) |
   "ENS@KAU.M".ts_append_eval %Q|"E_NFNS@KAU.M".ts + "EAGNS@KAU.M".ts|
   "E_TRADENS@KAU.M".ts_append_eval %Q|"EWTNS@KAU.M".ts + "ERTNS@KAU.M".ts|
   "E_GVSLNS@KAU.M".ts_append_eval %Q|"EGVNS@KAU.M".ts - "EGVFDNS@KAU.M".ts|
   "E_SVNS@KAU.M".ts_append_eval %Q|"E_NFNS@KAU.M".ts - ("ECTNS@KAU.M".ts + "EMNNS@KAU.M".ts + "E_TRADENS@KAU.M".ts + "E_TUNS@KAU.M".ts + "E_FIRNS@KAU.M".ts + "EGVNS@KAU.M".ts) |
  #  # # Series To finish: 532
  # # # -----end------
  
  
  
  
  
  
  
  
  
  
  
  
  
  "PMKRSGFNS@KAU.A".ts_eval= %Q|"PMKRSGFNS@KAU.Q".ts.aggregate(:year, :average)|
  "GDP_C@US.A".ts_append_eval %Q|"GDP_C@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|
  "PMKRSGFNS@HI.A".ts_eval= %Q|"PMKRSGFNS@HI.Q".ts.aggregate(:year, :average)|
  "PMKRSGFNS@HAW.A".ts_eval= %Q|"PMKRSGFNS@HAW.Q".ts.aggregate(:year, :average)|
  "PMKRSGFNS@MAU.A".ts_eval= %Q|"PMKRSGFNS@MAU.Q".ts.aggregate(:year, :average)|
  "PMKRCONNS@HI.A".ts_eval= %Q|"PMKRCONNS@HI.Q".ts.aggregate(:year, :average)|
  "VDAYCRDRNS@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCRDRNS@HI.M".ts|
  "VDAYCRADRNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRDRNS@HI.M".ts|
  "VDAYCRSAFNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRAFNS@HI.M".ts|
  "VDAYCRAAFNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRAFNS@HI.M".ts|
  "VDAYCRNDNS@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCRNDNS@HI.M".ts|
  "VDAYCRSNDNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRNDNS@HI.M".ts|
  "VDAYCRANDNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRNDNS@HI.M".ts|
  "SH_JPNS@MAUI.M".ts_eval= %Q|"VISJPNS@MAUI.M".ts / "VISJPNS@HI.M".ts|
  "GDP_CD_R@US.A".ts_append_eval %Q|"GDP_CD_R@US.A".tsn.load_from "/Volumes/UHEROwork/data/US/update/us_upd_a.xls"|






  #getting NAN values
  "PRM@KAU.Q".ts_eval= %Q|(("PRMNS@KAU.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts) / ("PRMNS@KAU.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts).annual_sum * "PRMNS@KAU.M".ts.annual_sum).aggregate :quarter, :average|











  "VRLSDMNS@MAU.M".ts_eval= %Q|("VRLSDMNS@MAUI.M".ts * "VISDMNS@MAUI.M".ts + "VRLSDMNS@MOL.M".ts * "VISDMNS@MOL.M".ts + "VRLSDMNS@LAN.M".ts * "VISDMNS@LAN.M".ts) / "VISDMNS@MAU.M".ts|
  "VDAYDMNS@MAU.M".ts_eval= %Q|"VISDMNS@MAU.M".ts * "VRLSDMNS@MAU.M".ts|
  "VRLSITNS@MAU.M".ts_eval= %Q|("VRLSITNS@MAUI.M".ts * "VISITNS@MAUI.M".ts + "VRLSITNS@MOL.M".ts * "VISITNS@MOL.M".ts + "VRLSITNS@LAN.M".ts * "VISITNS@LAN.M".ts) / "VISITNS@MAU.M".ts|
  "VDAYITNS@MAU.M".ts_eval= %Q|"VISITNS@MAU.M".ts * "VRLSITNS@MAU.M".ts|
  "VRLSCANNS@MAU.M".ts_eval= %Q|("VRLSCANNS@MAUI.M".ts * "VISCANNS@MAUI.M".ts + "VRLSCANNS@MOL.M".ts * "VISCANNS@MOL.M".ts + "VRLSCANNS@LAN.M".ts * "VISCANNS@LAN.M".ts) / "VISCANNS@MAU.M".ts|
  "VRLSJPNS@MAU.M".ts_eval= %Q|("VRLSJPNS@MAUI.M".ts * "VISJPNS@MAUI.M".ts + "VRLSJPNS@MOL.M".ts * "VISJPNS@MOL.M".ts + "VRLSJPNS@LAN.M".ts * "VISJPNS@LAN.M".ts) / "VISJPNS@MAU.M".ts|
  "VRLSUSENS@MAU.M".ts_eval= %Q|("VRLSUSENS@MAUI.M".ts * "VISUSENS@MAUI.M".ts + "VRLSUSENS@MOL.M".ts * "VISUSENS@MOL.M".ts + "VRLSUSENS@LAN.M".ts * "VISUSENS@LAN.M".ts) / "VISUSENS@MAU.M".ts|
  "PMKRCONNS@HON.A".ts_eval= %Q|"PMKRCONNS@HON.Q".ts.aggregate(:year, :average)|
  "PMKRCONNS@MAU.A".ts_eval= %Q|"PMKRCONNS@MAU.Q".ts.aggregate(:year, :average)|
  "VIS@HAW.A".ts_eval= %Q|"VIS@HAW.M".ts.aggregate(:year, :sum)|
  "VDAYCRSBFNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRBFNS@HI.M".ts|
  "VDAYCRABFNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRBFNS@HI.M".ts|
  "VDAYCRSDRNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRDRNS@HI.M".ts|
  "VDAYCRAFNS@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCRAFNS@HI.M".ts|
  "KRCONNS@MAU.Q".ts_eval= %Q|"KRCONNS@HI.Q".ts.share_using("KRCONNS_NMC@MAU.Q".ts, "KRCONNS_NMC@HON.Q".ts + "KRCONNS_NMC@HAW.Q".ts + "KRCONNS_NMC@MAU.Q".ts + "KRCONNS_NMC@KAU.Q".ts).round|
  "KRSGFNS@KAU.Q".ts_eval= %Q|"KRSGFNS@HI.Q".ts.share_using("KRSGFNS_NMC@KAU.Q".ts, "KRSGFNS_NMC@HON.Q".ts + "KRSGFNS_NMC@HAW.Q".ts + "KRSGFNS_NMC@MAU.Q".ts + "KRSGFNS_NMC@KAU.Q".ts).round|
  "PC_EN@HON.Q".ts_eval= %Q|'PC_EN@HON.S'.ts.interpolate :quarter, :linear|
  "VISRESNS@MAU.M".ts_eval= %Q|"VISNS@MAU.M".ts - "VISUSNS@MAU.M".ts - "VISJPNS@MAU.M".ts|
  "VISRESNS@LAN.M".ts_eval= %Q|"VISNS@LAN.M".ts - "VISUSNS@LAN.M".ts - "VISJPNS@LAN.M".ts|
  "VEXPPDUSWNS@HI.M".ts_append_eval %Q|"VEXPUSWNS@HI.M".ts / "VDAYUSWNS@HI.M".ts*1000|
  "KRCONNS@HAW.Q".ts_eval= %Q|"KRCONNS@HI.Q".ts.share_using("KRCONNS_NMC@HAW.Q".ts, "KRCONNS_NMC@HON.Q".ts + "KRCONNS_NMC@HAW.Q".ts + "KRCONNS_NMC@MAU.Q".ts + "KRCONNS_NMC@KAU.Q".ts).round|
  "PCHSSHRT@HON.Q".ts_eval= %Q|'PCHSSHRT@HON.S'.ts.interpolate :quarter, :linear|
  
  
  
   "VDAYUS@HI.M".ts_append_eval %Q|"VDAYUS@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VDAYUS@HI.M".ts_append_eval %Q|"VDAYUS@HI.M".ts.apply_seasonal_adjustment :additive|
   "VDAYIT@HI.M".ts_eval= %Q|"VDAYIT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VDAYIT@HI.M".ts_eval= %Q|"VDAYIT@HI.M".ts.apply_seasonal_adjustment :additive|
   "VDAYJP@HI.M".ts_append_eval %Q|"VDAYJP@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VDAYJP@HI.M".ts_append_eval %Q|"VDAYJP@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  
   "VDAYRESNS@HI.M".ts_eval= %Q|"VDAYNS@HI.M".ts - "VDAYUSNS@HI.M".ts - "VDAYJPNS@HI.M".ts|
   "VDAYRES@HI.M".ts_append_eval %Q|"VDAYRES@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
   "VDAYRES@HI.M".ts_append_eval %Q|"VDAYRES@HI.M".ts.apply_seasonal_adjustment :additive|
   "VDAY@HI.M".ts_append_eval %Q|"VDAYJP@HI.M".ts + "VDAYUS@HI.M".ts + "VDAYRES@HI.M".ts|
  
  "VDAY_MC@HI.M".ts_eval= %Q|"VDAY@HI.M".ts / "VDAY@HI.M".ts.annual_sum * "VDAYNS@HI.M".ts.annual_sum|
  "VISDM_MC@HON.M".ts_eval= %Q|"VISDM@HON.M".ts / "VISDM@HON.M".ts.annual_sum * "VISDMNS@HON.M".ts.annual_sum|

  "RMRV@HON.Q".ts_eval= %Q|(("RMRVNS@HON.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts) / ("RMRVNS@HON.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts).annual_sum * "RMRVNS@HON.M".ts.annual_sum).aggregate :quarter, :average|
  "RMRV@HAW.Q".ts_eval= %Q|(("RMRVNS@HAW.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts) / ("RMRVNS@HAW.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts).annual_sum * "RMRVNS@HAW.M".ts.annual_sum).aggregate :quarter, :average|
  "RMRV@MAU.Q".ts_eval= %Q|(("RMRVNS@MAU.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts) / ("RMRVNS@MAU.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts).annual_sum * "RMRVNS@MAU.M".ts.annual_sum).aggregate :quarter, :average|
  "RMRV@KAU.Q".ts_eval= %Q|(("RMRVNS@KAU.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts) / ("RMRVNS@KAU.M".ts.moving_average / "RMRVNS@HI.M".ts.moving_average * "RMRV@HI.M".ts).annual_sum * "RMRVNS@KAU.M".ts.annual_sum).aggregate :quarter, :average|
  
  "PC@HON.A".ts_append_eval %Q|"PC@HON.S".ts.aggregate(:year, :average)|
  "PC@HON.A".ts_append_eval %Q|"PC_ANNUAL@HON.M".ts.aggregate(:year, :average)|
  
  "PCHSSH@HON.Q".ts_eval= %Q|'PCHSSH@HON.S'.ts.interpolate :quarter, :linear|
  "EIF@MAU.M".ts_eval= %Q|"EIF@HI.M".ts.aa_county_share_for("MAU")|
  "EAE@HON.M".ts_eval= %Q|"EAE@HI.M".ts.aa_county_share_for("HON")|
  "EAE@HAW.M".ts_eval= %Q|"EAE@HI.M".ts.aa_county_share_for("HAW")|
  "EAE@MAU.M".ts_eval= %Q|"EAE@HI.M".ts.aa_county_share_for("MAU")|
  "EAE@KAU.M".ts_eval= %Q|"EAE@HI.M".ts.aa_county_share_for("KAU")|
  "EAD@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EADNS@HI.M".ts.annual_sum, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).annual_sum)|
  "EAD@HON.M".ts_eval= %Q|"EAD@HI.M".ts.aa_county_share_for("HON")|
  "EAD@HAW.M".ts_eval= %Q|"EAD@HI.M".ts.aa_county_share_for("HAW")|
  "ERE@HON.M".ts_eval= %Q|"ERE@HI.M".ts.aa_county_share_for("HON")|
  "ERE@HAW.M".ts_eval= %Q|"ERE@HI.M".ts.aa_county_share_for("HAW")|
  "ERE@MAU.M".ts_eval= %Q|"ERE@HI.M".ts.aa_county_share_for("MAU")|
  "VISDM_MC@HAW.M".ts_eval= %Q|"VISDM@HAW.M".ts / "VISDM@HAW.M".ts.annual_sum * "VISDMNS@HAW.M".ts.annual_sum|
  "VISDM_MC@MAU.M".ts_eval= %Q|"VISDM@MAU.M".ts / "VISDM@MAU.M".ts.annual_sum * "VISDMNS@MAU.M".ts.annual_sum|
  "VLOSUSWNS@HI.M".ts_eval= %Q|"VDAYUSWNS@HI.M".ts / "VISUSWNS@HI.M".ts|
  "VLOSUSENS@HI.M".ts_eval= %Q|"VDAYUSENS@HI.M".ts / "VISUSENS@HI.M".ts|
  "PRMNS@HI.Q".ts_eval= %Q|"PRMNS@HI.M".ts.aggregate(:quarter, :average)|
  
  
  
  
  
  "PCFBFDAW@HON.Q".ts_eval= %Q|'PCFBFDAW@HON.S'.ts.interpolate :quarter, :linear|
  "VISRESNS@MOL.M".ts_eval= %Q|"VISNS@MOL.M".ts - "VISUSNS@MOL.M".ts - "VISJPNS@MOL.M".ts|
  "VLOSUSWNS@HON.M".ts_eval= %Q|"VDAYUSWNS@HON.M".ts / "VISUSWNS@HON.M".ts|
  "VLOSUSENS@HON.M".ts_eval= %Q|"VDAYUSENS@HON.M".ts / "VISUSENS@HON.M".ts|
  "VLOSJPNS@HON.M".ts_eval= %Q|"VDAYJPNS@HON.M".ts / "VISJPNS@HON.M".ts|
  "VLOSCANNS@HON.M".ts_eval= %Q|"VDAYCANNS@HON.M".ts / "VISCANNS@HON.M".ts|
  "VLOSDMNS@HAW.M".ts_eval= %Q|"VDAYDMNS@HAW.M".ts / "VISDMNS@HAW.M".ts|
  "VLOSUSWNS@HAW.M".ts_eval= %Q|"VDAYUSWNS@HAW.M".ts / "VISUSWNS@HAW.M".ts|
  "VLOSUSENS@HAW.M".ts_eval= %Q|"VDAYUSENS@HAW.M".ts / "VISUSENS@HAW.M".ts|
  "VLOSJPNS@HAW.M".ts_eval= %Q|"VDAYJPNS@HAW.M".ts / "VISJPNS@HAW.M".ts|
  "VLOSCANNS@HAW.M".ts_eval= %Q|"VDAYCANNS@HAW.M".ts / "VISCANNS@HAW.M".ts|
  "VLOSUSWNS@KAU.M".ts_eval= %Q|"VDAYUSWNS@KAU.M".ts / "VISUSWNS@KAU.M".ts|
  "VLOSUSENS@KAU.M".ts_eval= %Q|"VDAYUSENS@KAU.M".ts / "VISUSENS@KAU.M".ts|
  "VLOSJPNS@KAU.M".ts_eval= %Q|"VDAYJPNS@KAU.M".ts / "VISJPNS@KAU.M".ts|
  "VLOSCANNS@KAU.M".ts_eval= %Q|"VDAYCANNS@KAU.M".ts / "VISCANNS@KAU.M".ts|
  "VLOSDMNS@MAUI.M".ts_eval= %Q|"VDAYDMNS@MAUI.M".ts / "VISDMNS@MAUI.M".ts|
  "VLOSITNS@MAUI.M".ts_eval= %Q|"VDAYITNS@MAUI.M".ts / "VISITNS@MAUI.M".ts|
  "RMRVNS@HI.Q".ts_eval= %Q|"RMRVNS@HI.M".ts.aggregate(:quarter, :average)|
  "PRMNS@MAU.Q".ts_eval= %Q|"PRMNS@MAU.M".ts.aggregate(:quarter, :average)|
  "PCTR@HON.Q".ts_eval= %Q|'PCTR@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRPR@HON.Q".ts_eval= %Q|'PCTRPR@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRGS@HON.Q".ts_eval= %Q|'PCTRGS@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRGSRG@HON.Q".ts_eval= %Q|'PCTRGSRG@HON.S'.ts.interpolate :quarter, :linear|
  "PCTRGSMD@HON.Q".ts_eval= %Q|'PCTRGSMD@HON.S'.ts.interpolate :quarter, :linear|
  "RMRV@HI.Q".ts_eval= %Q|"RMRV@HI.M".ts.aggregate(:quarter, :average)|

  "VISRESNS@HI.M".ts_eval= %Q|"VISNS@HI.M".ts - "VISUSNS@HI.M".ts - "VISJPNS@HI.M".ts|
  "VISRES@HI.M".ts_append_eval %Q|"VISRES@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VISRES@HI.M".ts_append_eval %Q|"VISRES@HI.M".ts.apply_seasonal_adjustment :additive|
  "VISJP@HI.M".ts_append_eval %Q|"VISJP@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VISJP@HI.M".ts_append_eval %Q|"VISJP@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  "VIS@HI.M".ts_append_eval %Q|"VISJP@HI.M".ts + "VISUS@HI.M".ts + "VISRES@HI.M".ts|  
  "VLOS@HI.M".ts_eval= %Q|"VDAY@HI.M".ts / "VIS@HI.M".ts|
  "INF_SH@HON.Q".ts_eval= %Q|"PC_SH@HON.Q".ts.annualized_percentage_change|
  "OCUP%@MAU.Q".ts_eval= %Q|(("OCUP%NS@MAU.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts) / ("OCUP%NS@MAU.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts).annual_sum * "OCUP%NS@MAU.M".ts.annual_sum).aggregate :quarter, :average|
  "OCUP%@KAU.Q".ts_eval= %Q|(("OCUP%NS@KAU.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts) / ("OCUP%NS@KAU.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts).annual_sum * "OCUP%NS@KAU.M".ts.annual_sum).aggregate :quarter, :average|
  "PRM@MAU.Q".ts_eval= %Q|(("PRMNS@MAU.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts) / ("PRMNS@MAU.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts).annual_sum * "PRMNS@MAU.M".ts.annual_sum).aggregate :quarter, :average|
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.M".ts.aggregate(:quarter, :average)|
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.S".ts.interpolate :quarter, :linear|
  "RMORT@US.Q".ts_eval= %Q|"RMORT@US.M".ts.aggregate(:quarter, :average)|
  "PMKRCONNS@HAW.A".ts_eval= %Q|"PMKRCONNS@HAW.Q".ts.aggregate(:year, :average)|
  "VIS@HI.A".ts_eval= %Q|"VIS@HI.M".ts.aggregate(:year, :sum)|
  "VDAYCRSHPNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRNS@HI.M".ts|
  "E_GDSPR@HI.M".ts_append_eval %Q|"ECT@HI.M".ts + "EMN@HI.M".ts|
  "KRSGFNS@HON.Q".ts_eval= %Q|"KRSGFNS@HI.Q".ts.share_using("KRSGFNS_NMC@HON.Q".ts, "KRSGFNS_NMC@HON.Q".ts + "KRSGFNS_NMC@HAW.Q".ts + "KRSGFNS_NMC@MAU.Q".ts + "KRSGFNS_NMC@KAU.Q".ts).round|
  "KRCONNS@HON.Q".ts_eval= %Q|"KRCONNS@HI.Q".ts.share_using("KRCONNS_NMC@HON.Q".ts, "KRCONNS_NMC@HON.Q".ts + "KRCONNS_NMC@HAW.Q".ts + "KRCONNS_NMC@MAU.Q".ts + "KRCONNS_NMC@KAU.Q".ts).round|
  "KRSGFNS@HAW.Q".ts_eval= %Q|"KRSGFNS@HI.Q".ts.share_using("KRSGFNS_NMC@HAW.Q".ts, "KRSGFNS_NMC@HON.Q".ts + "KRSGFNS_NMC@HAW.Q".ts + "KRSGFNS_NMC@MAU.Q".ts + "KRSGFNS_NMC@KAU.Q".ts).round|
  "KRSGFNS@MAU.Q".ts_eval= %Q|"KRSGFNS@HI.Q".ts.share_using("KRSGFNS_NMC@MAU.Q".ts, "KRSGFNS_NMC@HON.Q".ts + "KRSGFNS_NMC@HAW.Q".ts + "KRSGFNS_NMC@MAU.Q".ts + "KRSGFNS_NMC@KAU.Q".ts).round|
  "PRM@HAW.Q".ts_eval= %Q|(("PRMNS@HAW.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts) / ("PRMNS@HAW.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts).annual_sum * "PRMNS@HAW.M".ts.annual_sum).aggregate :quarter, :average|
  "VISDM_MC@HI.M".ts_eval= %Q|"VISDM@HI.M".ts / "VISDM@HI.M".ts.annual_sum * "VISDMNS@HI.M".ts.annual_sum|
  "VISRESNS@HAW.M".ts_eval= %Q|"VISNS@HAW.M".ts - "VISUSNS@HAW.M".ts - "VISJPNS@HAW.M".ts|
  "VISRESNS@KAU.M".ts_eval= %Q|"VISNS@KAU.M".ts - "VISUSNS@KAU.M".ts - "VISJPNS@KAU.M".ts|
  "UR_MC@HI.M".ts_eval= %Q|"UR@HI.M".ts / "UR@HI.M".ts.annual_sum * "URNS@HI.M".ts.annual_sum|
  "EGVFD@HAW.M".ts_eval= %Q|"EGVFD@HI.M".ts.aa_county_share_for("HAW")|
  "EGVFD@MAU.M".ts_eval= %Q|"EGVFD@HI.M".ts.aa_county_share_for("MAU")|
  "EGVFD@KAU.M".ts_eval= %Q|"EGVFD@HI.M".ts.aa_county_share_for("KAU")|
  "EIF@HON.M".ts_eval= %Q|"EIF@HI.M".ts.aa_county_share_for("HON")|
  "EIF@HAW.M".ts_eval= %Q|"EIF@HI.M".ts.aa_county_share_for("HAW")|
  "EIF@KAU.M".ts_eval= %Q|"EIF@HI.M".ts.aa_county_share_for("KAU")|
  "EPS@HON.M".ts_eval= %Q|"EPS@HI.M".ts.aa_county_share_for("HON")|
  "EPS@HAW.M".ts_eval= %Q|"EPS@HI.M".ts.aa_county_share_for("HAW")|
  "EPS@MAU.M".ts_eval= %Q|"EPS@HI.M".ts.aa_county_share_for("MAU")|
  "EPS@KAU.M".ts_eval= %Q|"EPS@HI.M".ts.aa_county_share_for("KAU")|
  "EMA@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts).share_using("EMANS@HI.M".ts.annual_sum, ("EMANS@HI.M".ts + "EADNS@HI.M".ts).annual_sum)|
  "EMA@HON.M".ts_eval= %Q|"EMA@HI.M".ts.aa_county_share_for("HON")|
  "EMA@HAW.M".ts_eval= %Q|"EMA@HI.M".ts.aa_county_share_for("HAW")|
  "EMA@MAU.M".ts_eval= %Q|"EMA@HI.M".ts.aa_county_share_for("MAU")|
  "EMA@KAU.M".ts_eval= %Q|"EMA@HI.M".ts.aa_county_share_for("KAU")|
  "ERE@KAU.M".ts_eval= %Q|"ERE@HI.M".ts.aa_county_share_for("KAU")|
  "OCUP%NS@HON.Q".ts_eval= %Q|"OCUP%NS@HON.M".ts.aggregate(:quarter, :average)|
  "PRMNS@HON.Q".ts_eval= %Q|"PRMNS@HON.M".ts.aggregate(:quarter, :average)|
  "OCUP%NS@HAW.Q".ts_eval= %Q|"OCUP%NS@HAW.M".ts.aggregate(:quarter, :average)|
  "PRMNS@HAW.Q".ts_eval= %Q|"PRMNS@HAW.M".ts.aggregate(:quarter, :average)|
  "RMRVNS@HAW.Q".ts_eval= %Q|"RMRVNS@HAW.M".ts.aggregate(:quarter, :average)|
  "OCUP%NS@KAU.Q".ts_eval= %Q|"OCUP%NS@KAU.M".ts.aggregate(:quarter, :average)|
  "PRMNS@KAU.Q".ts_eval= %Q|"PRMNS@KAU.M".ts.aggregate(:quarter, :average)|
  "PCOT@HON.Q".ts_eval= %Q|'PCOT@HON.S'.ts.interpolate :quarter, :linear|
  "OCUP%@HI.Q".ts_eval= %Q|"OCUP%@HI.M".ts.aggregate(:quarter, :average)|
  "OCUP%@HON.Q".ts_eval= %Q|(("OCUP%NS@HON.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts) / ("OCUP%NS@HON.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts).annual_sum * "OCUP%NS@HON.M".ts.annual_sum).aggregate :quarter, :average|
  "PRM@HON.Q".ts_eval= %Q|(("PRMNS@HON.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts) / ("PRMNS@HON.M".ts.moving_average / "PRMNS@HI.M".ts.moving_average * "PRM@HI.M".ts).annual_sum * "PRMNS@HON.M".ts.annual_sum).aggregate :quarter, :average|
  "OCUP%@HAW.Q".ts_eval= %Q|(("OCUP%NS@HAW.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts) / ("OCUP%NS@HAW.M".ts.moving_average / "OCUP%NS@HI.M".ts.moving_average * "OCUP%@HI.M".ts).annual_sum * "OCUP%NS@HAW.M".ts.annual_sum).aggregate :quarter, :average|
  "VISRESNS@HON.M".ts_eval= %Q|"VISNS@HON.M".ts - "VISUSNS@HON.M".ts - "VISJPNS@HON.M".ts|
  "VEXPPTNS@HON.M".ts_append_eval %Q|"VEXPNS@HON.M".ts / "VISNS@HON.M".ts*1000|
  "VIS_MC@HAW.M".ts_eval= %Q|"VIS@HAW.M".ts / "VIS@HAW.M".ts.annual_average * "VISNS@HAW.M".ts.annual_average|
  "EGVST@HON.M".ts_eval= %Q|"EGVST@HI.M".ts.aa_county_share_for("HON")|
  "EGVLC@HON.M".ts_eval= %Q|"EGVLC@HI.M".ts.aa_county_share_for("HON")|
  "VDAYITNS@HAW.M".ts_eval= %Q|"VISITNS@HAW.M".ts * "VRLSITNS@HAW.M".ts|
  "VDAYDMNS@KAU.M".ts_eval= %Q|"VISDMNS@KAU.M".ts * "VRLSDMNS@KAU.M".ts|
  "VDAYUSENS@MAU.M".ts_eval= %Q|"VRLSUSENS@MAU.M".ts * "VISUSENS@MAU.M".ts|
  "VDAYNS@MAU.M".ts_eval= %Q|"VDAYDMNS@MAU.M".ts + "VDAYITNS@MAU.M".ts|
  "VDAYRESNS@HON.M".ts_eval= %Q|"VDAYNS@HON.M".ts - "VDAYUSNS@HON.M".ts + "VDAYJPNS@HON.M".ts|
  "E_OTNS@HAW.M".ts_append_eval %Q|"EMANS@HAW.M".ts + "EADNS@HAW.M".ts + "EEDNS@HAW.M".ts + "EOSNS@HAW.M".ts|
  "E_OTNS@MAU.M".ts_append_eval %Q|"EMANS@MAU.M".ts + "EADNS@MAU.M".ts + "EEDNS@MAU.M".ts + "EOSNS@MAU.M".ts|
  "E_OTNS@KAU.M".ts_append_eval %Q|"EMANS@KAU.M".ts + "EADNS@KAU.M".ts + "EEDNS@KAU.M".ts + "EOSNS@KAU.M".ts|
  "VDAYDMNS@MOL.M".ts_eval= %Q|"VISDMNS@MOL.M".ts * "VRLSDMNS@MOL.M".ts|
  "VDAYDMNS@LAN.M".ts_eval= %Q|"VISDMNS@LAN.M".ts * "VRLSDMNS@LAN.M".ts|
  "VDAYRESNS@MAUI.M".ts_eval= %Q|"VDAYNS@MAUI.M".ts - "VDAYUSNS@MAUI.M".ts + "VDAYJPNS@MAUI.M".ts|
  "EUTNS@HON.M".ts_append_eval %Q|"E_TUNS@HON.M".ts - "ETWNS@HON.M".ts|
  "E_TRADE@HI.M".ts_append_eval %Q|"EWT@HI.M".ts + "ERT@HI.M".ts|
  "EFI@HI.M".ts_eval= %Q|"E_FIR@HI.M".ts - "ERE@HI.M".ts|
  "E_GVSL@HI.M".ts_append_eval %Q|"EGVST@HI.M".ts + "EGVLC@HI.M".ts|
  "VISUSNS@MAUI.M".ts_append_eval %Q|"VISUSENS@MAUI.M".ts + "VISUSWNS@MAUI.M".ts|
  "VISUSNS@MAUI.M".ts_append_eval %Q|"VISUSNS@MAUI.M".tsn.load_from "/Volumes/UHEROwork/data/tour/update/tour_upd3.xls"|
  "SH_USNS@HON.M".ts_eval= %Q|"VISUSNS@HON.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@HON.M".ts_eval= %Q|"VISJPNS@HON.M".ts / "VISJPNS@HI.M".ts|
  "SH_RESNS@HON.M".ts_eval= %Q|"VISRESNS@HON.M".ts / "VISRESNS@HI.M".ts|
  "SH_USNS@HAW.M".ts_eval= %Q|"VISUSNS@HAW.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@HAW.M".ts_eval= %Q|"VISJPNS@HAW.M".ts / "VISJPNS@HI.M".ts|
   "SH_RESNS@HAW.M".ts_eval= %Q|"VISRESNS@HAW.M".ts / "VISRESNS@HI.M".ts|
  
  "SH_USNS@KAU.M".ts_eval= %Q|"VISUSNS@KAU.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@KAU.M".ts_eval= %Q|"VISJPNS@KAU.M".ts / "VISJPNS@HI.M".ts|
  "SH_USNS@MAU.M".ts_eval= %Q|"VISUSNS@MAU.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@MAU.M".ts_eval= %Q|"VISJPNS@MAU.M".ts / "VISJPNS@HI.M".ts|
  "SH_USNS@MOL.M".ts_eval= %Q|"VISUSNS@MOL.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@MOL.M".ts_eval= %Q|"VISJPNS@MOL.M".ts / "VISJPNS@HI.M".ts|
  "SH_RESNS@MOL.M".ts_eval= %Q|"VISRESNS@MOL.M".ts / "VISRESNS@HI.M".ts|
  "SH_USNS@LAN.M".ts_eval= %Q|"VISUSNS@LAN.M".ts / "VISUSNS@HI.M".ts|
  "SH_JPNS@LAN.M".ts_eval= %Q|"VISJPNS@LAN.M".ts / "VISJPNS@HI.M".ts|

  
  "SH_RESNS@LAN.M".ts_eval= %Q|"VISRESNS@LAN.M".ts / "VISRESNS@HI.M".ts|
  "SH_USNS@HI.M".ts_eval= %Q|"SH_USNS@HON.M".ts + "SH_USNS@HAW.M".ts + "SH_USNS@KAU.M".ts + "SH_USNS@MAU.M".ts|
  "SH_JPNS@HI.M".ts_eval= %Q|"SH_JPNS@HON.M".ts + "SH_JPNS@HAW.M".ts + "SH_JPNS@KAU.M".ts + "SH_JPNS@MAU.M".ts|
  "VISNS@NBI.M".ts_append_eval %Q|"VISNS@HI.M".ts - "VISNS@HON.M".ts|
  "VLOSCANNS@LAN.M".ts_eval= %Q|"VDAYCANNS@LAN.M".ts / "VISCANNS@LAN.M".ts|
  "VLOSUSENS@MAU.M".ts_eval= %Q|"VDAYUSENS@MAU.M".ts / "VISUSENS@MAU.M".ts|
  "VLOSDMNS@MAU.M".ts_eval= %Q|"VDAYDMNS@MAU.M".ts / "VISDMNS@MAU.M".ts|
  "VLOSITNS@MAU.M".ts_eval= %Q|"VDAYITNS@MAU.M".ts / "VISITNS@MAU.M".ts|
  "EOS@HI.M".ts_append_eval %Q|"EOSSA@HI.M".ts|
  "E_GVSL@HON.M".ts_append_eval %Q|"EGVST@HON.M".ts + "EGVLC@HON.M".ts|
  "KRCONNS@KAU.Q".ts_eval= %Q|"KRCONNS@HI.Q".ts.share_using("KRCONNS_NMC@KAU.Q".ts, "KRCONNS_NMC@HON.Q".ts + "KRCONNS_NMC@HAW.Q".ts + "KRCONNS_NMC@MAU.Q".ts + "KRCONNS_NMC@KAU.Q".ts).round|
  "VEXPOTNS@HI.M".ts_append_eval %Q|"VEXPNS@HI.M".ts - "VEXPUSNS@HI.M".ts - "VEXPJPNS@HI.M".ts - "VEXPCANNS@HI.M".ts|
  "VEXPPDNS@HI.M".ts_append_eval %Q|"VEXPNS@HI.M".ts / "VDAYNS@HI.M".ts*1000|
  "VEXPPDUSENS@HI.M".ts_append_eval %Q|"VEXPUSENS@HI.M".ts / "VDAYUSENS@HI.M".ts*1000|
  "VEXPPDJPNS@HI.M".ts_append_eval %Q|"VEXPJPNS@HI.M".ts / "VDAYJPNS@HI.M".ts*1000|
  "VEXPPDCANNS@HI.M".ts_append_eval %Q|"VEXPCANNS@HI.M".ts / "VDAYCANNS@HI.M".ts*1000|
  "VEXPPDOTNS@HI.M".ts_append_eval %Q|"VEXPOTNS@HI.M".ts / "VDAYOTNS@HI.M".ts*1000|
  "VEXPPTUSWNS@HI.M".ts_append_eval %Q|"VEXPUSWNS@HI.M".ts / "VISUSWNS@HI.M".ts*1000|
  "VEXPPTJPNS@HI.M".ts_append_eval %Q|"VEXPJPNS@HI.M".ts / "VISJPNS@HI.M".ts*1000|
  



  #getting NAN Values
  "VEXPPTOTNS@HI.M".ts_append_eval %Q|"VEXPOTNS@HI.M".ts / "VISOTNS@HI.M".ts*1000|










  "VEXPPDNS@HON.M".ts_append_eval %Q|"VEXPNS@HON.M".ts / "VDAYNS@HON.M".ts*1000|
  "VEXPPDNS@MAUI.M".ts_append_eval %Q|"VEXPNS@MAUI.M".ts / "VDAYNS@MAUI.M".ts*1000|
  "VEXPPTNS@MAUI.M".ts_append_eval %Q|"VEXPNS@MAUI.M".ts / "VISNS@MAUI.M".ts*1000|
  "VEXPPTNS@MOL.M".ts_append_eval %Q|"VEXPNS@MOL.M".ts / "VISNS@MOL.M".ts*1000|
  "VEXPPTNS@LAN.M".ts_append_eval %Q|"VEXPNS@LAN.M".ts / "VISNS@LAN.M".ts*1000|
  "VEXPPTNS@HAW.M".ts_append_eval %Q|"VEXPNS@HAW.M".ts / "VISNS@HAW.M".ts*1000|
  "E_NF@HI.M".ts_append_eval %Q|"E_NFSA@HI.M".ts|
  "E_NF@HI.M".ts_append_eval %Q|"ECT@HI.M".ts + "EMN@HI.M".ts + "E_TTU@HI.M".ts + "EIF@HI.M".ts + "E_FIR@HI.M".ts + "E_PBS@HI.M".ts + "E_EDHC@HI.M".ts + "E_LH@HI.M".ts + "EOS@HI.M".ts + "EGV@HI.M".ts|
  "VDAYNS@HAW.M".ts_eval= %Q|"VDAYDMNS@HAW.M".ts + "VDAYITNS@HAW.M".ts|
  
  
  
  "VIS_MC@HI.M".ts_eval= %Q|"VIS@HI.M".ts / "VIS@HI.M".ts.annual_sum * "VISNS@HI.M".ts.annual_sum|
  "VISUS_MC@HI.M".ts_eval= %Q|"VISUS@HI.M".ts / "VISUS@HI.M".ts.annual_sum * "VISUSNS@HI.M".ts.annual_sum|
  "VISIT@HI.M".ts_append_eval %Q|"VISIT@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VISIT@HI.M".ts_append_eval %Q|"VISIT@HI.M".ts.apply_seasonal_adjustment :additive|
  "ECT@HON.M".ts_eval= %Q|"ECT@HI.M".ts.aa_county_share_for("HON")|
  "EMN@HON.M".ts_eval= %Q|"EMN@HI.M".ts.aa_county_share_for("HON")|
  "EWT@HAW.M".ts_eval= %Q|"EWT@HI.M".ts.aa_county_share_for("HAW")|
  "EWT@MAU.M".ts_eval= %Q|"EWT@HI.M".ts.aa_county_share_for("MAU")|
  "EHC@MAU.M".ts_eval= %Q|"EHC@HI.M".ts.aa_county_share_for("MAU")|
  "EHC@KAU.M".ts_eval= %Q|"EHC@HI.M".ts.aa_county_share_for("KAU")|
  "EOS@HAW.M".ts_eval= %Q|"EOS@HI.M".ts.aa_county_share_for("HAW")|
  "EOS@MAU.M".ts_eval= %Q|"EOS@HI.M".ts.aa_county_share_for("MAU")|
  "EOS@KAU.M".ts_eval= %Q|"EOS@HI.M".ts.aa_county_share_for("KAU")|
  "EGV@MAU.M".ts_eval= %Q|"EGV@HI.M".ts.aa_county_share_for("MAU")|
  
  
  
  
  
  "VISJP@HON.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("HON")|
  "VISIT@HON.M".ts_eval= %Q|"VISIT@HI.M".ts.mc_ma_county_share_for("HON")|
  "ECT@HAW.M".ts_eval= %Q|"ECT@HI.M".ts.aa_county_share_for("HAW")|
  "ECT@MAU.M".ts_eval= %Q|"ECT@HI.M".ts.aa_county_share_for("MAU")|
  "ECT@KAU.M".ts_eval= %Q|"ECT@HI.M".ts.aa_county_share_for("KAU")|
  "EMN@HAW.M".ts_eval= %Q|"EMN@HI.M".ts.aa_county_share_for("HAW")|
  "EED@HON.M".ts_eval= %Q|"EED@HI.M".ts.aa_county_share_for("HON")|
  "EHC@HON.M".ts_eval= %Q|"EHC@HI.M".ts.aa_county_share_for("HON")|
  "EOS@HON.M".ts_eval= %Q|"EOS@HI.M".ts.aa_county_share_for("HON")|
  "EGVST@HAW.M".ts_eval= %Q|"EGVST@HI.M".ts.aa_county_share_for("HAW")|
  "EGVST@MAU.M".ts_eval= %Q|"EGVST@HI.M".ts.aa_county_share_for("MAU")|
  "EGVST@KAU.M".ts_eval= %Q|"EGVST@HI.M".ts.aa_county_share_for("KAU")|
  "EGVLC@HAW.M".ts_eval= %Q|"EGVLC@HI.M".ts.aa_county_share_for("HAW")|
  "EGVLC@MAU.M".ts_eval= %Q|"EGVLC@HI.M".ts.aa_county_share_for("MAU")|
  "EGVLC@KAU.M".ts_eval= %Q|"EGVLC@HI.M".ts.aa_county_share_for("KAU")|
  
  
  "E_GVSL@KAU.M".ts_append_eval %Q|"EGVST@KAU.M".ts + "EGVLC@KAU.M".ts|
   
  "EGV@KAU.M".ts_eval= %Q|"EGV@HI.M".ts.aa_county_share_for("KAU")|
  "EGV@KAU.M".ts_append_eval %Q|"EGVFD@KAU.M".ts + "E_GVSL@KAU.M".ts|
  
  "E_TU@HI.M".ts_eval= %Q|"E_TTU@HI.M".ts - "E_TRADE@HI.M".ts|
  "VISUS@HON.M".ts_eval= %Q|"VISUS@HI.M".ts.mc_ma_county_share_for("HON")|
  "VISUS@HAW.M".ts_eval= %Q|"VISUS@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VISUS@KAU.M".ts_eval= %Q|"VISUS@HI.M".ts.mc_ma_county_share_for("KAU")|
  "VISIT@MAU.M".ts_eval= %Q|"VISIT@HI.M".ts.mc_ma_county_share_for("MAU")|
  "VISJP@KAU.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("KAU")|
  "VDAYUS@HON.M".ts_eval= %Q|"VDAYUS@HI.M".ts.mc_ma_county_share_for("HON")|
  "EMN@MAU.M".ts_eval= %Q|"EMN@HI.M".ts.aa_county_share_for("MAU")|
  "EMN@KAU.M".ts_eval= %Q|"EMN@HI.M".ts.aa_county_share_for("KAU")|
  "EWT@HON.M".ts_eval= %Q|"EWT@HI.M".ts.aa_county_share_for("HON")|
  "EWT@KAU.M".ts_eval= %Q|"EWT@HI.M".ts.aa_county_share_for("KAU")|
  "ERT@HON.M".ts_eval= %Q|"ERT@HI.M".ts.aa_county_share_for("HON")|
  "ERT@HAW.M".ts_eval= %Q|"ERT@HI.M".ts.aa_county_share_for("HAW")|
  "ERT@MAU.M".ts_eval= %Q|"ERT@HI.M".ts.aa_county_share_for("MAU")|
  "ERT@KAU.M".ts_eval= %Q|"ERT@HI.M".ts.aa_county_share_for("KAU")|
  "E_TU@HAW.M".ts_eval= %Q|"E_TU@HI.M".ts.aa_county_share_for("HAW")|
  "E_TU@MAU.M".ts_eval= %Q|"E_TU@HI.M".ts.aa_county_share_for("MAU")|
  "E_TU@KAU.M".ts_eval= %Q|"E_TU@HI.M".ts.aa_county_share_for("KAU")|
  "EED@HAW.M".ts_eval= %Q|"EED@HI.M".ts.aa_county_share_for("HAW")|
  "EED@MAU.M".ts_eval= %Q|"EED@HI.M".ts.aa_county_share_for("MAU")|
  "EED@KAU.M".ts_eval= %Q|"EED@HI.M".ts.aa_county_share_for("KAU")|
  "EHC@HAW.M".ts_eval= %Q|"EHC@HI.M".ts.aa_county_share_for("HAW")|
  "EMPL_MC@HI.M".ts_eval= %Q|"EMPLSA@HI.M".ts / "EMPLSA@HI.M".ts.annual_sum * "EMPLNS@HI.M".ts.annual_sum|
  "EMPL@HI.M".ts_append_eval %Q|"EMPLSA@HI.M".ts|
  "EMPL@HI.M".ts_append_eval %Q|"EMPL_MC@HI.M".ts|
  "E_TU_MC@HI.M".ts_eval= %Q|"E_TU@HI.M".ts / "E_TU@HI.M".ts.annual_sum * "E_TUNS@HI.M".ts.annual_sum|
  "E_TU_MC@HAW.M".ts_eval= %Q|"E_TU@HAW.M".ts / "E_TU@HAW.M".ts.annual_sum * "E_TUNS@HAW.M".ts.annual_sum|
  "E_TU_MC@MAU.M".ts_eval= %Q|"E_TU@MAU.M".ts / "E_TU@MAU.M".ts.annual_sum * "E_TUNS@MAU.M".ts.annual_sum|
  "E_TU_MC@KAU.M".ts_eval= %Q|"E_TU@KAU.M".ts / "E_TU@KAU.M".ts.annual_sum * "E_TUNS@KAU.M".ts.annual_sum|
  "EMPL@HON.M".ts_eval= %Q|"EMPL@HI.M".ts.aa_county_share_for("HON")|
  "EMPL@HAW.M".ts_eval= %Q|"EMPL@HI.M".ts.aa_county_share_for("HAW")|
  "EMPL@MAU.M".ts_eval= %Q|"EMPL@HI.M".ts.aa_county_share_for("MAU")|
  "EMPL@KAU.M".ts_eval= %Q|"EMPL@HI.M".ts.aa_county_share_for("KAU")|
  "EAFAC@HI.M".ts_eval= %Q|"EAF@HI.M".ts.share_using("EAFACNS@HI.M".ts.annual_average,"EAFNS@HI.M".ts.annual_average)|
  "EAFAC@HI.M".ts_append_eval %Q|"EAF@HI.M".ts.share_using("EAFACNS@HI.M".ts.backward_looking_moving_average.trim,"EAFNS@HI.M".ts.backward_looking_moving_average.trim)|
  "EAFFD@HI.M".ts_eval= %Q|"EAF@HI.M".ts.share_using("EAFFDNS@HI.M".ts.annual_average,"EAFNS@HI.M".ts.annual_average)|
  "EAFFD@HI.M".ts_append_eval %Q|"EAF@HI.M".ts.share_using("EAFFDNS@HI.M".ts.backward_looking_moving_average.trim,"EAFNS@HI.M".ts.backward_looking_moving_average.trim)|
  "EAFAC@HON.M".ts_eval= %Q|"EAFAC@HI.M".ts.aa_county_share_for("HON")|
  "EGVFD@HON.M".ts_eval= %Q|"EGVFD@HI.M".ts.aa_county_share_for("HON")|
  "EAFFD@MAU.M".ts_eval= %Q|"EAFFD@HI.M".ts.aa_county_share_for("MAU")|
  "E_LH@HON.M".ts_eval= %Q|"E_LH@HI.M".ts.aa_county_share_for("HON")|
  "EAD@MAU.M".ts_eval= %Q|"EAD@HI.M".ts.aa_county_share_for("MAU")|
  "EAD@KAU.M".ts_eval= %Q|"EAD@HI.M".ts.aa_county_share_for("KAU")|
  "E_PBS@KAU.M".ts_eval= %Q|"E_PBS@HI.M".ts.aa_county_share_for("KAU")|
  "E_PBS@KAU.M".ts_append_eval %Q|"EPS@KAU.M".ts + "EMA@KAU.M".ts + "EAD@KAU.M".ts|
  "EFI@HON.M".ts_eval= %Q|"EFI@HI.M".ts.aa_county_share_for("HON")|
  "EFI@HAW.M".ts_eval= %Q|"EFI@HI.M".ts.aa_county_share_for("HAW")|
  "EFI@MAU.M".ts_eval= %Q|"EFI@HI.M".ts.aa_county_share_for("MAU")|
  "E_FIR@HON.M".ts_eval= %Q|"E_FIR@HI.M".ts.aa_county_share_for("HON")|
  "E_PBS@HON.M".ts_eval= %Q|"E_PBS@HI.M".ts.aa_county_share_for("HON")|
  "E_PBS@HAW.M".ts_eval= %Q|"E_PBS@HI.M".ts.aa_county_share_for("HAW")|
  "E_PBS@HAW.M".ts_append_eval %Q|"EPS@HAW.M".ts + "EMA@HAW.M".ts + "EAD@HAW.M".ts|
  "E_PBS@MAU.M".ts_eval= %Q|"E_PBS@HI.M".ts.aa_county_share_for("MAU")|
  "E_PBS@MAU.M".ts_append_eval %Q|"EPS@MAU.M".ts + "EMA@MAU.M".ts + "EAD@MAU.M".ts|
  "VISUS@MAU.M".ts_eval= %Q|"VISUS@HI.M".ts.mc_ma_county_share_for("MAU")|
  
  
  
  "VISRES@HON.M".ts_eval= %Q|"VISRES@HI.M".ts.mc_ma_county_share_for("HON")|
  "VISRES@HAW.M".ts_eval= %Q|"VISRES@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VISRES@MAU.M".ts_eval= %Q|"VISRES@HI.M".ts.mc_ma_county_share_for("MAU")|
  
  "VISJP@HAW.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VISJP@MAU.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("MAU")|
  "VIS@MAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("MAU","VIS")|
  "VIS@MAU.M".ts_append_eval %Q|"VISJP@MAU.M".ts + "VISUS@MAU.M".ts + "VISRES@MAU.M".ts|
  
  
  "VDAYUS@HAW.M".ts_eval= %Q|"VDAYUS@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VDAYUS@KAU.M".ts_eval= %Q|"VDAYUS@HI.M".ts.mc_ma_county_share_for("KAU")|
  "VDAYRES@HON.M".ts_eval= %Q|"VDAYRES@HI.M".ts.mc_ma_county_share_for("HON")|
  "VDAYJP@HON.M".ts_eval= %Q|"VDAYJP@HI.M".ts.mc_ma_county_share_for("HON")|
  "VDAYJP@HAW.M".ts_eval= %Q|"VDAYJP@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VDAYJP@KAU.M".ts_eval= %Q|"VDAYJP@HI.M".ts.mc_ma_county_share_for("KAU")|
  "VISIT@HAW.M".ts_eval= %Q|"VISIT@HI.M".ts.mc_ma_county_share_for("HAW")|
  "VISIT@KAU.M".ts_eval= %Q|"VISIT@HI.M".ts.mc_ma_county_share_for("KAU")|
  "VISDM@KAU.M".ts_eval= %Q|"VISDM@HI.M".ts.mc_ma_county_share_for("KAU")|
  "EAFAC@HAW.M".ts_eval= %Q|"EAFAC@HI.M".ts.aa_county_share_for("HAW")|
  "EAFAC@MAU.M".ts_eval= %Q|"EAFAC@HI.M".ts.aa_county_share_for("MAU")|
  "EAFAC@KAU.M".ts_eval= %Q|"EAFAC@HI.M".ts.aa_county_share_for("KAU")|
  "EAFFD@HAW.M".ts_eval= %Q|"EAFFD@HI.M".ts.aa_county_share_for("HAW")|
  "KRCONNS_MC@KAU.Q".ts_eval= %Q|"KRCONNS@KAU.Q".ts / ("KRCONNS@HON.Q".ts + "KRCONNS@HAW.Q".ts + "KRCONNS@MAU.Q".ts + "KRCONNS@KAU.Q".ts) * "KRCONNS@HI.Q".ts|
  "KRCONNS_MC@HAW.Q".ts_eval= %Q|"KRCONNS@HAW.Q".ts / ("KRCONNS@HON.Q".ts + "KRCONNS@HAW.Q".ts + "KRCONNS@MAU.Q".ts + "KRCONNS@KAU.Q".ts) * "KRCONNS@HI.Q".ts|
  "KRCONNS_MC@MAU.Q".ts_eval= %Q|"KRCONNS@MAU.Q".ts / ("KRCONNS@HON.Q".ts + "KRCONNS@HAW.Q".ts + "KRCONNS@MAU.Q".ts + "KRCONNS@KAU.Q".ts) * "KRCONNS@HI.Q".ts|
  "E_GDSPR@HAW.M".ts_append_eval %Q|"ECT@HAW.M".ts + "EMN@HAW.M".ts|
  
  
  "EAFFD@KAU.M".ts_eval= %Q|"EAFFD@HI.M".ts.aa_county_share_for("KAU")|
  
  "EAF@HAW.M".ts_eval= %Q|"EAFAC@HAW.M".ts + "EAFFD@HAW.M".ts|
  "EAF@MAU.M".ts_eval= %Q|"EAFAC@MAU.M".ts + "EAFFD@MAU.M".ts|
  "EAF@KAU.M".ts_eval= %Q|"EAFAC@KAU.M".ts + "EAFFD@KAU.M".ts|
  
  "E_LH@HAW.M".ts_append_eval %Q|"EAE@HAW.M".ts + "EAF@HAW.M".ts|
  "E_LH@MAU.M".ts_append_eval %Q|"EAE@MAU.M".ts + "EAF@MAU.M".ts|
  
  
  
  "EFI@KAU.M".ts_eval= %Q|"EFI@HI.M".ts.aa_county_share_for("KAU")|
  "E_FIR@KAU.M".ts_append_eval %Q|"EFI@KAU.M".ts + "ERE@KAU.M".ts|
  "VLOSDMNS@HI.M".ts_eval= %Q|"VDAYDMNS@HI.M".ts / "VISDMNS@HI.M".ts|
  "RMORT@US.A".ts_eval= %Q|"RMORT@US.M".ts.aggregate(:year, :average)|
  "CPI@HON.A".ts_eval= %Q|"PC@HON.A".ts|
  "CPI@HON.Q".ts_eval= %Q|"PC@HON.Q".ts|
  "VLOSITNS@HI.M".ts_eval= %Q|"VDAYITNS@HI.M".ts / "VISITNS@HI.M".ts|
  "VLOSDMNS@LAN.M".ts_eval= %Q|"VDAYDMNS@LAN.M".ts / "VISDMNS@LAN.M".ts|
  "VEXPPDNS@MAU.M".ts_append_eval %Q|"VEXPNS@MAU.M".ts / "VDAYNS@MAU.M".ts*1000|
  "VEXPPDUSNS@HI.M".ts_append_eval %Q|"VEXPUSNS@HI.M".ts / "VDAYUSNS@HI.M".ts*1000|
  "E_PR@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - "EGV@HI.M".ts|
  "E_TRADE@HAW.M".ts_append_eval %Q|"EWT@HAW.M".ts + "ERT@HAW.M".ts|
  "LF_MC@HI.M".ts_eval= %Q|"LFSA@HI.M".ts / "LFSA@HI.M".ts.annual_sum * "LFNS@HI.M".ts.annual_sum|
  "E_LH@KAU.M".ts_append_eval %Q|"EAE@KAU.M".ts + "EAF@KAU.M".ts|
  "VDAYDM@HI.M".ts_eval= %Q|"VDAYDM@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VDAYDM@HI.M".ts_eval= %Q|"VDAYDM@HI.M".ts.apply_seasonal_adjustment :additive|
  
  "EGV@HON.M".ts_eval= %Q|"EGV@HI.M".ts.aa_county_share_for("HON")|
  "EGV@HON.M".ts_append_eval %Q|"EGVFD@HON.M".ts + "E_GVSL@HON.M".ts|
  
  
  "E_TTU@HAW.M".ts_append_eval %Q|"E_TU@HAW.M".ts + "E_TRADE@HAW.M".ts|
  "E_SVCPR@HAW.M".ts_append_eval %Q|"E_NF@HAW.M".ts - "E_GDSPR@HAW.M".ts|
  "E_SVCPR@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - "E_GDSPR@HI.M".ts|
  "E_TRADE@HON.M".ts_append_eval %Q|"EWT@HON.M".ts + "ERT@HON.M".ts|
  "E_GVSL@HAW.M".ts_append_eval %Q|"EGVST@HAW.M".ts + "EGVLC@HAW.M".ts|
  "E_GVSL@MAU.M".ts_append_eval %Q|"EGVST@MAU.M".ts + "EGVLC@MAU.M".ts|
  "EGV@MAU.M".ts_append_eval %Q|"EGVFD@MAU.M".ts + "E_GVSL@MAU.M".ts|
  
  
  
  "E_EDHC@MAU.M".ts_append_eval %Q|"EED@MAU.M".ts + "EHC@MAU.M".ts|
  "E_TRADE@MAU.M".ts_append_eval %Q|"EWT@MAU.M".ts + "ERT@MAU.M".ts|
  "E_TTU@MAU.M".ts_append_eval %Q|"E_TU@MAU.M".ts + "E_TRADE@MAU.M".ts|

  "E_GDSPR@MAU.M".ts_append_eval %Q|"ECT@MAU.M".ts + "EMN@MAU.M".ts|
  "E_EDHC@KAU.M".ts_append_eval %Q|"EED@KAU.M".ts + "EHC@KAU.M".ts|
  "E_TRADE@KAU.M".ts_append_eval %Q|"EWT@KAU.M".ts + "ERT@KAU.M".ts|
  "E_TTU@KAU.M".ts_append_eval %Q|"E_TU@KAU.M".ts + "E_TRADE@KAU.M".ts|
  "E_GDSPR@KAU.M".ts_append_eval %Q|"ECT@KAU.M".ts + "EMN@KAU.M".ts|
  "E_SV@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - ("ECT@HI.M".ts + "EMN@HI.M".ts + "E_TTU@HI.M".ts + "E_FIR@HI.M".ts + "EGV@HI.M".ts)|  
  "E_EDHC@HON.M".ts_append_eval %Q|"EED@HON.M".ts + "EHC@HON.M".ts|
  "E_GDSPR@HON.M".ts_append_eval %Q|"ECT@HON.M".ts + "EMN@HON.M".ts|
  "E_TU@HON.M".ts_eval= %Q|"E_TU@HI.M".ts.aa_county_share_for("HON")|
  "EAF@HAW.M".ts_eval= %Q|"EAFAC@HAW.M".ts + "EAFFD@HAW.M".ts|
  "EAF@MAU.M".ts_eval= %Q|"EAFAC@MAU.M".ts + "EAFFD@MAU.M".ts|
  "EAF@KAU.M".ts_eval= %Q|"EAFAC@KAU.M".ts + "EAFFD@KAU.M".ts|

  "EAFFD@HON.M".ts_eval= %Q|"EAFFD@HI.M".ts.aa_county_share_for("HON")|
  "EAF@HON.M".ts_eval= %Q|"EAFAC@HON.M".ts + "EAFFD@HON.M".ts|
  "E_TU_MC@HON.M".ts_eval= %Q|"E_TU@HON.M".ts / "E_TU@HON.M".ts.annual_sum * "E_TUNS@HON.M".ts.annual_sum|
  "EGV@HAW.M".ts_eval= %Q|"EGV@HI.M".ts.aa_county_share_for("HAW")|
  "EGV@HAW.M".ts_append_eval %Q|"EGVFD@HAW.M".ts + "E_GVSL@HAW.M".ts|
  "E_TTU@HON.M".ts_append_eval %Q|"E_TU@HON.M".ts + "E_TRADE@HON.M".ts|
  "E_NF@HAW.M".ts_append_eval %Q|"E_NF@HI.M".ts.aa_county_share_for("HAW")|

  "E_EDHC@HAW.M".ts_append_eval %Q|"EED@HAW.M".ts + "EHC@HAW.M".ts|

  "E_FIR@HAW.M".ts_append_eval %Q|"EFI@HAW.M".ts + "ERE@HAW.M".ts|
  "E_FIR@MAU.M".ts_append_eval %Q|"EFI@MAU.M".ts + "ERE@MAU.M".ts|
  
  "E_NF@HAW.M".ts_append_eval %Q|"ECT@HAW.M".ts + "EMN@HAW.M".ts + "E_TTU@HAW.M".ts + "EIF@HAW.M".ts + "E_FIR@HAW.M".ts + "E_PBS@HAW.M".ts + "E_EDHC@HAW.M".ts + "E_LH@HAW.M".ts + "EOS@HAW.M".ts + "EGV@HAW.M".ts|
  "E_NF@MAU.M".ts_append_eval %Q|"E_NF@HI.M".ts.aa_county_share_for("MAU")|
  "E_NF@MAU.M".ts_append_eval %Q|"ECT@MAU.M".ts + "EMN@MAU.M".ts + "E_TTU@MAU.M".ts + "EIF@MAU.M".ts + "E_FIR@MAU.M".ts + "E_PBS@MAU.M".ts + "E_EDHC@MAU.M".ts + "E_LH@MAU.M".ts + "EOS@MAU.M".ts + "EGV@MAU.M".ts|
  "E_NF@KAU.M".ts_append_eval %Q|"E_NF@HI.M".ts.aa_county_share_for("KAU")|
  "E_NF@KAU.M".ts_append_eval %Q|"ECT@KAU.M".ts + "EMN@KAU.M".ts + "E_TTU@KAU.M".ts + "EIF@KAU.M".ts + "E_FIR@KAU.M".ts + "E_PBS@KAU.M".ts + "E_EDHC@KAU.M".ts + "E_LH@KAU.M".ts + "EOS@KAU.M".ts + "EGV@KAU.M".ts|
  "VDAYUSNS@MAU.M".ts_eval= %Q|"VDAYUSENS@MAU.M".ts + "VDAYUSWNS@MAU.M".ts|
  
  "E_NF@HON.M".ts_append_eval %Q|"E_NF@HON.M".tsn.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/bls_sa_history.xls"|
  "E_NF@HON.M".ts_append_eval %Q|"E_NF@HI.M".ts.aa_county_share_for("HON")|
  "E_NF@HON.M".ts_append_eval %Q|"ECT@HON.M".ts + "EMN@HON.M".ts + "E_TTU@HON.M".ts + "EIF@HON.M".ts + "E_FIR@HON.M".ts + "E_PBS@HON.M".ts + "E_EDHC@HON.M".ts + "E_LH@HON.M".ts + "EOS@HON.M".ts + "EGV@HON.M".ts|
  # Series To finish: 203
  # -----end------













  "HPMT@HI.A".ts_eval= %Q|"PMKRSGFNS@HI.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "HPMT@HAW.A".ts_eval= %Q|"PMKRSGFNS@HAW.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "VDAYCANNS@MAU.M".ts_eval= %Q|"VRLSCANNS@MAU.M".ts * "VISCANNS@MAU.M".ts|
  "VDAYJPNS@MAU.M".ts_eval= %Q|"VRLSJPNS@MAU.M".ts * "VISJPNS@MAU.M".ts|
  "HYQUAL@HAW.A".ts_eval= %Q|"HPMT@HAW.A".ts*10/3*12.0|
  "HPMTCON@HI.A".ts_eval= %Q|"PMKRCONNS@HI.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "VIS@MAU.A".ts_eval= %Q|"VIS@MAU.M".ts.aggregate(:year, :sum)|

  "SH_RESNS@KAU.M".ts_eval= %Q|"VISRESNS@KAU.M".ts / "VISRESNS@HI.M".ts|
  "SH_RESNS@MAU.M".ts_eval= %Q|"VISRESNS@MAU.M".ts / "VISRESNS@HI.M".ts|
  "SH_USNS@MAUI.M".ts_eval= %Q|"VISUSNS@MAUI.M".ts / "VISUSNS@HI.M".ts|
  "YPCBEA_R@HI.A".ts_eval= %Q|"Y@HI.A".ts / ("CPI@HON.A".ts * "NR@HI.A".ts)|
  "YPCBEA_R@KAU.A".ts_eval= %Q|"Y@KAU.A".ts / ("CPI@HON.A".ts * "NR@KAU.A".ts)|
  "YPCBEA_R@MAU.A".ts_eval= %Q|"Y@MAU.A".ts / ("CPI@HON.A".ts * "NR@MAU.A".ts)|
  "PAFSGF@KAU.A".ts_eval= %Q|"YMED@KAU.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "PAFSGF@MAU.A".ts_eval= %Q|"YMED@MAU.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|

  "YPCBEA_R.A".ts_eval= %Q|"Y@HI.A".ts / "CPI@HON.A".ts * "NR@HI.A".ts|
  "HPMTCON@HAW.A".ts_eval= %Q|"PMKRCONNS@HAW.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "HYQUALCON@HAW.A".ts_eval= %Q|"HPMTCON@HAW.A".ts*10/3*12.0|
  "HPMT@MAU.A".ts_eval= %Q|"PMKRSGFNS@MAU.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "PAKRSGF@HI.Q".ts_eval= %Q|(("PAKRSGFNS@HON.Q".ts * "KRSGFNS@HON.Q".ts) + ("PAKRSGFNS@HAW.Q".ts * "KRSGFNS@HAW.Q".ts) + ("PAKRSGFNS@MAU.Q".ts * "KRSGFNS@MAU.Q".ts)  + ("PAKRSGFNS@KAU.Q".ts * "KRSGFNS@KAU.Q".ts))/ "KRSGFNS@HI.Q".ts|
  "PAKRCON@HI.Q".ts_eval= %Q|(("PAKRCONNS@HON.Q".ts * "KRCONNS@HON.Q".ts) + ("PAKRCONNS@HAW.Q".ts * "KRCONNS@HAW.Q".ts) + ("PAKRCONNS@MAU.Q".ts * "KRCONNS@MAU.Q".ts)  + ("PAKRCONNS@KAU.Q".ts * "KRCONNS@KAU.Q".ts))/ "KRCONNS@HI.Q".ts|
  "HYQUAL@HI.A".ts_eval= %Q|"HPMT@HI.A".ts*10/3*12.0|
  "PAFSGF@HON.A".ts_eval= %Q|"YMED@HON.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "VDAYJP_MC@HI.M".ts_eval= %Q|"VDAYJP@HI.M".ts / "VDAYJP@HI.M".ts.annual_sum * "VDAYJPNS@HI.M".ts.annual_sum|
  "VDAYJP_MC@KAU.M".ts_eval= %Q|"VDAYJP@KAU.M".ts / "VDAYJP@KAU.M".ts.annual_sum * "VDAYJPNS@KAU.M".ts.annual_sum|
  "VISJP_MC@HI.M".ts_eval= %Q|"VISJP@HI.M".ts / "VISJP@HI.M".ts.annual_sum * "VISJPNS@HI.M".ts.annual_sum|
  "VDAYIT_MC@HI.M".ts_eval= %Q|"VDAYIT@HI.M".ts / "VDAYIT@HI.M".ts.annual_sum * "VDAYITNS@HI.M".ts.annual_sum|
  "VDAYUS_MC@KAU.M".ts_eval= %Q|"VDAYUS@KAU.M".ts / "VDAYUS@KAU.M".ts.annual_sum * "VDAYUSNS@KAU.M".ts.annual_sum|
  "VDAYJP_MC@HON.M".ts_eval= %Q|"VDAYJP@HON.M".ts / "VDAYJP@HON.M".ts.annual_sum * "VDAYJPNS@HON.M".ts.annual_sum|
  "VISJP_MC@HON.M".ts_eval= %Q|"VISJP@HON.M".ts / "VISJP@HON.M".ts.annual_sum * "VISJPNS@HON.M".ts.annual_sum|
  "Y_R@KAU.A".ts_eval= %Q|"Y@KAU.A".ts / "CPI@HON.A".ts |
  "HAI@HAW.A".ts_eval= %Q|"YMED@HAW.A".ts / "HYQUAL@HAW.A".ts*100.0|
  "VISIT_MC@MAU.M".ts_eval= %Q|"VISIT@MAU.M".ts / "VISIT@MAU.M".ts.annual_sum * "VISITNS@MAU.M".ts.annual_sum|
  "VISIT_MC@KAU.M".ts_eval= %Q|"VISIT@KAU.M".ts / "VISIT@KAU.M".ts.annual_sum * "VISITNS@KAU.M".ts.annual_sum|
  "VDAYUS_MC@HAW.M".ts_eval= %Q|"VDAYUS@HAW.M".ts / "VDAYUS@HAW.M".ts.annual_sum * "VDAYUSNS@HAW.M".ts.annual_sum|
  "VISUS_MC@HON.M".ts_eval= %Q|"VISUS@HON.M".ts / "VISUS@HON.M".ts.annual_sum * "VISUSNS@HON.M".ts.annual_sum|
  "VDAYRES_MC@HON.M".ts_eval= %Q|"VDAYRES@HON.M".ts / "VDAYRES@HON.M".ts.annual_sum * "VDAYRESNS@HON.M".ts.annual_sum|
  "Y_R@HON.A".ts_eval= %Q|"Y@HON.A".ts / "CPI@HON.A".ts |
  "Y_R@HAW.A".ts_eval= %Q|"Y@HAW.A".ts / "CPI@HON.A".ts |
  "Y_R@MAU.A".ts_eval= %Q|"Y@MAU.A".ts / "CPI@HON.A".ts |
  "PAFSGF@HAW.A".ts_eval= %Q|"YMED@HAW.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "KRSGFNS_MC@HON.Q".ts_eval= %Q|"KRSGFNS@HON.Q".ts / ("KRSGFNS@HON.Q".ts + "KRSGFNS@HAW.Q".ts + "KRSGFNS@MAU.Q".ts + "KRSGFNS@KAU.Q".ts) * "KRSGFNS@HI.Q".ts|
  "KRSGFNS_MC@HAW.Q".ts_eval= %Q|"KRSGFNS@HAW.Q".ts / ("KRSGFNS@HON.Q".ts + "KRSGFNS@HAW.Q".ts + "KRSGFNS@MAU.Q".ts + "KRSGFNS@KAU.Q".ts) * "KRSGFNS@HI.Q".ts|
  "KRSGFNS_MC@MAU.Q".ts_eval= %Q|"KRSGFNS@MAU.Q".ts / ("KRSGFNS@HON.Q".ts + "KRSGFNS@HAW.Q".ts + "KRSGFNS@MAU.Q".ts + "KRSGFNS@KAU.Q".ts) * "KRSGFNS@HI.Q".ts|
  "KRSGFNS_MC@KAU.Q".ts_eval= %Q|"KRSGFNS@KAU.Q".ts / ("KRSGFNS@HON.Q".ts + "KRSGFNS@HAW.Q".ts + "KRSGFNS@MAU.Q".ts + "KRSGFNS@KAU.Q".ts) * "KRSGFNS@HI.Q".ts|
  "VISDM_MC@KAU.M".ts_eval= %Q|"VISDM@KAU.M".ts / "VISDM@KAU.M".ts.annual_sum * "VISDMNS@KAU.M".ts.annual_sum|
  "VISIT_MC@HON.M".ts_eval= %Q|"VISIT@HON.M".ts / "VISIT@HON.M".ts.annual_sum * "VISITNS@HON.M".ts.annual_sum|
  "VISIT_MC@HAW.M".ts_eval= %Q|"VISIT@HAW.M".ts / "VISIT@HAW.M".ts.annual_sum * "VISITNS@HAW.M".ts.annual_sum|
  "VLOSDMNS@KAU.M".ts_eval= %Q|"VDAYDMNS@KAU.M".ts / "VISDMNS@KAU.M".ts|
  "VLOSITNS@HAW.M".ts_eval= %Q|"VDAYITNS@HAW.M".ts / "VISITNS@HAW.M".ts|
  "VLOSDMNS@MOL.M".ts_eval= %Q|"VDAYDMNS@MOL.M".ts / "VISDMNS@MOL.M".ts|
  "PAKRSGFNS@HI.Q".ts_eval= %Q|"PAKRSGF@HI.Q".ts|
  "PAKRCONNS@HI.Q".ts_eval= %Q|"PAKRCON@HI.Q".ts|
  "INF@HON.Q".ts_eval= %Q|"CPI@HON.Q".ts.rebase("2010-01-01").annualized_percentage_change|
  "HPMT@HON.A".ts_eval= %Q|"PMKRSGFNS@HON.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "HYQUAL@HON.A".ts_eval= %Q|"HPMT@HON.A".ts*10/3*12.0|
  "HPMTCON@HON.A".ts_eval= %Q|"PMKRCONNS@HON.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "HPMTCON@KAU.A".ts_eval= %Q|"PMKRCONNS@KAU.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "HPMTCON@MAU.A".ts_eval= %Q|"PMKRCONNS@MAU.A".ts*0.8*("RMORT@US.A".ts/1200.0)/(((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "Y_R@HI.A".ts_eval= %Q|"Y@HI.A".ts / "CPI@HON.A".ts  |
  "HPMT@KAU.A".ts_eval= %Q|"PMKRSGFNS@KAU.A".ts * 0.8 * ("RMORT@US.A".ts/1200.0) / (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "VLOSJPNS@MAU.M".ts_eval= %Q|"VDAYJPNS@MAU.M".ts / "VISJPNS@MAU.M".ts|
  "Y_R@HI.Q".ts_eval= %Q|"Y@HI.Q".ts / "CPI@HON.Q".ts  * 100|
  "E@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts + "EAG@HI.M".ts|
  "VDAYDM_MC@HI.M".ts_eval= %Q|"VDAYDM@HI.M".ts / "VDAYDM@HI.M".ts.annual_sum * "VDAYDMNS@HI.M".ts.annual_sum|
  "VDAYUS_MC@HI.M".ts_eval= %Q|"VDAYUS@HI.M".ts / "VDAYUS@HI.M".ts.annual_sum * "VDAYUSNS@HI.M".ts.annual_sum|
  "VISIT_MC@HI.M".ts_eval= %Q|"VISIT@HI.M".ts / "VISIT@HI.M".ts.annual_sum * "VISITNS@HI.M".ts.annual_sum|
  "VDAYJP_MC@HAW.M".ts_eval= %Q|"VDAYJP@HAW.M".ts / "VDAYJP@HAW.M".ts.annual_sum * "VDAYJPNS@HAW.M".ts.annual_sum|
  "VISUS_MC@HAW.M".ts_eval= %Q|"VISUS@HAW.M".ts / "VISUS@HAW.M".ts.annual_sum * "VISUSNS@HAW.M".ts.annual_sum|
  "VISUS_MC@MAU.M".ts_eval= %Q|"VISUS@MAU.M".ts / "VISUS@MAU.M".ts.annual_sum * "VISUSNS@MAU.M".ts.annual_sum|
  "VISUS_MC@KAU.M".ts_eval= %Q|"VISUS@KAU.M".ts / "VISUS@KAU.M".ts.annual_sum * "VISUSNS@KAU.M".ts.annual_sum|
  "VISJP_MC@HAW.M".ts_eval= %Q|"VISJP@HAW.M".ts / "VISJP@HAW.M".ts.annual_sum * "VISJPNS@HAW.M".ts.annual_sum|
  "VISJP_MC@MAU.M".ts_eval= %Q|"VISJP@MAU.M".ts / "VISJP@MAU.M".ts.annual_sum * "VISJPNS@MAU.M".ts.annual_sum|
  "VDAY@HON.M".ts_append_eval %Q|"VDAYJP@HON.M".ts + "VDAYUS@HON.M".ts + "VDAYRES@HON.M".ts|
  "YPCBEA_R@HON.A".ts_eval= %Q|"Y@HON.A".ts / ("CPI@HON.A".ts * "NR@HON.A".ts)|
  "EMPL_MC@HON.M".ts_eval= %Q|"EMPL@HON.M".ts / "EMPL@HON.M".ts.annual_sum * "EMPLNS@HON.M".ts.annual_sum|
  "EMPL_MC@HAW.M".ts_eval= %Q|"EMPL@HAW.M".ts / "EMPL@HAW.M".ts.annual_sum * "EMPLNS@HAW.M".ts.annual_sum|
  "HAI@HON.A".ts_eval= %Q|"YMED@HON.A".ts / "HYQUAL@HON.A".ts*100.0|
  "KRCONNS_MC@HON.Q".ts_eval= %Q|"KRCONNS@HON.Q".ts / ("KRCONNS@HON.Q".ts + "KRCONNS@HAW.Q".ts + "KRCONNS@MAU.Q".ts + "KRCONNS@KAU.Q".ts) * "KRCONNS@HI.Q".ts|
  "PAFSGF@HI.A".ts_eval= %Q|"YMED@HI.A".ts/"RMORT@US.A".ts * (300/8.0) * (((("RMORT@US.A".ts/1200.0)+1)**-360)*-1+1)|
  "VISRESNS@MAUI.M".ts_eval= %Q|"VISNS@MAUI.M".ts - "VISUSNS@MAUI.M".ts - "VISJPNS@MAUI.M".ts|
  "VDAYRES_MC@HI.M".ts_eval= %Q|"VDAYRES@HI.M".ts / "VDAYRES@HI.M".ts.annual_sum * "VDAYRESNS@HI.M".ts.annual_sum|
  "VDAYUS_MC@HON.M".ts_eval= %Q|"VDAYUS@HON.M".ts / "VDAYUS@HON.M".ts.annual_sum * "VDAYUSNS@HON.M".ts.annual_sum|
  "HAI@HI.A".ts_eval= %Q|"YMED@HI.A".ts / "HYQUAL@HI.A".ts*100.0|
  "VDAYNS@MOL.M".ts_eval= %Q|"VDAYDMNS@MOL.M".ts + "VDAYITNS@MOL.M".ts|
  "VDAYNS@LAN.M".ts_eval= %Q|"VDAYDMNS@LAN.M".ts + "VDAYITNS@LAN.M".ts|
  "VDAYNS@KAU.M".ts_eval= %Q|"VDAYDMNS@KAU.M".ts + "VDAYITNS@KAU.M".ts|
  "VDAYRESNS@MAU.M".ts_eval= %Q|"VDAYNS@MAU.M".ts - "VDAYUSNS@MAU.M".ts + "VDAYJPNS@MAU.M".ts|
  "VDAYRESNS@HAW.M".ts_eval= %Q|"VDAYNS@HAW.M".ts - "VDAYUSNS@HAW.M".ts + "VDAYJPNS@HAW.M".ts|
  "VDAYRESNS@KAU.M".ts_eval= %Q|"VDAYNS@KAU.M".ts - "VDAYUSNS@KAU.M".ts + "VDAYJPNS@KAU.M".ts|
  "VDAYRESNS@MOL.M".ts_eval= %Q|"VDAYNS@MOL.M".ts - "VDAYUSNS@MOL.M".ts + "VDAYJPNS@MOL.M".ts|
  "VDAYRESNS@LAN.M".ts_eval= %Q|"VDAYNS@LAN.M".ts - "VDAYUSNS@LAN.M".ts + "VDAYJPNS@LAN.M".ts|
  "SH_RESNS@HI.M".ts_eval= %Q|"SH_RESNS@HON.M".ts + "SH_RESNS@HAW.M".ts + "SH_RESNS@KAU.M".ts + "SH_RESNS@MAU.M".ts|
    "VLOSCANNS@MAU.M".ts_eval= %Q|"VDAYCANNS@MAU.M".ts / "VISCANNS@MAU.M".ts|
    "VEXPPDNS@MOL.M".ts_append_eval %Q|"VEXPNS@MOL.M".ts / "VDAYNS@MOL.M".ts*1000|
    "VEXPPDNS@LAN.M".ts_append_eval %Q|"VEXPNS@LAN.M".ts / "VDAYNS@LAN.M".ts*1000|
    "VEXPPDNS@KAU.M".ts_append_eval %Q|"VEXPNS@KAU.M".ts / "VDAYNS@KAU.M".ts*1000|
    "VEXPPDNS@HAW.M".ts_append_eval %Q|"VEXPNS@HAW.M".ts / "VDAYNS@HAW.M".ts*1000|
    "VISRES_MC@HI.M".ts_eval= %Q|"VISRES@HI.M".ts / "VISRES@HI.M".ts.annual_sum * "VISRESNS@HI.M".ts.annual_sum|
    "VISJP_MC@KAU.M".ts_eval= %Q|"VISJP@KAU.M".ts / "VISJP@KAU.M".ts.annual_sum * "VISJPNS@KAU.M".ts.annual_sum|  
    "VIS@HAW.M".ts_append_eval %Q|"VISJP@HAW.M".ts + "VISUS@HAW.M".ts + "VISRES@HAW.M".ts|
  
    "EMPL_MC@MAU.M".ts_eval= %Q|"EMPL@MAU.M".ts / "EMPL@MAU.M".ts.annual_sum * "EMPLNS@MAU.M".ts.annual_sum|
    "EMPL_MC@KAU.M".ts_eval= %Q|"EMPL@KAU.M".ts / "EMPL@KAU.M".ts.annual_sum * "EMPLNS@KAU.M".ts.annual_sum|
    "LF@HI.M".ts_append_eval %Q|"LFSA@HI.M".ts|
    "LF@HI.M".ts_append_eval %Q|"LF_MC@HI.M".ts|
    "LF@HON.M".ts_eval= %Q|"LF@HI.M".ts.aa_county_share_for("HON")|
    "LF@HAW.M".ts_eval= %Q|"LF@HI.M".ts.aa_county_share_for("HAW")|
    "LF@MAU.M".ts_eval= %Q|"LF@HI.M".ts.aa_county_share_for("MAU")|
    "LF@KAU.M".ts_eval= %Q|"LF@HI.M".ts.aa_county_share_for("KAU")|
    "VDAYRES@KAU.M".ts_eval= %Q|"VDAYRES@HI.M".ts.mc_ma_county_share_for("KAU")|
    "VISRES@KAU.M".ts_eval= %Q|"VISRES@HI.M".ts.mc_ma_county_share_for("KAU")|
    "VDAYUS@MAU.M".ts_eval= %Q|"VDAYUS@HI.M".ts.mc_ma_county_share_for("MAU")|
    "VDAYRES@HAW.M".ts_eval= %Q|"VDAYRES@HI.M".ts.mc_ma_county_share_for("HAW")|
    "VDAYRES@MAU.M".ts_eval= %Q|"VDAYRES@HI.M".ts.mc_ma_county_share_for("MAU")|
    "VDAYJP@MAU.M".ts_eval= %Q|"VDAYJP@HI.M".ts.mc_ma_county_share_for("MAU")|
    "HAICON@HAW.A".ts_eval= %Q|"YMED@HAW.A".ts / "HYQUALCON@HAW.A".ts*100.0|
    "YPCBEA_R@HAW.A".ts_eval= %Q|"Y@HAW.A".ts / ("CPI@HON.A".ts * "NR@HAW.A".ts)|
    "VIS@KAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("KAU","VIS")|
    "VIS@KAU.M".ts_append_eval %Q|"VISJP@KAU.M".ts + "VISUS@KAU.M".ts + "VISRES@KAU.M".ts|
    "VIS@HON.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HON","VIS")|
    "VIS@HON.M".ts_append_eval %Q|"VISJP@HON.M".ts + "VISUS@HON.M".ts + "VISRES@HON.M".ts|

  # Series To finish: 44
  # -----end------













  "HYQUALCON@HI.A".ts_eval= %Q|"HPMTCON@HI.A".ts*10/3*12.0|
  "HYQUAL@KAU.A".ts_eval= %Q|"HPMT@KAU.A".ts*10/3*12.0|
  "HYQUAL@MAU.A".ts_eval= %Q|"HPMT@MAU.A".ts*10/3*12.0|
  
  "SH_RESNS@MAUI.M".ts_eval= %Q|"VISRESNS@MAUI.M".ts / "VISRESNS@HI.M".ts|
  "HYQUALCON@HON.A".ts_eval= %Q|"HPMTCON@HON.A".ts*10/3*12.0|
  "VIS@HON.A".ts_eval= %Q|"VIS@HON.M".ts.aggregate(:year, :sum)|
  "VIS@KAU.A".ts_eval= %Q|"VIS@KAU.M".ts.aggregate(:year, :sum)|
  "VDAYUS_MC@MAU.M".ts_eval= %Q|"VDAYUS@MAU.M".ts / "VDAYUS@MAU.M".ts.annual_sum * "VDAYUSNS@MAU.M".ts.annual_sum|
  "VDAYJP_MC@MAU.M".ts_eval= %Q|"VDAYJP@MAU.M".ts / "VDAYJP@MAU.M".ts.annual_sum * "VDAYJPNS@MAU.M".ts.annual_sum|
  "VDAYRES_MC@HAW.M".ts_eval= %Q|"VDAYRES@HAW.M".ts / "VDAYRES@HAW.M".ts.annual_sum * "VDAYRESNS@HAW.M".ts.annual_sum|
  "VDAYRES_MC@MAU.M".ts_eval= %Q|"VDAYRES@MAU.M".ts / "VDAYRES@MAU.M".ts.annual_sum * "VDAYRESNS@MAU.M".ts.annual_sum|
  "VDAYRES_MC@KAU.M".ts_eval= %Q|"VDAYRES@KAU.M".ts / "VDAYRES@KAU.M".ts.annual_sum * "VDAYRESNS@KAU.M".ts.annual_sum|
  "VISRES_MC@HAW.M".ts_eval= %Q|"VISRES@HAW.M".ts / "VISRES@HAW.M".ts.annual_sum * "VISRESNS@HAW.M".ts.annual_sum|
  "VISRES_MC@MAU.M".ts_eval= %Q|"VISRES@MAU.M".ts / "VISRES@MAU.M".ts.annual_sum * "VISRESNS@MAU.M".ts.annual_sum|
  "VISRES_MC@KAU.M".ts_eval= %Q|"VISRES@KAU.M".ts / "VISRES@KAU.M".ts.annual_sum * "VISRESNS@KAU.M".ts.annual_sum|
  "VDAY@HAW.M".ts_append_eval %Q|"VDAYJP@HAW.M".ts + "VDAYUS@HAW.M".ts + "VDAYRES@HAW.M".ts|
  "VDAY@MAU.M".ts_append_eval %Q|"VDAYJP@MAU.M".ts + "VDAYUS@MAU.M".ts + "VDAYRES@MAU.M".ts|
  "VDAY@KAU.M".ts_append_eval %Q|"VDAYJP@KAU.M".ts + "VDAYUS@KAU.M".ts + "VDAYRES@KAU.M".ts|
  "VISRES_MC@HON.M".ts_eval= %Q|"VISRES@HON.M".ts / "VISRES@HON.M".ts.annual_sum * "VISRESNS@HON.M".ts.annual_sum|
  "HYQUALCON@KAU.A".ts_eval= %Q|"HPMTCON@KAU.A".ts*10/3*12.0|
  "HYQUALCON@MAU.A".ts_eval= %Q|"HPMTCON@MAU.A".ts*10/3*12.0|
  "HAI@MAU.A".ts_eval= %Q|"YMED@MAU.A".ts / "HYQUAL@MAU.A".ts*100.0|
  "E_ELSE@HI.M".ts_append_eval %Q|"E_SV@HI.M".ts - ("EAF@HI.M".ts + "EHC@HI.M".ts)|
  "LF_MC@MAU.M".ts_eval= %Q|"LF@MAU.M".ts / "LF@MAU.M".ts.annual_sum * "LFNS@MAU.M".ts.annual_sum|
  "HAICON@MAU.A".ts_eval= %Q|"YMED@MAU.A".ts / "HYQUALCON@MAU.A".ts*100.0|
  "HAICON@HI.A".ts_eval= %Q|"YMED@HI.A".ts / "HYQUALCON@HI.A".ts*100.0|
  "VIS_MC@HON.M".ts_eval= %Q|"VIS@HON.M".ts / "VIS@HON.M".ts.annual_sum * "VISNS@HON.M".ts.annual_sum|
  "UR@HON.M".ts_eval= %Q|(("EMPL@HON.M".ts / "LF@HON.M".ts) * -1 + 1)*100|
  "UR@HAW.M".ts_eval= %Q|(("EMPL@HAW.M".ts / "LF@HAW.M".ts) * -1 + 1)*100|
  "UR@MAU.M".ts_eval= %Q|(("EMPL@MAU.M".ts / "LF@MAU.M".ts) * -1 + 1)*100|
  "UR@KAU.M".ts_eval= %Q|(("EMPL@KAU.M".ts / "LF@KAU.M".ts) * -1 + 1)*100|
  "UR_MC@HON.M".ts_eval= %Q|"UR@HON.M".ts / "UR@HON.M".ts.annual_sum * "URNS@HON.M".ts.annual_sum|
  "UR_MC@HAW.M".ts_eval= %Q|"UR@HAW.M".ts / "UR@HAW.M".ts.annual_sum * "URNS@HAW.M".ts.annual_sum|
  "UR_MC@MAU.M".ts_eval= %Q|"UR@MAU.M".ts / "UR@MAU.M".ts.annual_sum * "URNS@MAU.M".ts.annual_sum|
  "UR_MC@KAU.M".ts_eval= %Q|"UR@KAU.M".ts / "UR@KAU.M".ts.annual_sum * "URNS@KAU.M".ts.annual_sum|
  "LF_MC@HON.M".ts_eval= %Q|"LF@HON.M".ts / "LF@HON.M".ts.annual_sum * "LFNS@HON.M".ts.annual_sum|
  "LF_MC@HAW.M".ts_eval= %Q|"LF@HAW.M".ts / "LF@HAW.M".ts.annual_sum * "LFNS@HAW.M".ts.annual_sum|
  "LF_MC@KAU.M".ts_eval= %Q|"LF@KAU.M".ts / "LF@KAU.M".ts.annual_sum * "LFNS@KAU.M".ts.annual_sum|
  "HAI@KAU.A".ts_eval= %Q|"YMED@KAU.A".ts / "HYQUAL@KAU.A".ts*100.0|
  "HAICON@HON.A".ts_eval= %Q|"YMED@HON.A".ts / "HYQUALCON@HON.A".ts*100.0|
  "HAICON@KAU.A".ts_eval= %Q|"YMED@KAU.A".ts / "HYQUALCON@KAU.A".ts*100.0|
  "E_PR@HAW.M".ts_append_eval %Q|"E_NF@HAW.M".ts - "EGV@HAW.M".ts|
  "E_PR@KAU.M".ts_append_eval %Q|"E_NF@KAU.M".ts - "EGV@KAU.M".ts|
  "E_PR@HON.M".ts_append_eval %Q|"E_NF@HON.M".ts - "EGV@HON.M".ts|
  "E_PR@MAU.M".ts_append_eval %Q|"E_NF@MAU.M".ts - "EGV@MAU.M".ts|
  
  "E_SVCPR@KAU.M".ts_append_eval %Q|"E_NF@KAU.M".ts - "E_GDSPR@KAU.M".ts|
  "E_SVCPR@MAU.M".ts_append_eval %Q|"E_NF@MAU.M".ts - "E_GDSPR@MAU.M".ts|

  
  "E_SVCPR@HON.M".ts_append_eval %Q|"E_NF@HON.M".ts - "E_GDSPR@HON.M".ts|
  "E_PRSVCPR@HAW.M".ts_append_eval %Q|"E_SVCPR@HAW.M".ts - "EGV@HAW.M".ts|
  "E_PRSVCPR@HON.M".ts_append_eval %Q|"E_SVCPR@HON.M".ts - "EGV@HON.M".ts|
  "E_PRSVCPR@KAU.M".ts_append_eval %Q|"E_SVCPR@KAU.M".ts - "EGV@KAU.M".ts|
  "E_PRSVCPR@MAU.M".ts_append_eval %Q|"E_SVCPR@MAU.M".ts - "EGV@MAU.M".ts|
  "E_PRSVCPR@HI.M".ts_append_eval %Q|"E_SVCPR@HI.M".ts - "EGV@HI.M".ts|
  
  # Series To finish: 0
  # -----end------
end