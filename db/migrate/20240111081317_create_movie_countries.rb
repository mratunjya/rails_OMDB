class CreateMovieCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_countries do |t|
      t.string :name
      t.string :imdb_movie_id

      t.timestamps
    end
  end
end
