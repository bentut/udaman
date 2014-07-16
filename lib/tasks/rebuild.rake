# run REBUILD.rb line by line

task :rebuild => :environment do
    File.open('lib/tasks/REBUILD_DOWNLOADS.rb', 'r') do |file|
      while line = file.gets
        eval(line)
      end
    end
    
    error_rounds = []
    errors = []
    last_errors = []
    
    File.open('lib/tasks/REBUILD.rb', 'r') do |file|
      while line = file.gets
        begin
          eval(line)
          print "."
        rescue Exception => exc
          puts line
          errors.push [line,exc.message]
        end
      end
    end
    
    while last_errors.count == errors.count
      error_rounds.push(errors)
      last_errors = errors
      errors = []
        
      last_errors.each do |error|
        begin
          eval(error[0])
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