# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

hour = "1"
set :output, "~/Documents/cronlog/udaman-download.log"
set :environment, "development"
job_type :rake,    "cd :path && rake :task :output"
#job_type :rake,    "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.day, :at => "#{hour}:00 am" do
  rake "jp_upd_a"
  rake "jp_upd_q"
  rake "jp_upd_m"
end

every 1.day, :at => "#{hour}:10 am" do
  rake "gsp_upd"
  rake "inc_upd_q"
  rake "inc_upd_a"
end

every 1.day, :at => "#{hour}:20 am" do
  rake "bls_cpi_upd_m"
  rake "bls_job_upd_m"
  rake "bls_job_upd_s"
  rake "hiwi_upd"
end

every 1.day, :at => "#{hour}:30 am" do
  rake "uic_upd"
  rake "const_upd_q"
  rake "const_upd_m"
end

every 1.day, :at => "#{hour}:35 am" do
  rake "tax_upd"
end

every 1.day, :at => "#{hour}:40 am" do
  rake "tour_PC_upd"
  rake "tour_seats_upd"
  rake "tour_upd"
end

every 1.day, :at => "#{hour}:50 am" do
  rake "us_upd_a"
  rake "us_upd_q"
  rake "us_upd_m"
end
