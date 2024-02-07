class MovieIdToBeInteger < ActiveRecord::Migration[7.0]
  def up
    change_column :favorite_movie_notifications, :movie_id, :integer
    change_column :favorite_movies, :movie_id, :integer
    change_column :movie_actors, :movie_id, :integer
    change_column :movie_countries, :movie_id, :integer
    change_column :movie_directors, :movie_id, :integer
    change_column :movie_genres, :movie_id, :integer
    change_column :movie_languages, :movie_id, :integer
    change_column :movie_ratings, :movie_id, :integer
    change_column :movie_writers, :movie_id, :integer
  end

  def down
    change_column :favorite_movie_notifications, :movie_id, :string
    change_column :favorite_movies, :movie_id, :string
    change_column :movie_actors, :movie_id, :string
    change_column :movie_countries, :movie_id, :string
    change_column :movie_directors, :movie_id, :string
    change_column :movie_genres, :movie_id, :string
    change_column :movie_languages, :movie_id, :string
    change_column :movie_ratings, :movie_id, :string
    change_column :movie_writers, :movie_id, :string
  end
end
