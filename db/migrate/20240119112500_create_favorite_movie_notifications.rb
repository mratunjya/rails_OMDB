class CreateFavoriteMovieNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_movie_notifications do |t|
      t.string :movie_id
      t.integer :user_id
      t.string :message

      t.timestamps
    end
  end
end
