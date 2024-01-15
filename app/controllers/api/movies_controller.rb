class Api::MoviesController < ApplicationController
  def index
    title = params[:title].present? ? "%#{params[:title].split('').join('%')}%" : "%"
    actor = params[:actor].present? ? "%#{params[:actor].split('').join('%')}%" : "%"
    genre = params[:genre].present? ? "%#{params[:genre].split('').join('%')}%" : "%"
    released = params[:released].present? ? "%#{params[:released].split('').join('%')}%" : "%"

    page = params[:page].present? ? params[:page].to_i : 1
    per_page = 8

    movies = Movie
              .left_joins(:movie_actor, :movie_genre)
              .where('movies.title LIKE ? AND movies.released LIKE ? AND movie_actors.name LIKE ? AND movie_genres.genre LIKE ?', title, released, actor, genre)
              .distinct

    total_count = movies.count

    movies = movies.offset((page - 1) * per_page)
                    .limit(per_page)

    output = []

    output = movies.map do |movie|
      actors = MovieActor.where(movie_id: movie.id).pluck(:name)
      genres = MovieGenre.where(movie_id: movie.id).pluck(:genre)

      {
        actors: actors,
        awards: movie.awards,
        genre: genres,
        imdb_rating: movie.imdb_rating,
        imdb_votes: movie.imdb_votes,
        media_type: movie.media_type,
        metascore: movie.metascore,
        plot: movie.plot,
        poster: movie.poster,
        released: movie.released,
        rated: movie.rated,
        runtime: movie.runtime,
        title: movie.title,
        total_seasons: movie.total_seasons,
        year: movie.year
      }
    end

    render json: { movies: output, total_count: total_count }
  end
end