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

ActiveRecord::Schema.define(version: 20150831212752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "city"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zip_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "days", ["event_id"], name: "index_days_on_event_id", using: :btree

  create_table "dinners", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "price"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unique_id"
  end

  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree
  add_index "events", ["unique_id"], name: "index_events_on_unique_id", using: :btree

  create_table "nights", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_days", force: true do |t|
    t.integer  "participant_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participant_days", ["day_id"], name: "index_participant_days_on_day_id", using: :btree
  add_index "participant_days", ["participant_id"], name: "index_participant_days_on_participant_id", using: :btree

  create_table "participant_dinners", force: true do |t|
    t.integer  "participant_id"
    t.integer  "dinner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participant_dinners", ["dinner_id"], name: "index_participant_dinners_on_dinner_id", using: :btree
  add_index "participant_dinners", ["participant_id"], name: "index_participant_dinners_on_participant_id", using: :btree

  create_table "participant_nights", force: true do |t|
    t.integer  "participant_id"
    t.integer  "night_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participant_nights", ["night_id"], name: "index_participant_nights_on_night_id", using: :btree
  add_index "participant_nights", ["participant_id"], name: "index_participant_nights_on_participant_id", using: :btree

  create_table "participant_services", force: true do |t|
    t.integer "participant_id"
    t.integer "service_id"
  end

  add_index "participant_services", ["participant_id"], name: "index_participant_services_on_participant_id", using: :btree
  add_index "participant_services", ["service_id"], name: "index_participant_services_on_service_id", using: :btree

  create_table "participants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.integer  "cost"
    t.float    "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "gender"
    t.datetime "payment_deadline"
    t.boolean  "archived",         default: false
    t.boolean  "arrived",          default: false
    t.integer  "event_id"
  end

  add_index "participants", ["event_id"], name: "index_participants_on_event_id", using: :btree
  add_index "participants", ["role_id"], name: "index_participants_on_role_id", using: :btree

  create_table "price_tables", force: true do |t|
    t.string  "name"
    t.integer "days"
    t.integer "day1"
    t.integer "day2"
    t.integer "day3"
    t.integer "night"
    t.integer "dinner"
  end

  create_table "pricing_periods", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "event_id"
  end

  add_index "pricing_periods", ["event_id"], name: "index_pricing_periods_on_event_id", using: :btree

  create_table "roles", force: true do |t|
    t.string  "name"
    t.integer "price_table_id"
  end

  add_index "roles", ["price_table_id"], name: "index_roles_on_price_table_id", using: :btree

  create_table "service_groups", force: true do |t|
    t.string "name"
  end

  create_table "services", force: true do |t|
    t.string  "name"
    t.decimal "price"
    t.integer "service_group_id"
    t.integer "event_id"
  end

  add_index "services", ["event_id"], name: "index_services_on_event_id", using: :btree
  add_index "services", ["service_group_id"], name: "index_services_on_service_group_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
