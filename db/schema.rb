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

ActiveRecord::Schema.define(version: 20190605140909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",                null: false
    t.datetime "expiry_time",            null: false
    t.string   "token",       limit: 20, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "user_idx", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                 limit: 127, null: false
    t.string   "email",                limit: 127, null: false
    t.string   "phone_no",             limit: 127, null: false
    t.string   "status",               limit: 127, null: false
    t.string   "company_name",         limit: 127, null: false
    t.string   "password",             limit: 127, null: false
    t.string   "user_profile_pic_url"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["email"], name: "users_email_idx", unique: true, using: :btree
  end

  add_foreign_key "sessions", "users"
end
