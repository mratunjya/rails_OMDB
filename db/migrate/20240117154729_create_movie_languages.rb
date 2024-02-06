class CreateMovieLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_languages do |t|
      t.string :language
      t.string :movie_id

      t.timestamps
    end
  end
end
