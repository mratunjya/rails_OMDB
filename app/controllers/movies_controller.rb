class MoviesController < ApplicationController
    def index
        @title = params[:title]
        @actor = params[:actor]
        @genre = params[:genre]
        @released = params[:released]

        title = @title.present? ? "%#{@title.split('').join('%')}%" : "%"
        actor = @actor.present? ? "%#{@actor.split('').join('%')}%" : "%"
        genre = @genre.present? ? "%#{@genre.split('').join('%')}%" : "%"
        released = @released.present? ? "%#{@released.split('').join('%')}%" : "%"

        page = params[:page].present? ? params[:page].to_i : 1
        per_page = 8

        movies_query = Movie
                        .left_joins(:movie_actor, :movie_genre)
                        .includes(:movie_actor, :movie_genre)
                        .where('movies.title LIKE ? AND movies.released LIKE ? AND movie_actors.name LIKE ? AND movie_genres.genre LIKE ?', title, released, actor, genre)
                        .distinct

        total_count = movies_query.count

        if page * per_page - total_count >= per_page
            # render json: { error: "No movie present on page: #{page}", total_count: total_count }
            return
        end

        movies_query = movies_query
                .offset((page - 1) * per_page)
                .limit(per_page)

        @movies = movies_query.map do |movie| {
            id: movie.id,
            actors: movie.movie_actor.pluck(:name),
            awards: movie.awards,
            genres: movie.movie_genre.pluck(:genre),
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

        if page > 1
            @prev_page = page - 1
        end

        if page * per_page < total_count
            @next_page = page + 1
        end
    end

    def show
        @movie = Movie.find(params[:id])
    end
end