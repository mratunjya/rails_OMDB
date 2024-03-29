class Api::FavoriteMoviesController < ApplicationController
    # Ensures that only authenticated users can access the movie-related endpoints.
    before_action :authenticate_user!

    # Get a list of favorite movie titles for the current user.
    def index
        begin
            # Retrieve movie titles using a left join on the associated movies.
            favorite_movies_titles = current_user.favorite_movies.left_joins(:movie).pluck(:title)
            render json: { movie_titles: favorite_movies_titles }
        rescue => e
            # Handle exceptions and provide an error message in case of failure.
            render json: { error: "Error retrieving favorite movies: #{e.message}" }, status: :internal_server_error
        end
    end

    # Toggle the favorite status of a movie for the current user.
    def toggle_favorite
        begin
            # Find the movie and user based on the provided parameters.
            movie = Movie.find(params[:movie_id])
            user = User.find(current_user.id)

            # Check if the movie is already in the user's favorites.
            if user.favorite_movies.exists?(movie_id: movie.id)
                # If the movie is in favorites, find the associated record and delete it.
                favorite_movie = user.favorite_movies.find_by(movie_id: movie.id)

                if favorite_movie.destroy
                    # Provide a success message if the deletion is successful.
                    render json: { message: "Deleted #{movie.title} from user's favorites" }
                else
                    # Handle errors if deletion fails.
                    render json: { error: "Failed to delete #{movie.title} from user's favorites", details: favorite_movie.errors.full_messages }, status: :bad_request
                end
            else
                # If the movie is not in favorites, create a new record to add it.
                favorite_movies_attributes = {
                    user_id: user.id,
                    movie_id: movie.id
                }

                if user.favorite_movies.create!(favorite_movies_attributes)
                    # Provide a success message if the creation is successful.
                    render json: { message: "Added #{movie.title} to user's favorites" }
                else
                    # Handle errors if creation fails.
                    render json: { error: "Failed to add #{movie.title} to user's favorites", details: user.favorite_movies.last.errors.full_messages }, status: :bad_request
                end
            end
        rescue ActiveRecord::RecordNotFound => e
            # Handle the case where either the movie or user is not found.
            render json: { error: "Movie or User not found: #{e.message}" }, status: :not_found
        rescue => e
            # Handle unexpected errors and provide an error message.
            render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
        end
    end
end
