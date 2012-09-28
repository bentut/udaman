
task :update_diffs => :environment do
  to_investigate = Series.where("aremos_missing > 0 OR ABS(aremos_diff) > 0.0").order('frequency, name ASC')
  to_investigate.each {|s| s.aremos_comparison}

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
end


task :gen_prognoz_diffs => :environment do
  diff_data = []
  
  PrognozDataFile.all.each do |pdf| 
    os = UpdateSpreadsheet.new pdf.filename    
    os.headers_with_frequency_code.each do |header|
      puts "checking #{header}"
      diff_data.push({:pdf_id => pdf.id, :id => 0, :name => header, :display_array => [-1]}) if header.ts.nil?
      next if header.ts.nil?
      next if header.ts.data_diff(os.series(header.split(".")[0]), 3).count == 0
      diff_hash = header.ts.data_diff_display_array(os.series(header.split(".")[0]), 3)
      diff_data.push({:pdf_id => pdf.id, :id => header.ts.id, :name => header, :display_array => diff_hash}) if diff_hash.count > 0
    end    
  end 
    
  CSV.open("public/prognoz_diffs.csv", "wb") do |csv|        
    diff_data.each do |dd|
      csv << [dd[:name]] + [dd[:id]] + dd[:display_array]
    end
  end

  PrognozDataFile.all.each do |pdf|
    pdf.write_export
  end
end

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
      puts dsd.handle.to_s
      next if dsd.dsd_log_entries == []
      last_log = dsd.dsd_log_entries.order(:time).last
      csv << [dsd.id, dsd.handle, last_log.time, last_log.status, last_log.changed, last_log.url] if last_log.time > Time.now.to_date - 1
      downloads += 1 if last_log.changed and last_log.time > Time.now.to_date - 1
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
      next if dsd.dsd_log_entries.nil?
      last_log = dsd.dsd_log_entries.order(:time).last
      csv << [dsd.id, dsd.handle, dsd.time, dsd.status, dsd.changed, dsd.url] if last_log.time > Time.now.to_date - 1
      downloads += 1 if last_log.changed and dsd.download_log.time > Time.now.to_date - 1
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



task :clean_data_sources => :environment do

  active_ds = DataSource.where("last_run > FROM_DAYS(TO_DAYS(NOW()))").order(:last_run); 0
  inactive_ds = DataSource.where("last_run <= FROM_DAYS(TO_DAYS(NOW()))").order(:last_run); 0

# active_but_not_current = active_ds.reject {|elem| elem.current? }
# active_current = active_ds.reject {|elem| !elem.current? }
# inactive_not_current = inactive_ds.reject {|elem| elem.current? }
# inactive_but_current = inactive_ds.reject {|elem| !elem.current? }

  active_but_not_current = []
  active_current = []
  inactive_not_current = []
  inactive_but_current = []

  t = Time.now
  active_ds.each do |ds|
    if ds.current?
      active_current.push(ds)
    else
      active_but_not_current.push(ds)
    end
  end; 0
  puts "#{ "%.2f" % (Time.now - t) } |  Active but not Current | #{ active_but_not_current.count } | Active Current | #{ active_current.count } |"
  
  t = Time.now
  inactive_ds.each do |ds|
    if ds.current?
      inactive_but_current.push(ds)
    else
      inactive_not_current.push(ds)
    end  
  end; 0
  puts "#{ "%.2f" % (Time.now - t) } |  Inactive not Current | #{ inactive_not_current.count } | Inactive but Current | #{ inactive_but_current.count } |"
  
  # active_but_not_current.count #delete and pull out of definitions INVESTIGATE - 390
  # active_current.count #leave alone - 6301
  # inactive_not_current.count #delete. Store all deleted ones - 11840
  # inactive_but_current.count #make current / flag ones that need to be replaced - 3255

  puts "COPY THESE INTO AN ARCHIVE"
  inactive_not_current.each do |ds|
    ds.print_eval_statement
    begin
      ds.delete
    rescue
      puts "ERROR!"
    end
  end; 0
  puts "COPY THESE INTO AN ARCHIVE"
end
#Maybe should move circular diffs in here

