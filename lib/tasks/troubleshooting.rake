# Definition fixes
task :def_update => :environment do
    updated_defs = {
    31206 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:NUMBER OF SHIP ARRIVALS:1:55", :col=>2, :frequency=>"M" })/1|,
    31713 => %QSeries.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"CRUISE[or]CRUSE", :row=>"header:col:1:NUMBER OF SHIP ARRIVALS", :col=>"repeat:2:13", :frequency=>"M" })/1|,
    31717 => %QSeries.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"CRUISE[or]CRUSE", :row=>"header:col:1:Big Island[or]Hawaii Island:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|,
    31210 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Big Island[or]hawaii island:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31205 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:ARRIVED BY AIR:1:55", :col=>2, :frequency=>"M" })/1000|,
    31203 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:TOTAL VISITORS:1:55", :col=>2, :frequency=>"M" })/1000|,
    31214 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Total days in Hawaii:1:55:no_okina", :col=>2, :frequency=>"M" })/1|,
    31212 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:during Cruise:1:55:sub", :col=>2, :frequency=>"M" })/1|,
    31207 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Oahu:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31208 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Kauai:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
    31209 => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:Maui County:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|
    }

    updated_defs.each do |key, value|
        DataSource.find(key).update_attributes(:eval => value)
end
