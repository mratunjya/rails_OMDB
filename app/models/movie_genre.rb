class MovieGenre < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_genres
end
