task :aremos_exports => :environment do
  t = Time.now
  #TOUR
  DataList.write "tour1", "/Volumes/UHEROwork/data/udaman/tour1_UDA.xls" #8.9s
  DataList.write "tour2", "/Volumes/UHEROwork/data/udaman/tour2_UDA.xls" #9.2s
  DataList.write "tour3", "/Volumes/UHEROwork/data/udaman/tour3_UDA.xls" #6.7s
  DataList.write "tour_vrls", "/Volumes/UHEROwork/data/udaman/tour_vrls_UDA.xls" #6.7s
  DataList.write "tour_ocup", "/Volumes/UHEROwork/data/udaman/ocup_UDA.xls" 
  DataList.write "tour_vso", "/Volumes/UHEROwork/data/udaman/vso_UDA.xls" 
  
  #BLS
  DataList.write "bls_job_m", "/Volumes/UHEROwork/data/udaman/bls_job_m_UDA.xls" #25.5
  
  #pseudo spline
  DataList.write "famsize_q", "/Volumes/UHEROwork/data/udaman/famsize_q.xls" #3.15
  DataList.write "famsize_a", "/Volumes/UHEROwork/data/udaman/famsize_a.xls" #0.63

  #MISC
  DataList.write "const", "/Volumes/UHEROwork/data/udaman/const.xls" #2.23

  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["aremos_exports", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :tsd_exports => :environment do
  t = Time.now
  path = "/Volumes/UHEROwork/data/BnkLists/"
  [ "bea_a", "bls_a", "census_a", "jp_a", "misc_a", "tax_a", "tour_a", "us_a", 
    "bea_s", "bls_s", 
    "bea_q", "bls_q", "census_q", "jp_q", "misc_q", "tax_q", "tour_q", "us_q",
    "bls_m", "jp_m", "misc_m", "tax_m", "tour_m", "us_m",
    "misc_w", "tour_w", "tour_d" ].each do |bank|
  # ["misc_w"].each do |bank|
    # ["bls_m"].each do |bank|
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
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["tsd_exports", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end
