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

ActiveRecord::Schema.define(version: 20170121230346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "tracking_number",         null: false
    t.string   "carrier",                 null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "easypost_tracking_id",    null: false
    t.text     "status",                  null: false
    t.date     "estimated_delivery_date"
    t.index ["easypost_tracking_id"], name: "index_packages_on_easypost_tracking_id", using: :btree
    t.index ["user_id"], name: "index_packages_on_user_id", using: :btree
  end

  create_table "tracking_updates", force: :cascade do |t|
    t.integer  "package_id",          null: false
    t.text     "message",             null: false
    t.text     "status",              null: false
    t.datetime "tracking_updated_at", null: false
    t.text     "city"
    t.text     "state"
    t.text     "country"
    t.text     "zip"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["package_id", "tracking_updated_at", "status"], name: "index_tracking_update_on_uniqueness", unique: true, using: :btree
    t.index ["package_id"], name: "index_tracking_updates_on_package_id", using: :btree
    t.index ["tracking_updated_at"], name: "index_tracking_updates_on_tracking_updated_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "packages", "users"
  add_foreign_key "tracking_updates", "packages"
end
