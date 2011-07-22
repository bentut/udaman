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

ActiveRecord::Schema.define(:version => 20110722034452) do

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
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
