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

ActiveRecord::Schema.define(:version => 20110321031236) do

  create_table "academic_records", :force => true do |t|
    t.integer "user_id",                 :limit => 11
    t.text    "college",                 :limit => 255
    t.text    "college_start"
    t.text    "college_end"
    t.text    "college_level",           :limit => 255
    t.text    "major",                   :limit => 255
    t.text    "gpa",                     :limit => 255
    t.text    "gpa_range",               :limit => 255
    t.text    "p_college",               :limit => 255
    t.text    "p_college_start"
    t.text    "p_college_end"
    t.text    "transcript_file_name",    :limit => 255
    t.text    "transcript_content_type", :limit => 255
    t.integer "transcript_file_size",    :limit => 11
    t.text    "transcript_updated_at"
    t.text    "created_at"
    t.text    "updated_at"
  end

  add_index "academic_records", ["id"], :name => "sqlite_autoindex_academic_records_1", :unique => true
  add_index "academic_records", ["user_id"], :name => "index_academic_records_on_user_id", :unique => true

  create_table "extras", :force => true do |t|
    t.integer "user_id",            :limit => 11
    t.text    "awards"
    t.text    "lab_skills"
    t.text    "comp_skills"
    t.text    "gpa_comments"
    t.text    "learn",              :limit => 255
    t.text    "personal_statement"
    t.text    "created_at"
    t.text    "updated_at"
  end

  add_index "extras", ["id"], :name => "sqlite_autoindex_extras_1", :unique => true
  add_index "extras", ["user_id"], :name => "index_extras_on_user_id", :unique => true

  create_table "projects", :force => true do |t|
    t.text    "title",                  :limit => 255
    t.text    "participant",            :limit => 255
    t.text    "participant_university", :limit => 255
    t.text    "faculty_mentor",         :limit => 255
    t.integer "year",                   :limit => 11
    t.text    "created_at"
    t.text    "updated_at"
  end

  add_index "projects", ["id"], :name => "sqlite_autoindex_projects_1", :unique => true

  create_table "recommendations", :force => true do |t|
    t.integer "user_id",         :limit => 11
    t.integer "recommender_id",  :limit => 11
    t.text    "known_student",   :limit => 255
    t.text    "know_capacity",   :limit => 255
    t.text    "rating",          :limit => 255
    t.text    "gpa",             :limit => 255
    t.text    "gpa_range",       :limit => 255
    t.text    "undergrad_inst",  :limit => 255
    t.text    "faculty_comment"
    t.text    "created_at"
    t.text    "updated_at"
  end

  add_index "recommendations", ["id"], :name => "sqlite_autoindex_recommendations_1", :unique => true
  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id", :unique => true

  create_table "recommenders", :force => true do |t|
    t.integer "user_id",      :limit => 11
    t.text    "name",         :limit => 255
    t.text    "title",        :limit => 255
    t.text    "department",   :limit => 255
    t.text    "college",      :limit => 255
    t.text    "phone",        :limit => 255
    t.text    "email",        :limit => 255
    t.integer "waive_rights", :limit => 1
    t.text    "created_at"
    t.text    "updated_at"
  end

  add_index "recommenders", ["id"], :name => "sqlite_autoindex_recommenders_1", :unique => true
  add_index "recommenders", ["user_id"], :name => "index_recommenders_on_user_id", :unique => true

  create_table "roles", :force => true do |t|
    t.text "name",       :limit => 255
    t.text "created_at"
    t.text "updated_at"
  end

  add_index "roles", ["id"], :name => "sqlite_autoindex_roles_1", :unique => true

  create_table "users", :force => true do |t|
    t.text     "login",                       :limit => 100
    t.text     "firstname",                   :limit => 100
    t.text     "middlename",                  :limit => 100
    t.text     "lastname",                    :limit => 100
    t.text     "email",                       :limit => 100
    t.text     "dob"
    t.text     "street",                      :limit => 255
    t.text     "city",                        :limit => 255
    t.text     "state",                       :limit => 255
    t.text     "zip",                         :limit => 255
    t.text     "phone",                       :limit => 255
    t.text     "pstreet",                     :limit => 255
    t.text     "pcity",                       :limit => 255
    t.text     "pstate",                      :limit => 255
    t.text     "pzip",                        :limit => 255
    t.text     "pphone",                      :limit => 255
    t.text     "citizenship",                 :limit => 255
    t.text     "cresidence",                  :limit => 255
    t.text     "gender",                      :limit => 255
    t.text     "ethnicity",                   :limit => 255
    t.text     "race",                        :limit => 255
    t.text     "disability",                  :limit => 255
    t.text     "activated_at"
    t.text     "submitted_at"
    t.text     "rec_request_at"
    t.text     "completed_at"
    t.text     "token",                       :limit => 255
    t.text     "token_created_at"
    t.text     "remember_token",              :limit => 40
    t.text     "remember_token_expires_at"
    t.text     "crypted_password",            :limit => 40
    t.text     "salt",                        :limit => 40
    t.text     "status",                      :limit => 255
    t.integer  "role_id",                     :limit => 11
    t.text     "created_at"
    t.text     "updated_at"
    t.datetime "emailed_rejection_letter_at"
    t.datetime "emailed_waitlist_letter_at"
  end

  add_index "users", ["id"], :name => "sqlite_autoindex_users_1", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
