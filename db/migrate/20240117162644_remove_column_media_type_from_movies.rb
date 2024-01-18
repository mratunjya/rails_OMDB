class RemoveColumnMediaTypeFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :media_type
  end
end
