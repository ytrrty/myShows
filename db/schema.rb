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

ActiveRecord::Schema.define(version: 20150309202202) do

  create_table "comments", force: :cascade do |t|
    t.text     "body",             limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "comments_id",      limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["comments_id"], name: "index_comments_on_comments_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "episodes", force: :cascade do |t|
    t.string  "name",           limit: 255,               null: false
    t.text    "about",          limit: 65535,             null: false
    t.date    "released"
    t.float   "rate_imdb",      limit: 24
    t.integer "show_id",        limit: 4
    t.integer "season",         limit: 4,                 null: false
    t.integer "number",         limit: 4,                 null: false
    t.integer "comments_count", limit: 4,     default: 0
    t.string  "photo",          limit: 255
    t.string  "photo_orig",     limit: 255
  end

  add_index "episodes", ["show_id"], name: "fk_rails_5a2eb758b9", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "shows", force: :cascade do |t|
    t.string  "name",           limit: 255,                null: false
    t.string  "status",         limit: 255,   default: "", null: false
    t.date    "start_date"
    t.date    "finish_date"
    t.text    "about",          limit: 65535,              null: false
    t.integer "seasons_count",  limit: 4,     default: 0,  null: false
    t.integer "runtime",        limit: 4,     default: 0,  null: false
    t.float   "rate_imdb",      limit: 24
    t.integer "comments_count", limit: 4,     default: 0,  null: false
    t.string  "photo",          limit: 255
    t.string  "photo_orig",     limit: 255
  end

  create_table "shows_genres", force: :cascade do |t|
    t.integer "show_id",  limit: 4
    t.integer "genre_id", limit: 4
  end

  add_index "shows_genres", ["genre_id"], name: "fk_rails_62dd371099", using: :btree
  add_index "shows_genres", ["show_id"], name: "fk_rails_86f4ad6cd5", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",                  limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.integer  "access",                 limit: 4,   default: 0,  null: false
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
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

  create_table "users_episodes", force: :cascade do |t|
    t.integer "episode_id", limit: 4
    t.integer "user_id",    limit: 4
    t.boolean "favorite",   limit: 1, default: false
  end

  add_index "users_episodes", ["episode_id"], name: "fk_rails_3c48ff33f0", using: :btree
  add_index "users_episodes", ["user_id"], name: "fk_rails_1967e0de0d", using: :btree

  create_table "users_shows", force: :cascade do |t|
    t.integer "user_id",     limit: 4
    t.integer "show_id",     limit: 4
    t.string  "show_status", limit: 255
    t.boolean "favorite",    limit: 1,   default: false
  end

  add_index "users_shows", ["show_id"], name: "fk_rails_892183c1e7", using: :btree
  add_index "users_shows", ["user_id"], name: "fk_rails_21a9d73691", using: :btree

  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "shows"
  add_foreign_key "shows_genres", "genres"
  add_foreign_key "shows_genres", "shows"
  add_foreign_key "users_episodes", "episodes"
  add_foreign_key "users_episodes", "users"
  add_foreign_key "users_shows", "shows"
  add_foreign_key "users_shows", "users"
end
