# app/models/movie_director.rb
class MovieDirector < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_directors
end