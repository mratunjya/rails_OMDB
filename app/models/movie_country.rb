class MovieCountry < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_countries
end
