class UpdateColumnNameInMovieCountries < ActiveRecord::Migration[7.1]
  def change
    rename_column :movie_countries, :name, :country
  end
end
