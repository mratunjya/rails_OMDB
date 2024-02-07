require 'rails_helper'

# Specifying the Api::MoviesController for request tests
describe "Api::Movies", type: :request do
  # Creating a user and storing its authentication headers for requests
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  # Creating a list of movies for testing
  let!(:movie_list) { create_list(:movie, 100) }
  # Storing the count of movies for reference
  let(:movies_count) { movie_list.count }

  # Testing scenarios when the user is not signed in
  context "when the user is not signed in" do
    # Testing GET /api/movies without authentication
    describe "GET /api/movies" do
      subject(:get_movies) { get "/api/movies" }

      it "should be unauthorized access" do
        get_movies

        expect(response).to be_unauthorized
      end
    end

    # Testing GET /api/movies with pagination without authentication
    describe "GET /api/movies params: { page: 100 }" do
      subject(:get_next_movies) { get "/api/movies", params: { page: 100 } }

      it "should be unauthorized access" do
        get_next_movies

        expect(response).to be_unauthorized
      end
    end
  end

  # Testing scenarios when the user is signed in
  context "when the user is signed in" do
    # Testing GET /api/movies endpoint
    describe "GET /api/movies" do
      subject(:get_movies) { get "/api/movies", headers: auth_headers }

      it "should return first 8 movies" do
        get_movies

        expect(response).to be_successful

        # Verifying the movie list returned for the first page
        verify_movie_list(1)
      end
    end

    # Testing GET /api/movies with pagination
    describe "GET /api/movies params: { page: 2 }" do
      subject(:get_next_movies) { get "/api/movies", params: { page: 2 }, headers: auth_headers }

      it "should return next 8 movies" do
        get_next_movies

        expect(response).to be_successful

        # Verifying the movie list returned for the second page
        verify_movie_list(2)
      end
    end

    # Testing GET /api/movies with pagination for the last page
    describe "GET /api/movies params: { page: 13 }" do
      subject(:get_last_movies) { get "/api/movies", params: { page: 13 }, headers: auth_headers }

      it "should return last 4 movies" do
        get_last_movies

        expect(response).to be_successful

        # Verifying the movie list returned for the last page with custom movie count
        verify_movie_list(13, 4)
      end
    end

    # Testing GET /api/movies with pagination for a non-existent page
    describe "GET /api/movies params: { page: 100 }" do
      subject(:get_nonexistent_movies) { get "/api/movies", params: { page: 100 }, headers: auth_headers }

      it "should return 0 movies" do
        get_nonexistent_movies

        expect(response).to be_successful

        # Verifying the movie list returned for a non-existent page
        verify_movie_list(100, 0)
      end
    end
  end

  # Helper method to verify the movie list returned in the response
  def verify_movie_list(page_number, movies_length = 8)
    response_body = JSON.parse(response.body)

    # Verifying page number, maximum movies per page, total movies count, and movies length
    expect(response_body["page"]).to eq(page_number)
    expect(response_body["max_movies_per_page"]).to eq(8)
    expect(response_body["total_movies_count"]).to eq(movies_count)
    expect(response_body["movies"].length).to eq(movies_length)

    # Extracting expected movie titles based on the page number
    expected_titles = movie_list[((page_number - 1) * 8), 8]&.map(&:title)
    # Handling nil case for expected titles
    expected_titles = [] if expected_titles.nil?

    # Extracting response movie titles
    response_titles = response_body["movies"]&.map { |movie| movie["title"] }

    # Verifying if response titles match expected titles
    expect(response_titles).to eq(expected_titles)
  end
end