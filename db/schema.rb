# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100110031958) do

  create_table "academic_records", :force => true do |t|
    t.integer  "user_id"
    t.string   "college"
    t.datetime "college_start"
    t.datetime "college_end"
    t.string   "college_level"
    t.string   "major"
    t.string   "gpa"
    t.string   "gpa_range"
    t.string   "p_college"
    t.datetime "p_college_start"
    t.datetime "p_college_end"
    t.string   "transcript_file_name"
    t.string   "transcript_content_type"
    t.integer  "transcript_file_size"
    t.datetime "transcript_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "academic_records", ["user_id"], :name => "index_academic_records_on_user_id", :unique => true

  create_table "extras", :force => true do |t|
    t.integer  "user_id"
    t.text     "awards"
    t.text     "lab_skills"
    t.text     "comp_skills"
    t.text     "gpa_comments"
    t.string   "learn"
    t.text     "personal_statement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "extras", ["user_id"], :name => "index_extras_on_user_id", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "participant"
    t.string   "participant_university"
    t.string   "faculty_mentor"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recommender_id"
    t.string   "known_student"
    t.string   "know_capacity"
    t.string   "rating"
    t.string   "gpa"
    t.string   "gpa_range"
    t.string   "undergrad_inst"
    t.text     "faculty_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id", :unique => true

  create_table "recommenders", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "title"
    t.string   "department"
    t.string   "college"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommenders", ["user_id"], :name => "index_recommenders_on_user_id", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 100
    t.string   "firstname",                 :limit => 100, :default => ""
    t.string   "middlename",                :limit => 100, :default => ""
    t.string   "lastname",                  :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.datetime "dob"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "pstreet"
    t.string   "pcity"
    t.string   "pstate"
    t.string   "pzip"
    t.string   "pphone"
    t.string   "citizenship"
    t.string   "cresidence"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "race"
    t.string   "disability"
    t.datetime "activated_at"
    t.datetime "submitted_at"
    t.datetime "rec_request_at"
    t.datetime "completed_at"
    t.string   "token"
    t.datetime "token_created_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                                  :default => 2
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
