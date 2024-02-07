class AddForeignKeyToTables < ActiveRecord::Migration[7.0]
  def up
    add_foreign_key :favorite_movies, :users
    add_foreign_key :favorite_movies, :movies

    add_foreign_key :favorite_movie_notifications, :users
    add_foreign_key :favorite_movie_notifications, :movies

    add_foreign_key :movie_actors, :movies
    add_foreign_key :movie_countries, :movies
    add_foreign_key :movie_directors, :movies
    add_foreign_key :movie_genres, :movies
    add_foreign_key :movie_languages, :movies
    add_foreign_key :movie_ratings, :movies
    add_foreign_key :movie_writers, :movies
  end

  def down
    remove_foreign_key :favorite_movies, :users
    remove_foreign_key :favorite_movies, :movies

    remove_foreign_key :favorite_movie_notifications, :users
    remove_foreign_key :favorite_movie_notifications, :movies

    remove_foreign_key :movie_actors, :movies
    remove_foreign_key :movie_countries, :movies
    remove_foreign_key :movie_directors, :movies
    remove_foreign_key :movie_genres, :movies
    remove_foreign_key :movie_languages, :movies
    remove_foreign_key :movie_ratings, :movies
    remove_foreign_key :movie_writers, :movies
  end
end
