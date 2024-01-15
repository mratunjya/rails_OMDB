class Api::MoviesController < ApplicationController
  def index
    title = params[:title].present? ? "%#{params[:title].split('').join('%')}%" : "%"
    actor = params[:actor].present? ? "%#{params[:actor].split('').join('%')}%" : "%"
    genre = params[:genre].present? ? "%#{params[:genre].split('').join('%')}%" : "%"
    released = params[:released].present? ? "%#{params[:released].split('').join('%')}%" : "%"

    page = params[:page].present? ? params[:page].to_i : 1
    per_page = 8

    movies_query = Movie
                    .left_joins(:movie_actor, :movie_genre)
                    .where('movies.title LIKE ? AND movies.released LIKE ? AND movie_actors.name LIKE ? AND movie_genres.genre LIKE ?', "%#{params[:title]}%", "%#{params[:released]}%", "%#{params[:actor]}%", "%#{params[:genre]}%")
                    .distinct

    total_count = movies_query.count

    if page * per_page - total_count >= per_page
      render json: { error: "No movies present on page: #{page}", total_count: total_count }
      return
    end

    movies = movies_query
              .offset((page - 1) * per_page)
              .limit(per_page)
              .includes(:movie_actor, :movie_genre)
    return

    output = movies.map do |movie|
      {
        actors: movie.movie_actor.pluck(:name),
        awards: movie.awards,
        genre: movie.movie_genre.pluck(:genre),
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