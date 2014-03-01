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
