# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_08_150052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "club_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "club_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_id"], name: "index_club_users_on_club_id"
    t.index ["user_id"], name: "index_club_users_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "year"
    t.string "imdbID"
    t.string "description"
    t.string "poster"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_movies_on_title", unique: true
  end

  create_table "nominations", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_nominations_on_movie_id"
    t.index ["poll_id", "user_id"], name: "index_nominations_on_poll_id_and_user_id", unique: true
    t.index ["poll_id"], name: "index_nominations_on_poll_id"
    t.index ["user_id"], name: "index_nominations_on_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.bigint "viewing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["viewing_id"], name: "index_polls_on_viewing_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "viewings", force: :cascade do |t|
    t.datetime "datetime"
    t.bigint "club_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_id"], name: "index_viewings_on_club_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "user_id", null: false
    t.jsonb "choices", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  create_table "watchlists", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_watchlists_on_movie_id"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "club_users", "clubs"
  add_foreign_key "club_users", "users"
  add_foreign_key "nominations", "movies"
  add_foreign_key "nominations", "polls"
  add_foreign_key "nominations", "users"
  add_foreign_key "polls", "viewings"
  add_foreign_key "viewings", "clubs"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "users"
  add_foreign_key "watchlists", "movies"
  add_foreign_key "watchlists", "users"
end
