# run REBUILD.rb line by line
# run each line in a try-catch
task :rebuild => :environment do
    File.open('REBUILD.rb', 'r') do |file|
        while line = file.gets
            begin
                eval(line)
            rescue Exception => exc
                puts line
            end
        end
    end
end
