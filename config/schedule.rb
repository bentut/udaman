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
bls_hour = "4"
set :output, "~/Documents/cronlog/udaman-download.log"
set :environment, "development"
#job_type :rake,    "cd :path && rake :task :output"
job_type :rake,    "cd :path && rake :task"
#job_type :rake,    "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"


every 1.day, :at => "10:00 pm" do
  rake "reload_aremos"
end

every 1.day, :at => "#{hour}:00 am" do
  rake "update_seats_links"
  rake "update_vis_history_links"
end

every 1.day, :at => "#{hour}:10 am" do
  rake "reload_all_series"
end

# ------- These two are together. Need only sometimes --------
every 1.day, :at => "4:30 am" do
  rake "update_bea_links"
end

every 1.day, :at => "5:00 am" do
  rake "reload_bea_series_only"
end
# -----------------------------------------------------------

every 1.day, :at => "#{bls_hour}:00 am" do
  rake "update_bea_links"
end

every 1.day, :at => "#{bls_hour.to_i+2}:30 am" do 
  rake "write_ur_dash"
end

every 1.day, :at => "#{hour.to_i+5}:30 am" do
  rake "gen_investigate_csv"
end

every 1.day, :at => "#{hour.to_i+5}:40 am" do
  rake "gen_prognoz_diffs"
end

every 1.day, :at => "#{hour.to_i+5}:50 am" do
  rake "aremos_exports"
end

every 1.day, :at => "#{hour.to_i+5}:55 am" do
  rake "tsd_exports"
end

every :saturday, :at => '9am' do
  rake "mark_pseudo_history"
end

#bring down pv file daily
every 1.day, :at => "9:15 am" do
  runner "DataSourceDownload.get(\"PV_HON@hawaii.gov\").download"
end

#alternatives in case of emergency

# every 1.day, :at => "12:05 pm" do
#   rake "update_bea_links"
# end
# 
# every 1.day, :at => "12:05 pm" do
#   rake "jp_upd_a"
#   rake "jp_upd_q"
#   rake "jp_upd_m"
# end
# 
# every 1.day, :at => "12:10 pm" do
#   rake "tour_PC_upd"
#   rake "tour_seats_upd"
#   rake "tour_upd"
#   rake "tour_ocup_upd"
# end
# 
# every 1.day, :at => "12:30 pm" do
#   rake "uic_upd"
#   rake "const_upd_q"
#   rake "const_upd_m"
# end
# 
# every 1.day, :at => "12:35 pm" do
#   rake "tax_upd"
# end
# 
# every 1.day, :at => "12:40 pm" do
#   rake "tour_rev_upd"
# end
# 
# every 1.day, :at => "1:00 pm" do
#   rake "tax_identities"
# end
# 
# 
# every 1.day, :at => "1:15 pm" do
#   rake "gsp_upd" 
#   rake "inc_upd_q"
#   rake "inc_upd_a"
#   rake "com_upd"
# end
# 
# every 1.day, :at => "1:40 pm" do
#   rake "us_upd_a"
#   rake "us_upd_q"
#   rake "us_upd_m"
# end
# 
# every 1.day, :at => "2:00 pm" do 
#   rake "bls_cpi_upd_m"
#   rake "bls_job_upd_m"
#   rake "bls_cpi_upd_s"
#   rake "hiwi_upd"
# end
# 
# every 1.day, :at => "2:30 pm" do 
#   rake "bls_identities"
#   rake "bea_identities"
# end
# 
# every 1.day, :at => "3:00 pm" do
#   rake "expenditures_and_nbi"
#   rake "visitor_identities"
#   rake "const_identities"
# end
# 
# 
# every 1.day, :at => "3:20 pm" do
#   rake "run_aggregations"
#   rake "run_aggregations2"
#   rake "run_aggregations3"
#   rake "run_aggregations4"
#   rake "run_aggregations5"
# end
# 
# every 1.day, :at => "3:40 pm" do
#   rake "bls_nbis"
# end
# 
# every 1.day, :at => "3:50 pm" do
#   rake "gen_investigate_csv"
# end







