# run REBUILD.rb line by line

task :rebuild => :environment do
    File.open('lib/tasks/REBUILD_DOWNLOADS.rb', 'r') do |file|
      while line = file.gets
        eval(line)
      end
    end
    
    File.open('lib/tasks/REBUILD.rb', 'r') do |file|
      errors = []
      while line = file.gets
        begin
          eval(line)
          print "."
        rescue Exception => exc
          puts line
          puts exc.message
          errors.push [line,exc.message]
        end
      end
    end
    
    CSV.open("public/rebuild_errors", "wb") {|file| errors.each {|e| file << e} }
    
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