# Definition fixes
task :def_update => :environment do
    updated_defs = {
    "NTCRNS@HI.M" => %QSeries.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2012-01-01", :sheet=>"Cruise[or]Cruse", :row=>"header_range:col:1:NUMBER OF SHIP ARRIVALS:1:55", :col=>2, :frequency=>"M" })/1|
    }
    p = Packager.new
    p.add_definitions updated_defs
    p.write_definitions_to "udaman"
end
