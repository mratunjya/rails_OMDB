class RenameColumnImdbMovieIdToMovieIdInAllModel < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :imdb_id, :id
    rename_column :movie_actors, :imdb_movie_id, :movie_id
    rename_column :movie_countries, :imdb_movie_id, :movie_id
    rename_column :movie_directors, :imdb_movie_id, :movie_id
    rename_column :movie_genres, :imdb_movie_id, :movie_id
    rename_column :movie_writers, :imdb_movie_id, :movie_id
  end
end
