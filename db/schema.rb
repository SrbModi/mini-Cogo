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

ActiveRecord::Schema.define(version: 20190606130111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "postgis"

  create_table "bookings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",                        null: false
    t.uuid     "origin_port_id",                 null: false
    t.uuid     "destination_port_id",            null: false
    t.integer  "result_id",                      null: false
    t.integer  "price",                          null: false
    t.string   "status",              limit: 32, null: false
    t.string   "currency",            limit: 4,  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["destination_port_id"], name: "destination_port_id_idx", using: :btree
    t.index ["origin_port_id"], name: "origin_port_id_idx", using: :btree
    t.index ["user_id"], name: "user_id_idx", using: :btree
  end

# Could not dump table "locations" because of following StandardError
#   Unknown type 'geography(Point,4326)' for column 'lonlat'

  create_table "sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",                null: false
    t.datetime "expiry_time",            null: false
    t.string   "token",       limit: 20, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "user_idx", using: :btree
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
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

  add_foreign_key "bookings", "locations", column: "destination_port_id"
  add_foreign_key "bookings", "locations", column: "origin_port_id"
  add_foreign_key "bookings", "users"
  add_foreign_key "sessions", "users"
end
