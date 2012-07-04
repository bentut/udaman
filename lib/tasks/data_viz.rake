task :compressed_data_csv => :environment do
  require 'csv'
  path = "/Volumes/UHEROwork/data/rawdata/alltimeseries/"

  CSV.open(path+'all_series.csv','wb') do |csv|  
    date_range = Date.compressed_date_range
    csv << ["series_name"] + date_range
    Series.find(:all, :order => "name").each do |s| 
      puts s.name
      data = s.compressed_date_range_data(date_range)
      data_array = []
      date_range.each { |date| data_array.push(data[date]) }
      csv << [s.name] + data_array
    end
  end
  
end