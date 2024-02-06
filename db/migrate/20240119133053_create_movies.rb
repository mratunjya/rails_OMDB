class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :awards
      t.string :box_office
      t.string :dvd_release
      t.string :imdb_id
      t.string :imdb_rating
      t.string :imdb_votes
      t.string :metascore
      t.text :plot
      t.text :poster
      t.string :production
      t.string :rated
      t.string :released
      t.string :runtime
      t.string :title
      t.string :website
      t.integer :year

      t.timestamps
    end
  end
end
