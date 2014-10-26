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

ActiveRecord::Schema.define(version: 20141026234311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: true do |t|
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

  create_table "participants", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "age"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.integer  "cost"
    t.float    "paid"
    t.integer  "role_id"
    t.integer  "nights"
    t.integer  "dinners"
    t.boolean  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "roles", force: true do |t|
    t.string  "name"
    t.integer "price_table_id"
  end

  add_index "roles", ["price_table_id"], name: "index_roles_on_price_table_id", using: :btree

end
