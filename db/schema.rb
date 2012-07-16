# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120716113825) do

  create_table "aremos_series", :force => true do |t|
    t.string   "name"
    t.string   "frequency"
    t.string   "description"
    t.string   "start"
    t.string   "end"
    t.text     "data",               :limit => 2147483647
    t.text     "aremos_data",        :limit => 2147483647
    t.date     "aremos_update_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aremos_series", ["name"], :name => "index_aremos_series_on_name"

  create_table "data_lists", :force => true do |t|
    t.string   "name"
    t.text     "list"
    t.integer  "startyear"
    t.integer  "endyear"
    t.string   "startdate"
    t.string   "enddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_load_patterns", :force => true do |t|
    t.string   "start_date"
    t.string   "frequency"
    t.string   "path"
    t.string   "worksheet"
    t.string   "row"
    t.string   "col"
    t.string   "last_date_read"
    t.string   "last_read_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reverse",          :default => false
  end

  create_table "data_points", :force => true do |t|
    t.integer  "series_id"
    t.string   "date_string"
    t.float    "value"
    t.boolean  "current"
    t.integer  "data_source_id"
    t.datetime "history"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restore_counter", :default => 0
  end

  add_index "data_points", ["series_id", "date_string"], :name => "index_data_points_on_series_id_and_date_string"
  add_index "data_points", ["series_id"], :name => "index_data_points_on_series_id"

  create_table "data_source_downloads", :force => true do |t|
    t.string   "url"
    t.text     "post_parameters"
    t.string   "save_path"
    t.text     "download_log",    :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "file_to_extract"
    t.text     "notes"
  end

  create_table "data_sources", :force => true do |t|
    t.integer  "series_id"
    t.string   "description"
    t.string   "eval"
    t.text     "data",         :limit => 2147483647
    t.datetime "last_run"
    t.text     "dependencies"
    t.string   "color"
    t.float    "runtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_sources", ["series_id"], :name => "index_data_sources_on_series_id"

  create_table "packager_outputs", :force => true do |t|
    t.string   "path"
    t.date     "last_new_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prognoz_data_files", :force => true do |t|
    t.string   "name"
    t.string   "filename"
    t.string   "frequency"
    t.text     "series_loaded",     :limit => 2147483647
    t.text     "series_covered"
    t.text     "series_validated"
    t.text     "output_series"
    t.string   "output_start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.string   "frequency"
    t.string   "description"
    t.integer  "units"
    t.boolean  "seasonally_adjusted"
    t.string   "last_demetra_datestring"
    t.text     "factors"
    t.string   "factor_application"
    t.string   "prognoz_data_file_id"
    t.integer  "aremos_missing"
    t.float    "aremos_diff"
    t.integer  "mult"
    t.text     "data",                    :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "investigation_notes"
  end

  add_index "series", ["name"], :name => "index_series_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
