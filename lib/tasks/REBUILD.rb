"VISJPNS@HI.M".ts_eval= %Q|"VISJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISJPNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"Japan", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|
"VISJPNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:4:10:12", :frequency => "M" })/1000|
"VISJPNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Japan", :row=>"header:col:1:TOTAL VISITORS", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISJPNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Days by MMA", :row=>"header_range:col:1:Japan:11:20", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISJPNS@HI.M".ts_eval= %Q|"VISJPNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/Manual/visfix.xls"|
"VISJP@HI.M".ts_eval= %Q|"VISJP@HI.M".ts.apply_seasonal_adjustment :multiplicative|
"VISJP@HI.M".ts_eval= %Q|"VISJP@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
"VISJPNS@HON.M".ts_eval= %Q|"VISJPNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISJPNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"Japan", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|
"VISJPNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Japan", :row=>"header:col:1:Oahu:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISJP@HON.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("HON")|
"VISJP@HON.M".ts_eval= %Q|"VISJP@HI.M".ts.mc_ma_county_share_for("HON","VISJP")|
"VISUSWNS@HI.M".ts_eval= %Q|"VISUSWNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISUSWNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|
"VISUSWNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:2:10:12", :frequency => "M" })/1000|
"VISUSWNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"US West", :row=>"header:col:1:TOTAL VISITORS", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSWNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Days by MMA", :row=>"header_range:col:1:US West:11:20", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSENS@HI.M".ts_eval= %Q|"VISUSENS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISUSENS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:TOTAL VISITORS:1:100", :col=>2, :frequency=>"M" })/1000|
"VISUSENS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:3:10:12", :frequency => "M" })/1000|
"VISUSENS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"US East", :row=>"header:col:1:TOTAL VISITORS", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSENS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Days by MMA", :row=>"header_range:col:1:US East:11:20", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSNS@HI.M".ts_eval= %Q|"VISUSNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd3_hist.xls"|
"VISUSNS@HI.M".ts_eval= %Q|"VISUSWNS@HI.M".ts + "VISUSENS@HI.M".ts|
"VISUS@HI.M".ts_eval= %Q|"VISUS@HI.M".ts.apply_seasonal_adjustment :additive|
"VISUS@HI.M".ts_eval= %Q|"VISUS@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
"VISUSWNS@HON.M".ts_eval= %Q|"VISUSWNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISUSWNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:3", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|
"VISUSWNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"US West", :row=>"header:col:1:Oahu:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSENS@HON.M".ts_eval= %Q|"VISUSENS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISUSENS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-01-01", :sheet=>"sheet_num:4", :row=>"header_range:col:1:Oahu:10:45:no_okina", :col=>2, :frequency=>"M" })/1000|
"VISUSENS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"US East", :row=>"header:col:1:Oahu:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISUSNS@HON.M".ts_eval= %Q|"VISUSNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd3_hist.xls"|
"VISUSNS@HON.M".ts_eval= %Q|"VISUSWNS@HON.M".ts + "VISUSENS@HON.M".ts|
"VISUS@HON.M".ts_eval= %Q|"VISUS@HI.M".ts.mc_ma_county_share_for("HON")|
"VISNS@HI.M".ts_eval= %Q|"VISNS@HI.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"HL", :row=>"header_range:col:1:TOTAL VISITORS:1:59", :col=>2, :frequency=>"M" })/1000|
"VISNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1989-01-01", :sheet => "5", :row => "repeat:5:16", :col => "block:11:10:12", :frequency => "M" })/1000|
"VISNS@HI.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"sheet_num:1", :row=>"header_range:col:1:TOTAL VISITORS:1:94", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISRESNS@HI.M".ts_eval= %Q|"VISNS@HI.M".ts - "VISUSNS@HI.M".ts - "VISJPNS@HI.M".ts|
"VISRES@HI.M".ts_eval= %Q|"VISRES@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
"VISRES@HI.M".ts_eval= %Q|"VISRES@HI.M".ts.apply_seasonal_adjustment :additive|
"VISNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Oahu:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|
"VISNS@HON.M".ts_eval= %Q|"VISNS@HON.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:18:29", :col => "block:2:3:12", :frequency => "M" })/1000|
"VISNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"sheet_num:1", :row=>"header_range:col:1:Oahu:1:94:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISNS@HON.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Days by Island", :row=>"header_range:col:1:Oahu:13:23:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISRESNS@HON.M".ts_eval= %Q|"VISNS@HON.M".ts - "VISUSNS@HON.M".ts - "VISJPNS@HON.M".ts|
"VISRES@HON.M".ts_eval= %Q|"VISRES@HI.M".ts.mc_ma_county_share_for("HON")|
"VISNS@HAW.M".ts_eval= %Q|Series.load_from_download(  "TOUR_%b%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2011-02-01", :sheet=>"sheet_num:8", :row=>"header_range:col:1:Big Island[or]hawaii island:24:32:no_okina", :col=>2, :frequency=>"M" })/1000|
"VISNS@HAW.M".ts_eval= %Q|"VISNS@HAW.M".tsn.load_from "/Volumes/UHEROwork/data/rawdata/History/tour_upd1_hist.xls"|
"VISNS@HAW.M".ts_eval= %Q|Series.load_from_download(  "TOUR_FINAL@hawaiitourismauthority.org", { :file_type => "xls", :start_date => "1990-01-01", :sheet => "6", :row => "repeat:96:107", :col => "block:2:3:12", :frequency => "M" })/1000|
"VISNS@HAW.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", {:file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"sheet_num:1", :row=>"header_range:col:1:Big Island[or]Hawaii Island:1:94", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISNS@HAW.M".ts_eval= %Q|Series.load_from_download(  "TOUR_HIST%y@hawaiitourismauthority.org", { :file_type=>"xls", :start_date=>"2010-01-01", :sheet=>"Days by Island", :row=>"header_range:col:1:Hawaii Island:13:23:no_okina", :col=>"repeat:2:13", :frequency=>"M" })/1000|
"VISDEMETRA_MC@HI.M".ts_eval= %Q|"VIS@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
"VISDEMETRA_MC@HI.M".ts_eval= %Q| "VIS@HI.M".ts.apply_seasonal_adjustment :additive|
"VIS@HON.M".ts_eval= %Q| "VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HON","VIS").trim("1990-01-01","1999-12-01")|
"VIS@HON.M".ts_eval= %Q| "VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HON","VIS").trim|
"VIS@HON.M".ts_eval= %Q|"VISJP@HON.M".ts + "VISUS@HON.M".ts + "VISRES@HON.M".ts|
"VIS@HON.A".ts_eval= %Q|"VIS@HON.M".ts.aggregate(:year, :sum)|
