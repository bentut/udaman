task :aremos_exports => :environment do
  #DataList.write "tour_rev_upd3", "/Volumes/UHEROwork/data/tour/update/tour_upd3_UDAMAN.xls"
  DataList.write "tour1", "/Volumes/UHEROwork/data/udaman/tour1_UDA.xls" #8.9s
  DataList.write "tour2", "/Volumes/UHEROwork/data/udaman/tour2_UDA.xls" #9.2s
  DataList.write "tour3", "/Volumes/UHEROwork/data/udaman/tour3_UDA.xls" #6.7s
  DataList.write "tour_ocup", "/Volumes/UHEROwork/data/udaman/ocup_UDA.xls" #6.7s
  
end