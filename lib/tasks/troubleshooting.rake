task :test_rake => :environment do
  puts "all rakes are syntactically ok!"
  series_to_refresh = ["VEXP@HI.M"]
  eval_statements = []
  errors = []
  Series.run_all_dependencies(series_to_refresh, {}, errors, eval_statements)
end

# Definition fixes
task :def_update => :environment do
    updated_defs = {
    31206 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:NUMBER OF SHIP ARRIVALS:1:55", :col=>2, :frequency=>"M" })/1|,
    31713 => %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"CRUISE[or]CRUSE", :row=>"header:col:1:NUMBER OF SHIP ARRIVALS", :col=>"repeat:2:13", :frequency=>"M" })/1|,
    31717 => %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"CRUISE[or]CRUSE", :row=>"header:col:1:Big Island[or]Hawaii Island:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|,
    31210 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Big Island[or]hawaii island:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31205 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:ARRIVED BY AIR:1:55", :col=>2, :frequency=>"M" })/1000|,
    31203 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:TOTAL VISITORS:1:55", :col=>2, :frequency=>"M" })/1000|,
    31214 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Total days in Hawaii:1:55:no_okina", :col=>2, :frequency=>"M" })/1|,
    31212 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:during Cruise:1:55:sub", :col=>2, :frequency=>"M" })/1|,
    31207 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Oahu:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31208 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Kauai:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31209 => %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Maui County:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|
    }

    updated_defs.each do |key, value|
        DataSource.find(key).update_attributes(:eval => value)
      end
end


task :add_2014_seasonal_adjustment_method_change do
  sa_series = ["visdm@hon.m","visdm@mau.m","visdm@kau.m","visdm@haw.m","visit@hon.m","visit@mau.m","visit@kau.m","visit@haw.m","visus@hon.m","visus@mau.m","visus@kau.m","visus@haw.m","visuse@hon.m","visuse@mau.m","visuse@kau.m","visuse@haw.m","visusw@hon.m","visusw@mau.m","visusw@kau.m","visusw@haw.m","visjp@hon.m","visjp@mau.m","visjp@kau.m","visjp@haw.m","viscan@hon.m","viscan@mau.m","viscan@kau.m","viscan@haw.m","visres@hon.m","visres@mau.m","visres@kau.m","visres@haw.m","vdaydm@hon.m","vdaydm@mau.m","vdaydm@kau.m","vdaydm@haw.m","vdayit@hon.m","vdayit@mau.m","vdayit@kau.m","vdayit@haw.m","vdayus@hon.m","vdayus@mau.m","vdayus@kau.m","vdayus@haw.m","vdayuse@hon.m","vdayuse@mau.m","vdayuse@kau.m","vdayuse@haw.m","vdayusw@hon.m","vdayusw@mau.m","vdayusw@kau.m","vdayusw@haw.m","vdayjp@hon.m","vdayjp@mau.m","vdayjp@kau.m","vdayjp@haw.m","vdaycan@hon.m","vdaycan@mau.m","vdaycan@kau.m","vdaycan@haw.m","vdayres@hon.m","vdayres@mau.m","vdayres@kau.m","vdayres@haw.m","prm@hon.m","prm@mau.m","prm@kau.m","prm@haw.m","ocup%@hon.m","ocup%@mau.m","ocup%@kau.m","ocup%@haw.m","rmrv@hon.m","rmrv@mau.m","rmrv@kau.m","rmrv@haw.m", "vexp@hon.m","vexp@mau.m","vexp@kau.m","vexp@haw.m","vexppd@hon.m","vexppd@mau.m","vexppd@kau.m","vexppd@haw.m","vexppt@hon.m","vexppt@mau.m","vexppt@kau.m","vexppt@haw.m","vso@hon.m","vso@mau.m","vso@kau.m","vso@haw.m","vsodm@hon.m","vsodm@mau.m","vsodm@kau.m","vsodm@haw.m","vs@hon.m","vs@mau.m","vs@kau.m","vs@haw.m","vsdm@hon.m","vsdm@mau.m","vsdm@kau.m"]
  #sa_series_not_in_udaman =  ["pcdm@hon.m","pcdm@mau.m","pcdm@kau.m","pcdm@haw.m"]
  sa_series.each do |s|
    s.upcase.ts_eval= %Q|"#{s.upcase}".ts.apply_ns_growth_rate_sa|
  end
end

task :add_construction_series => :environment do
  "DOMSGFNS@HON.M".ts_eval= %Q|"DOMSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  "DOMCONNS@HON.M".ts_eval= %Q|"DOMCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  "MINVSGFNS@HON.M".ts_eval= %Q|"MINVSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  "MINVCONNS@HON.M".ts_eval= %Q|"MINVCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  "NLSGFNS@HON.M".ts_eval= %Q|"NLSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  "NLCONNS@HON.M".ts_eval= %Q|"NLCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  
  
  # "INVSGFNS@HON.M".ts_eval= %Q|"INVSGFNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  # "INVCONNS@HON.M".ts_eval= %Q|"INVCONNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hbr_detail_m.csv"|
  
  "DOMCONNS@MAU.M".ts_eval= %Q|"DOMCONNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|
  "DOMSGFNS@MAU.M".ts_eval= %Q|"DOMSGFNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/mbr_upd_m.csv"|
  
  "KBSGFNS@HAW.M".ts_eval= %Q|"KBSGFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "KBCONNS@HAW.M".ts_eval= %Q|"KBCONNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "PMKBSGFNS@HAW.M".ts_eval= %Q|"PMKBSGFNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "PMKBCONNS@HAW.M".ts_eval= %Q|"PMKBCONNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "KBSGFNS@KAU.M".ts_eval= %Q|"KBSGFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "KBCONNS@KAU.M".ts_eval= %Q|"KBCONNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "PMKBSGFNS@KAU.M".ts_eval= %Q|"PMKBSGFNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  "PMKBCONNS@KAU.M".ts_eval= %Q|"PMKBCONNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/hiinfo_upd_m.csv"|
  
  "KPGOVNS@HON.M".ts_eval= %Q|("KPGOVNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/BIA_M.xls")/1000|
  "KPGVONNS@HAW.M".ts_eval= %Q|("KPGVONNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/BIA_M.xls")/1000|
  "KPGOVNS@MAU.M".ts_eval= %Q|("KPGOVNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/BIA_M.xls")/1000|
  "KPGOVNS@KAU.M".ts_eval= %Q|("KPGOVNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/BIA_M.xls")/1000|
end

task :fix_VS_history_series => :environment do
  "VSNS@HI.M".ts_eval=%Q|("VSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@HI.M".ts_eval=%Q|("VSSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@HI.M".ts_eval=%Q|("VSCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@HI.M".ts_eval=%Q|("VSDMNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@HI.M".ts_eval=%Q|("VSDMSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@HI.M".ts_eval=%Q|("VSUSWSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@HI.M".ts_eval=%Q|("VSUSESCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@HI.M".ts_eval=%Q|("VSDMCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@HI.M".ts_eval=%Q|("VSITNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@HI.M".ts_eval=%Q|("VSITSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@HI.M".ts_eval=%Q|("VSJPSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@HI.M".ts_eval=%Q|("VSCANSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@HI.M".ts_eval=%Q|("VSOTACHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@HI.M".ts_eval=%Q|("VSAUSSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@HI.M".ts_eval=%Q|("VSOTSCHNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@HI.M".ts_eval=%Q|("VSITCHTNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSNS@HON.M".ts_eval=%Q|("VSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@HON.M".ts_eval=%Q|("VSSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@HON.M".ts_eval=%Q|("VSCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@HON.M".ts_eval=%Q|("VSDMNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@HON.M".ts_eval=%Q|("VSDMSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@HON.M".ts_eval=%Q|("VSUSWSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@HON.M".ts_eval=%Q|("VSUSESCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@HON.M".ts_eval=%Q|("VSDMCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@HON.M".ts_eval=%Q|("VSITNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@HON.M".ts_eval=%Q|("VSITSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@HON.M".ts_eval=%Q|("VSJPSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@HON.M".ts_eval=%Q|("VSCANSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@HON.M".ts_eval=%Q|("VSOTACHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@HON.M".ts_eval=%Q|("VSAUSSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@HON.M".ts_eval=%Q|("VSOTSCHNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@HON.M".ts_eval=%Q|("VSITCHTNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSNS@MAU.M".ts_eval=%Q|("VSNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@MAU.M".ts_eval=%Q|("VSSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@MAU.M".ts_eval=%Q|("VSCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@MAU.M".ts_eval=%Q|("VSDMNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@MAU.M".ts_eval=%Q|("VSDMSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@MAU.M".ts_eval=%Q|("VSUSWSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@MAU.M".ts_eval=%Q|("VSUSESCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@MAU.M".ts_eval=%Q|("VSDMCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@MAU.M".ts_eval=%Q|("VSITNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@MAU.M".ts_eval=%Q|("VSITSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@MAU.M".ts_eval=%Q|("VSJPSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@MAU.M".ts_eval=%Q|("VSCANSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@MAU.M".ts_eval=%Q|("VSOTACHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@MAU.M".ts_eval=%Q|("VSAUSSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@MAU.M".ts_eval=%Q|("VSOTSCHNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@MAU.M".ts_eval=%Q|("VSITCHTNS@MAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSNS@HAWK.M".ts_eval=%Q|("VSNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@HAWK.M".ts_eval=%Q|("VSSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@HAWK.M".ts_eval=%Q|("VSCHTNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@HAWK.M".ts_eval=%Q|("VSDMNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@HAWK.M".ts_eval=%Q|("VSDMSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@HAWK.M".ts_eval=%Q|("VSUSWSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@HAWK.M".ts_eval=%Q|("VSUSESCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@HAWK.M".ts_eval=%Q|("VSDMCHTNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@HAWK.M".ts_eval=%Q|("VSITNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@HAWK.M".ts_eval=%Q|("VSITSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@HAWK.M".ts_eval=%Q|("VSJPSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@HAWK.M".ts_eval=%Q|("VSCANSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@HAWK.M".ts_eval=%Q|("VSOTACHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@HAWK.M".ts_eval=%Q|("VSAUSSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@HAWK.M".ts_eval=%Q|("VSOTSCHNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@HAWK.M".ts_eval=%Q|("VSITCHTNS@HAWK.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSNS@HAWH.M".ts_eval=%Q|("VSNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@HAWH.M".ts_eval=%Q|("VSSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@HAWH.M".ts_eval=%Q|("VSCHTNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@HAWH.M".ts_eval=%Q|("VSDMNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@HAWH.M".ts_eval=%Q|("VSDMSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@HAWH.M".ts_eval=%Q|("VSUSWSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@HAWH.M".ts_eval=%Q|("VSUSESCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@HAWH.M".ts_eval=%Q|("VSDMCHTNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@HAWH.M".ts_eval=%Q|("VSITNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@HAWH.M".ts_eval=%Q|("VSITSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@HAWH.M".ts_eval=%Q|("VSJPSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@HAWH.M".ts_eval=%Q|("VSCANSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@HAWH.M".ts_eval=%Q|("VSOTACHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@HAWH.M".ts_eval=%Q|("VSAUSSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@HAWH.M".ts_eval=%Q|("VSOTSCHNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@HAWH.M".ts_eval=%Q|("VSITCHTNS@HAWH.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSNS@KAU.M".ts_eval=%Q|("VSNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSSCHNS@KAU.M".ts_eval=%Q|("VSSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCHTNS@KAU.M".ts_eval=%Q|("VSCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMNS@KAU.M".ts_eval=%Q|("VSDMNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMSCHNS@KAU.M".ts_eval=%Q|("VSDMSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSWSCHNS@KAU.M".ts_eval=%Q|("VSUSWSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSUSESCHNS@KAU.M".ts_eval=%Q|("VSUSESCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSDMCHTNS@KAU.M".ts_eval=%Q|("VSDMCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITNS@KAU.M".ts_eval=%Q|("VSITNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITSCHNS@KAU.M".ts_eval=%Q|("VSITSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSJPSCHNS@KAU.M".ts_eval=%Q|("VSJPSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSCANSCHNS@KAU.M".ts_eval=%Q|("VSCANSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTACHNS@KAU.M".ts_eval=%Q|("VSOTACHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSAUSSCHNS@KAU.M".ts_eval=%Q|("VSAUSSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSOTSCHNS@KAU.M".ts_eval=%Q|("VSOTSCHNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
  "VSITCHTNS@KAU.M".ts_eval=%Q|("VSITCHTNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/manual/seats_0711.csv")/1000|
end