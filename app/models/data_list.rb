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
  
  def get_series_data
    series_data = {}
    series_names.each do |s| 
      series = s.ts
      series_data[s] = series.nil? ? {} : series.get_values_after_including(start_date)
    end
    series_data
  end
  
  def get_all_series_data_with_changes
    series_data = {}
    series_names.each do |s| 
      series = s.ts
      if series.nil?
        series_data[s] = {}
      else
        all_changes = {}
        yoy = series.yoy.data
        ytd = series.ytd.data
        yoy_diff = series.yoy_diff.data
        data = series.data
        data.keys.sort.each do |date|
          all_changes[date] = {:value => data[date], :yoy => yoy[date], :ytd => ytd[date], :yoy_diff => yoy_diff[date]}
        end
        series_data[s] = all_changes
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



