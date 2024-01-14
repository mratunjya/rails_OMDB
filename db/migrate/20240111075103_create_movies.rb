class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :awards
      t.string :imdb_rating
      t.string :imdb_votes
      t.string :media_type
      t.string :metascore
      t.text :plot
      t.text :poster
      t.string :rated
      t.string :released
      t.string :runtime
      t.string :title
      t.string :total_seasons
      t.integer :year

      t.timestamps
    end
  end
end
