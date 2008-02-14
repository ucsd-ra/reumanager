# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "recommendations", :force => true do |t|
    t.integer  "student_id"
    t.string   "known_student"
    t.string   "know_capacity"
    t.string   "rating"
    t.integer  "gpa",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "gpa_total",       :limit => 10, :precision => 10, :scale => 0
    t.boolean  "undergrad_inst"
    t.text     "faculty_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommenders", :force => true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "title"
    t.string   "department"
    t.string   "univeristy"
    t.integer  "phone",      :limit => 10
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "students", :force => true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip",                 :limit => 9
    t.integer  "phone",               :limit => 10
    t.string   "pstreet"
    t.string   "pcity"
    t.string   "pstate"
    t.integer  "pzip",                :limit => 9
    t.integer  "pphone",              :limit => 10
    t.string   "email"
    t.string   "citizenship"
    t.string   "cresidence"
    t.string   "gender"
    t.string   "race"
    t.string   "disability"
    t.string   "college"
    t.datetime "cstart"
    t.datetime "cend"
    t.string   "clevel"
    t.string   "major"
    t.integer  "gpa",                 :limit => 10, :precision => 10, :scale => 0
    t.integer  "gpa_total",           :limit => 10, :precision => 10, :scale => 0
    t.string   "prev_college"
    t.datetime "pc_start"
    t.datetime "pc_end"
    t.integer  "recommender_id"
    t.text     "awards"
    t.text     "research_experience"
    t.text     "comments"
    t.text     "learn"
    t.text     "personal_statement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
