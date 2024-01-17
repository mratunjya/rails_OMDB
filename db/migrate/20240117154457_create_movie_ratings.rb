class CreateMovieRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_ratings do |t|
      t.string :source
      t.string :value
      t.string :movie_id

      t.timestamps
    end
  end
end
