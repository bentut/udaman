
task :gen_system_summary => :environment do
  CSV.open("public/system_summary.csv", "wb") do |csv|        
    csv << ["series_name", "ds_id", "ds_eval", "current_data_points", "dependencies_count", "aremos_diffs", "last_run"]
    DataSource.order('series_id desc').all.each do |ds| 
      puts ds.series.name.rjust(20, " ") + ds.id.to_s.rjust(6," ") + ds.series.current_data_points.count.to_s.rjust(5," ") + ds.dependencies.count.to_s.rjust(3, " ") + ds.series.aremos_diff.to_s.rjust(5, " ") + ds.last_run.to_s.rjust(40," ")      
      csv << [ ds.series.name, ds.id, ds.eval, ds.series.current_data_points.count, ds.dependencies.count, ds.series.aremos_diff, ds.last_run ]
    end
  end
end

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
  t = Time.now
  diff_data = []
  
  
  PrognozDataFile.all.each do |pdf| 
    t1 = Time.now
    os = UpdateSpreadsheet.new pdf.filename    
    os.headers_with_frequency_code.each do |header|
      diff_data.push({:pdf_id => pdf.id, :id => 0, :name => header, :display_array => [-1]}) if header.ts.nil?
      next if header.ts.nil?
      ddiff = header.ts.data_diff(os.series(header.split(".")[0]), 3)
      diff_hash = ddiff[:display_array]
      diff_data.push({:pdf_id => pdf.id, :id => header.ts.id, :name => header, :display_array => diff_hash}) if diff_hash.count > 0
    end    
    pdf.write_export
    puts "#{"%.2f" %(Time.now - t1)} | #{pdf.filename}"
  end 
    
  CSV.open("public/prognoz_diffs.csv", "wb") do |csv|        
    diff_data.each do |dd|
      csv << [dd[:pdf_id]]+[dd[:name]] + [dd[:id]] + dd[:display_array]
    end
  end

  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["gen_prognoz_diffs", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :gen_investigate_csv => :environment do
  t = Time.now
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
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["gen_investigate_csv", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end

task :gen_daily_summary => :environment do
  t = Time.now
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
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["gen_daily_summary", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
end


task :mark_pseudo_history => :environment do
  t = Time.now
  
  DataSource.where("eval LIKE '%bls_histextend_date_format_correct.xls%'").each {|ds| ds.mark_as_pseudo_history}
  DataSource.where("eval LIKE '%inc_hist.xls%'").each {|ds| ds.mark_as_pseudo_history}
  DataSource.where("eval LIKE '%bls_sa_history.xls%'").each {|ds| ds.mark_as_pseudo_history}
  
  CSV.open("public/rake_time.csv", "a") {|csv| csv << ["mark_pseudo_history", "%.2f" % (Time.now - t) , t.to_s, Time.now.to_s] }
  
end

task :clean_obvious_missing_data_issues do
  # aremos_diff number indicates missing values. 10000... is how AREMOS encodes
  # data_source == 1 is a weak criteria. Just noticed it was less likely to bring in series we didn't want to mess with... Should probably be something else
  Series.where('aremos_diff > 10000000000').each do |s| 
    if s.data_sources.count == 1
      s.data_sources[0].clear_and_reload_source
      puts s.name
    end
  end
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

  # inactive_but_current.each do |ds|
  #     ds.print_eval_statement
  # end

  puts "COPY THESE INTO AN ARCHIVE"
  inactive_not_current.each do |ds|
    begin
      ds.print_eval_statement
      #ds.delete
    rescue
      puts "ERROR! Series ID: #{ds.id}"
    end
  end; 0
  puts "COPY THESE INTO AN ARCHIVE"
end
#Maybe should move circular diffs in here


task :find_outliers => :environment do
  errors = []
  outlier_series = []
  t = Time.now
  Series.all.each do |s| 
    outliers = s.outlier
    if outliers.nil?
      errors.push s.name 
      print "E"
    elsif outliers.count > 0
      outlier_series.push s.name 
      print s.name
    else
      print "."
    end
  end
  puts "#{ "%.2f" % (Time.now - t) }"
  puts errors
end
