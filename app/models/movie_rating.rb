class MovieRating < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_ratings
end
