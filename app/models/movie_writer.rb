class MovieWriter < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_writers
end
