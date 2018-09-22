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

ActiveRecord::Schema.define(version: 20180922231837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "token", null: false
    t.string "username"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_token"
    t.datetime "expires_at"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "gmail_watches", force: :cascade do |t|
    t.datetime "expires_at", null: false
    t.string "current_history_id", null: false
    t.string "email_address", null: false
    t.bigint "authentication_id", null: false
    t.index ["authentication_id"], name: "index_gmail_watches_on_authentication_id", unique: true
    t.index ["email_address"], name: "index_gmail_watches_on_email_address"
  end

  create_table "packages", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "tracking_number", null: false
    t.string "carrier", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "easypost_tracking_id", null: false
    t.text "status", null: false
    t.date "estimated_delivery_date"
    t.index ["easypost_tracking_id"], name: "index_packages_on_easypost_tracking_id"
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "tracking_updates", id: :serial, force: :cascade do |t|
    t.integer "package_id", null: false
    t.text "message", null: false
    t.text "status", null: false
    t.datetime "tracking_updated_at"
    t.text "city"
    t.text "state"
    t.text "country"
    t.text "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id", "tracking_updated_at", "status"], name: "index_tracking_update_on_uniqueness", unique: true
    t.index ["package_id"], name: "index_tracking_updates_on_package_id"
    t.index ["tracking_updated_at"], name: "index_tracking_updates_on_tracking_updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "gmail_watches", "authentications"
  add_foreign_key "packages", "users"
  add_foreign_key "tracking_updates", "packages"
end
