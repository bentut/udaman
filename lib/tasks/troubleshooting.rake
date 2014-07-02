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

task :fix_bea_series_june_2014 => :environment do
  series_to_modify = [
  "YLAGFA@HI.A",
  "YL_NF@HI.A",
  "YL_PR@HI.A",
  "YLAGFF@HI.A",
  "YLAGFFFO@HI.A",
  "YLAGFFFS@HI.A",
  "YLAGFFSP@HI.A",
  "YLMI@HI.A",
  "YLMIOG@HI.A",
  "YLMIMI@HI.A",
  "YLMISP@HI.A",
  "YLUT@HI.A",
  "YLCT@HI.A",
  "YLCTBL@HI.A",
  "YLCTHV@HI.A",
  "YLCTSP@HI.A",
  "YLMN@HI.A",
  "YLMNDR@HI.A",
  "YLMNDRWD@HI.A",
  "YLMNDRNM@HI.A",
  "YLMNDRPM@HI.A",
  "YLMNDRFB@HI.A",
  "YLMNDRMC@HI.A",
  "YLMNDRCM@HI.A",
  "YLMNDREL@HI.A",
  "YLMNDRMV@HI.A",
  "YLMNDRTR@HI.A",
  "YLMNDRFR@HI.A",
  "YLMNDRFR@HI.A",
  "YLMNND@HI.A",
  "YLMNNDFD@HI.A",
  "YLMNNDBV@HI.A",
  "YLMNNDXM@HI.A",
  "YLMNNDXP@HI.A",
  "YLMNNDAP@HI.A",
  "YLMNNDLT@HI.A",
  "YLMNNDPA@HI.A",
  "YLMNNDPR@HI.A",
  "YLMNNDPT@HI.A",
  "YLMNNDCH@HI.A",
  "YLMNNDPL@HI.A",
  "YLWT@HI.A",
  "YLRT@HI.A",
  "YLRTMV@HI.A",
  "YLRTFR@HI.A",
  "YLRTEL@HI.A",
  "YLRTBL@HI.A",
  "YLRTFD@HI.A",
  "YLRTHC@HI.A",
  "YLRTGA@HI.A",
  "YLRTCL@HI.A",
  "YLRTSP@HI.A",
  "YLRTGM@HI.A",
  "YLRTMS@HI.A",
  "YLRTOT@HI.A",
  "YLTW@HI.A",
  "YLTWTA@HI.A",
  "YLTWTR@HI.A",
  "YLTWTW@HI.A",
  "YLTWTT@HI.A",
  "YLTWTG@HI.A",
  "YLTWPL@HI.A",
  "YLTWSC@HI.A",
  "YLTWSP@HI.A",
  "YLTWCU@HI.A",
  "YLTWWH@HI.A",
  "YLIF@HI.A",
  "YLIFPB@HI.A",
  "YLIFMP@HI.A",
  "YLIFBC@HI.A",
  "YLIFIT@HI.A",
  "YLIFTC@HI.A",
  "YLIFDP@HI.A",
  "YLIFOT@HI.A",
  "YLFI@HI.A",
  "YLFIMO@HI.A",
  "YLFICR@HI.A",
  "YLFISE@HI.A",
  "YLFIIN@HI.A",
  "YLFIOT@HI.A",
  "YLRE@HI.A",
  "YLRERE@HI.A",
  "YLRERL@HI.A",
  "YLRELE@HI.A",
  "YLPS@HI.A",
  "YLMA@HI.A",
  "YLAD@HI.A",
  "YLADAD@HI.A",
  "YLADWM@HI.A",
  "YLED@HI.A",
  "YLHC@HI.A",
  "YLHCAM@HI.A",
  "YLHCHO@HI.A",
  "YLHCNR@HI.A",
  "YLHCSO@HI.A",
  "YLAE@HI.A",
  "YLAEPF@HI.A",
  "YLAEMU@HI.A",
  "YLAERE@HI.A",
  "YLAF@HI.A",
  "YLAFAC@HI.A",
  "YLAFFD@HI.A",
  "YLOS@HI.A",
  "YLOSRP@HI.A",
  "YLOSPL@HI.A",
  "YLOSMA@HI.A",
  "YLOSHH@HI.A",
  "YLGV@HI.A",
  "YLGVFD@HI.A",
  "YLGVML@HI.A",
  "YL_GVSL@HI.A",
  "YLGVST@HI.A",
  "YLGVLC@HI.A",
  "YLAGFA@HON.A",
  "YL_NF@HON.A",
  "YL_PR@HON.A",
  "YLAGFF@HON.A",
  "YLMI@HON.A",
  "YLUT@HON.A",
  "YLCT@HON.A",
  "YLMN@HON.A",
  "YLMNDR@HON.A",
  "YLMNND@HON.A",
  "YLWT@HON.A",
  "YLRT@HON.A",
  "YLTW@HON.A",
  "YLIF@HON.A",
  "YLFI@HON.A",
  "YLRE@HON.A",
  "YLPS@HON.A",
  "YLMA@HON.A",
  "YLAD@HON.A",
  "YLED@HON.A",
  "YLHC@HON.A",
  "YLAE@HON.A",
  "YLAF@HON.A",
  "YLAFAC@HON.A",
  "YLAFFD@HON.A",
  "YLOS@HON.A",
  "YLGV@HON.A",
  "YLGVFD@HON.A",
  "YLGVML@HON.A",
  "YL_GVSL@HON.A",
  "YLGVST@HON.A",
  "YLGVLC@HON.A",
  "YLAGFA@MAU.A",
  "YL_NF@MAU.A",
  "YL_PR@MAU.A",
  "YLAGFF@MAU.A",
  "YLMI@MAU.A",
  "YLUT@MAU.A",
  "YLCT@MAU.A",
  "YLMN@MAU.A",
  "YLMNDR@MAU.A",
  "YLMNND@MAU.A",
  "YLWT@MAU.A",
  "YLRT@MAU.A",
  "YLTW@MAU.A",
  "YLIF@MAU.A",
  "YLFI@MAU.A",
  "YLRE@MAU.A",
  "YLPS@MAU.A",
  "YLMA@MAU.A",
  "YLAD@MAU.A",
  "YLED@MAU.A",
  "YLHC@MAU.A",
  "YLAE@MAU.A",
  "YLAF@MAU.A",
  "YLAFAC@MAU.A",
  "YLAFFD@MAU.A",
  "YLOS@MAU.A",
  "YLGV@MAU.A",
  "YLGVFD@MAU.A",
  "YLGVML@MAU.A",
  "YL_GVSL@MAU.A",
  "YLGVST@MAU.A",
  "YLGVLC@MAU.A",
  "YLAGFA@HAW.A",
  "YL_NF@HAW.A",
  "YL_PR@HAW.A",
  "YLAGFF@HAW.A",
  "YLMI@HAW.A",
  "YLUT@HAW.A",
  "YLCT@HAW.A",
  "YLMN@HAW.A",
  "YLMNDR@HAW.A",
  "YLMNND@HAW.A",
  "YLWT@HAW.A",
  "YLRT@HAW.A",
  "YLTW@HAW.A",
  "YLIF@HAW.A",
  "YLFI@HAW.A",
  "YLRE@HAW.A",
  "YLPS@HAW.A",
  "YLMA@HAW.A",
  "YLAD@HAW.A",
  "YLED@HAW.A",
  "YLHC@HAW.A",
  "YLAE@HAW.A",
  "YLAF@HAW.A",
  "YLAFAC@HAW.A",
  "YLAFFD@HAW.A",
  "YLOS@HAW.A",
  "YLGV@HAW.A",
  "YLGVFD@HAW.A",
  "YLGVML@HAW.A",
  "YL_GVSL@HAW.A",
  "YLGVST@HAW.A",
  "YLGVLC@HAW.A",
  "YLAGFA@KAU.A",
  "YL_NF@KAU.A",
  "YL_PR@KAU.A",
  "YLAGFF@KAU.A",
  "YLMI@KAU.A",
  "YLUT@KAU.A",
  "YLCT@KAU.A",
  "YLMN@KAU.A",
  "YLMNDR@KAU.A",
  "YLMNND@KAU.A",
  "YLWT@KAU.A",
  "YLRT@KAU.A",
  "YLTW@KAU.A",
  "YLIF@KAU.A",
  "YLFI@KAU.A",
  "YLRE@KAU.A",
  "YLPS@KAU.A",
  "YLMA@KAU.A",
  "YLAD@KAU.A",
  "YLED@KAU.A",
  "YLHC@KAU.A",
  "YLAE@KAU.A",
  "YLAF@KAU.A",
  "YLAFAC@KAU.A",
  "YLAFFD@KAU.A",
  "YLOS@KAU.A",
  "YLGV@KAU.A",
  "YLGVFD@KAU.A",
  "YLGVML@KAU.A",
  "YL_GVSL@KAU.A",
  "YLGVST@KAU.A",
  "YLGVLC@KAU.A",
  "YLAGFA@HI.Q",
  "YL_NF@HI.Q",
  "YL_PR@HI.Q",
  "YLAGFF@HI.Q",
  "YLMI@HI.Q",
  "YLUT@HI.Q",
  "YLCT@HI.Q",
  "YLMN@HI.Q",
  "YLMNDR@HI.Q",
  "YLMNND@HI.Q",
  "YLWT@HI.Q",
  "YLRT@HI.Q",
  "YLTW@HI.Q",
  "YLIF@HI.Q",
  "YLFI@HI.Q",
  "YLRE@HI.Q",
  "YLPS@HI.Q",
  "YLMA@HI.Q",
  "YLAD@HI.Q",
  "YLED@HI.Q",
  "YLHC@HI.Q",
  "YLAE@HI.Q",
  "YLAF@HI.Q",
  "YLOS@HI.Q",
  "YLGV@HI.Q",
  "YLGVFD@HI.Q",
  "YLGVML@HI.Q",
  "YL_GVSL@HI.Q",
  "YCAGFA@HI.A",
  "YC_NF@HI.A",
  "YC_PR@HI.A",
  "YCAGFFO@HI.A",
  "YCAGFFFO@HI.A",
  "YLAGFFFS@HI.A",
  "YCAGFFSP@HI.A",
  "YCMI@HI.A",
  "YCMIOG@HI.A",
  "YCMIMI@HI.A",
  "YCMISP@HI.A",
  "YCUT@HI.A",
  "YCCT@HI.A",
  "YCCTBL@HI.A",
  "YCCTHV@HI.A",
  "YCCTSP@HI.A",
  "YCMN@HI.A",
  "YCMNDR@HI.A",
  "YCMNDRWD@HI.A",
  "YCMNDRNM@HI.A",
  "YCMNDRPM@HI.A",
  "YCMNDRFB@HI.A",
  "YCMNDRMC@HI.A",
  "YCMNDRCM@HI.A",
  "YCMNDREL@HI.A",
  "YCMNDRMV@HI.A",
  "YCMNDRTR@HI.A",
  "YCMNDRFR@HI.A",
  "YCMNDRFR@HI.A",
  "YCMNND@HI.A",
  "YCMNNDFD@HI.A",
  "YCMNNDBV@HI.A",
  "YCMNNDXM@HI.A",
  "YCMNNDXP@HI.A",
  "YCMNNDAP@HI.A",
  "YCMNNDLT@HI.A",
  "YCMNNDPA@HI.A",
  "YCMNNDPR@HI.A",
  "YCMNNDPT@HI.A",
  "YCMNNDCH@HI.A",
  "YCMNNDPL@HI.A",
  "YCWT@HI.A",
  "YCRT@HI.A",
  "YCRTMV@HI.A",
  "YCRTFR@HI.A",
  "YCRTEL@HI.A",
  "YCRTBL@HI.A",
  "YCRTFD@HI.A",
  "YCRTHC@HI.A",
  "YCRTGA@HI.A",
  "YCRTCL@HI.A",
  "YCRTSP@HI.A",
  "YCRTGM@HI.A",
  "YCRTMS@HI.A",
  "YCRTOT@HI.A",
  "YCTW@HI.A",
  "YCTWTA@HI.A",
  "YCTWTR@HI.A",
  "YCTWTW@HI.A",
  "YCTWTT@HI.A",
  "YCTWTG@HI.A",
  "YCTWPL@HI.A",
  "YCTWSC@HI.A",
  "YCTWSP@HI.A",
  "YCTWCU@HI.A",
  "YCTWWH@HI.A",
  "YCIF@HI.A",
  "YCIFPB@HI.A",
  "YCIFMP@HI.A",
  "YCIFBC@HI.A",
  "YCIFIT@HI.A",
  "YCIFTC@HI.A",
  "YCIFDP@HI.A",
  "YCIFOT@HI.A",
  "YCFI@HI.A",
  "YCFIMO@HI.A",
  "YCFICR@HI.A",
  "YCFISE@HI.A",
  "YCFIIN@HI.A",
  "YCFIOT@HI.A",
  "YCRE@HI.A",
  "YCRERE@HI.A",
  "YCRERL@HI.A",
  "YCRELE@HI.A",
  "YCPS@HI.A",
  "YCMA@HI.A",
  "YCAD@HI.A",
  "YCADAD@HI.A",
  "YCADWM@HI.A",
  "YCED@HI.A",
  "YCHC@HI.A",
  "YCHCAM@HI.A",
  "YCHCHO@HI.A",
  "YCHCNR@HI.A",
  "YCHCSO@HI.A",
  "YCAE@HI.A",
  "YCAEPF@HI.A",
  "YCAEMU@HI.A",
  "YCAERE@HI.A",
  "YCAF@HI.A",
  "YCAFAC@HI.A",
  "YCAFFD@HI.A",
  "YCOS@HI.A",
  "YCOSRP@HI.A",
  "YCOSPL@HI.A",
  "YCOSMA@HI.A",
  "YCOSHH@HI.A",
  "YCGV@HI.A",
  "YCGVFD@HI.A",
  "YCGVML@HI.A",
  "YC_GVSL@HI.A",
  "YCGVST@HI.A",
  "YCGVLC@HI.A",
  "YCAGFA@HON.A",
  "YC_NF@HON.A",
  "YC_PR@HON.A",
  "YCAGFFO@HON.A",
  "YCMI@HON.A",
  "YCUT@HON.A",
  "YCCT@HON.A",
  "YCMN@HON.A",
  "YCMNDR@HON.A",
  "YCMNND@HON.A",
  "YCWT@HON.A",
  "YCRT@HON.A",
  "YCTW@HON.A",
  "YCIF@HON.A",
  "YCFI@HON.A",
  "YCRE@HON.A",
  "YCPS@HON.A",
  "YCMA@HON.A",
  "YCAD@HON.A",
  "YCED@HON.A",
  "YCHC@HON.A",
  "YCAE@HON.A",
  "YCAF@HON.A",
  "YCAFAC@HON.A",
  "YCAFFD@HON.A",
  "YCOS@HON.A",
  "YCGV@HON.A",
  "YCGVFD@HON.A",
  "YCGVML@HON.A",
  "YC_GVSL@HON.A",
  "YCGVST@HON.A",
  "YCGVLC@HON.A",
  "YCAGFA@MAU.A",
  "YC_NF@MAU.A",
  "YC_PR@MAU.A",
  "YCAGFFO@MAU.A",
  "YCMI@MAU.A",
  "YCUT@MAU.A",
  "YCCT@MAU.A",
  "YCMN@MAU.A",
  "YCMNDR@MAU.A",
  "YCMNND@MAU.A",
  "YCWT@MAU.A",
  "YCRT@MAU.A",
  "YCTW@MAU.A",
  "YCIF@MAU.A",
  "YCFI@MAU.A",
  "YCRE@MAU.A",
  "YCPS@MAU.A",
  "YCMA@MAU.A",
  "YCAD@MAU.A",
  "YCED@MAU.A",
  "YCHC@MAU.A",
  "YCAE@MAU.A",
  "YCAF@MAU.A",
  "YCAFAC@MAU.A",
  "YCAFFD@MAU.A",
  "YCOS@MAU.A",
  "YCGV@MAU.A",
  "YCGVFD@MAU.A",
  "YCGVML@MAU.A",
  "YC_GVSL@MAU.A",
  "YCGVST@MAU.A",
  "YCGVLC@MAU.A",
  "YCAGFA@HAW.A",
  "YC_NF@HAW.A",
  "YC_PR@HAW.A",
  "YCAGFFO@HAW.A",
  "YCMI@HAW.A",
  "YCUT@HAW.A",
  "YCCT@HAW.A",
  "YCMN@HAW.A",
  "YCMNDR@HAW.A",
  "YCMNND@HAW.A",
  "YCWT@HAW.A",
  "YCRT@HAW.A",
  "YCTW@HAW.A",
  "YCIF@HAW.A",
  "YCFI@HAW.A",
  "YCRE@HAW.A",
  "YCPS@HAW.A",
  "YCMA@HAW.A",
  "YCAD@HAW.A",
  "YCED@HAW.A",
  "YCHC@HAW.A",
  "YCAE@HAW.A",
  "YCAF@HAW.A",
  "YCAFAC@HAW.A",
  "YCAFFD@HAW.A",
  "YCOS@HAW.A",
  "YCGV@HAW.A",
  "YCGVFD@HAW.A",
  "YCGVML@HAW.A",
  "YC_GVSL@HAW.A",
  "YCGVST@HAW.A",
  "YCGVLC@HAW.A",
  "YCAGFA@KAU.A",
  "YC_NF@KAU.A",
  "YC_PR@KAU.A",
  "YCAGFFO@KAU.A",
  "YCMI@KAU.A",
  "YCUT@KAU.A",
  "YCCT@KAU.A",
  "YCMN@KAU.A",
  "YCMNDR@KAU.A",
  "YCMNND@KAU.A",
  "YCWT@KAU.A",
  "YCRT@KAU.A",
  "YCTW@KAU.A",
  "YCIF@KAU.A",
  "YCFI@KAU.A",
  "YCRE@KAU.A",
  "YCPS@KAU.A",
  "YCMA@KAU.A",
  "YCAD@KAU.A",
  "YCED@KAU.A",
  "YCHC@KAU.A",
  "YCAE@KAU.A",
  "YCAF@KAU.A",
  "YCAFAC@KAU.A",
  "YCAFFD@KAU.A",
  "YCOS@KAU.A",
  "YCGV@KAU.A",
  "YCGVFD@KAU.A",
  "YCGVML@KAU.A",
  "YC_GVSL@KAU.A",
  "YCGVST@KAU.A",
  "YCGVLC@KAU.A"
  ]
  
  #(DataSource.where("eval LIKE '%load_from_download%'").reject {|ds| series_to_modify.index(ds.series.name).nil? }).each {|ds| ds.delete}
  
  "YLAGFA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:81:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_NF@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:82:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_PR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:90:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFF@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFFFO@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:101:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFFFS@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:102:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFFSP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:103:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMI@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMIOG@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:201:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMIMI@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:202:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMISP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:203:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLUT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCTBL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:401:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCTHV@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:402:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCTSP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:403:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMN@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:510:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRWD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:511:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRNM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:512:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRPM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:513:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRFB@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:514:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRMC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:515:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRCM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:516:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDREL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:517:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRMV@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:518:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRTR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:519:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRFR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:521:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDRFR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:522:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNND@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:530:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDFD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:531:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDBV@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:532:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDXM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:533:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDXP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:534:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDAP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:535:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDLT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:536:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDPA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:537:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDPR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:538:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDPT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:539:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDCH@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:541:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNNDPL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:542:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLWT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTMV@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:701:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTFR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:702:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTEL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:703:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTBL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:704:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTFD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:705:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTHC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:706:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTGA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:707:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTCL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:708:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTSP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:709:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTGM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:711:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTMS@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:712:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRTOT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:713:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTW@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWTA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWTR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWTW@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:803:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWTT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:804:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWTG@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:805:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWPL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:806:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWSC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:807:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWSP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:808:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWCU@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:809:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTWWH@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:811:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIF@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFPB@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:901:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFMP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:902:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFBC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:903:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFIT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:904:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFTC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:905:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFDP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:906:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIFOT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:907:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFI@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFIMO@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFICR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFISE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1003:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFIIN@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1004:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFIOT@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1005:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRERE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1101:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRERL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1102:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRELE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1103:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLPS@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLADAD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1401:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLADWM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1402:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLED@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHCAM@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1601:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHCHO@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1602:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHCNR@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1603:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHCSO@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1604:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAEPF@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1701:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAEMU@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1702:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAERE@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1703:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAF@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFAC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFFD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOS@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOSRP@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1901:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOSPL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1902:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOSMA@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1903:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOSHH@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1904:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGV@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVFD@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVML@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_GVSL@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2010:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVST@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2011:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVLC@HI.A".ts_eval= %Q|Series.load_from_download "SA05N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2012:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFA@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_NF@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_PR@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFF@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMI@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLUT@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCT@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMN@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDR@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNND@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLWT@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRT@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTW@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIF@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFI@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRE@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLPS@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMA@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAD@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLED@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHC@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAE@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAF@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFAC@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFFD@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOS@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGV@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVFD@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVML@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_GVSL@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVST@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVLC@HON.A".ts_eval= %Q|Series.load_from_download "CA05N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFA@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_NF@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_PR@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFF@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMI@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLUT@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCT@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMN@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDR@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNND@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLWT@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRT@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTW@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIF@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFI@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRE@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLPS@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMA@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAD@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLED@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHC@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAE@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAF@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFAC@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFFD@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOS@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGV@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVFD@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVML@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_GVSL@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVST@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVLC@MAU.A".ts_eval= %Q|Series.load_from_download "CA05N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFA@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_NF@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_PR@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFF@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMI@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLUT@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCT@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMN@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDR@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNND@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLWT@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRT@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTW@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIF@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFI@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRE@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLPS@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMA@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAD@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLED@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHC@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAE@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAF@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFAC@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFFD@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOS@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGV@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVFD@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVML@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_GVSL@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVST@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVLC@HAW.A".ts_eval= %Q|Series.load_from_download "CA05N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFA@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_NF@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_PR@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFF@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMI@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLUT@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLCT@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMN@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNDR@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMNND@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLWT@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRT@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLTW@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLIF@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLFI@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLRE@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLPS@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLMA@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAD@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLED@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLHC@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAE@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAF@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFAC@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAFFD@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLOS@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGV@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVFD@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVML@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YL_GVSL@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVST@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLGVLC@KAU.A".ts_eval= %Q|Series.load_from_download "CA05N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:142", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFA@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:81:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YL_NF@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:82:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YL_PR@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:90:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLAGFF@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:100:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLMI@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:200:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLUT@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:300:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLCT@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:400:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLMN@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:500:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLMNDR@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:510:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLMNND@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:530:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLWT@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:600:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLRT@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:700:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLTW@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:800:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLIF@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:900:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLFI@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1000:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLRE@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1100:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLPS@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1200:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLMA@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1300:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLAD@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1400:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLED@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1500:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLHC@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1600:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLAE@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1700:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLAF@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1800:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLOS@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1900:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLGV@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2000:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLGVFD@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2001:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YLGVML@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2002:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YL_GVSL@HI.Q".ts_eval= %Q|Series.load_from_download "SQ5N@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2010:6:55", :col => "increment:5:1", :frequency => "Q" }|
  "YCAGFA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:81:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_NF@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:82:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_PR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:90:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFO@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFFO@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:101:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YLAGFFFS@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:102:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFSP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:103:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMI@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMIOG@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:201:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMIMI@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:202:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMISP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:203:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCUT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCTBL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:401:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCTHV@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:402:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCTSP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:403:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMN@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:510:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRWD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:511:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRNM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:512:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRPM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:513:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRFB@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:514:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRMC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:515:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRCM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:516:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDREL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:517:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRMV@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:518:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRTR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:519:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRFR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:521:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDRFR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:522:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNND@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:530:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDFD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:531:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDBV@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:532:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDXM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:533:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDXP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:534:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDAP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:535:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDLT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:536:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDPA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:537:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDPR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:538:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDPT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:539:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDCH@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:541:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNNDPL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:542:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCWT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTMV@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:701:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTFR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:702:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTEL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:703:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTBL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:704:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTFD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:705:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTHC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:706:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTGA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:707:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTCL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:708:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTSP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:709:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTGM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:711:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTMS@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:712:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRTOT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:713:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTW@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWTA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWTR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWTW@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:803:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWTT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:804:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWTG@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:805:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWPL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:806:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWSC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:807:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWSP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:808:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWCU@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:809:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTWWH@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:811:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIF@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFPB@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:901:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFMP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:902:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFBC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:903:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFIT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:904:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFTC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:905:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFDP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:906:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIFOT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:907:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFI@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFIMO@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFICR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFISE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1003:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFIIN@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1004:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFIOT@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1005:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRERE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1101:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRERL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1102:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRELE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1103:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCPS@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCADAD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1401:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCADWM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1402:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCED@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHCAM@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1601:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHCHO@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1602:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHCNR@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1603:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHCSO@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1604:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAEPF@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1701:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAEMU@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1702:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAERE@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1703:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAF@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFAC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFFD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOS@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOSRP@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1901:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOSPL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1902:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOSMA@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1903:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOSHH@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:1904:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGV@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVFD@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVML@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_GVSL@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2010:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVST@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2011:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVLC@HI.A".ts_eval= %Q|Series.load_from_download "SA06N_HI@bea.gov", { :file_type => "csv", :start_date => "1998-01-01", :row => "header_range:col:3:2012:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFA@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_NF@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_PR@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFO@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMI@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCUT@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCT@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMN@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDR@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNND@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCWT@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRT@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTW@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIF@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFI@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRE@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCPS@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMA@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAD@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCED@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHC@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAE@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAF@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFAC@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFFD@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOS@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGV@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVFD@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVML@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_GVSL@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVST@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVLC@HON.A".ts_eval= %Q|Series.load_from_download "CA06N_HON@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFA@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_NF@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_PR@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFO@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMI@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCUT@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCT@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMN@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDR@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNND@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCWT@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRT@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTW@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIF@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFI@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRE@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCPS@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMA@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAD@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCED@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHC@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAE@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAF@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFAC@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFFD@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOS@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGV@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVFD@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVML@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_GVSL@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVST@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVLC@MAU.A".ts_eval= %Q|Series.load_from_download "CA06N_MAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFA@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_NF@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_PR@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFO@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMI@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCUT@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCT@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMN@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDR@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNND@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCWT@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRT@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTW@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIF@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFI@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRE@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCPS@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMA@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAD@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCED@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHC@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAE@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAF@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFAC@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFFD@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOS@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGV@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVFD@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVML@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_GVSL@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVST@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVLC@HAW.A".ts_eval= %Q|Series.load_from_download "CA06N_HAW@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFA@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:81:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_NF@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:82:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_PR@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:90:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAGFFO@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMI@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCUT@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCCT@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMN@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNDR@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:510:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMNND@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:530:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCWT@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRT@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCTW@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCIF@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCFI@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCRE@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1100:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCPS@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1200:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCMA@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1300:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAD@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1400:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCED@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1500:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCHC@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1600:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAE@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1700:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAF@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1800:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFAC@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1801:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCAFFD@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1802:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCOS@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:1900:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGV@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2000:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVFD@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2001:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVML@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2002:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YC_GVSL@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2010:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVST@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2011:6:126", :col => "increment:5:1", :frequency => "A" }|
  "YCGVLC@KAU.A".ts_eval= %Q|Series.load_from_download "CA06N_KAU@bea.gov", { :file_type => "csv", :start_date => "2001-01-01", :row => "header_range:col:3:2012:6:126", :col => "increment:5:1", :frequency => "A" }|
end