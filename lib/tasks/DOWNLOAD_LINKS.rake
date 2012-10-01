task :update_bea_links => :environment do
  t = Time.now
  bea_table_links = {
    #{}"SA05N@bea.gov" => 'http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=2&7023=0&7024=NAICS&7025=0&7026=15000&7027=-1&7001=42&7029=28&7090=70&7033=-1'
    "SQ5N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=0&7023=0&7024=NAICS&7025=0&7026=00000&7027=-1&7001=30&7029=34&7090=70&7033=-1&form=7&7090=70&7024=NAICS&7026=15000&7028=-1&7083=Levels&7027=-1&7033=-1&7040=-1&step=30&7090=70&7024=NAICS&7026=15000&7028=-1&7083=Levels&7027=-1&7033=-1&7040=-1",
    "SA06N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=50&7023=0&7024=NAICS&7025=0&7026=15000&7027=-1&7001=450&7029=51&7090=70&7033=-1",
    "SA05N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=2&7023=0&7024=NAICS&7025=0&7026=15000&7027=-1&7001=42&7029=28&7090=70&7033=-1",
    "GSP@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=10&isuri=1&7093=Levels&7001=1200&7002=1&7003=200&7004=NAICS&7005=-1&7006=15000&7007=-1",
    "CA05N@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7083=Levels&7031=15000&7040=-1&7033=-1&7022=10&7023=7&7024=NAICS&7025=4&7026=XX&7001=710&7029=32&7090=70&7027=-1",
    "CA06N@bea.gov" => "http://www.bea.gov/iTable/iTable.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=15000&7022=54&7023=7&7024=NAICS&7025=4&7026=XX&7027=-1&7001=754&7029=55&7090=70&7033=-1",
    "SA04@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7083=Levels&7031=0&7022=48&7023=0&7024=Non-Industry&7025=0&7026=15000&7027=-1&7001=448&7029=48&7090=70&7033=-1",
    "CA04@bea.gov" => "http://www.bea.gov/iTable/iTableHtml.cfm?reqid=70&step=30&isuri=1&7028=-1&7040=-1&7090=70&7031=15000&7083=Levels&7022=49&7023=7&7024=Non-Industry&7025=4&7026=15001,15003,15007,15901&7027=-1&7001=749&7029=49&7003=749&7033=-1",
    }
  require 'watir-webdriver'
  b = Watir::Browser.new
  new_links = {}
  bea_table_links.each do |handle, url| 
    begin
      b.goto url
      sleep(10)
      b.link(:id => "showDownload").click
      sleep(1)
      new_url = b.link(:text => "Download CSV File").href
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
    
    if has_seats_text and is_excel and is_not_already_in_downloads
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