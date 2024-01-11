# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_11_083621) do
  create_table "movie_actors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_countries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_directors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_generes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "genere"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_genres", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "genre"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_writers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "imdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", primary_key: "imdb_id", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "awards"
    t.string "imdb_rating"
    t.string "imdb_votes"
    t.string "media_type"
    t.string "metascore"
    t.text "plot"
    t.text "poster"
    t.string "rated"
    t.string "released"
    t.string "runtime"
    t.string "title"
    t.string "total_seasons"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "email", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
