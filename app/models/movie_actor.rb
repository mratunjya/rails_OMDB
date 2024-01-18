class MovieActor < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_actors
end
