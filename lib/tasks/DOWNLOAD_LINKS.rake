#BEA Links not yet in below because they are still working in the old style
# Table name - Table Number
# 82 - 2.8.5
# 75 - 2.5.6
# 253Y - 6.20B
# 253Q - 6.20B
task :update_bea_links => :environment do
  t = Time.now
  bea_table_links = {
    "CA_YP@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7083=Levels&7031=0&7040=-1&7001=336&7022=36&7023=0&7024=Non-Industry&7025=0&7026=06000&7028=10&7029=36&7090=70&7033=-1&7027=-1",
    "SQ5N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=0&7023=0&7024=NAICS&7025=0&7026=00000&7027=-1&7001=30&7029=34&7090=70&7033=-1&form=7&7090=70&7024=NAICS&7026=15000&7028=-1&7083=Levels&7027=-1&7033=-1&7040=-1&step=30&7090=70&7024=NAICS&7026=15000&7028=-1&7083=Levels&7027=-1&7033=-1&7040=-1",
    "SA06N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=50&7023=0&7024=NAICS&7025=0&7026=15000&7027=-1&7001=450&7029=51&7090=70&7033=-1",
    "SA05N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=2&7023=0&7024=NAICS&7025=0&7026=15000&7027=-1&7001=42&7029=28&7090=70&7033=-1",
    "GSP@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=10&isuri=1&7093=Levels&7001=1200&7002=1&7003=200&7004=NAICS&7005=-1&7006=15000&7007=-1",
    "CA05N@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7083=Levels&7031=15000&7040=-1&7033=-1&7022=10&7023=7&7024=NAICS&7025=4&7026=XX&7001=710&7029=32&7090=70&7027=-1",
    "CA06N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=15000&7022=54&7023=7&7024=NAICS&7025=4&7026=XX&7027=-1&7001=754&7029=55&7090=70&7033=-1",
    "SA04@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=48&7023=0&7024=Non-Industry&7025=0&7026=15000&7027=-1&7001=448&7029=48&7090=70&7033=-1",
    "CA04@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7090=70&7031=15000&7083=Levels&7022=49&7023=7&7024=Non-Industry&7025=4&7026=15001,15003,15007,15901&7027=-1&7001=749&7029=49&7003=749&7033=-1",
    "83M@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&911=1&903=83&904=1995&905=2012",
    "76M@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&911=1&903=76&904=1929&905=2012",
    "6A@bea.gov" =>  "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=6&904=1929&905=2012&906=A",
    "6Q@bea.gov" =>  "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=6&904=1929&905=2012&906=Q",
    "66A@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=66&904=1995&905=2012&906=A",
    "66Q@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=66&904=1995&905=2012&906=Q",
    "58A@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=58&904=1929&905=2012&906=A",
    "58Q@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=58&904=1929&905=2012&906=Q",
    "44Q@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=44&904=1929&905=2012&906=Q",
    "44A@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=44&904=1929&905=2012&906=A",
    "43Q@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=43&904=1929&905=2012&906=Q",
    "43A@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=43&904=1929&905=2012&906=A",
    "264A@bea.gov" =>"http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=264&904=1929&905=2012&906=A",        
    "264Q@bea.gov" =>"http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&910=X&911=0&903=264&904=1929&905=2012&906=Q" ,    
    "5Q@bea.gov" =>  "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=5&904=1929&905=2012&906=Q",
    "5A@bea.gov" =>  "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=5&904=1929&905=2012&906=A",
    "13Q@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=13&904=1929&905=2012&906=Q",
    "13A@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=9&step=3&isuri=1&903=13&904=1929&905=2012&906=A",
    "SQ4@bea.gov" => "http://bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7022=56&7023=0&7033=-1&7024=non-industry&7025=0&7026=15000&7027=-1&7001=356&7028=-1&7031=0&7040=-1&7083=levels&7029=56&7090=70",
    "SA1_CA@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=21&7023=0&7033=-1&7024=non-industry&7025=0&7026=06000&7027=-1&7001=421&7028=-1&7031=0&7040=-1&7083=levels&7029=21&7090=70",
    "SA05N_HI@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=2&7023=0&7033=-1&7024=naics&7025=0&7026=15000&7027=-1&7001=42&7028=-1&7031=0&7040=-1&7083=levels&7029=28&7090=70",
    "CA05N_HAW@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=10&7023=7&7033=-1&7024=naics&7025=4&7026=15001&7027=-1&7001=710&7028=-1&7031=15000&7040=-1&7083=levels&7029=32&7090=70",                      
    "CA05N_HON@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=10&7023=7&7033=-1&7024=naics&7025=4&7026=15003&7027=-1&7001=710&7028=-1&7031=15000&7040=-1&7083=levels&7029=32&7090=70",
     "CA05N_KAU@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=10&7023=7&7033=-1&7024=naics&7025=4&7026=15007&7027=-1&7001=710&7028=-1&7031=15000&7040=-1&7083=levels&7029=32&7090=70",
     "CA05N_MAU@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=10&7023=7&7033=-1&7024=naics&7025=4&7026=15901&7027=-1&7001=710&7028=-1&7031=15000&7040=-1&7083=levels&7029=32&7090=70",
     "SA06N_HI@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=50&7023=0&7033=-1&7024=naics&7025=0&7026=15000&7027=-1&7001=450&7028=-1&7031=0&7040=-1&7083=levels&7029=51&7090=70",
     "SQ35_HI@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=79&7023=0&7033=-1&7024=non-industry&7025=0&7026=15000&7027=-1&7001=379&7028=-1&7031=0&7040=-1&7083=levels&7029=79&7090=70",
     "CA04_HAW@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=49&7023=7&7033=-1&7024=non-industry&7025=4&7026=15001&7027=-1&7001=749&7028=-1&7031=15000&7040=-1&7083=levels&7029=49&7090=70",
     "CA04_HON@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=49&7023=7&7033=-1&7024=non-industry&7025=4&7026=15003&7027=-1&7001=749&7028=-1&7031=15000&7040=-1&7083=levels&7029=49&7090=70",
     "CA04_KAU@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=49&7023=7&7033=-1&7024=non-industry&7025=4&7026=15007&7027=-1&7001=749&7028=-1&7031=15000&7040=-1&7083=levels&7029=49&7090=70",
     "SA06S_HI@bea.gov" => "http://bea.gov/iTable/iTable.cfm?reqid=70&step=1&isuri=1&acrdn=4#reqid=70&step=30&isuri=1&7022=50&7023=0&7033=-1&7024=sic&7025=0&7026=15000&7027=-1&7001=450&7028=-1&7031=0&7040=-1&7083=levels&7029=50&7090=70"
   }
     


  require 'watir-webdriver'
  b = Watir::Browser.new
  new_links = {}
  bea_table_links.each do |handle, url| 
    begin
      b.goto url
      sleep(10)
      b.link(:id => "showDownload").click
      sleep(2)
      new_url = b.link(:text => "CSV Download your table in CSV format.").href
      dsd = DataSourceDownload.get(handle)
      puts new_url
      puts dsd.url
      unless dsd.url == new_url
        puts "NEW!" 
        dsd.update_attributes(:url => new_url)
        PackagerMailer.download_link_notification(handle, new_url, dsd.save_path, true).deliver
      end
    rescue
      next
    end
  end
   #"http://www.bea.gov/iTable/download.cfm?ext=csv&fid=0E386BB9F144E39E27116629223749DCC50FB6ED6A5971812E268A5BE984E29D81649D287CDF61113A6FA4754050E98C629157B57B353AAC6DB94578D6DADA6C" 
   b.close
   CSV.open("public/rake_time.csv", "a") {|csv| csv << ["update_bea_links", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :update_seats_links => :environment do  
  t = Time.now
  seats_links = DataSourceDownload.where("handle LIKE 'SEATS%'").map { |dsd| dsd.url.gsub("http://www.hawaiitourismauthority.org","") }

  require 'mechanize'
  agent = Mechanize.new

  hta_seats = agent.get "http://www.hawaiitourismauthority.org/research/research/infrastructure-research/"  
  hta_seats.search("#content").css("a").each do |link|
    puts "inspecting "+link.text
    href = link.attributes["href"].to_s
    
    has_seats_text = !link.text.index("Seat Outlook for").nil?
    is_excel = !["xls", "xlsx"].index(href.split(".")[-1]).nil?
    is_not_already_in_downloads = seats_links.index(href.gsub("%20"," ")).nil?
    is_not_in_exclusion_list = ["/default/assets/File/research/airline-capacity/Seat%20Outlook%202013.xls"].index(href).nil?
    
    if has_seats_text and is_excel and is_not_already_in_downloads and is_not_in_exclusion_list
      begin
        puts "creating Data Source Download for "+href
        file_name = href.split("/")[-1].gsub("%20"," ")
        month = file_name[0..2]
        year = ([2011,2012,2013,2014,2015,2016,2017,2018].keep_if {|year| !file_name.index(year.to_s).nil? })[0]
        url = "http://www.hawaiitourismauthority.org" + href.gsub("%20"," ")
        save_path = "/Volumes/UHEROwork/data/rawdata/TOUR_SEATS_" + month.upcase + year.to_s[2..4] + "." + href.split(".")[-1]
        handle = "SEATS_#{month.upcase}#{year.to_s[2..4]}@hawaiitourismauthority.org"
        dsd = DataSourceDownload.new(:handle => handle, :url => url, :save_path => save_path)
        if dsd.download[:status] == 200
          dsd.save
          PackagerMailer.download_link_notification(handle, url, save_path, true).deliver
        else
          puts dsd
          PackagerMailer.download_link_notification(handle, url, save_path, false).deliver
        end
      rescue
        puts "There was an error"
        PackagerMailer.download_link_notification(handle, url, save_path, false).deliver
      end
    end
  end
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["update_seat_links", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end


task :update_vis_history_links => :environment do
  t = Time.now
  handle_fragment = "TOUR_HIST"
  search_page = "http://www.hawaiitourismauthority.org/research/reports/historical-visitor-statistics/"
  link_search_string = "Monthly Final"
    
  seats_links = DataSourceDownload.where("handle LIKE '#{handle_fragment}%'").map { |dsd| dsd.url.gsub("http://www.hawaiitourismauthority.org","") }
  
  require 'mechanize'
  agent = Mechanize.new

  hta_seats = agent.get search_page

  hta_seats.search("#content").css("a").each do |link|
    puts "inspecting "+link.text
    href = link.attributes["href"].to_s
    
    has_seats_text = !link.text.index(link_search_string).nil?
    is_excel = !["xls", "xlsx"].index(href.split(".")[-1]).nil?
    is_not_already_in_downloads = seats_links.index(href.gsub("%20"," ")).nil?
    
    if has_seats_text and is_excel and is_not_already_in_downloads
      begin
        puts "creating Data Source Download for "+href
        file_name = href.split("/")[-1].gsub("%20"," ")
        #month = file_name[0..2]
        year = ([2011,2012,2013,2014,2015,2016,2017,2018].keep_if {|year| !file_name.index(year.to_s).nil? })[0]
        url = "http://www.hawaiitourismauthority.org" + href.gsub("%20"," ")
        save_path = "/Volumes/UHEROwork/data/rawdata/TOUR_HIST" + year.to_s[2..4] + "." + href.split(".")[-1]
        handle = "TOUR_HIST#{year.to_s[2..4]}@hawaiitourismauthority.org"
        dsd = DataSourceDownload.new(:handle => handle, :url => url, :save_path => save_path)
        if dsd.download[:status] == 200
          dsd.save
          PackagerMailer.download_link_notification(handle, url, save_path, true).deliver
        else
          puts dsd
          PackagerMailer.download_link_notification(handle, url, save_path, false).deliver
        end
      rescue
        puts "There was an error"
        PackagerMailer.download_link_notification(handle, url, save_path, false).deliver
      end
    end
  end
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["update_vis_history_links", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end