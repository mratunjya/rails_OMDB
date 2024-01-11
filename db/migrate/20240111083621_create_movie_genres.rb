class CreateMovieGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_genres do |t|
      t.string :genre
      t.string :imdb_movie_id

      t.timestamps
    end
  end
end
