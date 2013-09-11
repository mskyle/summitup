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

ActiveRecord::Schema.define(version: 20130911230014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mountains", force: true do |t|
    t.string   "name",       null: false
    t.integer  "height",     null: false
    t.decimal  "latitude",   null: false
    t.decimal  "longitude",  null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_mountains", force: true do |t|
    t.integer  "mountain_id", null: false
    t.integer  "trip_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.date     "date",             null: false
    t.string   "title",            null: false
    t.text     "note"
    t.text     "trails"
    t.integer  "book_time"
    t.integer  "actual_time"
    t.decimal  "distance"
    t.integer  "hike_difficulty"
    t.integer  "hike_awesomeness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
