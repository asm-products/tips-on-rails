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

ActiveRecord::Schema.define(version: 20150218025117) do

  create_table "bookmarks", force: true do |t|
    t.integer  "tip_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.integer  "tip_id"
    t.text     "body_cached"
    t.integer  "bookmarks_count", default: 0, null: false
    t.string   "slug"
  end

  add_index "tips", ["slug"], name: "index_tips_on_slug", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",              default: "",    null: false
    t.string   "encrypted_password", default: "",    null: false
    t.integer  "sign_in_count",      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.integer  "bookmarks_count",    default: 0,     null: false
    t.integer  "tips_count",         default: 0,     null: false
    t.boolean  "admin",              default: false
    t.string   "username",                           null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
