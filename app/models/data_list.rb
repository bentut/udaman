class DataList < ActiveRecord::Base
  # def export
  #   
  #   return unless File::exists? save_path_flex 
  #   Dir.mkdir save_path_flex+"_vintages" unless File::directory?(save_path_flex+"_vintages")
  #   filename = save_path_flex.split("/")[-1]
  #   date = Date.today    
  #   FileUtils.cp(save_path_flex, save_path_flex+"_vintages/#{date}_"+filename)
  # end
  def series_names
    list.split("\n").map {|element| element.strip} 
  end
  
  #not to be confused with startdate and enddate
  def start_date
    "#{self.startyear}-01-01"
  end
  
  def series_data
    @series_data ||= get_series_data
  end
  
  def get_series_descriptions 
    series_data = {}
    series_names.each do |s| 
      as = AremosSeries.get(s)
      series_data[s.split(".")[0]] = as.description unless as.nil?
    end
    series_data    
  end
  
  def get_series_ids
    series_data = {}
    series_names.each do |s| 
      series = s.ts
      series_data[s] = series.nil? ? nil : series.id
    end
    series_data    
  end
  
  def get_series_ids_for_frequency(frequency)
    series_data = {}
    series_names.each do |s| 
      s_name = (s.split(".")[0]+"."+frequency)
      series = s_name.ts
      series_data[s_name] = series.id unless series.nil?
    end
    series_data    
  end
  
  def get_series_data
    series_data = {}
    series_names.each do |s| 
      series = s.ts
      series_data[s] = series.nil? ? {} : series.get_values_after_including(start_date)
    end
    series_data
  end
  
  def get_all_series_data_with_changes(frequency_suffix = nil)
    series_data = {}
    series_names.each do |s| 
      s = s.split(".")[0] + "." + frequency_suffix unless frequency_suffix.nil?
      series = s.ts
      if series.nil?
        series_data[s] = {}
      else
        all_changes = {}
        yoy = series.yoy.data
        ytd = series.ytd.data
        yoy_diff = series.scaled_yoy_diff.data
        data = series.scaled_data
        data.keys.sort.each do |date|
          all_changes[date] = {:value => data[date], :yoy => yoy[date], :ytd => ytd[date], :yoy_diff => yoy_diff[date]}
        end
        as = AremosSeries.get(s.upcase)
        desc = as.nil? ? "" : as.description
        series_data[s] = {:data => all_changes, :id => series.id, :desc => desc} 
      end
    end
    series_data
    
  end
  
  def get_tsd_series_data_with_changes(tsd_file)
    series_data = {}
    series_names.each do |s| 
      as = AremosSeries.get(s.upcase)
      desc = as.nil? ? "" : as.description
      
      url = URI.parse("http://readtsd.herokuapp.com/open/#{tsd_file}/search/#{s.split(".")[0].gsub("%","%25")}/json")
      res = Net::HTTP.new(url.host, url.port).request_get(url.path)
      tsd_data = res.code == "500" ? nil : JSON.parse(res.body)  

      if tsd_data.nil?
        series_data[s] = {:data => {}, :id => nil, :desc => desc, :freq => "M"} 
      else
        series = Series.new_transformation(tsd_data["name"]+"."+tsd_data["frequency"],  tsd_data["data"], Series.frequency_from_code(tsd_data["frequency"]))
        all_changes = {}
        yoy = series.yoy.data
        ytd = series.ytd.data
        yoy_diff = series.yoy_diff.data
        data = series.data
        data.keys.sort.each do |date|
          all_changes[date] = {:value => data[date], :yoy => yoy[date], :ytd => ytd[date], :yoy_diff => yoy_diff[date]}
        end
        series_data[s] = {:data => all_changes, :id => nil, :desc => desc, :freq => tsd_data["frequency"]} 
      end
    end
    series_data
    
  end
  
  def data_dates
    dates_array = []
    series_data.each {|series_name, data| dates_array |= data.keys}
    dates_array.sort
  end
  
  def DataList.write(name, path, start_date = "1900-01-01")
    t = Time.now
    names = DataList.where(:name => name).first.series_names
    Series.write_data_list names, path, start_date
    puts "#{ "%.2f" % (Time.now - t) } | #{ names.count } | #{ path }"
  end
  
  def DataList.write_tsd(name, path)
    t = Time.now
    names = DataList.where(:name => name).first.series_names
    Series.write_data_list_tsd names, path
    puts "#{ "%.2f" % (Time.now - t) } | #{ names.count } | #{ path }"
  end
end



