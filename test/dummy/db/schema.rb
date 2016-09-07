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

ActiveRecord::Schema.define(version: 20160907115040) do

  create_table "booking_blocked_days", force: :cascade do |t|
    t.date    "blocked_from_date"
    t.date    "blocked_to_date"
    t.boolean "permanent"
    t.integer "occurance"
  end

  create_table "booking_customer_reservations", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "customer_id"
    t.integer  "reservation_id"
  end

  create_table "booking_customers", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_reservations", force: :cascade do |t|
    t.float    "total_price"
    t.integer  "single_service_reservation_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "booking_service_calendars", force: :cascade do |t|
    t.integer  "service_type_ID"
    t.integer  "availability"
    t.integer  "reservation"
    t.float    "rate"
    t.date     "date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "booking_service_type_reservations", force: :cascade do |t|
    t.datetime "check_in"
    t.datetime "check_out"
    t.datetime "date"
    t.float    "single_res_price"
    t.integer  "occupancy"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "service_type_id"
    t.integer  "reservation_id"
  end

  create_table "booking_service_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_occupancy"
    t.float    "price"
    t.integer  "availability"
    t.text     "description"
    t.date     "available_from"
    t.date     "available_to"
    t.float    "default_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "special_price"
    t.integer  "duration"
    t.boolean  "multiple_day"
  end

  create_table "booking_todays_bookings", force: :cascade do |t|
    t.date     "date"
    t.integer  "service_type_ID"
    t.integer  "reservation_ID"
    t.integer  "customer_ID"
    t.float    "rate"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
