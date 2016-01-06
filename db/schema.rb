# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141126234350) do

  create_table "academic_records", force: true do |t|
    t.string   "university"
    t.date     "start"
    t.date     "finish"
    t.string   "degree"
    t.float    "gpa",                     limit: 24
    t.float    "gpa_range",               limit: 24, default: 4.0
    t.text     "gpa_comment"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transcript_file_name"
    t.string   "transcript_content_type"
    t.integer  "transcript_file_size"
    t.datetime "transcript_updated_at"
    t.string   "major"
    t.string   "minor"
  end

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "label"
    t.string   "permanent"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.date     "dob"
    t.string   "citizenship"
    t.string   "disability"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "race"
    t.string   "academic_level"
    t.text     "lab_skills"
    t.text     "cpu_skills"
    t.text     "statement"
    t.datetime "submitted_at"
    t.datetime "completed_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "gpa_comment"
  end

  add_index "applicants", ["authentication_token"], name: "index_applicants_on_authentication_token", unique: true, using: :btree
  add_index "applicants", ["confirmation_token"], name: "index_applicants_on_confirmation_token", unique: true, using: :btree
  add_index "applicants", ["email"], name: "index_applicants_on_email", unique: true, using: :btree
  add_index "applicants", ["reset_password_token"], name: "index_applicants_on_reset_password_token", unique: true, using: :btree
  add_index "applicants", ["unlock_token"], name: "index_applicants_on_unlock_token", unique: true, using: :btree

  create_table "awards", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "description"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "recommendations", force: true do |t|
    t.integer  "known_applicant_for"
    t.string   "known_capacity"
    t.string   "overall_promise"
    t.string   "undergraduate_institution"
    t.text     "body"
    t.string   "token"
    t.datetime "token_created_at"
    t.datetime "request_sent_at"
    t.datetime "received_at"
    t.integer  "applicant_id"
    t.integer  "recommender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["applicant_id"], name: "index_recommendations_on_applicant_id", using: :btree
  add_index "recommendations", ["recommender_id"], name: "index_recommendations_on_recommender_id", using: :btree

  create_table "recommenders", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "department"
    t.string   "organization"
    t.string   "url"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
    t.string   "rich_file_file_alt"
    t.string   "rich_file_file_title"
  end

  create_table "settings", force: true do |t|
    t.string   "name",        default: "", null: false
    t.text     "description"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["name"], name: "index_settings_on_name", using: :btree

  create_table "snippets", force: true do |t|
    t.string   "name",        default: "", null: false
    t.text     "description"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
