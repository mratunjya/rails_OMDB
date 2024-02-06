require 'rails_helper'

# Integration tests for the Api::FavoriteMovies controller
describe "Api::FavoriteMovies", type: :request do
  # Create a user, authentication headers, and a list of movies before each example
  let!(:user) { create(:user) }
  let!(:auth_headers) { user.create_new_auth_token }
  let!(:movie_list) { create_list(:movie, 100) }

  # Test suite for the GET /api/favorite_movies endpoint
  describe "GET /api/favorite_movies" do
    # Define subjects for making requests with and without authentication headers
    subject(:get_favorite_movies_without_headers) { get "/api/favorite_movies" }
    subject(:get_favorite_movies) { get "/api/favorite_movies", headers: auth_headers }

    # Context for testing when the user is not signed in
    context "when the user is not signed in" do
      it "should be unauthorized access" do
        get_favorite_movies_without_headers

        expect(response).to be_unauthorized
      end
    end

    # Context for testing when the user is signed in
    context "when the user is signed in" do
      # Test case for checking if no favorite movie titles are returned when the user has no favorite movies
      it "should give no favorite movie titles when user has no favorite movies" do
        get_favorite_movies

        expect(response).to be_successful
        expect(JSON.parse(response.body)["movie_titles"].length).to eq(0)
      end

      # Test case for adding 10 movies to the user's favorite list and checking if all are there in favorite movies
      it "adds 10 movies to the user's favorite list and check if all are there in favorite movies" do
        # Select 10 unique random movie indexes
        unique_random_movie_indexes = Set[]

        while unique_random_movie_indexes.length < 10
          unique_random_movie_indexes.add(rand(0...100))
        end

        # Toggle favorite status for each selected movie
        unique_random_movie_indexes.each do |index|
          toggle_favorite_movie(movie_list[index].id)
        end

        # Make a request to retrieve favorite movies
        get_favorite_movies
        expect(response).to be_successful

        # Get the expected movie titles based on the selected movie indexes
        expected_movie_titles = unique_random_movie_indexes.map do |index|
          movie_list[index].title
        end

        # Get the actual response movie titles
        response_movie_titles = JSON.parse(response.body)["movie_titles"]

        # Assert that the expected movie titles match the response movie titles
        expect(expected_movie_titles).to eq(response_movie_titles)
      end
    end
  end

  # Helper method to toggle the favorite status of a movie
  def toggle_favorite_movie(movie_id)
    post "/api/favorite_movies/toggle_favorite", params: { movie_id: movie_id }, headers: auth_headers
  end
end