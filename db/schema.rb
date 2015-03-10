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

ActiveRecord::Schema.define(version: 20150310032529) do

  create_table "browsers", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "genome"
    t.text     "description"
    t.string   "citation"
    t.text     "data_download"
  end

  add_index "browsers", ["user_id", "created_at"], name: "index_browsers_on_user_id_and_created_at"

  create_table "tracks", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "track_type"
    t.string   "path"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["user_id", "created_at"], name: "index_tracks_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "views", force: true do |t|
    t.integer  "linker_id"
    t.integer  "linked_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "views", ["linked_id"], name: "index_views_on_linked_id"
  add_index "views", ["linker_id", "linked_id"], name: "index_views_on_linker_id_and_linked_id", unique: true
  add_index "views", ["linker_id"], name: "index_views_on_linker_id"

end
