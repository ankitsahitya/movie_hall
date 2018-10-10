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

ActiveRecord::Schema.define(version: 20181010165111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audis", force: :cascade do |t|
    t.integer  "theater_id"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "audis", ["theater_id"], name: "index_audis_on_theater_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "theater_id"
    t.integer  "show_time_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bookings", ["show_time_id"], name: "index_bookings_on_show_time_id", using: :btree
  add_index "bookings", ["theater_id"], name: "index_bookings_on_theater_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "show_times", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "audi_id"
    t.time     "time_of_show"
    t.date     "date_of_show"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "show_times", ["audi_id"], name: "index_show_times_on_audi_id", using: :btree
  add_index "show_times", ["movie_id"], name: "index_show_times_on_movie_id", using: :btree

  create_table "theaters", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "audi_id"
    t.string   "type_of_seat"
    t.integer  "seat_no"
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tickets", ["audi_id"], name: "index_tickets_on_audi_id", using: :btree
  add_index "tickets", ["booking_id"], name: "index_tickets_on_booking_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "phone_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "audis", "theaters"
  add_foreign_key "bookings", "show_times"
  add_foreign_key "bookings", "theaters"
  add_foreign_key "bookings", "users"
  add_foreign_key "show_times", "audis"
  add_foreign_key "show_times", "movies"
  add_foreign_key "tickets", "audis"
  add_foreign_key "tickets", "bookings"
end
