class Movie < ApplicationRecord
    has_many :movie_actor, foreign_key: "movie_id"
    has_many :movie_country, foreign_key: "movie_id"
    has_many :movie_director, foreign_key: "movie_id"
    has_many :movie_genre, foreign_key: "movie_id"
    has_many :movie_writer, foreign_key: "movie_id"
end
