require 'json'
require 'net/http'

namespace :omdb do
  # Rake task to save a list of movies to the database
  desc 'This task file is used to save and store the list of top 100 movies using OMDB API'
  task save_top_100_movies_to_db: [:environment] do
    # Task to fetch details of the top 100 movies from OMDB API and store them in the database

    top_movies_imdb_ids = [
      'tt0111161',  'tt23849204', 'tt0068646', 'tt0468569', 'tt0167260',
      'tt0108052',  'tt0071562',  'tt0050083', 'tt0120737', 'tt0110912',
      'tt1375666',  'tt0137523',  'tt0109830', 'tt0167261', 'tt0060196',
      'tt0816692',  'tt0073486',  'tt0099685', 'tt0133093', 'tt0080684',
      'tt9362722',  'tt0102926',  'tt0114369', 'tt0103064', 'tt0245429',
      'tt0076759',  'tt0120689',  'tt0120815', 'tt0317248', 'tt0038650',
      'tt0118799',  'tt0047478',  'tt0056058', 'tt6751668', 'tt0172495',
      'tt2582802',  'tt0078748',  'tt0482571', 'tt0407887', 'tt0088763',
      'tt0110413',  'tt1853728',  'tt0120586', 'tt0114814', 'tt0110357',
      'tt0253474',  'tt0034583',  'tt1675434', 'tt0047396', 'tt0054215',
      'tt0095327',  'tt0064116',  'tt0095765', 'tt0021749', 'tt0027977',
      'tt15398776', 'tt7286456',  'tt0361748', 'tt4154796', 'tt0090605',
      'tt1345836',  'tt0209144',  'tt4633694', 'tt0082971', 'tt0078788',
      'tt0081505',  'tt0086879',  'tt0091251', 'tt4154756', 'tt5311514',
      'tt1187043',  'tt2380307',  'tt0910970', 'tt0405094', 'tt0057012',
      'tt8267604',  'tt0043014',  'tt0082096', 'tt0051201', 'tt0050825',
      'tt0032553',  'tt0057565',  'tt0364569', 'tt0119217', 'tt0180093',
      'tt0169547',  'tt0338013',  'tt0112573', 'tt2106476', 'tt0062622',
      'tt0105236',  'tt0087843',  'tt0086190', 'tt0114709', 'tt0119698',
      'tt0045152',  'tt0056172',  'tt0435761', 'tt0053604', 'tt0044741'
    ]

    ActiveRecord::Base.transaction do
      top_movies_imdb_ids.each do |imdb_id|
        begin
          response = fetch_movie_details_with_retry(imdb_id)

          # Extracting movie details from the API response
          movie_params = extract_movie_params(response)

          # Creating a new Movie object and saving it to the database with nested attributes
          Movie.create!(movie_params)

          puts "\n ************************************************ \n"
        rescue StandardError => e
          puts "Error while processing imdb id: #{imdb_id}. #{e.message}"
          # Log the error or handle it as needed
        end
      end
    end
  end

  # Method to fetch movie details from the OMDB API with retry logic
  #
  # @param imdb_id [String] The IMDB ID of the movie to fetch details for
  # @param max_retries [Integer] The maximum number of retries in case of errors
  # @return [Hash] Hash containing movie details
  def fetch_movie_details_with_retry(imdb_id, max_retries = 3)
    retries = 0

    begin
      fetch_movie_details(imdb_id)
    rescue StandardError => e
      retries += 1
      if retries <= max_retries
        puts "Error fetching details for imdb id: #{imdb_id}. Retrying (#{retries}/#{max_retries})..."
        sleep(5) # Add a delay before retrying to avoid rate limiting issues
        retry
      else
        puts "Max retries reached. Unable to fetch details for imdb id: #{imdb_id}. Error: #{e.message}"
        raise
      end
    end
  end

  # Method to fetch movie details from the OMDB API
  #
  # @param imdb_id [String] The IMDB ID of the movie to fetch details for
  # @return [Hash] Hash containing movie details
  def fetch_movie_details(imdb_id)
    omdb_api_url = ENV['OMDB_API_URL']
    url_params = URI.encode_www_form(i: imdb_id)

    url = "#{omdb_api_url}&#{url_params}"
    uri = URI.parse(url)

    puts "Searching imdb id: #{imdb_id} using OMDB api..."
    response = Net::HTTP.get_response(uri)

    unless response.is_a?(Net::HTTPSuccess)
      raise StandardError, "Failed to fetch details for imdb id: #{imdb_id}. HTTP Response: #{response.code} #{response.message}"
    end

    JSON.parse(response.body)
  end

  # Method to extract movie parameters from the API response
  #
  # @param response [Hash] API response containing movie details
  # @return [Hash] Extracted movie parameters
  def extract_movie_params(response)
    {
      awards: response['Awards'],
      box_office: response['BoxOffice'],
      dvd_release: response['DVD'],
      imdb_id: response['imdbID'],
      imdb_rating: response['imdbRating'],
      imdb_votes: response['imdbVotes'],
      metascore: response['Metascore'],
      plot: response['Plot'],
      production: response['Production'],
      poster: response['Poster'],
      rated: response['Rated'],
      released: response['Released'],
      runtime: response['Runtime'],
      title: response['Title'],
      website: response['Website'],
      year: response['Year'],
      movie_actors_attributes: response['Actors'].split(', ').map { |actor| { name: actor } },
      movie_countries_attributes: response['Country'].split(', ').map { |country| { country: country } },
      movie_directors_attributes: response['Director'].split(', ').map { |director| { name: director } },
      movie_genres_attributes: response['Genre'].split(', ').map { |genre| { genre: genre } },
      movie_languages_attributes: response['Language'].split(', ').map { |language| { language: language } },
      movie_ratings_attributes: response['Ratings'].map { |rating| { source: rating['Source'], value: rating['Value'] } },
      movie_writers_attributes: response['Writer'].split(', ').map { |writer| { name: writer } }
    }
  end
end