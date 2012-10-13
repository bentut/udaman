#JAPAN SERIES DOWNLOADS

###*******************************************************************
###NOTES BOX

#ben's new updates
#jp_upd_q has a problem (file gone?)
#jp_upd_m has a problem (file changed?)

#jp_upd_a works
#jp_upd_q works
#jp_upd_m has a variety of problems, problem series have been commented out
#jp_cpi has link that changes monthly, recently, they have stopped reporting seasonally adjusted numbers

###*******************************************************************

# sox.add "R@JP.M",         Series.load_pattern("1960-01-01", "M", path_JP_R, "csv", "increment:4:1", 3)
# sox.add "IP@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IP_hist, "csv", "increment:6:1", 2)
# sox.add "IPNS@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IPNS_hist, "csv", "increment:6:1", 2)
# sox.add "IPMN@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IP_hist, "csv", "increment:6:1", 3)
# sox.add "IPMNNS@JP.M",         Series.load_pattern("1978-01-01", "M", path_JP_IPNS_hist, "csv", "increment:6:1", 3)
# sox.add "CSCFNS@JP.M",         Series.load_pattern("2004-03-01", "M", path_JP_CSCFNS, "original series", "increment:94:1", 2)


task :jp_upd_a => :environment do
  t = Time.now
	jp_a = {
    # "GDP@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "A" }|, 
    # "GDP_CP@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "A" }|, 
    # "GDP_IRSP@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "A" }|, 
    # "GDP_INRP@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "A" }|, 
    # "GDP_IIVP@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "A" }|, 
    # "GDP_CG@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "A" }|, 
    # "GDP_IFXG@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "A" }|, 
    # "GDP_IIVG@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "A" }|, 
    # "GDP_NX@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "A" }|, 
    # "GDP_EX@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "A" }|, 
    # "GDP_IM@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "A" }|, 
    # "GNI@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 19, :frequency => "A" }|, 
    # "GDP_IFX@JP.A" => %Q|Series.load_from_download  "GDP_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 25, :frequency => "A" }|, 
    # "GDP_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "A" }|, 
    # "GDP_CP_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "A" }|, 
    # "GDP_IRSP_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "A" }|, 
    # "GDP_INRP_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "A" }|, 
    # "GDP_IIVP_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "A" }|, 
    # "GDP_CG_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "A" }|, 
    # "GDP_IFXG_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "A" }|, 
    # "GDP_IIVG_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "A" }|, 
    # "GDP_NX_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "A" }|, 
    # "GDP_EX_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "A" }|, 
    # "GDP_IM_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "A" }|, 
    # "GNI_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 22, :frequency => "A" }|, 
    # "GDP_IFX_R@JP.A" => %Q|Series.load_from_download  "GDP_R_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 28, :frequency => "A" }|, 
    # "GDPDEF@JP.A" => %Q|Series.load_from_download  "GDPDEF_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "A" }|, 
    # "GNIDEF@JP.A" => %Q|Series.load_from_download  "GDPDEF_A@esri.cao.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 19, :frequency => "A" }|,
    # 
    # #series that Ben added in
    "N@JP.A" => %Q|Series.load_from_download "JP_POP@esa.un.org", {:file_type => "xls", :start_date => "1950-01-01", :sheet => "sheet_num:1", :row => "header:col:3:Japan", :col => "increment:6:1", :frequency => "A" }|,
		#JPNPOPL
		
		
		"GDP@JP.A" => %Q|Series.load_from_fred("JPNGDPNADSMEI", "A") * 1000 |	,	
    "GDP_CP@JP.A" => %Q|Series.load_from_fred("JPNPFCEADSMEI", "A") * 1000 |,
		"GDP_CG@JP.A" => %Q|Series.load_from_fred("JPNGFCEADSMEI", "A") * 1000 |,
		"GDP_EX@JP.A" => %Q|Series.load_from_fred("JPNEXPORTADSMEI", "A") * 1000 |,
		"GDP_IM@JP.A" => %Q|Series.load_from_fred("JPNIMPORTADSMEI", "A") * 1000 |,
		"GDP_IFX@JP.A" => %Q|Series.load_from_fred("JPNGFCFADSMEI", "A") * 1000 |,
		"GDPDEF@JP.A" => %Q|Series.load_from_fred("JPNGDPDEFAISMEI", "A") |, 
		"GDP_R@JP.A" => %Q|Series.load_from_fred("JPNRGDPR", "A") |, 

    #"N@JP.A" => %Q|Series.load_from_fred("JPNPOPL", "A") * 1000|	,	
	}
	
	p = Packager.new
	p.add_definitions jp_a
	p.write_definitions_to "/Volumes/UHEROwork/data/japan/update/jp_upd_a_NEW.xls"

  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["jp_upd_a", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end




task :jp_upd_q => :environment do
  t = Time.now
  
	jp_q = {
    # "GDP@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "Q" }|, 
    # "GDP_CP@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "Q" }|, 
    # "GDP_IRSP@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "Q" }|, 
    # "GDP_INRP@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "Q" }|, 
    # "GDP_IIVP@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "Q" }|, 
    # "GDP_CG@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "Q" }|, 
    # "GDP_IFXG@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "Q" }|, 
    # "GDP_IIVG@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "Q" }|, 
    # "GDP_NX@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "Q" }|, 
    # "GDP_EX@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "Q" }|, 
    # "GDP_IM@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "Q" }|, 
    # "GNI@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 19, :frequency => "Q" }|, 
    # "GDP_IFX@JP.Q" => %Q|Series.load_from_download  "GDP_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 25, :frequency => "Q" }|, 
    # "GDPNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "Q" }|, 
    # "GDP_CPNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "Q" }|, 
    # "GDP_IRSPNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "Q" }|, 
    # "GDP_INRPNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "Q" }|, 
    # "GDP_IIVPNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "Q" }|, 
    # "GDP_CGNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "Q" }|, 
    # "GDP_IFXGNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "Q" }|, 
    # "GDP_IIVGNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "Q" }|, 
    # "GDP_NXNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "Q" }|, 
    # "GDP_EXNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "Q" }|, 
    # "GDP_IMNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "Q" }|, 
    # "GNINS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 19, :frequency => "Q" }|, 
    # "GDP_IFXNS@JP.Q" => %Q|Series.load_from_download  "GDPNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 25, :frequency => "Q" }|, 
    # "GDP_IRSP_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "Q" }|, 
    # "GDP_INRP_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "Q" }|, 
    # "GDP_IIVP_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "Q" }|, 
    # "GDP_IFXG_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "Q" }|, 
    # "GDP_IIVG_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "Q" }|, 
    # "GDP_NX_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "Q" }|, 
    # "GNI_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 22, :frequency => "Q" }|, 		
    # "GDP_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "Q" }|, 
    # "GDP_CP_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "Q" }|, 
    # "GDP_IRSP_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 6, :frequency => "Q" }|, 
    # "GDP_INRP_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 7, :frequency => "Q" }|, 
    # "GDP_IIVP_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 8, :frequency => "Q" }|, 
    # "GDP_CG_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "Q" }|, 
    # "GDP_IFXG_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 10, :frequency => "Q" }|, 
    # "GDP_IIVG_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 11, :frequency => "Q" }|, 
    # "GDP_NX_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 12, :frequency => "Q" }|, 
    # "GDP_EX_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "Q" }|, 
    # "GDP_IM_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "Q" }|, 
    # "GNI_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 22, :frequency => "Q" }|, 
    # "GDP_IFX_RNS@JP.Q" => %Q|Series.load_from_download  "GDP_RNS_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 28, :frequency => "Q" }|, 
    # "GDPDEF@JP.Q" => %Q|Series.load_from_download  "GDPDEF_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "Q" }|, 

    # "GDP_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 2, :frequency => "Q" }|, 
    # "GDP_CP_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 3, :frequency => "Q" }|, 
    # "GDP_CG_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 9, :frequency => "Q" }|, 
    # "GDP_EX_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 13, :frequency => "Q" }|, 
    # "GDP_IM_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 14, :frequency => "Q" }|, 
    # "GDP_IFX_R@JP.Q" => %Q|Series.load_from_download  "GDP_R_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 28, :frequency => "Q" }|, 

    "GDP_R@JP.Q" => %Q|Series.load_from_fred("JPNRGDPQDSNAQ", "Q")|	,	
    "GDP_CP_R@JP.Q" => %Q|Series.load_from_fred("JPNPFCEQDSNAQ", "Q")|,
		"GDP_CG_R@JP.Q" => %Q|Series.load_from_fred("JPNGFCEQDSNAQ", "Q")|,
		"GDP_EX_R@JP.Q" => %Q|Series.load_from_fred("JPNEXPORTQDSNAQ", "Q")|,
		"GDP_IM_R@JP.Q" => %Q|Series.load_from_fred("JPNIMPORTQDSNAQ", "Q")|,
		"GDP_IFX_R@JP.Q" => %Q|Series.load_from_fred("JPNGFCFQDSNAQ", "Q")|,


    
    #this should probably move to an identities task
		"INFGDPDEF@JP.Q" => %Q|"GDPDEF@JP.Q".ts.annualized_percentage_change.trim("1994-01-01")|,
		
		#"GNIDEF@JP.Q" => %Q|Series.load_from_download  "GDPDEF_Q@esri.cao.go.jp", { :file_type => "csv", :start_date => "1994-01-01", :row => "increment:8:1", :col => 19, :frequency => "Q" }|, 

"CSCFNS@JP.Q" => [%Q|Series.load_from_download "CSCFNS@esri.cao.go.jp", { :file_type => "xls", :start_date => "1982-04-01", :end_date=>"2004-01-01", :sheet => "sheet_num:1", :row => "increment:7:1", :col => 2, :frequency => "Q" }|,
			%Q|Series.load_from_download "CSCFNS@esri.cao.go.jp", { :file_type => "xls", :start_date => "2004-04-01", :sheet => "sheet_num:1", :row => "increment:97:3", :col => 2, :frequency => "Q" }|],
"CSCF@JP.Q" => [%Q|Series.load_from_download "CSCF@esri.cao.go.jp", { :file_type => "xls", :start_date => "1982-04-01", :end_date=>"2004-01-01", :sheet => "sheet_num:1", :row => "increment:7:1", :col => 2, :frequency => "Q" }|,
			%Q|Series.load_from_download "CSCF@esri.cao.go.jp", { :file_type => "xls", :start_date => "2004-04-01", :sheet => "sheet_num:1", :row => "increment:97:3", :col => 2, :frequency => "Q" }| ]
#we do not record CSCF for monthly even though we can

}

p = Packager.new
p.add_definitions jp_q
p.write_definitions_to "/Volumes/UHEROwork/data/japan/update/jp_upd_q_NEW.xls"

CSV.open("public/rake_time.csv", "a") {|csv| csv << ["jp_upd_q", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :jp_upd_m => :environment do
  t = Time.now
	jp_m = {
		"CSCFNS@JP.M" => %Q|Series.load_from_download "CSCFNS@esri.cao.go.jp", { :file_type => "xls", :start_date => "2004-04-01", :sheet => "sheet_num:1", :row => "increment:95:1", :col => 2, :frequency => "M" }|,
		"LF@JP.M" => %Q|Series.load_from_download("LF@stat.go.jp", { :file_type => "xls", :start_row => 10, :start_col => 3, :sheet => "Table 18", :row => "increment:10:1", :col => 4, :frequency => "M" }) * 10|, 
		"EMPL@JP.M" => %Q|Series.load_from_download("LF@stat.go.jp", { :file_type => "xls", :start_row => 10, :start_col => 3, :sheet => "Table 18", :row => "increment:10:1", :col => 7, :frequency => "M" }) * 10|, 
		"E_NF@JP.M" => %Q|Series.load_from_download("LF@stat.go.jp", { :file_type => "xls", :start_row => 10, :start_col => 3, :sheet => "Table 18", :row => "increment:10:1", :col => 14, :frequency => "M" }) * 10|, 
		"UR@JP.M" => %Q|Series.load_from_download("LF@stat.go.jp", { :file_type => "xls", :start_row => 10, :start_col => 3, :sheet => "Table 18", :row => "increment:10:1", :col => 31, :frequency => "M" })|, 
		"CPINS@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "1970-01-01", :row => "increment:19:1", :col => 2, :frequency => "M" }|, 
		"CPI@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "2000-01-01", :row => "increment:379:1", :col => 46, :frequency => "M" }|, 
		"CPICORE@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "2000-01-01", :row => "increment:379:1", :col => 47, :frequency => "M" }|, 
		"INF@JP.M" => %Q|"CPI@JP.M".ts.annualized_percentage_change|,
		"IP@JP.M" => %Q|Series.load_from_download  "IP@meti.go.jp", { :file_type => "csv", :start_date => "2003-01-01", :row => "4", :col => "increment:4:1", :frequency => "M" }|, 
		"IPNS@JP.M" => %Q|Series.load_from_download  "IPNS@meti.go.jp", { :file_type => "csv", :start_date => "2003-01-01", :row => "4", :col => "increment:4:1", :frequency => "M" }|, 
		"IPMN@JP.M" => %Q|Series.load_from_download  "IP@meti.go.jp", { :file_type => "csv", :start_date => "2003-01-01", :row => "5", :col => "increment:4:1", :frequency => "M" }|, 
		"IPMNNS@JP.M" => %Q|Series.load_from_download  "IPNS@meti.go.jp", { :file_type => "csv", :start_date => "2003-01-01", :row => "5", :col => "increment:4:1", :frequency => "M" }|,
		"STKNS@JP.M" => %Q|Series.load_from_download  "JP_STKNS@yahoo.com", { :file_type => "csv", :start_row => 3, :start_col => 1, :rev => true , :row => "increment:3:1", :col => "7", :frequency => "M" }|,
	
	  "YXR@JP.M" => %Q|Series.load_from_fred("EXJPUS", "M")|,

    "R@JP.M" => %Q|Series.load_from_download  "R@www.stat-search.boj.or.jp", { :file_type => "csv", :start_row => 4, :start_col => 1, :rev => false , :row => "increment:4:1", :col => "2", :frequency => "M" }|,
	  #CPICORENS
	  #INFCORE
	  #R
	  #YXR
	}
	
	jp_m_special = {
  
	"CPINS@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "1970-01-01", :row => "increment:19:1", :col => 2, :frequency => "M" }|, 
	"CPI@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "2000-01-01", :row => "increment:379:1", :col => 46, :frequency => "M" }|, 
	"CPICORE@JP.M" => %Q|Series.load_from_download  "CPI@e-stat.go.jp", { :file_type => "csv", :start_date => "2000-01-01", :row => "increment:379:1", :col => 47, :frequency => "M" }|, 
	"STKNS@JP.M" => %Q|Series.load_from_download  "JP_STKNS@yahoo.com", { :file_type => "csv", :start_row => 3, :start_col => 1, :rev => true , :row => "increment:3:1", :col => "7", :frequency => "M" }|
		#STKNS starts on row 3 rather than row 2 to capture only fully-completed months
	
	}
	
	"INFCORE@JP.M".ts_eval= %Q|"CPICORE@JP.M".ts.annualized_percentage_change|
	
	p = Packager.new
	p.add_definitions jp_m
	p.write_definitions_to "/Volumes/UHEROwork/data/japan/update/jp_upd_m_NEW.xls"

	p = Packager.new
	p.add_definitions jp_m_special
	p.write_definitions_to "/Volumes/UHEROwork/data/japan/update/jp_upd_m2_NEW.xls"

  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["jp_upd_m", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end
