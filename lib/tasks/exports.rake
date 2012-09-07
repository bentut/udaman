task :aremos_exports => :environment do
  #TOUR
  DataList.write "tour1", "/Volumes/UHEROwork/data/udaman/tour1_UDA.xls" #8.9s
  DataList.write "tour2", "/Volumes/UHEROwork/data/udaman/tour2_UDA.xls" #9.2s
  DataList.write "tour3", "/Volumes/UHEROwork/data/udaman/tour3_UDA.xls" #6.7s
  DataList.write "tour_ocup", "/Volumes/UHEROwork/data/udaman/ocup_UDA.xls" 
  
  #BLS
  DataList.write "bls_job_m", "/Volumes/UHEROwork/data/udaman/bls_job_m_UDA.xls" #25.5
end

task :tsd_exports => :environment do
  path = "/Volumes/UHEROwork/data/BnkLists/"
  [ "bea_a", "bls_a", "census_a", "jp_a", "misc_a", "tax_a", "tour_a", "us_a", 
    "bea_s", "bls_s", 
    "bea_q", "bls_q", "census_q", "jp_q", "misc_q", "tax_q", "tour_q", "us_q",
    "bls_m", "jp_m", "misc_m", "tax_m", "tour_m", "us_m",
   "tour_w", "tour_d" ].each do |bank|
    #["us_a"].each 
    t = Time.now
    frequency_code = bank.split("_")[1].upcase
    filename = path + bank + ".txt"
    f = open filename
    list = f.read.split("\r\n")
    f.close
    list.map! {|name| "#{name}.#{frequency_code}"}
    Series.write_data_list_tsd list, "/Volumes/UHEROwork/data/udaman_tsd/#{bank}.tsd"
    puts "#{ "%.2f" % (Time.now - t) } | #{ list.count } | #{ bank }"
    
  end
end