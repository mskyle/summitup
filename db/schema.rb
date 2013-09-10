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

ActiveRecord::Schema.define(version: 20130909201223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mountains", force: true do |t|
    t.string   "name"
    t.integer  "height"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mountains_lists", id: false, force: true do |t|
    t.integer "mountain_id"
    t.integer "list_id"
  end

  create_table "trip_mountains", id: false, force: true do |t|
    t.integer "mountain_id"
    t.integer "trip_id"
  end

  create_table "trip_participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.string   "trail"
    t.integer  "book_time"
    t.integer  "actual_time"
    t.integer  "hike_difficulty"
    t.integer  "hike_awesomeness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "trailname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

end
