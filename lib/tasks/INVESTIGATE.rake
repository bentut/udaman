
task :gen_investigate_csv => :environment do
  
  # diff_data = [{:id => 1, :name => "he", :display_array => [1,2,2,2] }]
  diff_data = []
  to_investigate = Series.where("aremos_missing > 0 OR ABS(aremos_diff) > 0.0").order('frequency, name ASC')

  to_investigate.each do |ts| 
    aremos_series = AremosSeries.get ts.name
    diff_data.push({:id => ts.id, :name => ts.name, :display_array => ts.aremos_comparison_display_array})
  end
  
  CSV.open("public/investigate_visual.csv", "wb") do |csv|        
    diff_data.each do |dd|
      csv << [dd[:name]] + [dd[:id]] + dd[:display_array]
    end
  end
  
  downloads = 0
  changed_files = 0
  dps = DataPoint.where("created_at > FROM_DAYS(TO_DAYS(NOW()))").count(:all, :group=> :series_id)
  CSV.open("public/dp_added.csv", "wb") do |csv|        
    csv << ["series_name", "series_id", "new_datapoints_added"]
    dps.each do |series_id,count| 
      csv << [Series.find(series_id).name, series_id, count]
    end
  end
  
  CSV.open("public/download_results.csv", "wb") do |csv|
    csv << ["id", "handle", "time", "status", "changed", "url"]
    DataSourceDownload.all.each do |dsd|
      puts dsd.handle
      next if dsd.download_log.nil?
      last_log = dsd.download_log[-1] 
      csv << [dsd.id, dsd.handle, last_log[:time], last_log[:status], last_log[:changed], last_log[:url] ] if dsd.download_log[-1][:time] > Time.now.to_date - 1
      downloads += 1 if last_log[:changed] and dsd.download_log[-1][:time] > Time.now.to_date - 1
    end
  end
  
  CSV.open("public/packager_output.csv", "wb") do |csv|
    csv << ["changed", "group", "label"]
    PackagerOutput.all.each do |po| 
      path_parts = po.path.split("/")
      csv << [po.last_new_data == Time.now.to_date, path_parts[4], path_parts[-1].gsub(".xls","").gsub("_NEW","")]
      downloads += 1 if po.last_new_data == Time.now.to_date
    end
  end
  system 'cd /Users/Shared/Dev/udaman/script && casperjs rasterize.js'
  puts "finished this now sending"
  PackagerMailer.visual_notification(dps.count, changed_files, downloads).deliver
  
end

task :gen_daily_summary => :environment do
  downloads = 0
  changed_files = 0
  dps = DataPoint.where("created_at > FROM_DAYS(TO_DAYS(NOW()))").count(:all, :group=> :series_id)
  CSV.open("public/dp_added.csv", "wb") do |csv|        
    csv << ["series_name", "series_id", "new_datapoints_added"]
    dps.each do |series_id,count| 
      csv << [Series.find(series_id).name, series_id, count]
    end
  end
  
  CSV.open("public/download_results.csv", "wb") do |csv|
    csv << ["id", "handle", "time", "status", "changed", "url"]
    DataSourceDownload.all.each do |dsd|
      puts dsd.handle
      next if dsd.download_log.nil?
      last_log = dsd.download_log[-1] 
      csv << [dsd.id, dsd.handle, last_log[:time], last_log[:status], last_log[:changed], last_log[:url] ] if dsd.download_log[-1][:time] > Time.now.to_date - 1
      downloads += 1 if last_log[:changed] and dsd.download_log[-1][:time] > Time.now.to_date - 1
    end
  end
  
  CSV.open("public/packager_output.csv", "wb") do |csv|
    csv << ["changed", "group", "label"]
    PackagerOutput.all.each do |po| 
      path_parts = po.path.split("/")
      csv << [po.last_new_data == Time.now.to_date, path_parts[4], path_parts[-1].gsub(".xls","").gsub("_NEW","")]
      changed_files += 1 if po.last_new_data == Time.now.to_date
    end
  end
  system 'cd /Users/Shared/Dev/udaman/public && casperjs rasterize.js'
  puts "finished this now sending"
  
  PackagerMailer.visual_notification(dps.count, changed_files, downloads).deliver
  
end