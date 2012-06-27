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
    series_data = {}
    series_names.each do |s| 
      series = s.ts
      series_data[s] = series.nil? ? {} : series.get_values_after_including(start_date)
    end
    series_data
  end
  
  def data_dates
    dates_array = []
    series_data.each {|series_name, data| dates_array |= data.keys}
    dates_array.sort
  end
  
end
