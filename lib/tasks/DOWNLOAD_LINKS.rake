task :update_seats_links => :environment do  
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
  
    
end
