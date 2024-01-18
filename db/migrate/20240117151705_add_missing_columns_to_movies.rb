class AddMissingColumnsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :box_office, :string
    add_column :movies, :dvd_release, :string
    add_column :movies, :production, :string
    add_column :movies, :website, :string
  end
end
