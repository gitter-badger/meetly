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

ActiveRecord::Schema.define(version: 20150927211814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "day_prices", force: true do |t|
    t.decimal  "price"
    t.integer  "day_id"
    t.integer  "role_id"
    t.integer  "pricing_period_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "day_prices", ["day_id"], name: "index_day_prices_on_day_id", using: :btree
  add_index "day_prices", ["pricing_period_id"], name: "index_day_prices_on_pricing_period_id", using: :btree
  add_index "day_prices", ["role_id"], name: "index_day_prices_on_role_id", using: :btree

  create_table "days", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "days", ["event_id"], name: "index_days_on_event_id", using: :btree

  create_table "event_prices", force: true do |t|
    t.decimal  "price"
    t.integer  "pricing_period_id"
    t.integer  "event_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_prices", ["event_id"], name: "index_event_prices_on_event_id", using: :btree
  add_index "event_prices", ["pricing_period_id"], name: "index_event_prices_on_pricing_period_id", using: :btree
  add_index "event_prices", ["role_id"], name: "index_event_prices_on_role_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "price"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unique_id"
    t.integer  "capacity"
  end

  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree
  add_index "events", ["unique_id"], name: "index_events_on_unique_id", using: :btree

  create_table "participant_days", force: true do |t|
    t.integer  "participant_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participant_days", ["day_id"], name: "index_participant_days_on_day_id", using: :btree
  add_index "participant_days", ["participant_id"], name: "index_participant_days_on_participant_id", using: :btree

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
    t.float    "paid",             default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.datetime "payment_deadline"
    t.integer  "event_id"
    t.integer  "gender"
    t.integer  "status",           default: 0
  end

  add_index "participants", ["event_id"], name: "index_participants_on_event_id", using: :btree
  add_index "participants", ["role_id"], name: "index_participants_on_role_id", using: :btree

  create_table "pricing_periods", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "event_id"
  end

  add_index "pricing_periods", ["event_id"], name: "index_pricing_periods_on_event_id", using: :btree

  create_table "roles", force: true do |t|
    t.string  "name"
    t.integer "event_id"
  end

  add_index "roles", ["event_id"], name: "index_roles_on_event_id", using: :btree

  create_table "service_groups", force: true do |t|
    t.string "name"
  end

  create_table "service_prices", force: true do |t|
    t.decimal  "price"
    t.integer  "service_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_prices", ["role_id"], name: "index_service_prices_on_role_id", using: :btree
  add_index "service_prices", ["service_id"], name: "index_service_prices_on_service_id", using: :btree

  create_table "services", force: true do |t|
    t.string  "name"
    t.integer "service_group_id"
    t.integer "event_id"
    t.integer "limit"
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

end
