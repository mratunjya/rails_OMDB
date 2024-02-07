class UserIdToBeBigint < ActiveRecord::Migration[7.0]
  def up
    change_column :favorite_movies, :user_id, :bigint
    change_column :favorite_movie_notifications, :user_id, :bigint
  end

  def down
    change_column :favorite_movies, :user_id, :int
    change_column :favorite_movie_notifications, :user_id, :int
  end
end
