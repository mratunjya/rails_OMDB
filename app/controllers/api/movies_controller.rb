class Api::MoviesController < ApplicationController
  # Ensures that only authenticated users can access the movie-related endpoints.
  before_action :authenticate_user!


  # GET /api/movies
  # Retrieves a list of movies based on specified parameters.
  def index
    # Set default values for search parameters
    title, actor, genre, released = %i[title actor genre released].map { |param| wildcard_string_generator(params[param]) }

    # Set default values for pagination
    page = (params[:page].presence || 1).to_i
    per_page = 8

    # Build the movie query with left joins and search conditions
    movies_query = Movie.left_joins(:movie_actors, :movie_genres)
                      .where('movies.title LIKE ? AND movies.released LIKE ? AND movie_actors.name LIKE ? AND movie_genres.genre LIKE ?', title, released, actor, genre)
                      .distinct

    # Paginate the movies and load necessary associations
    movies = movies_query.offset((page - 1) * per_page).limit(per_page)

    # Prepare the output JSON using a concise format
    output = prepare_movie_output(movies)

    # Render the final JSON response
    render json: { movies: output, page: page, max_movies_per_page: per_page, total_movies_count: movies_query.count }
  end

  private

  # Generates a wildcard string for SQL LIKE queries.
  def wildcard_string_generator(str)
    str = str&.strip

    return "%" if str.nil? || str.empty?

    "%#{str.split('').join('%')}%"
  end

  # Prepare the output JSON using a concise format
  def prepare_movie_output(movies)
    movies.map do |movie|
      {
        actors: movie.movie_actors.pluck(:name),
        awards: movie.awards,
        box_office: movie.box_office,
        countries: movie.movie_countries.pluck(:country),
        directors: movie.movie_directors.pluck(:name),
        dvd_release: movie.dvd_release,
        genres: movie.movie_genres.pluck(:genre),
        imdb_rating: movie.imdb_rating,
        imdb_votes: movie.imdb_votes,
        languages: movie.movie_languages.pluck(:language),
        metascore: movie.metascore,
        plot: movie.plot,
        poster: movie.poster,
        production: movie.production,
        rated: movie.rated,
        ratings: movie.movie_ratings.map { |rating| { value: rating.value, source: rating.source } },
        released: movie.released,
        runtime: movie.runtime,
        title: movie.title,
        website: movie.website,
        writers: movie.movie_writers.pluck(:name),
        year: movie.year
      }
    end
  end
end