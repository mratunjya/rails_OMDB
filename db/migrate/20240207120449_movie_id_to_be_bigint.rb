class MovieIdToBeBigint < ActiveRecord::Migration[7.0]
  def up
    change_column :favorite_movie_notifications, :movie_id, :bigint
    change_column :favorite_movies, :movie_id, :bigint
    change_column :movie_actors, :movie_id, :bigint
    change_column :movie_countries, :movie_id, :bigint
    change_column :movie_directors, :movie_id, :bigint
    change_column :movie_genres, :movie_id, :bigint
    change_column :movie_languages, :movie_id, :bigint
    change_column :movie_ratings, :movie_id, :bigint
    change_column :movie_writers, :movie_id, :bigint
  end

  def down
    change_column :favorite_movie_notifications, :movie_id, :int
    change_column :favorite_movies, :movie_id, :int
    change_column :movie_actors, :movie_id, :int
    change_column :movie_countries, :movie_id, :int
    change_column :movie_directors, :movie_id, :int
    change_column :movie_genres, :movie_id, :int
    change_column :movie_languages, :movie_id, :int
    change_column :movie_ratings, :movie_id, :int
    change_column :movie_writers, :movie_id, :int
  end
end
