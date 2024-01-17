class Movie < ApplicationRecord
    has_many :movie_actors, foreign_key: "movie_id"
    has_many :movie_countries, foreign_key: "movie_id"
    has_many :movie_directors, foreign_key: "movie_id"
    has_many :movie_genres, foreign_key: "movie_id"
    has_many :movie_languages, foreign_key: "movie_id"
    has_many :movie_ratings, foreign_key: "movie_id"
    has_many :movie_writers, foreign_key: "movie_id"
end
