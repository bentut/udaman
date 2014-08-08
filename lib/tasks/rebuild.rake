# run REBUILD.rb line by line

task :rebuild => :environment do
    t = Time.now
    total_t = t

    puts "\n\n------------DELETING CONTENT---------\n\n"
    DataPoint.delete_all
    DataSource.delete_all
    Series.delete_all
    DataSourceDownload.delete_all
    DsdLogEntry.delete_all
   
    puts "\n\n------LOADING UDAMAN ARCHIVE-------\n\n"
    Series.load_all_series_from('/Users/uhero/Documents/data/udaman_archive.csv', nil, 10)
    puts "Time: #{Time.now - t}"
    t = Time.now

    puts "\n\n-------RELOADING AREMOS--------\n\n"
    begin
        Rake::Task["reload_aremos"].reenable
        Rake::Task["reload_aremos"].invoke
    rescue
        puts "Problem with AREMOS reload"
    end

    puts "Time: #{Time.now - t}"
    t = Time.now

   puts "\n\n-------REBUILDING DOWNLOADS-------\n\n"
    File.open('lib/tasks/REBUILD_DOWNLOADS.rb', 'r') do |file|
       while line = file.gets
          line.gsub! "/Volumes/UHEROwork", "/Users/uhero/Documents"
          eval(line)
       end
    end
    puts "Time: #{Time.now - t}"
    t = Time.now


    error_rounds = []
    errors = []
    last_errors = []

    puts "\n\n--------REBUILDING DEFINITIONS--------\n\n"
    File.open('lib/tasks/REBUILD.rb', 'r') do |file|
       `chmod -R 777 /Users/uhero/Documents/data/*`
       while line = file.gets
          line.gsub! "/Volumes/UHEROwork", "/Users/uhero/Documents"
          line.gsub! "japan/seasadj/sadata.xls", "rawdata/sadata/japan.xls"
          line.gsub! "bls/seasadj/sadata.xls", "rawdata/sadata/bls.xls"
          line.gsub! "misc/hbr/seasadj/sadata.xls", "rawdata/sadata/misc_hbr.xls"
          line.gsub! "tour/seasadj/sadata.xls", "rawdata/sadata/tour.xls"
          line.gsub! "tour/seasadj/sadata_upd.xls", "rawdata/sadata/tour_upd.xls"
          line.gsub! "tax/seasadj/sadata.xls", "rawdata/sadata/tax.xls"
          line.gsub! "misc/prud/seasadj/prud_sa.xls", "rawdata/sadata/misc_prud_prud_sa.xls"
          line.gsub! "misc/hbr/seasadj/mbr_sa.xls", "rawdata/sadata/misc_hbr_mbr_sa.xls"
          line.gsub! "bls/seasadj/bls_wagesa.xls", "rawdata/sadata/bls_wages.xls"
          begin
             this_series = eval(line)
             this_series.find_units if this_series.aremos_diff > 0
             print "."
          rescue Exception => exc
             puts line
             errors.push [line,exc.message]
          end
       end
    end

    puts "done with first round\n\n\n\n\n\n\n\n"
    puts last_errors.count
    puts errors.count

    until last_errors.count == errors.count
       error_rounds.push(errors)
       last_errors = errors
       errors = []

       puts "Time: #{Time.now - t}"
       t = Time.now

       puts "\n\n\n----------WORKING ON ROUND #{} OF ERRORS--------------\n\n\n"

       last_errors.each do |error|
          begin
             this_series = eval(error[0])
             this_series.find_units if this_series.aremos_diff > 0
          rescue Exception => exc
             puts error[0]
             errors.push [error[0], exc.message]
          end
       end

    end

    error_rounds.each_index do |i|
       error = error_rounds[i] 
       CSV.open("public/rebuild_errors_#{i}.csv", "wb") {|file| error.each {|e| file << e} }
    end

    puts "Time: #{Time.now - t}"
    t = Time.now

    puts "\n\n\n----------RUNNING ts_eval_force on remaining errors--------------\n\n\n"

    # use ts_eval_force on these stubborn lines
    errors.each do |e| 
       begin 
          eval(e[0].gsub "ts_eval", "ts_eval_force")
       rescue SyntaxError => exc # this exception handles strings that are not ending
          puts "------Syntax Error------"
          puts exc.message
       end
    end

    puts "Time: #{(Time.now - t)}"
    t = Time.now

    puts "\n\n\n----------UPDATING PRIORITIES-------------\n\n\n"

    File.open('lib/tasks/REBUILD_PRIORITIES.rb', 'r') do |file|
       while line = file.gets
          line.gsub! "/Volumes/UHEROwork", "/Users/uhero/Documents"
          eval(line)
       end
    end

    puts "Time: #{(Time.now - t)}"
    t = Time.now

    puts "\n\n\n----------RUNNING find_units--------------\n\n\n"

    # adjust the units field to match aremos
    Series.all.each {|s| s.find_units}

    puts "Time: #{(Time.now - t)}"
    t = Time.now

    puts "\n\n\n----------Marking Pseudo History--------------\n\n\n"

    # run mark_pseudo_history task
    Rake::Task["mark_pseudo_history"].reenable
    Rake::Task["mark_pseudo_history"].invoke

    puts "Time: #{(Time.now - t)}"
    puts "Total Time: #{Time.now - total_t}"
end

task :test_case => :environment do
   "CPINS@US.M".tsn.load_from_bls("CUUR0000SA0", "M")
   "CPINS@US.Q".ts_eval= %Q|"CPINS@US.M".ts.aggregate(:quarter, :average)|
   "CPI@US.A".ts_eval= %Q|"CPINS@US.Q".ts.aggregate(:year, :average)|
end

task :output_active_downloads => :environment do
  File.open('lib/tasks/REBUILD_DOWNLOADS.rb', 'w') do |file|
    DsdLogEntry.maximum(:time, :group => :data_source_download_id).each do |dsd_id, time|
      if time > (Date.today - 10.day)
        puts "wrote: #{dsd_id}"
        file.puts DataSourceDownload.find(dsd_id).update_statement
      end
    end 
  end
end

task :output_priorities => :environment do
    File.open('lib/tasks/REBUILD_PRIORITIES.rb', 'w') do |file|
        DataSource.where("priority != 100").each do |ds|
            puts "wrote: #{ds.id}"
            file.puts %Q!DataSource.where(%Q|eval LIKE '#{ds.eval}'|).first.priority = #{ds.priority}!
        end
    end
end
