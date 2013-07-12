class ListseriesController < ApplicationController
  def get
    require "net/http"
    @filelist = []
    @data = []
    @filelist = JSON.parse(open("http://readtsd.herokuapp.com/listnames/json").read)
    @filelist["file_list"].each do |file|
      url = URI.parse("http://readtsd.herokuapp.com/open/#{file}/search/#{params[:name]}/json")
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      @data.push(JSON.parse(open("http://readtsd.herokuapp.com/open/#{file}/search/#{params[:name]}/json").read)) unless res.code == "500"
    end
  end
  
  def search
  end
  
  def redir
  @name = params[:name]
  redirect_to "/listseries/#{@name}"
  end
    
  
end
