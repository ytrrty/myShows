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

ActiveRecord::Schema.define(version: 20150202083444) do

  create_table "episodes", force: :cascade do |t|
    t.string   "name",           limit: 255,               null: false
    t.text     "about",          limit: 65535,             null: false
    t.date     "released"
    t.float    "rate_imdb",      limit: 24
    t.float    "users_rate",     limit: 24
    t.integer  "comments_count", limit: 4,     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "shows", force: :cascade do |t|
    t.string  "status",         limit: 255,   default: "", null: false
    t.date    "start_date"
    t.date    "finish_date"
    t.string  "country",        limit: 255,   default: "", null: false
    t.string  "channel",        limit: 255,   default: "", null: false
    t.text    "about",          limit: 65535,              null: false
    t.integer "seasons_count",  limit: 4,     default: 0,  null: false
    t.integer "runtime",        limit: 4,     default: 0,  null: false
    t.float   "rate_imdb",      limit: 24
    t.float   "rate_users",     limit: 24
    t.integer "comments_count", limit: 4,     default: 0,  null: false
  end

  create_table "shows_episodes", force: :cascade do |t|
    t.integer "show_id",     limit: 4
    t.integer "episode_id",  limit: 4
    t.integer "user_id",     limit: 4
    t.string  "show_status", limit: 255
    t.boolean "favorite",    limit: 1,   default: false
  end

  add_index "shows_episodes", ["episode_id"], name: "index_shows_episodes_on_episode_id", using: :btree
  add_index "shows_episodes", ["show_id"], name: "index_shows_episodes_on_show_id", using: :btree
  add_index "shows_episodes", ["user_id"], name: "index_shows_episodes_on_user_id", using: :btree

  create_table "user_shows", force: :cascade do |t|
    t.integer "user_id",     limit: 4
    t.integer "show_id",     limit: 4
    t.string  "show_status", limit: 255
    t.boolean "favorite",    limit: 1,   default: false
  end

  add_index "user_shows", ["show_id"], name: "index_user_shows_on_show_id", using: :btree
  add_index "user_shows", ["user_id"], name: "index_user_shows_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",                  limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "photo",                  limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "shows_episodes", "episodes"
  add_foreign_key "shows_episodes", "shows"
  add_foreign_key "shows_episodes", "users"
  add_foreign_key "user_shows", "shows"
  add_foreign_key "user_shows", "users"
end
