class Movie < ApplicationRecord
    has_many :movie_actor, foreign_key: "imdb_movie_id"
    has_many :movie_country, foreign_key: "imdb_movie_id"
    has_many :movie_director, foreign_key: "imdb_movie_id"
    has_many :movie_genre, foreign_key: "imdb_movie_id"
    has_many :movie_writer, foreign_key: "imdb_movie_id"
end
