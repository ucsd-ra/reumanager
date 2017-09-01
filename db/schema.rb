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

ActiveRecord::Schema.define(version: 20170901200320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_records", id: :serial, force: :cascade do |t|
    t.string "university", limit: 255
    t.date "start"
    t.date "finish"
    t.string "degree", limit: 255
    t.float "gpa"
    t.float "gpa_range", default: 4.0
    t.text "gpa_comment"
    t.integer "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "transcript_file_name", limit: 255
    t.string "transcript_content_type", limit: 255
    t.integer "transcript_file_size"
    t.datetime "transcript_updated_at"
    t.string "major", limit: 255
    t.string "minor", limit: 255
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "address", limit: 255
    t.string "address2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.string "country", limit: 255
    t.string "label", limit: 255
    t.string "permanent", limit: 255
    t.integer "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_accounts", force: :cascade do |t|
    t.string "admin1_email"
    t.string "admin1_pwd"
    t.string "admin2_email"
    t.string "admin2_pwd"
    t.string "admin3_email"
    t.string "admin3_pwd"
    t.string "admin4_email"
    t.string "admin4_pwd"
    t.string "admin5_email"
    t.string "admin5_pwd"
    t.bigint "grant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_id"], name: "index_admin_accounts_on_grant_id"
  end

  create_table "applicants", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "phone", limit: 255
    t.date "dob"
    t.string "citizenship", limit: 255
    t.string "disability", limit: 255
    t.string "gender", limit: 255
    t.string "ethnicity", limit: 255
    t.string "race", limit: 255
    t.string "academic_level", limit: 255
    t.text "lab_skills"
    t.text "cpu_skills"
    t.text "statement"
    t.datetime "submitted_at"
    t.datetime "completed_at"
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.integer "failed_attempts", default: 0
    t.string "unlock_token", limit: 255
    t.datetime "locked_at"
    t.string "authentication_token", limit: 255
    t.string "state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "gpa_comment"
    t.index ["authentication_token"], name: "index_applicants_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_applicants_on_confirmation_token", unique: true
    t.index ["email"], name: "index_applicants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_applicants_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_applicants_on_unlock_token", unique: true
  end

  create_table "awards", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.date "date"
    t.text "description"
    t.integer "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grant_settings", force: :cascade do |t|
    t.string "institute"
    t.string "department"
    t.string "department_postal_address"
    t.date "application_start"
    t.date "application_deadline"
    t.date "notification_date"
    t.date "program_start_date"
    t.date "program_end_date"
    t.date "checkback_date"
    t.string "mail_from"
    t.string "funded_by"
    t.string "main_url"
    t.string "department_url"
    t.string "program_url"
    t.bigint "grant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_id"], name: "index_grant_settings_on_grant_id"
  end

  create_table "grant_snippets", force: :cascade do |t|
    t.text "general_desc"
    t.text "highlights"
    t.text "eligibility"
    t.bigint "grant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_id"], name: "index_grant_snippets_on_grant_id"
  end

  create_table "grants", id: :serial, force: :cascade do |t|
    t.string "program_title", limit: 255
    t.string "subdomain", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "contact_email"
    t.string "contact_password"
  end

  create_table "rails_admin_histories", id: :serial, force: :cascade do |t|
    t.text "message"
    t.string "username", limit: 255
    t.integer "item"
    t.string "table", limit: 255
    t.integer "month", limit: 2
    t.bigint "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories"
  end

  create_table "recommendations", id: :serial, force: :cascade do |t|
    t.integer "known_applicant_for"
    t.string "known_capacity", limit: 255
    t.string "overall_promise", limit: 255
    t.string "undergraduate_institution", limit: 255
    t.text "body"
    t.string "token", limit: 255
    t.datetime "token_created_at"
    t.datetime "request_sent_at"
    t.datetime "received_at"
    t.integer "applicant_id"
    t.integer "recommender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["applicant_id"], name: "index_recommendations_on_applicant_id"
    t.index ["recommender_id"], name: "index_recommendations_on_recommender_id"
  end

  create_table "recommenders", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "title", limit: 255
    t.string "department", limit: 255
    t.string "organization", limit: 255
    t.string "url", limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rich_rich_files", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "rich_file_file_name", limit: 255
    t.string "rich_file_content_type", limit: 255
    t.integer "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string "owner_type", limit: 255
    t.integer "owner_id"
    t.text "uri_cache"
    t.string "simplified_type", limit: 255, default: "file"
    t.string "rich_file_file_alt", limit: 255
    t.string "rich_file_file_title", limit: 255
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.text "description"
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grant_id"
    t.index ["name"], name: "index_settings_on_name"
  end

  create_table "snippets", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.text "description"
    t.text "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grant_id"
  end

  create_table "universities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "subdomain", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.integer "failed_attempts", default: 0
    t.string "unlock_token", limit: 255
    t.datetime "locked_at"
    t.string "authentication_token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "grant_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "admin_accounts", "grants"
  add_foreign_key "grant_settings", "grants"
  add_foreign_key "grant_snippets", "grants"
end
