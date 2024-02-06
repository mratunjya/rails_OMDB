class RemoveColumnTotalSeasonsFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :total_seasons
  end
end
