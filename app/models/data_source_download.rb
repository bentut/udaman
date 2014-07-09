class DataSourceDownload < ActiveRecord::Base
  require 'httpclient'
  
  serialize :post_parameters, Hash
  serialize :download_log, Array

  has_many :dsd_log_entries
  
    #some tight coupling to the unizipping functionality in the string extension
    def DataSourceDownload.get_by_path(save_path)
      sp = save_path.split("_extracted_files/")[0] 
      DataSourceDownload.where(:save_path => sp).first
    end
    
    def DataSourceDownload.get(handle)
      DataSourceDownload.where(:handle => handle).first
    end
    
    def DataSourceDownload.test_url(url)
      dsd = DataSourceDownload.new(:url => url)
      dsd.test_url
    end

    def DataSourceDownload.test_save_path(save_path)
      dsd = DataSourceDownload.new(:save_path => save_path)
      dsd.test_save_path
    end

    def DataSourceDownload.test_post_params(params)
  #    begin
        DataSourceDownload.new.test_process_post_params(params)
      # rescue Exception => exc
      #   return false
      # end
      return true
    end
    #used this in the other script that downloaded https files
    #but this script doesn't appear to need it
    #client.ssl_config.set_trust_ca('ca.secure.webapp.domain.com.crt')


    def DataSourceDownload.upd(options)
      dsd = DataSourceDownload.where(:handle => options["handle"]).first
      if dsd.nil?
        DataSourceDownload.create(options)
      else
        handle = options.delete("handle")
        dsd.update_attributes(options)
      end
    end
    
    def update_statement
      return "DataSourceDownload.upd(#{self.attributes.select {|key, value| !value.is_a? Time}})"
    end
    
    def save_path_flex
      return save_path unless ENV["JON"] == "true"
      return save_path.gsub("UHEROwork", "UHEROwork-1")
    end
    
    def extract_path_flex
      return file_to_extract unless ENV["JON"] == "true"
      return file_to_extract.gsub("UHEROwork", "UHEROwork-1")
    end
    
    def DataSourceDownload.flex(path)
      return path unless ENV["JON"] == "true"
      return path.gsub("UHEROwork", "UHEROwork-1")
    end
    
    #this needs to be fixed
    def download_changed?
      self.download
      #puts self.download_log[-1][:changed].to_s+" "+save_path 
      #return self.download_log[-1][:changed] unless self.download_log[-1][:changed].nil?
      return true
    end

    def download
      #self.download_log ||= []
      client = HTTPClient.new
      #some will only respond to certain user agents... this may have to be updated
      client.agent_name = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0'
      client.connect_timeout = 1000
      resp = nil
      #loop seems to allow cookie to be downloaded... maybe more effective way to do this?
      (1..2).each do |i|
        if post_parameters.nil? or post_parameters.length == 0
          resp = client.get(URI.encode(url)) 
        else
          resp = client.post(URI.encode(url), post_parameters) 
        end
        break if resp.header.status_code == 200
      end
      puts "downloaded"
      #not sure why I was raising this exception. Want to note the failed downloads and continue
      #raise DownloadException if resp.header.status_code != 200
      if resp.header.status_code == 200 #successful download
        data_changed = content_changed?(resp.content)

        backup if data_changed

        open(save_path_flex, "wb") { |file| file.write resp.content }
        save_path_flex.unzip if save_path_flex[-3..-1] == "zip"
      end
      #logging section
      download_time = Time.now
      download_url = url
      download_location = resp.header["Location"]
      content_type = resp.header["Content-Type"]
      status = resp.header.status_code
      last_log = dsd_log_entries.order(:time).last
      
      if last_log.nil? or !(last_log.url == download_url and last_log.time.to_date == download_time.to_date and last_log.status == status)
        self.dsd_log_entries.create(:time => download_time, :url => download_url, :location => download_location, :type => content_type, :status => status, :dl_changed => data_changed)
      end
      
      #this return might be a little misleading since it isn't always the exact results of the last download, just an indication that they were mostly the same
      dsd_log_entries.order(:time).last
    end
    
    def content_changed?(new_content)
      puts "checking for changed content"
      return true unless File::exists? save_path_flex
      previous_download = open(save_path_flex, "rb").read
      return previous_download != new_content
    end

    def backup
      puts "backing up"
      return unless File::exists? save_path_flex 
      Dir.mkdir save_path_flex+"_vintages" unless File::directory?(save_path_flex+"_vintages")
      filename = save_path_flex.split("/")[-1]
      date = Date.today    
      FileUtils.cp(save_path_flex, save_path_flex+"_vintages/#{date}_"+filename)
    end

    def test_process_post_params(post_param)
      begin
        self.post_parameters = eval %Q|{#{post_param}}| 
      # rescue Exception => exc
      #   raise ProcessPostParamException
      end
    end

    def process_post_params(post_param)
      begin
        self.post_parameters = eval %Q|{#{post_param}}| 
        self.save
      rescue Exception => exc
        raise ProcessPostParamException
      end
    end

    def post_param_string
      return "" if post_parameters.nil?
      string = ""
      post_parameters.sort.each do |key,value|
        string += %Q|'#{key}'=>'#{value}',\n|
      end
      string.chop.chop
    end

    def test_url
      begin
        client = HTTPClient.new
        client.agent_name = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0'
        resp = client.get(url)
        resp.header.status_code 
      rescue 
        return nil
      end
    end

    def test_save_path
      return "nopath" if save_path.nil?
      return "duplicate" if DataSourceDownload.where(:save_path => save_path).count > 0
      return "badpath" unless File::directory?(save_path.split("/")[0..-2].join("/"))
      return "ok"
    end


  end
