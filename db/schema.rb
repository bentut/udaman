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

ActiveRecord::Schema.define(:version => 20110722102343) do

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
  end

  create_table "data_source_downloads", :force => true do |t|
    t.string   "url"
    t.text     "post_parameters"
    t.string   "save_path"
    t.text     "download_log",    :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
