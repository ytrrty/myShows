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

ActiveRecord::Schema.define(version: 2015_03_09_202202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "comments_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["comments_id"], name: "index_comments_on_comments_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "about", null: false
    t.date "released"
    t.float "rate_imdb"
    t.integer "show_id"
    t.integer "season", null: false
    t.integer "number", null: false
    t.integer "comments_count", default: 0
    t.string "photo"
    t.string "photo_orig"
  end

  create_table "genres", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "rates", id: :serial, force: :cascade do |t|
    t.integer "rater_id"
    t.string "rateable_type"
    t.integer "rateable_id"
    t.float "stars", null: false
    t.string "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
    t.index ["rater_id"], name: "index_rates_on_rater_id"
  end

  create_table "rating_caches", id: :serial, force: :cascade do |t|
    t.string "cacheable_type"
    t.integer "cacheable_id"
    t.float "avg", null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"
  end

  create_table "shows", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "", null: false
    t.date "start_date"
    t.date "finish_date"
    t.text "about", null: false
    t.integer "seasons_count", default: 0, null: false
    t.integer "runtime", default: 0, null: false
    t.float "rate_imdb"
    t.integer "comments_count", default: 0, null: false
    t.string "photo"
    t.string "photo_orig"
  end

  create_table "shows_genres", id: :serial, force: :cascade do |t|
    t.integer "show_id"
    t.integer "genre_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "access", default: 0, null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_episodes", id: :serial, force: :cascade do |t|
    t.integer "episode_id"
    t.integer "user_id"
    t.boolean "favorite", default: false
  end

  create_table "users_shows", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "show_id"
    t.string "show_status"
    t.boolean "favorite", default: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "shows"
  add_foreign_key "shows_genres", "genres"
  add_foreign_key "shows_genres", "shows"
  add_foreign_key "users_episodes", "episodes"
  add_foreign_key "users_episodes", "users"
  add_foreign_key "users_shows", "shows"
  add_foreign_key "users_shows", "users"
end
