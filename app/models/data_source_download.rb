class DataSourceDownload < ActiveRecord::Base
  require 'httpclient'
  
  serialize :post_parameters, Hash
  serialize :download_log, Array

    def DataSourceDownload.get(save_path)
      DataSourceDownload.where(:save_path => save_path).first
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

    def save_path_flex
      return save_path unless ENV["JON"] == "true"
      return save_path.gsub("UHEROwork", "UHEROwork-1")
    end
    
    def download_changed?
      self.download
      puts self.download_log[-1][:changed].to_s+" "+save_path 
      #return self.download_log[-1][:changed] unless self.download_log[-1][:changed].nil?
      return true
    end

    def download
      self.download_log ||= []
      client = HTTPClient.new
      if post_parameters.nil? or post_parameters.length == 0
        resp = client.get(URI.encode(url)) 
      else
        resp = client.post(URI.encode(url), post_parameters) 
      end
      #puts "downloaded"
      raise DownloadException if resp.header.status_code != 200
      data_changed = content_changed?(resp.content)

      backup if data_changed

      open(save_path_flex, "wb") { |file| file.write resp.content }
      #logging section
      download_time = Time.now
      download_url = url
      download_location = resp.header["Location"]
      content_type = resp.header["Content-Type"]
      status = resp.header.status_code
      self.download_log.push({:time => download_time, :url => download_url, :location => download_location, :type => content_type, :status => status, :changed => data_changed})
      self.save
    end

    def content_changed?(new_content)
      return true unless File::exists? save_path_flex
      previous_download = open(save_path_flex, "r").read
      return previous_download != new_content
    end

    def backup
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
