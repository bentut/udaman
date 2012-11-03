#encoding: UTF-8
#TOUR DATA DOWNLOADS

###*******************************************************************
###NOTES BOX

#ben's new updates
#tour_upd requires second sheet from cy which will be a manual pull of some kind
#need a manual handle protocol or something

#tour_PC_upd works
#tour_Seats rows change every month
#tour_vis have blanks for IT and DM vis (from Cy Feng), and will need monthly manual processes

#old series definitions. these can be read from files or calculated, but we want to calculate
#"VEXPPDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Total by air:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. West:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. East:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Japan:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Canada:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:40:47", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Total by air:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. West:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. East:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Japan:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Canada:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPTOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:49:56", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Oahu:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Maui:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Molokai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Lanai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Kauai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
#"VEXPPDNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Big Island[or]hawaii island:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,


###*******************************************************************



#some of these are overwriting read in series and need to be run after the reads
task :expenditures_and_nbi=>:environment do
  t = Time.now
  "VISNS@NBI.M".ts_append_eval %Q|"VISNS@HI.M".ts - "VISNS@HON.M".ts|
  "VEXPUSNS@HI.M".ts_append_eval %Q|"VEXPUSWNS@HI.M".ts + "VEXPUSENS@HI.M".ts|
  "VEXPOTNS@HI.M".ts_append_eval %Q|"VEXPNS@HI.M".ts - "VEXPUSNS@HI.M".ts - "VEXPJPNS@HI.M".ts - "VEXPCANNS@HI.M".ts|
  "VEXPNS@MAU.M".ts_append_eval %Q|"VEXPNS@MAUI.M".ts + "VEXPNS@LAN.M".ts + "VEXPNS@MOL.M".ts|
  ["CAN", "JP", "USE", "USW", "US", "OT"].each do |serlist| 
    "VEXPPD#{serlist}NS@HI.M".ts_append_eval %Q|"VEXP#{serlist}NS@HI.M".ts / "VDAY#{serlist}NS@HI.M".ts*1000|
    "VEXPPT#{serlist}NS@HI.M".ts_append_eval %Q|"VEXP#{serlist}NS@HI.M".ts / "VIS#{serlist}NS@HI.M".ts*1000|
  end

  ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
    "VEXPPDNS@#{cnty}.M".ts_append_eval %Q|"VEXPNS@#{cnty}.M".ts / "VDAYNS@#{cnty}.M".ts*1000|
    "VEXPPTNS@#{cnty}.M".ts_append_eval %Q|"VEXPNS@#{cnty}.M".ts / "VISNS@#{cnty}.M".ts*1000|
  end
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["expenditures_and_nbi", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :bls_3=>:environment do
  t = Time.now
  "EUTNS@HON.M".ts_append_eval %Q|"E_TUNS@HON.M".ts - "ETWNS@HON.M".ts| 
  "E_TRADE@HI.M".ts_append_eval %Q|"EWT@HI.M".ts + "ERT@HI.M".ts|
  "E_TU@HI.M".ts_append_eval %Q|"E_TTU@HI.M".ts - "E_TRADE@HI.M".ts|
  "EFI@HI.M".ts_append_eval %Q|"E_FIR@HI.M".ts - "ERE@HI.M".ts|
  "E_GVSL@HI.M".ts_append_eval %Q|"EGVST@HI.M".ts + "EGVLC@HI.M".ts|
  "E_NF@HI.M".ts_append_eval %Q|"ECT@HI.M".ts + "EMN@HI.M".ts + "E_TTU@HI.M".ts + "EIF@HI.M".ts + "E_FIR@HI.M".ts + "E_PBS@HI.M".ts + "E_EDHC@HI.M".ts + "E_LH@HI.M".ts + "EOS@HI.M".ts + "EGV@HI.M".ts|
  "E_PR@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - "EGV@HI.M".ts|
  "E_GDSPR@HI.M".ts_append_eval %Q|"ECT@HI.M".ts + "EMN@HI.M".ts|
  "E_SVCPR@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - "E_GDSPR@HI.M".ts|
  "E_PRSVCPR@HI.M".ts_append_eval %Q|"E_SVCPR@HI.M".ts - "EGV@HI.M".ts|
  "E_SV@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts - ("ECT@HI.M".ts + "EMN@HI.M".ts + "E_TTU@HI.M".ts + "E_FIR@HI.M".ts + "EGV@HI.M".ts)|
  "E_ELSE@HI.M".ts_append_eval %Q|"E_SV@HI.M".ts - ("EAF@HI.M".ts + "EHC@HI.M".ts)|
  "E@HI.M".ts_append_eval %Q|"E_NF@HI.M".ts + "EAG@HI.M".ts|
  "EAENS@HON.M".ts_append_eval %Q|"E_LHNS@HON.M".ts - "EAFNS@HON.M".ts| 
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["bls_3", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

#not reading into the database.


# "OCUP%NS@HI.M"
# <Series id: 7829, name: "OCUP%NS@HI.M", frequency: "month", description: nil, units: 1, seasonally_adjusted: nil, last_demetra_datestring: nil, factors: nil, factor_application: nil, prognoz_data_file_id: nil, aremos_missing: 7, aremos_diff: 0.0, mult: nil, created_at: "2011-08-11 01:00:17", updated_at: "2012-08-29 11:10:09", investigation_notes: nil> 
# 21302 | 2012-02-01 04:12:55 UTC | "OCUP%NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls"
# 25414 | 2012-02-25 00:58:30 UTC | "OCUP%NS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/Manual/TOUR_OCUP.xls"
# 25481 | 2012-08-29 11:10:09 UTC | Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>2, :frequency=>"M" })

task :tour_ocup_upd=>:environment do
  t = Time.now

  "OCUP%NS@HI.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2004-01-10", :sheet=>"sheet_num:1", :row=>"increment:4:1", :col=>2, :frequency=>"W" })|
  "PRMNS@HI.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2004-01-10", :sheet=>"sheet_num:1", :row=>"increment:4:1", :col=>3, :frequency=>"W" })|
  "OCUP%NS@HON.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>4, :frequency=>"W" })|
  "PRMNS@HON.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>5, :frequency=>"W" })|
  "OCUP%NS@MAU.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>6, :frequency=>"W" })|
  "PRMNS@MAU.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>7, :frequency=>"W" })|
  "OCUP%NS@KAU.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>8, :frequency=>"W" })|
  "PRMNS@KAU.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>9, :frequency=>"W" })|
  "OCUP%NS@HAW.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>10, :frequency=>"W" })|
  "PRMNS@HAW.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>11, :frequency=>"W" })|
  "OCUP%NS@US.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>12, :frequency=>"W" })|
  "PRMNS@US.W".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/ocupwkly.xls", {:file_type=>"xls", :start_date=>"2007-01-06", :sheet=>"sheet_num:1", :row=>"increment:160:1", :col=>13, :frequency=>"W" })|

  "OCUP%NS@HI.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>2, :frequency=>"M" })| 
  "OCUP%NS@HON.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>3, :frequency=>"M" })| 
  "OCUP%NS@HAW.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>4, :frequency=>"M" })| 
  "OCUP%NS@KAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>5, :frequency=>"M" })| 
  "OCUP%NS@MAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>6, :frequency=>"M" })|
  "PRMNS@HI.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>7, :frequency=>"M" })| 
  "PRMNS@HON.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>8, :frequency=>"M" })| 
  "PRMNS@HAW.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>9, :frequency=>"M" })| 
  "PRMNS@KAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>10, :frequency=>"M" })| 
  "PRMNS@MAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>11, :frequency=>"M" })| 
  "RMRVNS@HI.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>12, :frequency=>"M" })| 
  "RMRVNS@HON.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>13, :frequency=>"M" })| 
  "RMRVNS@HAW.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>14, :frequency=>"M" })| 
  "RMRVNS@KAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>15, :frequency=>"M" })| 
  "RMRVNS@MAU.M".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/TOUR_OCUP.xls", {:file_type=>"xls", :start_date=>"1998-01-01", :sheet=>"sheet_num:1", :row=>"increment:2:1", :col=>16, :frequency=>"M" })|

  "WAGOCUP%NS@HI.M".ts_eval= %Q|"OCUP%NS@HI.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGOCUP%NS@HON.M".ts_eval= %Q|"OCUP%NS@HON.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGOCUP%NS@HAW.M".ts_eval= %Q|"OCUP%NS@HAW.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGOCUP%NS@KAU.M".ts_eval= %Q|"OCUP%NS@KAU.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGOCUP%NS@MAU.M".ts_eval= %Q|"OCUP%NS@MAU.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGPRMNS@HI.M".ts_eval= %Q|"PRMNS@HI.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGPRMNS@HON.M".ts_eval= %Q|"PRMNS@HON.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGPRMNS@HAW.M".ts_eval= %Q|"PRMNS@HAW.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGPRMNS@KAU.M".ts_eval= %Q|"PRMNS@KAU.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 
  "WAGPRMNS@MAU.M".ts_eval= %Q|"PRMNS@MAU.W".ts.fill_days_interpolation.aggregate_by(:month, :average)| 



	
tour_vexp = {

"VEXPUS@HI.A"=>%Q|"VEXPUS@HI.M".ts.aggregate(:year, :sum)|,
"VEXPJP@HI.A"=>%Q|"VEXPJP@HI.M".ts.aggregate(:year, :sum)|,
"VXPRUS@HI.A"=>%Q|"VEXPUS@HI.A".ts|,
"VXPRJP@HI.A"=>%Q|"VEXPJP@HI.A".ts|,
"VX@HI.A"=>[%Q|"VXPR@HI.A".ts + "VXBU@HI.A".ts|, 
              %Q|"VX@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls" |], 

"VXBU@HI.A"=>%Q|"VXBU@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|,
"VXPR@HI.A"=>%Q|"VXPR@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls"|, 
#add in VX things here
}	
	
  # p = Packager.new
  # p.add_definitions tour_ocup
  # p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_ocup_upd_NEW.xls"

	p = Packager.new
	p.add_definitions tour_vexp
	p.write_definitions_to "/Volumes/UHEROwork/data/rawdata/trash/tour_vexp_upd_ID.xls"


  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tour_ocup_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end



task :tour_PC_upd=>:environment do
t = Time.now
tour_PC = {
"PCDMNS@HAW.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Domestic", :row=>"increment:5:1", :col=>6, :frequency=>"D" })/1|, 
"PCDMNS@HI.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Domestic", :row=>"increment:5:1", :col=>3, :frequency=>"D" })/1|, 
"PCDMNS@HON.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Domestic", :row=>"increment:5:1", :col=>4, :frequency=>"D" })/1|, 
"PCDMNS@KAU.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Domestic", :row=>"increment:5:1", :col=>7, :frequency=>"D" })/1|, 
"PCDMNS@MAU.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Domestic", :row=>"increment:5:1", :col=>5, :frequency=>"D" })/1|, 
"PCITJPNS@HI.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"International", :row=>"increment:6:1", :col=>4, :frequency=>"D" })/1|, 
"PCITNS@HI.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"International", :row=>"increment:6:1", :col=>3, :frequency=>"D" })/1|, 
"PCITOTNS@HI.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"International", :row=>"increment:6:1", :col=>5, :frequency=>"D" })/1|, 
"PCNS@HI.D"=>%Q|Series.load_from_download(  "tour_PC@hawaii.gov", { :file_type=>"xls", :start_date=>"2009-08-31", :sheet=>"Total", :row=>"increment:5:1", :col=>4, :frequency=>"D" })/1|
}
	
	p = Packager.new
	p.add_definitions tour_PC
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_PC_upd_NEW.xls"
	
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tour_PC_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

 
task :tour_seats_upd=>:environment do

  t = Time.now
	tour_seats = {
"VSONS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>2, :frequency=>"M" })/1000|,
"VSODMNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>2, :frequency=>"M" })/1000|,
"VSOUSWNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>2, :frequency=>"M" })/1000|,
"VSOUSENS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>2, :frequency=>"M" })/1000|,
"VSOITNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>2, :frequency=>"M" })/1000|,
"VSOJPNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>2, :frequency=>"M" })/1000|,
"VSOCANNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>2, :frequency=>"M" })/1000|,
"VSOOTANS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>2, :frequency=>"M" })/1000|,
"VSOAUSNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>2, :frequency=>"M" })/1000|,
"VSOOTNS@HI.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>2, :frequency=>"M" })/1000|,
"VSONS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>5, :frequency=>"M" })/1000|,
"VSODMNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>5, :frequency=>"M" })/1000|,
"VSOUSWNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>5, :frequency=>"M" })/1000|,
"VSOUSENS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>5, :frequency=>"M" })/1000|,
"VSOITNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>5, :frequency=>"M" })/1000|,
"VSOJPNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>5, :frequency=>"M" })/1000|,
"VSOCANNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>5, :frequency=>"M" })/1000|,
"VSOOTANS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>5, :frequency=>"M" })/1000|,
"VSOAUSNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>5, :frequency=>"M" })/1000|,
"VSOOTNS@HON.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>5, :frequency=>"M" })/1000|,
"VSONS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>8, :frequency=>"M" })/1000|,
"VSODMNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>8, :frequency=>"M" })/1000|,
"VSOUSWNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>8, :frequency=>"M" })/1000|,
"VSOUSENS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>8, :frequency=>"M" })/1000|,
"VSOITNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>8, :frequency=>"M" })/1000|,
"VSOJPNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>8, :frequency=>"M" })/1000|,
"VSOCANNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>8, :frequency=>"M" })/1000|,
"VSOOTANS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>8, :frequency=>"M" })/1000|,
"VSOAUSNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>8, :frequency=>"M" })/1000|,
"VSOOTNS@MAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>8, :frequency=>"M" })/1000|,
"VSONS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>17, :frequency=>"M" })/1000|,
"VSODMNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>17, :frequency=>"M" })/1000|,
"VSOUSWNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>17, :frequency=>"M" })/1000|,
"VSOUSENS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>17, :frequency=>"M" })/1000|,
"VSOITNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>17, :frequency=>"M" })/1000|,
"VSOJPNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>17, :frequency=>"M" })/1000|,
"VSOCANNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>17, :frequency=>"M" })/1000|,
"VSOOTANS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>17, :frequency=>"M" })/1000|,
"VSOAUSNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>17, :frequency=>"M" })/1000|,
"VSOOTNS@KAU.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>17, :frequency=>"M" })/1000|,
"VSONS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>11, :frequency=>"M" })/1000|,
"VSODMNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>11, :frequency=>"M" })/1000|,
"VSOUSWNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>11, :frequency=>"M" })/1000|,
"VSOUSENS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>11, :frequency=>"M" })/1000|,
"VSOITNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>11, :frequency=>"M" })/1000|,
"VSOJPNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>11, :frequency=>"M" })/1000|,
"VSOCANNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>11, :frequency=>"M" })/1000|,
"VSOOTANS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>11, :frequency=>"M" })/1000|,
"VSOAUSNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>11, :frequency=>"M" })/1000|,
"VSOOTNS@HAWK.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>11, :frequency=>"M" })/1000|,
"VSONS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:TOTAL:prefix", :col=>14, :frequency=>"M" })/1000|,
"VSODMNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US TOTAL", :col=>14, :frequency=>"M" })/1000|,
"VSOUSWNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US WEST", :col=>14, :frequency=>"M" })/1000|,
"VSOUSENS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:US EAST", :col=>14, :frequency=>"M" })/1000|,
"VSOITNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:INT:prefix", :col=>14, :frequency=>"M" })/1000|,
"VSOJPNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:JAPAN", :col=>14, :frequency=>"M" })/1000|,
"VSOCANNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:CANADA", :col=>14, :frequency=>"M" })/1000|,
"VSOOTANS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER ASIA", :col=>14, :frequency=>"M" })/1000|,
"VSOAUSNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OCEANIA", :col=>14, :frequency=>"M" })/1000|,
"VSOOTNS@HAWH.M"=>%Q|Series.load_from_download(  "SEATS_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-09-01", :sheet=>"sheet_num:1", :row=>"header:col:1:OTHER", :col=>14, :frequency=>"M" })/1000|

	}
	
	p = Packager.new
	p.add_definitions tour_seats
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_seats_upd_NEW.xls"
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tour_seats_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end


task :tour_upd=>:environment do
  t = Time.now
	tour_1 = {
"VDAYNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:VISITOR DAYS:1:59", :col=>2, :frequency=>"M" })/1000|,
"VISNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:TOTAL VISITORS:1:59", :col=>2, :frequency=>"M" })/1000|,
"VRDCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:1:59", :col=>2, :frequency=>"M" })/1000|,
"VISNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Maui County:1:59", :col=>2, :frequency=>"M" })/1000|,
"VISI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Any one island only:1:59", :col=>2, :frequency=>"M" })/1000|,
"VISIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Multiple Islands:1:59", :col=>2, :frequency=>"M" })/1000|,
"NAIVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Avg. Islands Visited:1:59", :col=>2, :frequency=>"M" })/1|,
"VRLSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Stay in Hawaii:1:59:no_okina", :col=>2, :frequency=>"M" })/1|,
"VAHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Hotel:1:59", :col=>2, :frequency=>"M" })/1000|,
"VAHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Hotel only:1:59", :col=>2, :frequency=>"M" })/1000|,
"VACNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Condo:1:59", :col=>2, :frequency=>"M" })/1000|,
"VACNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Condo only:1:59", :col=>2, :frequency=>"M" })/1000|,
"VATSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Timeshare:1:59", :col=>2, :frequency=>"M" })/1000|,
"VATSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Timeshare only:1:59", :col=>2, :frequency=>"M" })/1000|,
"VACRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Cruise Ship:1:59", :col=>2, :frequency=>"M" })/1000|,
"VAFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Friends/Relatives:1:59", :col=>2, :frequency=>"M" })/1000|,
"VABBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Bed & Breakfast:1:59", :col=>2, :frequency=>"M" })/1000|,
"VAOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other:1:59", :col=>2, :frequency=>"M" })/1000|,
"VPFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Pleasure:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other Business:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Visit Friends/Rel.:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Gov't/Military:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Attend School:62:96", :col=>2, :frequency=>"M" })/1000|,
"VPSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Sport Events:62:96", :col=>2, :frequency=>"M" })/1000|,
"VSTFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% First Timers:62:96:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% Repeaters:62:96:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Average # of Trips:62:96", :col=>2, :frequency=>"M" })/1|,
"VSTGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Group Tour:62:96", :col=>2, :frequency=>"M" })/1000|,
"VSTNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Non-Group:62:96", :col=>2, :frequency=>"M" })/1000|,
"VSTPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Package Trip:62:96", :col=>2, :frequency=>"M" })/1000|,
"VSTNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:No Package:62:96", :col=>2, :frequency=>"M" })/1000|,
"VSTINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Net True Independent:62:96", :col=>2, :frequency=>"M" })/1000|,
"VDAYDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:DOMESTIC VISITOR DAYS:99:154", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:VISITORS:99:154:sub", :col=>2, :frequency=>"M" })/1000|,
"VRDCDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:99:154:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Oahu:99:154:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Kauai:99:154:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Maui County:99:154", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Maui:99:154", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Molokai *:99:154:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Lanai *:99:154:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISDMNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Big Island[or]hawaii island:99:154:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISDMI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Any one island only:99:154", :col=>2, :frequency=>"M" })/1000|,
"VISDMIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Multiple Islands:99:154", :col=>2, :frequency=>"M" })/1000|,
"NAIVDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Avg. Islands Visited:99:154", :col=>2, :frequency=>"M" })/1|,
"VRLSDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Stay in Hawaii:99:154:no_okina", :col=>2, :frequency=>"M" })/1|,
"VADMHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Hotel:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Hotel only:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Condo:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Condo only:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Timeshare:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Timeshare only:99:154", :col=>2, :frequency=>"M" })/1000|,
"VADMCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Cruise Ship:99:162", :col=>2, :frequency=>"M" })/1000|,
"VADMFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Friends/Relatives:99:162", :col=>2, :frequency=>"M" })/1000|,
"VADMBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Bed & Breakfast:99:162", :col=>2, :frequency=>"M" })/1000|,
"VADMOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other:99:162", :col=>2, :frequency=>"M" })/1000|,
"VPDMFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Pleasure:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other Business:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Visit Friends/Rel.:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Gov't/Military:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Attend School:157:191", :col=>2, :frequency=>"M" })/1000|,
"VPDMSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Sport Events:157:191", :col=>2, :frequency=>"M" })/1000|,
"VSTDMFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% First Timers:157:191:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTDMRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% Repeaters:157:191:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTDMNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Average # of Trips:157:191", :col=>2, :frequency=>"M" })/1|,
"VSTDMGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Group Tour:157:197", :col=>2, :frequency=>"M" })/1000|,
"VSTDMNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Non-Group:157:197", :col=>2, :frequency=>"M" })/1000|,
"VSTDMPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Package Trip:157:197", :col=>2, :frequency=>"M" })/1000|,
"VSTDMNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:No Package:157:197", :col=>2, :frequency=>"M" })/1000|,
"VSTDMINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Net True Independent:157:197", :col=>2, :frequency=>"M" })/1000|,
"VDAYITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:INTERNATIONAL VISITOR DAYS:194:250", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:TIONAL VISITORS:194:250:sub", :col=>2, :frequency=>"M" })/1000|,
"VRDCITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:194:250:sub", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Oahu:194:250:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Kauai:194:250:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Maui County:194:250", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Maui:194:250", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Molokai *:194:250:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Lanai *:194:250:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISITNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Big Island[or]hawaii island:194:250:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISITI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Any one island only:194:250", :col=>2, :frequency=>"M" })/1000|,
"VISITIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Multiple Islands:194:250", :col=>2, :frequency=>"M" })/1000|,
"NAIVITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Avg. Islands Visited:194:250", :col=>2, :frequency=>"M" })/1|,
"VRLSITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Stay in Hawaii:194:250:no_okina", :col=>2, :frequency=>"M" })/1|,
"VAITHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Hotel:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Hotel only:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Condo:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Condo only:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Plan to stay in Timeshare:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Timeshare only:194:250", :col=>2, :frequency=>"M" })/1000|,
"VAITCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Cruise Ship:194:256", :col=>2, :frequency=>"M" })/1000|,
"VAITFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Friends/Relatives:194:256", :col=>2, :frequency=>"M" })/1000|,
"VAITBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Bed & Breakfast:194:256", :col=>2, :frequency=>"M" })/1000|,
"VAITOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other:194:256", :col=>2, :frequency=>"M" })/1000|,
"VPITFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Pleasure:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Other Business:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Visit Friends/Rel.:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Gov't/Military:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Attend School:252:287", :col=>2, :frequency=>"M" })/1000|,
"VPITSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Sport Events:252:287", :col=>2, :frequency=>"M" })/1000|,
"VSTITFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% First Timers:252:287:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTITRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:% Repeaters:252:287:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTITNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Average # of Trips:252:287", :col=>2, :frequency=>"M" })/1|,
"VSTITGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Group Tour:252:300", :col=>2, :frequency=>"M" })/1000|,
"VSTITNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Non-Group:252:300", :col=>2, :frequency=>"M" })/1000|,
"VSTITPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Package Trip:252:300", :col=>2, :frequency=>"M" })/1000|,
"VSTITNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:No Package:252:300", :col=>2, :frequency=>"M" })/1000|,
"VSTITINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:Net True Independent:252:300", :col=>2, :frequency=>"M" })/1000|,
"VISUSDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:UNITED STATES:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMPCFNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Pacific Region:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMCANS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:California:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMORNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Oregon:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMWANS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Washington:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMMTNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Mountain Region:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMWNCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:West North Central:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMWSCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:West South Central:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMTXNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Texas:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMENCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:East North Central:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMESCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:East South Central:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMNWENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:New England:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMMATNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:Middle Atlantic:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMNJNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:New Jersey:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMNYNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:New York:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VISDMSATNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:South Atlantic:1:65", :col=>2, :frequency=>"M" })/1000|,
"VISDMEURNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:2", :row=>"header_range:col:1:EUROPE:1:65:sub", :col=>2, :frequency=>"M" })/1000|,
"VDAYUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:VISITOR DAYS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Domestic:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:International:1:100", :col=>2, :frequency=>"M" })/1000|,
"VRDCUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Maui County:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Any one island only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSWIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Multiple Islands:1:100", :col=>2, :frequency=>"M" })/1000|,
"NAIVUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Avg. Islands Visited:1:100", :col=>2, :frequency=>"M" })/1|,
"VRLSUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Stay in Hawaii:1:100:no_okina", :col=>2, :frequency=>"M" })/1|,
"VAUSWHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Plan to stay in Hotel:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Hotel only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Plan to stay in Condo:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Condo only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Plan to stay in Timeshare:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Timeshare only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Cruise Ship:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Friends/Relatives:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Bed & Breakfast:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSWOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Other:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Pleasure:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Other Business:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Visit Friends/Rel.:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Gov't/Military:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Attend School:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSWSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Sport Events:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSWFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:% First Timers:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTUSWRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:% Repeaters:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTUSWNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Average # of Trips:1:100", :col=>2, :frequency=>"M" })/1|,
"VSTUSWGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Group Tour:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSWNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Non-Group:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSWPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Package Trip:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSWNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:No Package:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSWINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Net True Independent:1:100", :col=>2, :frequency=>"M" })/1000|,
"VDAYUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:VISITOR DAYS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSEDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Domestic:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSEITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:International:1:100", :col=>2, :frequency=>"M" })/1000|,
"VRDCUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSENS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Maui County:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSEI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Any one island only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISUSEIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Multiple Islands:1:100", :col=>2, :frequency=>"M" })/1000|,
"NAIVUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Avg. Islands Visited:1:100", :col=>2, :frequency=>"M" })/1|,
"VRLSUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Stay in Hawaii:1:100:no_okina", :col=>2, :frequency=>"M" })/1|,
"VAUSEHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Plan to stay in Hotel:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSEHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Hotel only:1:100", :col=>2, :frequency=>"M" })/1000|
	}

	tour_2 = {
"VAUSECNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Plan to stay in Condo:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSECNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Condo only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSETSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Plan to stay in Timeshare:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSETSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Timeshare only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSECRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Cruise Ship:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSEFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Friends/Relatives:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSEBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Bed & Breakfast:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAUSEOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Other:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSEFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Pleasure:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSECNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSEBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Other Business:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSERELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Visit Friends/Rel.:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSEGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Gov't/Military:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSEEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Attend School:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPUSESPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Sport Events:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSEFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:% First Timers:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTUSERPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:% Repeaters:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTUSENTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Average # of Trips:1:100", :col=>2, :frequency=>"M" })/1|,
"VSTUSEGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Group Tour:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSENGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Non-Group:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSEPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Package Trip:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSENPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:No Package:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTUSEINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Net True Independent:1:100", :col=>2, :frequency=>"M" })/1000|,
"VDAYJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:VISITOR DAYS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Domestic:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:International:1:100", :col=>2, :frequency=>"M" })/1000|,
"VRDCJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Maui:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Any one island only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISJPIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Multiple Islands:1:100", :col=>2, :frequency=>"M" })/1000|,
"NAIVJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Avg. Islands Visited:1:100", :col=>2, :frequency=>"M" })/1|,
"VRLSJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Stay in Hawaii:1:100:no_okina", :col=>2, :frequency=>"M" })/1|,
"VAJPHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Plan to stay in Hotel:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Hotel only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Plan to stay in Condo:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Condo only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Plan to stay in Timeshare:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Timeshare only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Cruise Ship:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Friends/Relatives:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Bed & Breakfast:1:100", :col=>2, :frequency=>"M" })/1000|,
"VAJPOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Other:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Pleasure:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Other Business:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Visit Friends/Rel.:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Gov't/Military:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Attend School:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPJPSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Sport Events:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTJPFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:% First Timers:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTJPRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:% Repeaters:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTJPNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Average # of Trips:1:100", :col=>2, :frequency=>"M" })/1|,
"VSTJPGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Group Tour:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTJPNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Non-Group:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTJPPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Package Trip:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTJPNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:No Package:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTJPINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:Net True Independent:1:100", :col=>2, :frequency=>"M" })/1000|,
"VDAYCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:VISITOR DAYS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Domestic:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:International:1:100", :col=>2, :frequency=>"M" })/1000|,
"VRDCCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:AVERAGE DAILY CENSUS:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Maui County:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANI1NS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Any one island only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VISCANIMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Multiple Islands:1:100", :col=>2, :frequency=>"M" })/1000|,
"NAIVCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Avg. Islands Visited:1:100", :col=>2, :frequency=>"M" })/1|,
"VRLSCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Stay in Hawaii:1:100:no_okina", :col=>2, :frequency=>"M" })/1|,
"VACANHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Plan to stay in Hotel:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Hotel only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Plan to stay in Condo:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Condo only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Plan to stay in Timeshare:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Timeshare only:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Cruise Ship:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Friends/Relatives:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Bed & Breakfast:1:100", :col=>2, :frequency=>"M" })/1000|,
"VACANOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Other:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANFUNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Pleasure:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANCNVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Mtgs/Conventions/Incentive:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANBUSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Other Business:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANRELNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Visit Friends/Rel.:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANGOVNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Gov't/Military:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANEDUNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Attend School:1:100", :col=>2, :frequency=>"M" })/1000|,
"VPCANSPTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Sport Events:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTCANFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:% First Timers:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTCANRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:% Repeaters:1:100:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTCANNTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Average # of Trips:1:100", :col=>2, :frequency=>"M" })/1|,
"VSTCANGRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Group Tour:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTCANNGRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Non-Group:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTCANPCKNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Package Trip:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTCANNPCNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:No Package:1:100", :col=>2, :frequency=>"M" })/1000|,
"VSTCANINDNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Canada", :row=>"header_range:col:1:Net True Independent:1:100", :col=>2, :frequency=>"M" })/1000|,
"VEXPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Total by air:1:11", :col=>2, :frequency=>"M" })/1|,
"VEXPUSWNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. West:1:11", :col=>2, :frequency=>"M" })/1|,
"VEXPUSENS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:U.S. East:1:11", :col=>2, :frequency=>"M" })/1|,
"VEXPJPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Japan:1:11", :col=>2, :frequency=>"M" })/1|,
"VEXPCANNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:Canada:1:11", :col=>2, :frequency=>"M" })/1|,
"VEXPOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:1:11", :col=>2, :frequency=>"M" })/1|,
"VDAYOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:13:20", :col=>2, :frequency=>"M" })/1000|,
"VISOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:22:29", :col=>2, :frequency=>"M" })/1000|,
"VRLSOTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:7", :row=>"header_range:col:1:All Others:31:38", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Oahu:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Maui:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Molokai:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Lanai:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Kauai:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Big Island[or]hawaii island:4:12:no_okina", :col=>2, :frequency=>"M" })/1|,
"VISNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Oahu:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Maui:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Molokai:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Lanai:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Kauai:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Big Island[or]hawaii island:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VEXPPDNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Oahu:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPPDNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Maui:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPPDNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Molokai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPPDNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Lanai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPPDNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Kauai:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,
"VEXPPDNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Big Island[or]hawaii island:44:52:no_okina", :col=>2, :frequency=>"M" })/1|,


}

	tour_3 = {
"VDAYCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:VISITOR DAYS:1:55", :col=>2, :frequency=>"M" })/1000|,
"VISCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:TOTAL VISITORS:1:55", :col=>2, :frequency=>"M" })/1000|,
"VISCRSHPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:ARRIVED BY SHIP:1:55", :col=>2, :frequency=>"M" })/1000|,
"VISCRAIRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:ARRIVED BY AIR:1:55", :col=>2, :frequency=>"M" })/1000|,
"NTCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:NUMBER OF SHIP ARRIVALS:1:55", :col=>2, :frequency=>"M" })/1|,
"VISCRNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Oahu:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISCRNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Kauai:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISCRNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Maui County:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VISCRNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Big Island[or]hawaii island:1:55:no_okina", :col=>2, :frequency=>"M" })/1000|,
"VLOSCRBFNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:before Cruise:1:55:sub", :col=>2, :frequency=>"M" })/1|,
"VLOSCRDRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:during Cruise:1:55:sub", :col=>2, :frequency=>"M" })/1|,
"VLOSCRAFNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:after Cruise:1:55:sub", :col=>2, :frequency=>"M" })/1|,
"VLOSCRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Total days in Hawaii:1:55:no_okina", :col=>2, :frequency=>"M" })/1|,
"VACRHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Hotel:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRHTOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Hotel only:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRCNNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Condo:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRCNOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Condo only:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRTSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Timeshare:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRTSOLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Timeshare Only:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRBBNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Bed & Breakfast:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRFRNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Friends & relatives:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACROTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Other accommodation:1:55", :col=>2, :frequency=>"M" })/1000|,
"VACRCROLNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:Cruise only:1:55", :col=>2, :frequency=>"M" })/1000|,
"VSTCRFTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:% First timers:1:55:prefix", :col=>2, :frequency=>"M" })/1|,
"VSTCRRPNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:9", :row=>"header_range:col:1:% Repeat visitors:1:55", :col=>2, :frequency=>"M" })/1|,
"VSNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Total Seats:1:90", :col=>2, :frequency=>"M" })/1000|,
"VSNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Total Seats:1:90", :col=>5, :frequency=>"M" })/1000|,
"VSNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Total Seats:1:90", :col=>8, :frequency=>"M" })/1000|,
"VSNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Total Seats:1:90", :col=>11, :frequency=>"M" })/1000|,
"VSNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Total Seats:1:90", :col=>17, :frequency=>"M" })/1000|,
"VSSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:5:7", :col=>2, :frequency=>"M" })/1000|,
"VSSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:5:7", :col=>5, :frequency=>"M" })/1000|,
"VSSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:5:7", :col=>8, :frequency=>"M" })/1000|,
"VSSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:5:7", :col=>11, :frequency=>"M" })/1000|,
"VSSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:5:7", :col=>17, :frequency=>"M" })/1000|,
"VSCHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:1:7", :col=>2, :frequency=>"M" })/1000|,
"VSCHTNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:1:7", :col=>5, :frequency=>"M" })/1000|,
"VSCHTNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:1:7", :col=>8, :frequency=>"M" })/1000|,
"VSCHTNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:1:7", :col=>11, :frequency=>"M" })/1000|,
"VSCHTNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:1:7", :col=>17, :frequency=>"M" })/1000|,
"VSDMNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Domestic Seats:1:90", :col=>2, :frequency=>"M" })/1000|,
"VSDMNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Domestic Seats:1:90", :col=>5, :frequency=>"M" })/1000|,
"VSDMNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Domestic Seats:1:90", :col=>8, :frequency=>"M" })/1000|,
"VSDMNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Domestic Seats:1:90", :col=>11, :frequency=>"M" })/1000|,
"VSDMNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Domestic Seats:1:90", :col=>17, :frequency=>"M" })/1000|,
"VSDMSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:8:15", :col=>2, :frequency=>"M" })/1000|,
"VSDMSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:8:15", :col=>5, :frequency=>"M" })/1000|,
"VSDMSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:8:15", :col=>8, :frequency=>"M" })/1000|,
"VSDMSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:8:15", :col=>11, :frequency=>"M" })/1000|,
"VSDMSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:8:15", :col=>17, :frequency=>"M" })/1000|,
"VSUSWSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US West:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSUSWSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US West:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSUSWSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US West:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSUSWSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US West:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSUSWSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US West:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSUSESCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US East:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSUSESCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US East:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSUSESCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US East:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSUSESCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US East:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSUSESCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:US East:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSDMCHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:8:15", :col=>2, :frequency=>"M" })/1000|,
"VSDMCHTNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:8:15", :col=>5, :frequency=>"M" })/1000|,
"VSDMCHTNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:8:15", :col=>8, :frequency=>"M" })/1000|,
"VSDMCHTNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:8:15", :col=>11, :frequency=>"M" })/1000|,
"VSDMCHTNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter seats:8:15", :col=>17, :frequency=>"M" })/1000|,
"VSITNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:International Seats:1:90", :col=>2, :frequency=>"M" })/1000|,
"VSITNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:International Seats:1:90", :col=>5, :frequency=>"M" })/1000|,
"VSITNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:International Seats:1:90", :col=>8, :frequency=>"M" })/1000|,
"VSITNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:International Seats:1:90", :col=>11, :frequency=>"M" })/1000|,
"VSITNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:International Seats:1:90", :col=>17, :frequency=>"M" })/1000|,
"VSITSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:40:50", :col=>2, :frequency=>"M" })/1000|,
"VSITSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:40:50", :col=>5, :frequency=>"M" })/1000|,
"VSITSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:40:50", :col=>8, :frequency=>"M" })/1000|,
"VSITSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:40:50", :col=>11, :frequency=>"M" })/1000|,
"VSITSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Scheduled Seats:40:50", :col=>17, :frequency=>"M" })/1000|,
"VSJPSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Japan:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSJPSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Japan:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSJPSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Japan:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSJPSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Japan:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSJPSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Japan:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSCANSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Canada:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSCANSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Canada:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSCANSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Canada:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSCANSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Canada:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSCANSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Canada:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSOTASCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other Asia:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSOTASCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other Asia:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSOTASCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other Asia:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSOTASCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other Asia:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSOTASCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other Asia:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSAUSSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Oceania:1:90:sub", :col=>2, :frequency=>"M" })/1000|,
"VSAUSSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Oceania:1:90:sub", :col=>5, :frequency=>"M" })/1000|,
"VSAUSSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Oceania:1:90:sub", :col=>8, :frequency=>"M" })/1000|,
"VSAUSSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Oceania:1:90:sub", :col=>11, :frequency=>"M" })/1000|,
"VSAUSSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Oceania:1:90:sub", :col=>17, :frequency=>"M" })/1000|,
"VSOTSCHNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other:1:90", :col=>2, :frequency=>"M" })/1000|,
"VSOTSCHNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other:1:90", :col=>5, :frequency=>"M" })/1000|,
"VSOTSCHNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other:1:90", :col=>8, :frequency=>"M" })/1000|,
"VSOTSCHNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other:1:90", :col=>11, :frequency=>"M" })/1000|,
"VSOTSCHNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Other:1:90", :col=>17, :frequency=>"M" })/1000|,
"VSITCHTNS@HI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter Seats:40:50", :col=>2, :frequency=>"M" })/1000|,
"VSITCHTNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter Seats:40:50", :col=>5, :frequency=>"M" })/1000|,
"VSITCHTNS@MAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter Seats:40:50", :col=>8, :frequency=>"M" })/1000|,
"VSITCHTNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter Seats:40:50", :col=>11, :frequency=>"M" })/1000|,
"VSITCHTNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-08-01", :sheet=>"sheet_num:10", :row=>"header_range:col:1:Charter Seats:40:50", :col=>17, :frequency=>"M" })/1000|,
"VDAYDMNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>4, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYDMNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>5, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYDMNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>6, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYDMNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>7, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYDMNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>8, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYDMNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>9, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>14, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>15, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>16, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>17, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>18, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISDMNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:1", :row=>19, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>4, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>5, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>6, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>7, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>8, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYITNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>9, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>14, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>15, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>16, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>17, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>18, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VISITNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:2", :row=>19, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>3, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>4, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>5, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>6, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>7, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSWNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>8, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>11, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>12, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>13, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>14, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>15, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSWNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>16, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>21, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>22, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>23, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>24, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>25, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYUSENS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>26, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>29, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>30, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>31, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>32, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>33, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISUSENS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>34, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>38, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>39, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>40, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>41, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>42, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYJPNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>43, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>46, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>47, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>48, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>49, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>50, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISJPNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>51, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>55, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>56, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>57, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>58, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>59, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
"VDAYCANNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>60, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@HON.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>63, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@KAU.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>64, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@MAUI.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>65, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@MOL.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>66, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@LAN.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>67, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 
# "VISCANNS@HAW.M"=>%Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/TOUR_CYFENG%y.xls", {:file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>68, :col=>"repeat:2:13", :frequency=>"M" })/1000|, 

"VISUSWNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSWNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Kauai:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSWNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Maui:10:45", :col=>2, :frequency=>"M" })/1000|, 
"VISUSWNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Molokai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSWNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Lanai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSWNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Big Island[or]hawaii island:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 

"VISUSENS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSENS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Kauai:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSENS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Maui:10:45", :col=>2, :frequency=>"M" })/1000|, 
"VISUSENS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Molokai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSENS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Lanai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISUSENS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Big Island[or]hawaii island:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 

"VISJPNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISJPNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Kauai:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISJPNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Maui:10:45", :col=>2, :frequency=>"M" })/1000|, 
"VISJPNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Molokai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISJPNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Lanai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISJPNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Big Island[or]hawaii island:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 

"VISCANNS@HON.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISCANNS@KAU.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Kauai:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISCANNS@MAUI.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Maui:10:45", :col=>2, :frequency=>"M" })/1000|, 
"VISCANNS@MOL.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Molokai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISCANNS@LAN.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Lanai *:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 
"VISCANNS@HAW.M"=>%Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Canada", :row=>"header_range:col:1:Big Island[or]hawaii island:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|, 

# "VRLSITNS@HON.M"=>%Q|"VDAYITNS@HON.M".ts / "VISITNS@HON.M".ts|,
# "VRLSITNS@HAW.M"=>%Q|"VDAYITNS@HAW.M".ts / "VISITNS@HAW.M".ts|,
# "VRLSITNS@MAUI.M"=>%Q|"VDAYITNS@MAUI.M".ts / "VISITNS@MAUI.M".ts|,
# "VRLSITNS@MOL.M"=>%Q|"VDAYITNS@MOL.M".ts / "VISITNS@MOL.M".ts|,
# "VRLSITNS@LAN.M"=>%Q|"VDAYITNS@LAN.M".ts / "VISITNS@LAN.M".ts|,
# "VRLSITNS@KAU.M"=>%Q|"VDAYITNS@KAU.M".ts / "VISITNS@KAU.M".ts|,
# "VRLSDMNS@HON.M"=>%Q|"VDAYDMNS@HON.M".ts / "VISDMNS@HON.M".ts|,
# "VRLSDMNS@HAW.M"=>%Q|"VDAYDMNS@HAW.M".ts / "VISDMNS@HAW.M".ts|,
# "VRLSDMNS@MAUI.M"=>%Q|"VDAYDMNS@MAUI.M".ts / "VISDMNS@MAUI.M".ts|,
# "VRLSDMNS@MOL.M"=>%Q|"VDAYDMNS@MOL.M".ts / "VISDMNS@MOL.M".ts|,
# "VRLSDMNS@LAN.M"=>%Q|"VDAYDMNS@LAN.M".ts / "VISDMNS@LAN.M".ts|,
# "VRLSDMNS@KAU.M"=>%Q|"VDAYDMNS@KAU.M".ts / "VISDMNS@KAU.M".ts|


	}
	
	p = Packager.new
	p.add_definitions tour_1
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_upd1_NEW.xls"
	
	p = Packager.new
	p.add_definitions tour_2
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_upd2_NEW.xls"
	
	
	p = Packager.new
	p.add_definitions tour_3
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_upd3_NEW.xls"
	
	CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tour_upd", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
	
end

task :vis_test=>:environment do
  
  tour_1 = {
    "VDAYDMNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "3", :row => "repeat:17:28", :col => "block:2:1:12", :frequency => "M" })/1000|,
    "VDAYITNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "3", :row => "repeat:30:41", :col => "block:2:1:12", :frequency => "M" })/1000|,

    "VISUSWNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:2:10:12", :frequency => "M" })/1000|,
    "VISUSENS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:3:10:12", :frequency => "M" })/1000|,
    "VISJPNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:4:10:12", :frequency => "M" })/1000|,
    "VISCANNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:5:10:12", :frequency => "M" })/1000|,
    "VISNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:11:10:12", :frequency => "M" })/1000|,
    "VISDMNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:18:29", :col => "block:11:10:12", :frequency => "M" })/1000|,
    "VISITNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:31:42", :col => "block:11:10:12", :frequency => "M" })/1000|,

    "VISNS@HON.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:18:29", :col => "block:2:3:12", :frequency => "M" })/1000|,
    "VISDMNS@HON.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:18:29", :col => "block:3:3:12", :frequency => "M" })/1000|,
    "VISITNS@HON.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:18:29", :col => "block:4:3:12", :frequency => "M" })/1000|,
    "VISNS@MAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:31:42", :col => "block:2:3:12", :frequency => "M" })/1000|,
    "VISDMNS@MAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:31:42", :col => "block:3:3:12", :frequency => "M" })/1000|,
    "VISITNS@MAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:31:42", :col => "block:4:3:12", :frequency => "M" })/1000|,
    "VISNS@MAUI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:44:55", :col => "block:5:3:12", :frequency => "M" })/1000|,
    "VISDMNS@MAUI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:44:55", :col => "block:6:3:12", :frequency => "M" })/1000|,
    "VISITNS@MAUI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:44:55", :col => "block:7:3:12", :frequency => "M" })/1000|,
    "VISNS@MOL.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:57:68", :col => "block:5:3:12", :frequency => "M" })/1000|,
    "VISDMNS@MOL.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:57:68", :col => "block:6:3:12", :frequency => "M" })/1000|,
    "VISITNS@MOL.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:57:68", :col => "block:7:3:12", :frequency => "M" })/1000|,
    "VISNS@LAN.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:70:81", :col => "block:5:3:12", :frequency => "M" })/1000|,
    "VISDMNS@LAN.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:70:81", :col => "block:6:3:12", :frequency => "M" })/1000|,
    "VISITNS@LAN.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1991-01-01", :sheet => "6", :row => "repeat:70:81", :col => "block:7:3:12", :frequency => "M" })/1000|,
    "VISNS@KAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:83:94", :col => "block:2:3:12", :frequency => "M" })/1000|,
    "VISDMNS@KAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:83:94", :col => "block:3:3:12", :frequency => "M" })/1000|,
    "VISITNS@KAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:83:94", :col => "block:4:3:12", :frequency => "M" })/1000|,
    "VISNS@HAW.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:96:107", :col => "block:2:3:12", :frequency => "M" })/1000|,
    "VISDMNS@HAW.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:96:107", :col => "block:3:3:12", :frequency => "M" })/1000|,
    "VISITNS@HAW.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:96:107", :col => "block:4:3:12", :frequency => "M" })/1000|,

    "VEXPUSWNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2001-01-01", :sheet => "12", :row => "repeat:5:16", :col => "block:2:6:12", :frequency => "M" })|,
    "VEXPUSENS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2001-01-01", :sheet => "12", :row => "repeat:5:16", :col => "block:3:6:12", :frequency => "M" })|,
    "VEXPJPNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2001-01-01", :sheet => "12", :row => "repeat:5:16", :col => "block:4:6:12", :frequency => "M" })|,
    "VEXPCANNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2001-01-01", :sheet => "12", :row => "repeat:5:16", :col => "block:5:6:12", :frequency => "M" })|,
    "VEXPNS@HI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2001-01-01", :sheet => "12", :row => "repeat:5:16", :col => "block:7:6:12", :frequency => "M" })|,

    "VEXPNS@HON.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:2:7:12", :frequency => "M" })|,
    "VEXPNS@MAUI.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:3:7:12", :frequency => "M" })|,
    "VEXPNS@MOL.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:4:7:12", :frequency => "M" })|,
    "VEXPNS@LAN.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:5:7:12", :frequency => "M" })|,
    "VEXPNS@KAU.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:6:7:12", :frequency => "M" })|,
    "VEXPNS@HAW.M" => %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "2004-01-01", :sheet => "13", :row => "repeat:5:16", :col => "block:7:7:12", :frequency => "M" })|,
	}
	
	p = Packager.new
	p.add_definitions tour_1
	p.write_definitions_to "/Volumes/UHEROwork/data/tour/update/tour_upd1_NEW.xls"  
end


task :visitor_identities=>:environment do
  t = Time.now
  
  "VISUSNS@HON.M".ts_eval= %Q|"VISUSWNS@HON.M".ts + "VISUSENS@HON.M".ts|
  "VISUSNS@HAW.M".ts_eval= %Q|"VISUSWNS@HAW.M".ts + "VISUSENS@HAW.M".ts|
  "VISUSNS@KAU.M".ts_eval= %Q|"VISUSWNS@KAU.M".ts + "VISUSENS@KAU.M".ts|
  "VISUSNS@MAU.M".ts_eval= %Q|"VISUSWNS@MAU.M".ts + "VISUSENS@MAU.M".ts|
  "VISUSNS@HI.M".ts_eval= %Q|"VISUSWNS@HI.M".ts + "VISUSENS@HI.M".ts|
  "VISUSNS@LAN.M".ts_eval= %Q|"VISUSWNS@LAN.M".ts + "VISUSENS@LAN.M".ts|
  "VISUSNS@MOL.M".ts_eval= %Q|"VISUSWNS@MOL.M".ts + "VISUSENS@MOL.M".ts|
  "VISUSNS@MAUI.M".ts_eval= %Q|"VISUSWNS@MAUI.M".ts + "VISUSENS@MAUI.M".ts|
  "VEXPPDNS@HI.M".ts_eval= %Q|"VEXPNS@HI.M".ts / "VDAYNS@HI.M".ts*1000|
  "VEXPPDUSWNS@HI.M".ts_eval= %Q|"VEXPUSWNS@HI.M".ts / "VDAYUSWNS@HI.M".ts*1000|
  "VEXPPDUSENS@HI.M".ts_eval= %Q|"VEXPUSENS@HI.M".ts / "VDAYUSENS@HI.M".ts*1000|
  "VEXPPDJPNS@HI.M".ts_eval= %Q|"VEXPJPNS@HI.M".ts / "VDAYJPNS@HI.M".ts*1000|
  "VEXPPDCANNS@HI.M".ts_eval= %Q|"VEXPCANNS@HI.M".ts / "VDAYCANNS@HI.M".ts*1000|
  "VEXPPDOTNS@HI.M".ts_eval= %Q|"VEXPOTNS@HI.M".ts / "VDAYOTNS@HI.M".ts*1000|
  "VEXPPTNS@HI.M".ts_eval= %Q|"VEXPNS@HI.M".ts / "VISNS@HI.M".ts*1000|
  "VEXPPTUSWNS@HI.M".ts_eval= %Q|"VEXPUSWNS@HI.M".ts / "VISUSWNS@HI.M".ts*1000|
  "VEXPPTUSENS@HI.M".ts_eval= %Q|"VEXPUSENS@HI.M".ts / "VISUSENS@HI.M".ts*1000|
  "VEXPPTJPNS@HI.M".ts_eval= %Q|"VEXPJPNS@HI.M".ts / "VISJPNS@HI.M".ts*1000|
  "VEXPPTCANNS@HI.M".ts_eval= %Q|"VEXPCANNS@HI.M".ts / "VISCANNS@HI.M".ts*1000|
  "VEXPPTOTNS@HI.M".ts_eval= %Q|"VEXPOTNS@HI.M".ts / "VISOTNS@HI.M".ts*1000|  
  "VEXPPDNS@HON.M".ts_eval= %Q|"VEXPNS@HON.M".ts / "VDAYNS@HON.M".ts*1000|
  "VEXPPDNS@MAUI.M".ts_eval= %Q|"VEXPNS@MAUI.M".ts / "VDAYNS@MAUI.M".ts*1000|
  "VEXPPDNS@MOL.M".ts_eval= %Q|"VEXPNS@MOL.M".ts / "VDAYNS@MOL.M".ts*1000|
  "VEXPPDNS@LAN.M".ts_eval= %Q|"VEXPNS@LAN.M".ts / "VDAYNS@LAN.M".ts*1000|
  "VEXPPDNS@KAU.M".ts_eval= %Q|"VEXPNS@KAU.M".ts / "VDAYNS@KAU.M".ts*1000|
  "VEXPPDNS@HAW.M".ts_eval= %Q|"VEXPNS@HAW.M".ts / "VDAYNS@HAW.M".ts*1000|
  "VISNS@NBI.M".ts_eval= %Q|"VISNS@HI.M".ts - "VISNS@HON.M".ts|
  "VEXPUSNS@HI.M".ts_eval= %Q|"VEXPUSWNS@HI.M".ts + "VEXPUSENS@HI.M".ts|
  "VEXPOTNS@HI.M".ts_eval= %Q|"VEXPNS@HI.M".ts - "VEXPUSNS@HI.M".ts - "VEXPJPNS@HI.M".ts - "VEXPCANNS@HI.M".ts|
  "VEXPNS@MAU.M".ts_eval= %Q|"VEXPNS@MAUI.M".ts + "VEXPNS@LAN.M".ts + "VEXPNS@MOL.M".ts|
  "VEXPPDNS@MAU.M".ts_eval= %Q|"VEXPNS@MAU.M".ts / "VDAYNS@MAU.M".ts*1000|
  "VDAYUSNS@HON.M".ts_eval= %Q|"VDAYUSENS@HON.M".ts + "VDAYUSWNS@HON.M".ts|
  "VDAYUSNS@HAW.M".ts_eval= %Q|"VDAYUSENS@HAW.M".ts + "VDAYUSWNS@HAW.M".ts|
  "VDAYUSNS@KAU.M".ts_eval= %Q|"VDAYUSENS@KAU.M".ts + "VDAYUSWNS@KAU.M".ts|
  "VDAYUSNS@MAU.M".ts_eval= %Q|"VDAYUSENS@MAU.M".ts + "VDAYUSWNS@MAU.M".ts|
  "VDAYUSNS@MAUI.M".ts_eval= %Q|"VDAYUSENS@MAUI.M".ts + "VDAYUSWNS@MAUI.M".ts|
  "VDAYUSNS@MOL.M".ts_eval= %Q|"VDAYUSENS@MOL.M".ts + "VDAYUSWNS@MOL.M".ts|
  "VDAYUSNS@LAN.M".ts_eval= %Q|"VDAYUSENS@LAN.M".ts + "VDAYUSWNS@LAN.M".ts|
  "VDAYUSNS@HI.M".ts_eval= %Q|"VDAYUSENS@HI.M".ts + "VDAYUSWNS@HI.M".ts|
  "VEXPPDUSNS@HI.M".ts_eval= %Q|"VEXPUSNS@HI.M".ts / "VDAYUSNS@HI.M".ts*1000|
  "VEXPPTUSNS@HI.M".ts_eval= %Q|"VEXPUSNS@HI.M".ts / "VISUSNS@HI.M".ts*1000|

  "VSONS@HAW.M".ts_eval= %Q|"VSONS@HAWH.M".ts.zero_add "VSONS@HAWK.M".ts|
  "VSODMNS@HAW.M".ts_eval= %Q|"VSODMNS@HAWH.M".ts.zero_add "VSODMNS@HAWK.M".ts|
  "VSOUSENS@HAW.M".ts_eval= %Q|"VSOUSENS@HAWH.M".ts.zero_add "VSOUSENS@HAWK.M".ts|
  "VSOUSWNS@HAW.M".ts_eval= %Q|"VSOUSWNS@HAWH.M".ts.zero_add "VSOUSWNS@HAWK.M".ts|
  "VSOITNS@HAW.M".ts_eval= %Q|"VSOITNS@HAWH.M".ts.zero_add "VSOITNS@HAWK.M".ts|
  "VSOJPNS@HAW.M".ts_eval= %Q|"VSOJPNS@HAWH.M".ts.zero_add "VSOJPNS@HAWK.M".ts|
  "VSOCANNS@HAW.M".ts_eval= %Q|"VSOCANNS@HAWH.M".ts.zero_add "VSOCANNS@HAWK.M".ts|
  
  ["HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|   
    #surprising this is not done in tour.rake considering so many definitions require it there.
    "VDAYNS@#{cnty}.M".ts_eval= %Q|"VDAYDMNS@#{cnty}.M".ts + "VDAYITNS@#{cnty}.M".ts|
  end

  "VDAYRESNS@HON.M".ts_eval= %Q|"VDAYNS@HON.M".ts - ("VDAYUSNS@HON.M".ts + "VDAYJPNS@HON.M".ts)|
  "VDAYRESNS@HAW.M".ts_eval= %Q|"VDAYNS@HAW.M".ts - ("VDAYUSNS@HAW.M".ts + "VDAYJPNS@HAW.M".ts)|
  "VDAYRESNS@KAU.M".ts_eval= %Q|"VDAYNS@KAU.M".ts - ("VDAYUSNS@KAU.M".ts + "VDAYJPNS@KAU.M".ts)|
  "VDAYRESNS@MAU.M".ts_eval= %Q|"VDAYNS@MAU.M".ts - ("VDAYUSNS@MAU.M".ts + "VDAYJPNS@MAU.M".ts)|
  "VDAYRESNS@MAUI.M".ts_eval= %Q|"VDAYNS@MAUI.M".ts - ("VDAYUSNS@MAUI.M".ts + "VDAYJPNS@MAUI.M".ts)|
  "VDAYRESNS@MOL.M".ts_eval= %Q|"VDAYNS@MOL.M".ts - ("VDAYUSNS@MOL.M".ts + "VDAYJPNS@MOL.M".ts)|
  "VDAYRESNS@LAN.M".ts_eval= %Q|"VDAYNS@LAN.M".ts - ("VDAYUSNS@LAN.M".ts + "VDAYJPNS@LAN.M".ts)|
  "VDAYRESNS@HI.M".ts_eval= %Q|"VDAYNS@HI.M".ts - "VDAYUSNS@HI.M".ts - "VDAYJPNS@HI.M".ts|

  ["MOL", "LAN", "MAUI"].each do |cnty|
    ["DM", "IT", "US", "RES"].each do |ser|
      "VIS#{ser}@#{cnty}.A".ts_eval= %Q|"VIS#{ser}NS@#{cnty}.M".ts.aggregate(:year, :sum)|
    end
    "VIS@#{cnty}.A".ts_eval= %Q|"VISNS@#{cnty}.M".ts.aggregate(:year, :sum)|
  end
  
  ["DM", "IT", "USW", "USE", "JP", "CAN"].each do |ser|
    ["HON", "KAU", "MAUI", "MOL", "LAN", "HAW", "MAU"].each do |cnty| 
      "VRLS#{ser}NS@#{cnty}.M".ts_eval= %Q| "VDAY#{ser}NS@#{cnty}.M".ts / "VIS#{ser}NS@#{cnty}.M".ts |
    end
  end

  ["", "DM", "IT", "CAN", "JP", "USE", "USW"].each do |serlist| 
    
    #this is causing the circular reference.... don't run... actually, this is ok for Maui only. definitely for IT... not sure about others
    #{}"VRLS#{serlist}NS@MAU.M".ts_eval= %Q|("VRLS#{serlist}NS@MAUI.M".ts * "VIS#{serlist}NS@MAUI.M".ts + "VRLS#{serlist}NS@MOL.M".ts * "VIS#{serlist}NS@MOL.M".ts + "VRLS#{serlist}NS@LAN.M".ts * "VIS#{serlist}NS@LAN.M".ts) / "VIS#{serlist}NS@MAU.M".ts|
    #{}"VDAY#{serlist}NS@MAU.M".ts_eval= %Q|"VRLS#{serlist}NS@MAU.M".ts * "VIS#{serlist}NS@MAU.M".ts|
    
    #if these change back, need to delete the old series, or it will cause circular reference
    #this got changed because of CyFeng, I think
    "VDAY#{serlist}NS@MAU.M".ts_eval= %Q|"VDAY#{serlist}NS@MAUI.M".ts + "VDAY#{serlist}NS@MOL.M".ts + "VDAY#{serlist}NS@LAN.M".ts|
    "VRLS#{serlist}NS@MAU.M".ts_eval= %Q|"VDAY#{serlist}NS@MAU.M".ts / "VIS#{serlist}NS@MAU.M".ts|
  end
  
  ["HI", "HON", "KAU", "MAUI", "MOL", "LAN", "HAW", "MAU"].each do |cnty| 
    "VRLSNS@#{cnty}.Q".ts_eval= %Q|("VRLSNS@#{cnty}.M".ts * "VISNS@#{cnty}.M".ts).aggregate(:quarter, :sum)  / "VISNS@#{cnty}.Q".ts|        
    "VRLS@#{cnty}.A".ts_eval= %Q|("VRLSNS@#{cnty}.M".ts * "VISNS@#{cnty}.M".ts).aggregate(:year, :sum) / "VIS@#{cnty}.A".ts|
  end

  "VRLSOTNS@HI.Q".ts_eval= %Q|("VRLSOTNS@HI.M".ts * "VISOTNS@HI.M".ts).aggregate(:quarter, :sum)  / "VISOTNS@HI.Q".ts|        
  "VRLSOT@HI.A".ts_eval= %Q|("VRLSOTNS@HI.M".ts * "VISOTNS@HI.M".ts).aggregate(:year, :sum) / "VISOT@HI.A".ts|
  
  #identities seemed to take over 10/21/12 Ben
  #need to load all history identities seem to take full precedence
  ["HON", "MAUI", "MOL", "LAN", "HAW"].each do |cnty| #note MAU is not included here. totally separate calculations
    "VRLSUSWNS@#{cnty}.M".ts_eval= %Q|"VRLSUSWNS@#{cnty}.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
    "VRLSUSENS@#{cnty}.M".ts_eval= %Q|"VRLSUSENS@#{cnty}.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
    "VRLSJPNS@#{cnty}.M".ts_eval= %Q|"VRLSJPNS@#{cnty}.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
    "VRLSCANNS@#{cnty}.M".ts_eval= %Q|"VRLSCANNS@#{cnty}.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
  end
  
  #KAU is in different history sheet
  "VRLSUSWNS@KAU.M".ts_eval= %Q|"VRLSUSWNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls"|
  "VRLSUSENS@KAU.M".ts_eval= %Q|"VRLSUSENS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls"|
  "VRLSJPNS@KAU.M".ts_eval= %Q|"VRLSJPNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls"|
  "VRLSCANNS@KAU.M".ts_eval= %Q|"VRLSCANNS@KAU.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd2_hist.xls"|
    
    
    
  ["DM", "IT", "USW", "USE", "JP", "CAN"].each do |ser|
    ["HI", "HON", "KAU", "MAUI", "MOL", "LAN", "HAW", "MAU"].each do |cnty| 
      "VRLS#{ser}NS@#{cnty}.Q".ts_eval= %Q|("VRLS#{ser}NS@#{cnty}.M".ts * "VIS#{ser}NS@#{cnty}.M".ts).aggregate(:quarter, :sum) / "VIS#{ser}NS@#{cnty}.Q".ts|
      "VRLS#{ser}@#{cnty}.A".ts_eval= %Q|("VRLS#{ser}NS@#{cnty}.M".ts * "VIS#{ser}NS@#{cnty}.M".ts).aggregate(:year, :sum) / "VIS#{ser}@#{cnty}.A".ts|
    end
  end
  #do the MAUI stuff here... THESE HAVE SOME MISMATCHING --------------------------------

    
  #from task vlos requires vdayNSs and visNSs and vrlsNSs
  ["RES", "US", "","CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
        "VLOS#{serlist}NS@#{cnty}.M".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.M".ts / "VIS#{serlist}NS@#{cnty}.M".ts|
        "VLOS#{serlist}NS@#{cnty}.Q".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.Q".ts / "VIS#{serlist}NS@#{cnty}.Q".ts|        
    end
  end

  ["HI", "HON", "HAW", "KAU", "MAU"].each do |cnty| 
    ["M", "Q", "A"].each do |f|
      "VLOS@#{cnty}.#{f}".ts_eval= %Q|"VDAY@#{cnty}.#{f}".ts / "VIS@#{cnty}.#{f}".ts|
      "VLOSJP@#{cnty}.#{f}".ts_eval= %Q|"VDAYJP@#{cnty}.#{f}".ts / "VISJP@#{cnty}.#{f}".ts|
      "VLOSCAN@#{cnty}.#{f}".ts_eval= %Q|"VDAYCAN@#{cnty}.#{f}".ts / "VISCAN@#{cnty}.#{f}".ts| 
      "VLOSUSE@#{cnty}.#{f}".ts_eval= %Q|"VDAYUSE@#{cnty}.#{f}".ts / "VISUSE@#{cnty}.#{f}".ts| 
      "VLOSUSW@#{cnty}.#{f}".ts_eval= %Q|"VDAYUSW@#{cnty}.#{f}".ts / "VISUSW@#{cnty}.#{f}".ts| 
      "VLOSUS@#{cnty}.#{f}".ts_eval= %Q|"VDAYUS@#{cnty}.#{f}".ts / "VISUS@#{cnty}.#{f}".ts| 
      "VLOSDM@#{cnty}.#{f}".ts_eval= %Q|"VDAYDM@#{cnty}.#{f}".ts / "VISDM@#{cnty}.#{f}".ts|
      "VLOSIT@#{cnty}.#{f}".ts_eval= %Q|"VDAYIT@#{cnty}.#{f}".ts / "VISIT@#{cnty}.#{f}".ts|
      "VLOSRES@#{cnty}.#{f}".ts_eval= %Q|"VDAYRES@#{cnty}.#{f}".ts / "VISRES@#{cnty}.#{f}".ts|
    end
  end
  
  ["MOL", "LAN", "MAUI"].each do |cnty| 
    ["A"].each do |f|
      "VLOS@#{cnty}.#{f}".ts_eval= %Q|"VDAY@#{cnty}.#{f}".ts / "VIS@#{cnty}.#{f}".ts|
      "VLOSJP@#{cnty}.#{f}".ts_eval= %Q|"VDAYJP@#{cnty}.#{f}".ts / "VISJP@#{cnty}.#{f}".ts|
      "VLOSCAN@#{cnty}.#{f}".ts_eval= %Q|"VDAYCAN@#{cnty}.#{f}".ts / "VISCAN@#{cnty}.#{f}".ts| 
      "VLOSUSE@#{cnty}.#{f}".ts_eval= %Q|"VDAYUSE@#{cnty}.#{f}".ts / "VISUSE@#{cnty}.#{f}".ts| 
      "VLOSUSW@#{cnty}.#{f}".ts_eval= %Q|"VDAYUSW@#{cnty}.#{f}".ts / "VISUSW@#{cnty}.#{f}".ts| 
      "VLOSUS@#{cnty}.#{f}".ts_eval= %Q|"VDAYUS@#{cnty}.#{f}".ts / "VISUS@#{cnty}.#{f}".ts| 
      "VLOSDM@#{cnty}.#{f}".ts_eval= %Q|"VDAYDM@#{cnty}.#{f}".ts / "VISDM@#{cnty}.#{f}".ts|
      "VLOSIT@#{cnty}.#{f}".ts_eval= %Q|"VDAYIT@#{cnty}.#{f}".ts / "VISIT@#{cnty}.#{f}".ts|
      "VLOSRES@#{cnty}.#{f}".ts_eval= %Q|"VDAYRES@#{cnty}.#{f}".ts / "VISRES@#{cnty}.#{f}".ts|
    end
  end
  
  "VLOSOT@HI.A".ts_eval= %Q|"VDAYOT@HI.A".ts / "VISOT@HI.A".ts|
  "VLOSOTNS@HI.Q".ts_eval= %Q|"VDAYOTNS@HI.Q".ts / "VISOTNS@HI.Q".ts|
  "VLOSOTNS@HI.M".ts_eval= %Q|"VDAYOTNS@HI.M".ts / "VISOTNS@HI.M".ts|
  
  "VLOSRES@MAUI.A".ts_eval=%Q|"VDAYRES@MAUI.A".ts / "VISRES@MAUI.A".ts|
  "VLOSRES@MOL.A".ts_eval=%Q|"VDAYRES@MOL.A".ts / "VISRES@MOL.A".ts|
  "VLOSRES@LAN.A".ts_eval=%Q|"VDAYRES@LAN.A".ts / "VISRES@LAN.A".ts|

  ["CR", "CRAF", "CRBF","CRDR", "CRND"].each do |serlist| 
      "VLOS#{serlist}NS@HI.Q".ts_eval= %Q|"VDAY#{serlist}NS@HI.Q".ts / "VISCRNS@HI.Q".ts|
      "VLOS#{serlist}@HI.A".ts_eval= %Q|"VDAY#{serlist}@HI.A".ts / "VISCR@HI.A".ts|
  end
  
  ["CRAIR", "US", "RES", "","CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
      ["M", "Q"].each do |f|
        begin
          "VADC#{serlist}NS@#{cnty}.#{f}".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.#{f}".ts / "VDAY#{serlist}NS@#{cnty}.#{f}".ts.days_in_period|
        rescue
          puts "ERROR: #{serlist}NS, #{cnty}, #{f}"
        end
      end
    end
  end
  
  ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty| 
    "VISRESNS@#{cnty}.M".ts_eval= %Q|"VISNS@#{cnty}.M".ts - "VISUSNS@#{cnty}.M".ts - "VISJPNS@#{cnty}.M".ts|
  end

  "VRLSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
  "VLOSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
  "VLOSCRNDNS@HI.M".ts_eval= %Q|"VLOSCRNS@HI.M".ts - "VLOSCRDRNS@HI.M".ts|
  
  "VRLSCRAIRNS@HI.Q".ts_eval= %Q|("VRLSCRAIRNS@HI.M".ts * "VISCRAIRNS@HI.M".ts).aggregate(:quarter, :sum) / "VISCRAIRNS@HI.Q".ts|
  "VRLSCRAIR@HI.A".ts_eval= %Q|("VRLSCRAIRNS@HI.M".ts * "VISCRAIRNS@HI.M".ts).aggregate(:year, :sum) / "VISCRAIR@HI.A".ts|
  
  ["HON", "HAW", "KAU", "MAU"].each do |cnty|
    "VISCRAIRNS@#{cnty}.M".ts_eval= %Q|"VISCRNS@#{cnty}.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
  end
  
  "VDAYCRAIRNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRAIRNS@HI.M".ts|
  
  ["HON", "HAW", "KAU", "MAU"].each do |cnty|
    "VDAYCRAIRNS@#{cnty}.M".ts_eval= %Q|"VISCRAIRNS@#{cnty}.M".ts * "VLOSCRNS@HI.M".ts / 4|
  end
  
  "VDAYCRSHPNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRNS@HI.M".ts|

  ["BFNS", "DRNS", "AFNS", "NDNS"].each do |myvar|
    "VDAYCR#{myvar}@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
    "VDAYCRS#{myvar}@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
    "VDAYCRA#{myvar}@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
  end
  
  [ "VISJP", "VISUS",  "VISRES", "VDAYUS", "VDAYRES", "VDAYJP", "VISIT", "VISDM", "VDAYDM", "VDAYIT"].each do |s_name|
    "#{s_name}@HI.M".ts_append_eval %Q|"#{s_name}@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
    add_factors = ["VISRES", "VDAYUS", "VISUS", "VDAYRES", "VISIT", "VDAYIT", "VDAYDM", "VISUSE", "VEXPUS", "VEXPPTUSE", "VEXP", "VEXPPDUSW", "VISCR", "VEXPPDUS", "VEXPOT", "VEXPPDOT", "VEXPPDOTNS", "VISCRAIR", "VEXPUSW", "VEXPPTCAN", 'VEXPPDUSE', "VEXPJPNS", "VEXPPD", "VDAYUSE", "VISDM"]
    mult_factors = ["VISJP",  "VDAYJP", "VISUSW", "VISCAN", "VEXPPTJP", "VEXPPTUSW", "VS", "VDAYCAN", "VEXPPT", "VEXPCAN", "VSDM", "VEXPPTOT" ]    
    
    "#{s_name}@HI.M".ts_eval= %Q|"#{s_name}@HI.M".ts.apply_seasonal_adjustment :additive| unless add_factors.index(s_name).nil?
    "#{s_name}@HI.M".ts_eval= %Q|"#{s_name}@HI.M".ts.apply_seasonal_adjustment :multiplicative| unless mult_factors.index(s_name).nil?
    
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "sharing #{s_name} to #{county}"
      "#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}@HI.M".ts.mc_ma_county_share_for("#{county}")|
    end
  end
  
  
  #weird one off of history? maybe ns doesn't go that far back or something
  "VEXPPTOT@HI.M".ts_eval= %Q|"VEXPPTOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPDOT@HI.M".ts_eval= %Q|"VEXPPDOT@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  
  ["VISUSW", "VISUSE", "VISCAN", "VEXPPTUSW", "VS", "VDAYCAN", "VEXPPT", "VEXPCAN", "VSDM", "VEXPPTOT", "VEXPUS", "VEXPPTUSE", "VEXP", "VEXPPDUSW", "VEXPPTJP", "VISCR", "VEXPPDUS", "VEXPOT", "VEXPPDOT", "VEXPPDOT", "VISCRAIR", "VEXPUSW", "VEXPPTCAN", 'VEXPPDUSE', "VEXPJP", "VEXPPD", "VDAYUSE", "VEXPPDCAN", "VDAYUSW", "VEXPUSE"].each do |s_name|
    "#{s_name}@HI.M".ts_append_eval %Q|"#{s_name}@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
    add_factors = [ "VEXPUS", "VEXPPTUSE", "VEXP", "VEXPPDUSW", "VISCR", "VEXPPDUS", "VEXPPDOT", "VEXPPDOT", "VEXPUSW", "VEXPPTCAN", 'VEXPPDUSE', "VEXPJP", "VEXPPD", "VDAYUSE", "VEXPPDCAN", "VDAYUSW", "VEXPUSE", "VEXPPTOT"]
    mult_factors = ["VISUSE", "VISUSW", "VISCAN", "VEXPPTJP", "VEXPPTUSW", "VS", "VDAYCAN", "VEXPPT", "VEXPCAN", "VSDM", "VISCRAIR", "VEXPOT" ]    

    "#{s_name}@HI.M".ts_eval= %Q|"#{s_name}@HI.M".ts.apply_seasonal_adjustment :additive| unless add_factors.index(s_name).nil?
    "#{s_name}@HI.M".ts_eval= %Q|"#{s_name}@HI.M".ts.apply_seasonal_adjustment :multiplicative| unless mult_factors.index(s_name).nil?
  end
  

  "VDAY@HI.M".ts_append_eval %Q|"VDAY@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
  "VDAY@HI.M".ts_append_eval %Q|"VDAYJP@HI.M".ts + "VDAYUS@HI.M".ts + "VDAYRES@HI.M".ts|
  "VIS@HI.M".ts_eval= %Q|"VISJP@HI.M".ts + "VISUS@HI.M".ts + "VISRES@HI.M".ts|
  "VISDEMETRA_MC@HI.M".ts_eval= %Q|"VIS@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
  "VISDEMETRA_MC@HI.M".ts_eval= %Q|"VIS@HI.M".ts.apply_seasonal_adjustment :additive|
  
  #intermediate share calculations... all match
  ["HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|   #CNTY WITHOUT HI
    "SH_USNS@#{cnty}.M".ts_eval= %Q|"VISUSNS@#{cnty}.M".ts / "VISUSNS@HI.M".ts|
    "SH_JPNS@#{cnty}.M".ts_eval= %Q|"VISJPNS@#{cnty}.M".ts / "VISJPNS@HI.M".ts|
    "SH_RESNS@#{cnty}.M".ts_eval= %Q|"VISRESNS@#{cnty}.M".ts / "VISRESNS@HI.M".ts|
  end
  "SH_USNS@HI.M".ts_eval= %Q|"SH_USNS@HON.M".ts + "SH_USNS@HAW.M".ts + "SH_USNS@KAU.M".ts + "SH_USNS@MAU.M".ts|
  "SH_JPNS@HI.M".ts_eval= %Q|"SH_JPNS@HON.M".ts + "SH_JPNS@HAW.M".ts + "SH_JPNS@KAU.M".ts + "SH_JPNS@MAU.M".ts|
  "SH_RESNS@HI.M".ts_eval= %Q|"SH_RESNS@HON.M".ts + "SH_RESNS@HAW.M".ts + "SH_RESNS@KAU.M".ts + "SH_RESNS@MAU.M".ts|

  "SH_JPNS@HON.Q".ts_eval= %Q|"VISJPNS@HON.Q".ts / "VISJPNS@HI.Q".ts|
  "SH_RESNS@HON.Q".ts_eval= %Q|"VISRESNS@HON.Q".ts / "VISRESNS@HI.Q".ts|

  "SH_JPNS@HI.Q".ts_eval= %Q|("VISJPNS@HON.Q".ts + "VISJPNS@HAW.Q".ts + "VISJPNS@KAU.Q".ts + "VISJPNS@MAU.Q".ts) / "VISJPNS@HI.Q".ts|
  "SH_RESNS@HI.Q".ts_eval= %Q|("VISRESNS@HON.Q".ts + "VISRESNS@HAW.Q".ts + "VISRESNS@KAU.Q".ts + "VISRESNS@MAU.Q".ts) / "VISRESNS@HI.Q".ts|
  
  
  ["JP","RES", "US"].each do |mma|
    ["A", "Q", "M"].each do |f|
      ["HAW", "HON", "MAU", "KAU"].each do |cnty|
      	("SH_#{mma}@#{cnty}.#{f}".ts_eval= %Q|"VIS#{mma}@#{cnty}.#{f}".ts / "VIS#{mma}@HI.#{f}".ts |) rescue puts "ERROR : SH_#{mma}@#{cnty}.#{f}"
      end
      ("SH_#{mma}@HI.#{f}".ts_eval= %Q|"SH_#{mma}@HON.#{f}".ts + "SH_#{mma}@HAW.#{f}".ts + "SH_#{mma}@KAU.#{f}".ts + "SH_#{mma}@MAU.#{f}".ts  |) rescue puts "ERROR : SH_#{mma}@HI.#{f}"
    end
  end

  
  # Does first segment
  "VIS@HON.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HON","VIS").trim("1990-01-01","1999-12-01")|
  "VIS@HAW.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HAW","VIS").trim("1990-01-01","1990-12-01")|
  "VIS@KAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("KAU","VIS").trim("1990-01-01","1990-12-01")|
  "VIS@MAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("MAU","VIS").trim("1990-01-01","1990-12-01")|
  
  #Does last segment... may get overwritten by identities below
  "VIS@HON.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HON","VIS").trim|
  "VIS@HAW.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HAW","VIS").trim|
  "VIS@KAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("KAU","VIS").trim|
  "VIS@MAU.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("MAU","VIS").trim|
  "VIS@MAUI.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("MAUI","VIS").trim|
  "VIS@MOL.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("MOL","VIS").trim|
  "VIS@LAN.M".ts_eval= %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("LAN","VIS").trim|

  "VLOS@HI.M".ts_eval=      %Q|"VDAY@HI.M".ts / "VIS@HI.M".ts|
  
  "VSO@HI.M".ts_eval= %Q|"VSO@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSO@HI.M".ts_eval= %Q|"VSO@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSO@HI.M".ts_eval= %Q|"VSO@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  
  "VSODM@HI.M".ts_eval= %Q|"VSODM@HI.M".tsn.load_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSODM@HI.M".ts_eval= %Q|"VSODM@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VSODM@HI.M".ts_eval= %Q|"VSODM@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  
  
  "VLOSCRAIR@HI.M".ts_eval= %Q|"VLOSCRAIR@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VLOSCRAIR@HI.M".ts_eval= %Q|"VLOSCRAIR@HI.M".ts.apply_seasonal_adjustment :additive|
  
  "VEXPPTUS@HI.M".ts_eval= %Q|"VEXPPTUS@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPTUS@HI.M".ts_eval= %Q|"VEXPPTUS@HI.M".ts.apply_seasonal_adjustment :multiplicative|
  
  "VEXPPDJP@HI.M".ts_eval= %Q|"VEXPPDJP@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "VEXPPDJP@HI.M".ts_eval= %Q|"VEXPPDJP@HI.M".ts.apply_seasonal_adjustment :additive|

  ["HON", "HAW", "KAU", "MAU"].each do |cnty| #MAUI / MOL / LAN?
    ser = ""
    "VS#{ser}@#{cnty}.M".ts_eval= %Q|"VS#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VS#{ser}")|
    "VS#{ser}@#{cnty}.Q".ts_eval= %Q|"VS#{ser}@#{cnty}.M".ts.aggregate(:quarter, :sum)|
    "VSDM@#{cnty}.M".ts_eval= %Q|"VSDM@HI.M".ts.mc_ma_county_share_for("#{cnty}","VSDM")|
    "VSDM@#{cnty}.Q".ts_eval= %Q|"VSDM@#{cnty}.M".ts.aggregate(:quarter, :sum)|
    
    "VSO#{ser}@#{cnty}.M".ts_eval= %Q|"VSO#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VSO#{ser}")| 
    "VSODM#{ser}@#{cnty}.M".ts_eval= %Q|"VSODM#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VSODM#{ser}")|
    "VEXP#{ser}@#{cnty}.M".ts_eval= %Q|"VEXP#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VEXP#{ser}")|
    "VEXPPD#{ser}@#{cnty}.M".ts_eval= %Q|"VEXPPD#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VEXPPD#{ser}")|
    "VEXPPT#{ser}@#{cnty}.M".ts_eval= %Q|"VEXPPT#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VEXPPT#{ser}")|
    "VSO@#{cnty}.M".ts_eval= %Q|"VSO@HI.M".ts.share_using("VSONS@#{cnty}.M".ts.moving_average_offset_early, "VSONS@HI.M".ts.moving_average_offset_early).trim("2005-01-01","2005-12-01")|
    "VSODM@#{cnty}.M".ts_eval= %Q|"VSODM@HI.M".ts.share_using("VSODMNS@#{cnty}.M".ts.moving_average_offset_early, "VSODMNS@HI.M".ts.moving_average_offset_early).trim("2005-01-01","2005-12-01")|
  end

  ["HON", "HAW", "KAU", "MAU"].each do |cnty| #MAUI / MOL / LAN?
    "VSO@#{cnty}.Q".ts_eval= %Q|"VSO@#{cnty}.M".ts.aggregate(:quarter, :average)|
    "VSODM@#{cnty}.Q".ts_eval= %Q|"VSODM@#{cnty}.M".ts.aggregate(:quarter, :average)|
  end
  
  ["CAN", "JP", "USE", "USW"].each do |ser|
    ["HON", "HAW", "KAU", "MAU","MAUI","MOL","LAN"].each do |cnty|
      "VIS#{ser}@#{cnty}.M".ts_eval= %Q|"VIS#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VIS#{ser}")|
      "VDAY#{ser}@#{cnty}.M".ts_eval= %Q|"VDAY#{ser}@HI.M".ts.mc_ma_county_share_for("#{cnty}","VDAY#{ser}")|
      "VIS#{ser}@#{cnty}.Q".ts_eval= %Q|"VIS#{ser}@#{cnty}.M".ts.aggregate(:quarter, :sum)|
      "VIS#{ser}@#{cnty}.A".ts_eval= %Q|"VIS#{ser}@#{cnty}.M".ts.aggregate(:year, :sum)|
      "VDAY#{ser}@#{cnty}.Q".ts_eval= %Q|"VDAY#{ser}@#{cnty}.M".ts.aggregate(:quarter, :sum)|
      "VDAY#{ser}@#{cnty}.A".ts_eval= %Q|"VDAY#{ser}@#{cnty}.M".ts.aggregate(:year, :sum)|
    end
  end
  

  
  ["VEXP"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      "#{s_name}@#{county}.Q".ts_eval= %Q|"#{s_name}@#{county}.M".ts.aggregate(:quarter, :sum)|
    end
  end
  
  ["VEXPPD", "VEXPPT"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      "#{s_name}@#{county}.Q".ts_eval= %Q|"#{s_name}@#{county}.M".ts.aggregate(:quarter, :average)|
    end
  end
  
  # "VEXPUS@HI.A"=>%Q|"VEXPUS@HI.M".ts.aggregate(:year, :sum)|,
  #   "VEXPJP@HI.A"=>%Q|"VEXPJP@HI.M".ts.aggregate(:year, :sum)|,
  #   "VXPRUS@HI.A"=>%Q|"VEXPUS@HI.A".ts|,
  #   "VXPRJP@HI.A"=>%Q|"VEXPJP@HI.A".ts|,
  #   "VX@HI.A"=>[%Q|"VXPR@HI.A".ts + "VXBU@HI.A".ts|, 
  #                 %Q|"VX@HI.A".tsn.load_from "/Volumes/UHEROwork/data/tour/update/vexp_upd.xls" |
  #currently wrong // only VXs left, though
  "VX@HI.Q".ts_eval= %Q|"VEXP@HI.Q".ts|
  
  ["HI","HON", "HAW", "MAU", "KAU"].each do |county| #think I need to add MAUI, MOL, LAN but need to figure out VIS / VDAYRES
    "VIS@#{county}.M".ts_append_eval %Q|"VISJP@#{county}.M".ts + "VISUS@#{county}.M".ts + "VISRES@#{county}.M".ts|  
    "VDAY@#{county}.M".ts_append_eval %Q|"VDAYJP@#{county}.M".ts + "VDAYUS@#{county}.M".ts + "VDAYRES@#{county}.M".ts| 
  end
  
  ["HON", "HI", "KAU", "MAU", "HAW", "MAUI", "MOL", "LAN"].each do |county| 
    "VIS@#{county}.A".ts_eval= %Q|"VIS@#{county}.M".ts.aggregate(:year, :sum)|
  end
  
  "VIS@NBI.M".ts_eval= %Q|"VIS@HI.M".ts - "VIS@HON.M".ts|
  "VIS@NBI.Q".ts_eval= %Q|"VIS@HI.Q".ts - "VIS@HON.Q".ts|
  
  "VDAYCRAIR@HI.M".ts_eval = %Q|"VISCRAIR@HI.M".ts * "VLOSCRAIR@HI.M".ts|
  "VDAYCRAIR@HI.Q".ts_eval = %Q|"VDAYCRAIR@HI.M".ts.aggregate(:quarter, :sum)|
  "VLOSCRAIR@HI.Q".ts_eval= %Q| "VDAYCRAIR@HI.Q".ts / "VISCRAIR@HI.Q".ts |
  
  ["HON", "HAW", "MAU", "KAU"].each do |cnty|
    "VISCRAIR@#{cnty}.M".ts_eval= %Q|"VISCRAIR@HI.M".ts|
    "VISCRAIR@#{cnty}.Q".ts_eval= %Q|"VISCRAIR@HI.M".ts.aggregate(:quarter,:sum)|
    "VLOSCRAIR@#{cnty}.M".ts_eval= %Q|"VLOSCRAIR@HI.M".ts / 4|
    "VLOSCRAIR@#{cnty}.Q".ts_eval= %Q|"VLOSCRAIR@HI.Q".ts / 4|
    "VDAYCRAIR@#{cnty}.M".ts_eval= %Q|"VISCRAIR@#{cnty}.M".ts * "VLOSCRAIR@#{cnty}.M".ts |
    "VDAYCRAIR@#{cnty}.Q".ts_eval= %Q|"VISCRAIR@#{cnty}.Q".ts * "VLOSCRAIR@#{cnty}.Q".ts |
  end
  
  ["CRAIR", "US", "RES", "","CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
      ["M", "Q", "A"].each do |f|
        begin
          #next unless ["MAUI", "MOL", "LAN"].index(cnty).nil? # think these all eventually need to be in, though
          "VADC#{serlist}@#{cnty}.#{f}".ts_eval= %Q|"VDAY#{serlist}@#{cnty}.#{f}".ts / "VDAY#{serlist}@#{cnty}.#{f}".ts.days_in_period|
        rescue
          puts "ERROR: #{serlist}, #{cnty}, #{f}"
        end
      end
    end
  end
  
  
  ["CR","CRAAF", "CRABF", "CRADR", "CRAF", "CRAND", "CRBF", "CRDR", "CRND", "CRSAF", "CRSBF", "CRSDR", "CRSHP", "CRSND", "OT"].each do |serlist| 
    ["HI"].each do |cnty|
      ["M", "Q"].each do |f|
        ("VADC#{serlist}NS@#{cnty}.#{f}".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.#{f}".ts / "VDAY#{serlist}NS@#{cnty}.#{f}".ts.days_in_period|) rescue puts "ERROR: #{serlist}NS, #{cnty}, #{f}"        
      end
      ("VADC#{serlist}@#{cnty}.A".ts_eval= %Q|"VDAY#{serlist}@#{cnty}.A".ts / "VDAY#{serlist}@#{cnty}.A".ts.days_in_period|) rescue puts "ERROR: #{serlist}, #{cnty}, A"        
    end
  end
  
  ["","DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
      "VRDC#{serlist}@#{cnty}.A".ts_eval= %Q|("VRDC#{serlist}NS@#{cnty}.M".ts * "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period).aggregate(:year, :sum) / "VRDC#{serlist}NS@HI.M".ts.days_in_period.aggregate(:year, :sum)|
      "VRDC#{serlist}NS@#{cnty}.Q".ts_eval= %Q|("VRDC#{serlist}NS@#{cnty}.M".ts * "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period).aggregate(:quarter, :sum) / "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period.aggregate(:quarter, :sum)|
    end
  end

  ["CAN","JP", "USE", "USW"].each do |serlist| 
    cnty = "HI"
    "VRDC#{serlist}@#{cnty}.A".ts_eval= %Q|("VRDC#{serlist}NS@#{cnty}.M".ts * "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period).aggregate(:year, :sum) / "VRDC#{serlist}NS@HI.M".ts.days_in_period.aggregate(:year, :sum)|
    "VRDC#{serlist}NS@#{cnty}.Q".ts_eval= %Q|("VRDC#{serlist}NS@#{cnty}.M".ts * "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period).aggregate(:quarter, :sum) / "VRDC#{serlist}NS@#{cnty}.M".ts.days_in_period.aggregate(:quarter, :sum)|
  end
  #I'm guessing most of these are actually aggregations
  #none of these vdays are in, I think
  # ["CR","CRAAF", "CRABF", "CRADR", "CRAD", "CRAF",  "CRAND", "CRBF", "CRDR", "CRND", "CRSAF", "CRSBF", "CRSDR", "CRSHP", "CRSND", "OT"].each do |serlist| 
  #   ["HI"].each do |cnty|
  #     ["A","M", "Q"].each do |f|
  #       begin
  #         "VADC#{serlist}@#{cnty}.#{f}".ts_eval= %Q|"VDAY#{serlist}@#{cnty}.#{f}".ts / "VDAY#{serlist}@#{cnty}.#{f}".ts.days_in_period|
  #       rescue
  #         puts "ERROR: #{serlist}NS, #{cnty}, #{f}"
  #       end
  #     end
  #   end
  # end
  

  # series vdaycrair@hi.m = viscrair@hi.m * vloscrair@hi.m
  # for cnty = hon, haw, mau, kau
  # 
  #     series viscrair@CNTY = viscrair@hi
  #     series vloscrair@CNTY = vloscrair@hi/4
  #     series vdaycrair@CNTY = viscrair@CNTY * vloscrair@CNTY
  # 
  # end

  
  
  #passenger count stuff
  "PCNS@HI.M".ts_eval= %Q|"PCNS@HI.D".ts.aggregate(:month, :sum) / 1000|
  "PCDMNS@HI.M".ts_eval= %Q|"PCDMNS@HI.D".ts.aggregate(:month, :sum) / 1000|
  "PCITJPNS@HI.M".ts_eval= %Q|"PCITJPNS@HI.D".ts.aggregate(:month, :sum) / 1000|
  "PCITOTNS@HI.M".ts_eval= %Q|"PCITOTNS@HI.D".ts.aggregate(:month, :sum) / 1000|
    
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
  "OCUP%@HI.M".ts_eval= %Q|"OCUP%@HI.M".ts.apply_seasonal_adjustment :additive|

  "PRM@HI.M".ts_eval= %Q|"PRM@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "PRM@HI.M".ts_eval= %Q|"PRM@HI.M".ts.apply_seasonal_adjustment :multiplicative|

  "RMRV@HI.M".ts_eval= %Q|"RMRV@HI.M".tsn.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls", "sadata"|
  "RMRV@HI.M".ts_eval= %Q|"RMRV@HI.M".ts.apply_seasonal_adjustment :additive|
  
  
  ["HON", "KAU", "MAU", "HAW"].each do |cnty|
    "OCUP%@#{cnty}.M".ts_eval= %Q|"OCUP%@HI.M".ts.mc_ma_county_share_for("#{cnty}","OCUP%")|
    "RMRV@#{cnty}.M".ts_eval= %Q|"RMRV@HI.M".ts.mc_ma_county_share_for("#{cnty}","RMRV")|
    "PRM@#{cnty}.M".ts_eval= %Q|"PRM@HI.M".ts.mc_ma_county_share_for("#{cnty}","PRM")|
    "OCUP%@#{cnty}.Q".ts_eval= %Q|"OCUP%@#{cnty}.M".ts.aggregate(:quarter, :average)|
    "RMRV@#{cnty}.Q".ts_eval= %Q|"RMRV@#{cnty}.M".ts.aggregate(:quarter, :average)|
    "PRM@#{cnty}.Q".ts_eval= %Q|"PRM@#{cnty}.M".ts.aggregate(:quarter, :average)|
    "OCUP%@#{cnty}.A".ts_eval= %Q|"OCUP%@#{cnty}.M".ts.aggregate(:year, :average)|
    "RMRV@#{cnty}.A".ts_eval= %Q|"RMRV@#{cnty}.M".ts.aggregate(:year, :average)|
    "PRM@#{cnty}.A".ts_eval= %Q|"PRM@#{cnty}.M".ts.aggregate(:year, :average)|
  end


  #separate section for these...?
  ["HON", "HI", "KAU", "MAU", "HAW"].each do |cnty|
   "OCUP%NS@#{cnty}.Q".ts_eval= %Q|"OCUP%NS@#{cnty}.M".ts.aggregate(:quarter, :average)|
   "RMRVNS@#{cnty}.Q".ts_eval= %Q|"RMRVNS@#{cnty}.M".ts.aggregate(:quarter, :average)|
   "PRMNS@#{cnty}.Q".ts_eval= %Q|"PRMNS@#{cnty}.M".ts.aggregate(:quarter, :average)|
  end 
 
  "OCUP%@HI.Q".ts_eval= %Q|"OCUP%@HI.M".ts.aggregate(:quarter, :average)|
  "RMRV@HI.Q".ts_eval= %Q|"RMRV@HI.M".ts.aggregate(:quarter, :average)|
  "PRM@HI.Q".ts_eval= %Q|"PRM@HI.M".ts.aggregate(:quarter, :average)|
  
  "TRMS@HI.A".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/trms.xls", {:file_type => "xls", :start_date => "1964-01-01", :sheet => "trms", :row => "increment:2:1", :col => 2, :frequency => "A" })|
  "TRMS@HON.A".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/trms.xls", {:file_type => "xls", :start_date => "1964-01-01", :sheet => "trms", :row => "increment:2:1", :col => 3, :frequency => "A" })|
  "TRMS@HAW.A".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/trms.xls", {:file_type => "xls", :start_date => "1964-01-01", :sheet => "trms", :row => "increment:2:1", :col => 4, :frequency => "A" })|
  "TRMS@KAU.A".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/trms.xls", {:file_type => "xls", :start_date => "1964-01-01", :sheet => "trms", :row => "increment:2:1", :col => 5, :frequency => "A" })|
  "TRMS@MAU.A".ts_eval= %Q|Series.load_from_file("/Volumes/UHEROwork/data/rawdata/manual/trms.xls", {:file_type => "xls", :start_date => "1964-01-01", :sheet => "trms", :row => "increment:2:1", :col => 6, :frequency => "A" })|

  ["Q", "A"].each do |f|
    "PPRM_WITH_CR@HI.#{f}".ts_eval= %Q|("VADC@HI.#{f}".ts - "VADCCRAIR@HI.#{f}".ts * 5 / 7) / ("TRMS@HI.#{f}".ts * "OCUP%@HI.#{f}".ts / 100)|
    "PPRM_WITH_CR@HON.#{f}".ts_eval= %Q|("VADC@HON.#{f}".ts - "VADCCRAIR@HON.#{f}".ts * 5 / 7) / ("TRMS@HON.#{f}".ts * "OCUP%@HON.#{f}".ts / 100)|
    "PPRM_WITH_CR@HAW.#{f}".ts_eval= %Q|("VADC@HAW.#{f}".ts - "VADCCRAIR@HAW.#{f}".ts * 5 / 7) / ("TRMS@HAW.#{f}".ts * "OCUP%@HAW.#{f}".ts / 100)|
    "PPRM_WITH_CR@KAU.#{f}".ts_eval= %Q|("VADC@KAU.#{f}".ts - "VADCCRAIR@KAU.#{f}".ts * 5 / 7) / ("TRMS@KAU.#{f}".ts * "OCUP%@KAU.#{f}".ts / 100)|
    "PPRM_WITH_CR@MAU.#{f}".ts_eval= %Q|("VADC@MAU.#{f}".ts - "VADCCRAIR@MAU.#{f}".ts * 5 / 7) / ("TRMS@MAU.#{f}".ts * "OCUP%@MAU.#{f}".ts / 100)|
    
    ["HI","HON","HAW", "KAU", "MAU"].each do |cnty|
      "PPRM_WITHOUT_CR@#{cnty}.#{f}".ts_eval= %Q|("VADC@#{cnty}.Q".ts) / ("TRMS@#{cnty}.Q".ts * "OCUP%@#{cnty}.Q".ts / 100)|
      "PPRM@#{cnty}.#{f}".ts_eval= %Q|"PPRM_WITH_CR@#{cnty}.#{f}".ts|
      "PPRM@#{cnty}.#{f}".ts_eval= %Q|("PPRM_WITHOUT_CR@#{cnty}.#{f}".ts + ("PPRM_WITHOUT_CR@#{cnty}.#{f}".ts - "PPRM_WITH_CR@#{cnty}.#{f}".ts).average).trim("1990-01-01", "2000-12-01")|
    end
  end
  # qtemp = 
  # (qtemp + (qtemp - "PPRM@HI.#{f}".ts).average).print
  
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["visitor_identities", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end