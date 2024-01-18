class CreateFavoriteMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_movies do |t|
      t.integer :user_id
      t.string :movie_id

      t.timestamps
    end
  end
end
