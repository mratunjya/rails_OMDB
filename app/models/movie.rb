class Movie < ApplicationRecord
    has_many :movie_actors, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_countries, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_directors, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_genres, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_languages, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_ratings, foreign_key: "movie_id", inverse_of: :movie
    has_many :movie_writers, foreign_key: "movie_id", inverse_of: :movie

    accepts_nested_attributes_for :movie_actors, :movie_countries, :movie_directors, :movie_genres, :movie_languages, :movie_ratings, :movie_writers, :movie_writers
end
