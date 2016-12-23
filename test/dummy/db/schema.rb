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

ActiveRecord::Schema.define(version: 20161223071732) do

  create_table "booking_blocked_days", force: :cascade do |t|
    t.date    "blocked_from_date"
    t.date    "blocked_to_date"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.integer "service_type_id"
  end

  create_table "booking_categories", force: :cascade do |t|
    t.boolean "multiple_day"
    t.string  "name"
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
    t.integer  "day_availability"
    t.float    "day_rate"
    t.date     "date"
    t.integer  "service_type_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "special_availability"
    t.integer  "normal_availability"
  end

  create_table "booking_service_type_reservations", force: :cascade do |t|
    t.datetime "check_in"
    t.datetime "check_out"
    t.string   "date"
    t.integer  "occupancy"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "service_type_id"
    t.integer  "reservation_id"
    t.integer  "adult"
    t.integer  "child"
    t.time     "time"
  end

  create_table "booking_service_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_occupancy"
    t.integer  "availability"
    t.integer  "special_availability"
    t.text     "description"
    t.date     "available_from"
    t.date     "available_to"
    t.float    "special_price"
    t.float    "default_price"
    t.boolean  "booking_limit_bool"
    t.integer  "booking_limit"
    t.boolean  "adult_child_field"
    t.boolean  "adult_compulsory"
    t.integer  "max_adult_occupancy"
    t.integer  "max_child_occupancy"
    t.float    "duration"
    t.integer  "category_id"
    t.boolean  "special_mondays"
    t.float    "special_monday_price"
    t.boolean  "special_tuesdays"
    t.float    "special_tuesday_price"
    t.boolean  "special_wednesdays"
    t.float    "special_wednesday_price"
    t.boolean  "special_thursdays"
    t.float    "special_thursday_price"
    t.boolean  "special_fridays"
    t.float    "special_friday_price"
    t.boolean  "special_saturdays"
    t.float    "special_saturday_price"
    t.boolean  "special_sundays"
    t.float    "special_sunday_price"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "booking_timeslots", force: :cascade do |t|
    t.time    "time"
    t.integer "availability"
    t.float   "timeslot_cost"
    t.integer "service_type_id"
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

  create_table "booking_user_reservations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
  end

  add_index "booking_users", ["email"], name: "index_booking_users_on_email", unique: true
  add_index "booking_users", ["reset_password_token"], name: "index_booking_users_on_reset_password_token", unique: true

end
