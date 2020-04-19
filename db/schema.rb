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

ActiveRecord::Schema.define(version: 2019_10_26_193354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "club_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "club_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_id"], name: "index_club_requests_on_club_id"
    t.index ["user_id"], name: "index_club_requests_on_user_id"
  end

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
    t.index ["name"], name: "index_clubs_on_name", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.integer "tmdb_genre_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "join_genre_to_movies", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_join_genre_to_movies_on_genre_id"
    t.index ["movie_id", "genre_id"], name: "index_join_genre_to_movies_on_movie_id_and_genre_id", unique: true
    t.index ["movie_id"], name: "index_join_genre_to_movies_on_movie_id"
  end

  create_table "join_list_to_movies", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "movie_id", null: false
    t.float "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["list_id"], name: "index_join_list_to_movies_on_list_id"
    t.index ["movie_id", "list_id"], name: "index_join_list_to_movies_on_movie_id_and_list_id", unique: true
    t.index ["movie_id"], name: "index_join_list_to_movies_on_movie_id"
  end

  create_table "join_movie_to_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_join_movie_to_users_on_movie_id"
    t.index ["user_id"], name: "index_join_movie_to_users_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_lists_on_name", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "year"
    t.string "imdb_id"
    t.string "description"
    t.string "poster"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "omdb_checked_date"
    t.string "rated"
    t.string "runtime"
    t.text "plot"
    t.string "language"
    t.string "country"
    t.string "production"
    t.string "awards"
    t.string "director"
    t.string "writer"
    t.text "actors"
    t.jsonb "ratings", default: "{}"
    t.date "tmdb_checked_date"
    t.date "guidebox_checked_date"
    t.integer "guidebox_id"
    t.jsonb "sources", default: "{}"
    t.index ["title", "imdb_id"], name: "index_movies_on_title_and_imdb_id", unique: true
  end

  create_table "nominations", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_nominations_on_movie_id"
    t.index ["poll_id", "movie_id"], name: "index_nominations_on_poll_id_and_movie_id", unique: true
    t.index ["poll_id"], name: "index_nominations_on_poll_id"
    t.index ["user_id"], name: "index_nominations_on_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.bigint "viewing_id", null: false
    t.bigint "movie_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_polls_on_movie_id"
    t.index ["viewing_id"], name: "index_polls_on_viewing_id"
  end

  create_table "seenlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_seenlists_on_movie_id"
    t.index ["user_id"], name: "index_seenlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
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

  add_foreign_key "club_requests", "clubs"
  add_foreign_key "club_requests", "users"
  add_foreign_key "club_users", "clubs"
  add_foreign_key "club_users", "users"
  add_foreign_key "join_genre_to_movies", "genres"
  add_foreign_key "join_genre_to_movies", "movies"
  add_foreign_key "join_list_to_movies", "lists"
  add_foreign_key "join_list_to_movies", "movies"
  add_foreign_key "join_movie_to_users", "movies"
  add_foreign_key "join_movie_to_users", "users"
  add_foreign_key "nominations", "movies"
  add_foreign_key "nominations", "polls"
  add_foreign_key "nominations", "users"
  add_foreign_key "polls", "movies"
  add_foreign_key "polls", "viewings"
  add_foreign_key "seenlists", "movies"
  add_foreign_key "seenlists", "users"
  add_foreign_key "viewings", "clubs"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "users"
  add_foreign_key "watchlists", "movies"
  add_foreign_key "watchlists", "users"
end
