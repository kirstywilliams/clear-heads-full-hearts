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

ActiveRecord::Schema.define(version: 20150312185716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sport"
    t.string   "position"
    t.string   "nationality"
    t.string   "team"
    t.string   "src",         null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "athletes", ["nationality"], name: "index_athletes_on_nationality", using: :btree
  add_index "athletes", ["sport"], name: "index_athletes_on_sport", using: :btree
  add_index "athletes", ["team"], name: "index_athletes_on_team", using: :btree

  create_table "twitter_handles", force: :cascade do |t|
    t.integer  "athlete_id"
    t.string   "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "twitter_handles", ["athlete_id"], name: "index_twitter_handles_on_athlete_id", using: :btree
  add_index "twitter_handles", ["handle"], name: "index_twitter_handles_on_handle", using: :btree

end
