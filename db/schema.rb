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

ActiveRecord::Schema.define(:version => 20120106015347) do

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

  create_table "jp_annual_measurements", :force => true do |t|
    t.date     "month_and_year"
    t.float    "gdp_jp"
    t.float    "gdpdef_jp"
    t.float    "gdppc_jp"
    t.float    "gdppc_r_jp"
    t.float    "gdp_cg_jp"
    t.float    "gdp_cg_r_jp"
    t.float    "gdp_cp_jp"
    t.float    "gdp_cp_r_jp"
    t.float    "gdp_ex_jp"
    t.float    "gdp_ex_r_jp"
    t.float    "gdp_ifx_jp"
    t.float    "gdp_ifxg_jp"
    t.float    "gdp_ifxg_r_jp"
    t.float    "gdp_ifx_r_jp"
    t.float    "gdp_iivg_jp"
    t.float    "gdp_iivg_r_jp"
    t.float    "gdp_iivp_jp"
    t.float    "gdp_iivp_r_jp"
    t.float    "gdp_im_jp"
    t.float    "gdp_im_r_jp"
    t.float    "gdp_inrp_jp"
    t.float    "gdp_inrp_r_jp"
    t.float    "gdp_irsp_jp"
    t.float    "gdp_irsp_r_jp"
    t.float    "gdp_nx_jp"
    t.float    "gdp_nx_r_jp"
    t.float    "gdp_r_jp"
    t.float    "gni_jp"
    t.float    "gnidef_jp"
    t.float    "gnipc_jp"
    t.float    "gnipc_r_jp"
    t.float    "gni_r_jp"
    t.float    "n_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "testaggregate"
  end

  create_table "jp_monthly_measurements", :force => true do |t|
    t.date     "month_and_year"
    t.float    "cpi_jp"
    t.float    "cpicore_jp"
    t.float    "cpicorens_jp"
    t.float    "cpins_jp"
    t.float    "cscfns_jp"
    t.float    "empl_jp"
    t.float    "e_nf_jp"
    t.float    "inf_jp"
    t.float    "infcore_jp"
    t.float    "ip_jp"
    t.float    "ipmn_jp"
    t.float    "ipmnns_jp"
    t.float    "ipns_jp"
    t.float    "lf_jp"
    t.float    "r_jp"
    t.float    "stkns_jp"
    t.float    "ur_jp"
    t.float    "yxr_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "testaggregate"
  end

  create_table "jp_quarterly_measurements", :force => true do |t|
    t.date     "month_and_year"
    t.float    "cscf_jp"
    t.float    "cscfns_jp"
    t.float    "gdp_jp"
    t.float    "gdpdef_jp"
    t.float    "gdpns_jp"
    t.float    "gdp_cg_jp"
    t.float    "gdp_cgns_jp"
    t.float    "gdp_cg_r_jp"
    t.float    "gdp_cg_rns_jp"
    t.float    "gdp_cp_jp"
    t.float    "gdp_cpns_jp"
    t.float    "gdp_cp_r_jp"
    t.float    "gdp_cp_rns_jp"
    t.float    "gdp_ex_jp"
    t.float    "gdp_exns_jp"
    t.float    "gdp_ex_r_jp"
    t.float    "gdp_ex_rns_jp"
    t.float    "gdp_ifx_jp"
    t.float    "gdp_ifxg_jp"
    t.float    "gdp_ifxgns_jp"
    t.float    "gdp_ifxg_r_jp"
    t.float    "gdp_ifxg_rns_jp"
    t.float    "gdp_ifxns_jp"
    t.float    "gdp_ifx_r_jp"
    t.float    "gdp_ifx_rns_jp"
    t.float    "gdp_iivg_jp"
    t.float    "gdp_iivgns_jp"
    t.float    "gdp_iivg_r_jp"
    t.float    "gdp_iivg_rns_jp"
    t.float    "gdp_iivp_jp"
    t.float    "gdp_iivpns_jp"
    t.float    "gdp_iivp_r_jp"
    t.float    "gdp_iivp_rns_jp"
    t.float    "gdp_im_jp"
    t.float    "gdp_imns_jp"
    t.float    "gdp_im_r_jp"
    t.float    "gdp_im_rns_jp"
    t.float    "gdp_inrp_jp"
    t.float    "gdp_inrpns_jp"
    t.float    "gdp_inrp_r_jp"
    t.float    "gdp_inrp_rns_jp"
    t.float    "gdp_irsp_jp"
    t.float    "gdp_irspns_jp"
    t.float    "gdp_irsp_r_jp"
    t.float    "gdp_irsp_rns_jp"
    t.float    "gdp_nx_jp"
    t.float    "gdp_nxns_jp"
    t.float    "gdp_nx_r_jp"
    t.float    "gdp_nx_rns_jp"
    t.float    "gdp_r_jp"
    t.float    "gdp_rns_jp"
    t.float    "gni_jp"
    t.float    "gnidef_jp"
    t.float    "gnins_jp"
    t.float    "gni_r_jp"
    t.float    "gni_rns_jp"
    t.float    "infgdpdef_jp"
    t.float    "tkbscamnns_jp"
    t.float    "tkbscamn_ns_jp"
    t.float    "tkbscanmns_jp"
    t.float    "tkbscanm_ns_jp"
    t.float    "tkbscans_jp"
    t.float    "tkbsca_ns_jp"
    t.float    "tkbsclmnns_jp"
    t.float    "tkbsclmn_ns_jp"
    t.float    "tkbsclnmns_jp"
    t.float    "tkbsclnm_ns_jp"
    t.float    "tkbsclns_jp"
    t.float    "tkbscl_ns_jp"
    t.float    "tkbscmmnns_jp"
    t.float    "tkbscmmn_ns_jp"
    t.float    "tkbscmnmns_jp"
    t.float    "tkbscmnm_ns_jp"
    t.float    "tkbscmns_jp"
    t.float    "tkbscm_ns_jp"
    t.float    "tkbscsmnns_jp"
    t.float    "tkbscsmn_ns_jp"
    t.float    "tkbscsnmns_jp"
    t.float    "tkbscsnm_ns_jp"
    t.float    "tkbscsns_jp"
    t.float    "tkbscs_ns_jp"
    t.float    "tkempamnns_jp"
    t.float    "tkempamn_ns_jp"
    t.float    "tkempanmns_jp"
    t.float    "tkempanm_ns_jp"
    t.float    "tkempans_jp"
    t.float    "tkempa_ns_jp"
    t.float    "tkemplmnns_jp"
    t.float    "tkemplmn_ns_jp"
    t.float    "tkemplnmns_jp"
    t.float    "tkemplnm_ns_jp"
    t.float    "tkemplns_jp"
    t.float    "tkempl_ns_jp"
    t.float    "tkempmmnns_jp"
    t.float    "tkempmmn_ns_jp"
    t.float    "tkempmnmns_jp"
    t.float    "tkempmnm_ns_jp"
    t.float    "tkempmns_jp"
    t.float    "tkempm_ns_jp"
    t.float    "tkempsmnns_jp"
    t.float    "tkempsmn_ns_jp"
    t.float    "tkempsnmns_jp"
    t.float    "tkempsnm_ns_jp"
    t.float    "tkempsns_jp"
    t.float    "tkemps_ns_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "testaggregate"
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
