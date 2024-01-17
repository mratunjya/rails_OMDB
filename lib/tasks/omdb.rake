# OMDB Namespace
# This namespace includes tasks and methods for interacting with the OMDB API and storing movie details in the database.

require 'json'
require 'net/http'

namespace :omdb do
  # Method to save actors to the database
  def save_actors(actors, movie_id)
    # Saves the list of actors for a given movie to the database
    # Params:
    # - actors: Array of actor names
    # - movie_id: IMDB ID of the movie

    puts "Saving Actors..."
    actors.each do |actor|
      new_actor = MovieActor.new
      new_actor.name = actor
      new_actor.movie_id = movie_id

      new_actor.save
    end
  end

  # Method to save countries to the database
  def save_countries(countries, movie_id)
    # Saves the list of countries for a given movie to the database
    # Params:
    # - countries: Array of country names
    # - movie_id: IMDB ID of the movie

    puts "Saving Countries..."
    countries.each do |country|
      new_country = MovieCountry.new
      new_country.country = country
      new_country.movie_id = movie_id

      new_country.save
    end
  end

  # Method to save directors to the database
  def save_directors(directors, movie_id)
    # Saves the list of directors for a given movie to the database
    # Params:
    # - directors: Array of director names
    # - movie_id: IMDB ID of the movie

    puts "Saving Directors..."
    directors.each do |director|
      new_director = MovieDirector.new
      new_director.name = director
      new_director.movie_id = movie_id

      new_director.save
    end
  end

  # Method to save genres to the database
  def save_genres(genres, movie_id)
    # Saves the list of genres for a given movie to the database
    # Params:
    # - genres: Array of genre names
    # - movie_id: IMDB ID of the movie

    puts "Saving Genres..."
    genres.each do |genre|
      new_genre = MovieGenre.new
      new_genre.genre = genre
      new_genre.movie_id = movie_id

      new_genre.save
    end
  end

  def save_languages(languages, movie_id)
    # Saves the list of languages for a given movie to the database
    # Params:
    # - languages: Array of language names
    # - movie_id: IMDB ID of the movie

    puts "Saving Languages..."
    languages.each do |language|
      new_language = MovieLanguage.new
      new_language.language = language
      new_language.movie_id = movie_id

      new_language.save
    end
  end

  def save_ratings(ratings, movie_id)
    # Saves the list of ratings for a given movie to the database
    # Params:
    # - ratings: Array of rating details (Source and Value)
    # - movie_id: IMDB ID of the movie

    puts "Saving Ratings..."
    ratings.each do |rating|
      new_rating = MovieRating.new
      new_rating.source = rating['Source']
      new_rating.value = rating['Value']
      new_rating.movie_id = movie_id

      new_rating.save
    end
  end

  # Method to save writers to the database
  def save_writers(writers, movie_id)
    # Saves the list of writers for a given movie to the database
    # Params:
    # - writers: Array of writer names
    # - movie_id: IMDB ID of the movie

    puts "Saving Writers..."
    writers.each do |writer|
      new_writer = MovieWriter.new
      new_writer.name = writer
      new_writer.movie_id = movie_id

      new_writer.save
    end
  end

  # Method to fetch movie details from the OMDB API
  def fetch_movie_details(imdb_id)
    # Fetches movie details from the OMDB API using the provided IMDB ID
    # Params:
    # - imdb_id: IMDB ID of the movie to fetch details for
    # Returns: Hash containing movie details

    api_url = ENV['api_url']
    url_params = URI.encode_www_form(i: imdb_id)

    url = "#{api_url}&#{url_params}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    return JSON.parse(response.body)
  end

  # Rake task to save a list of movies to the database
  desc 'This task file is used to save and store the list of top 100 movies using OMDB API'
  task save_top_100_movies_to_db: [:environment, :omdb_api_setup] do
    # Task to fetch details of the top 100 movies from OMDB API and store them in the database

    top_100_movies_imdb_id = [
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
      top_100_movies_imdb_id.each do |imdb_id|
        puts "Searching imdb id:#{imdb_id} using OMDB api..."
        response = fetch_movie_details(imdb_id)

        # Extracting movie details from the API response
        actors = response['Actors'].split(', ')
        awards = response['Awards']
        box_office = response['BoxOffice']
        countries = response['Country'].split(', ')
        directors = response['Director'].split(', ')
        dvd_release = response['DVD']
        genres = response['Genre'].split(', ')
        imdb_rating = response['imdbRating']
        imdb_votes = response['imdbVotes']
        imdb_id = response['imdbID']
        languages = response['Language'].split(', ')
        metascore = response['Metascore']
        plot = response['Plot']
        production = response['Production']
        poster = response['Poster']
        rated = response['Rated']
        ratings = response['Ratings']
        released = response['Released']
        runtime = response['Runtime']
        title = response['Title']
        website = response['Website']
        writers = response['Writer'].split(', ')
        year = response['Year']

        # Creating a new Movie object and saving it to the database
        movie = Movie.new

        movie.awards = awards
        movie.box_office = box_office
        movie.dvd_release = dvd_release
        movie.imdb_rating = imdb_rating
        movie.imdb_votes = imdb_votes
        movie.id = imdb_id
        movie.metascore = metascore
        movie.plot = plot
        movie.production = production
        movie.poster = poster
        movie.rated = rated
        movie.released = released
        movie.runtime = runtime
        movie.title = title
        movie.website = website
        movie.year = year

        # Calling methods to save related details to the database
        save_actors(actors, imdb_id)
        save_countries(countries, imdb_id)
        save_directors(directors, imdb_id)
        save_genres(genres, imdb_id)
        save_languages(languages, imdb_id)
        save_ratings(ratings, imdb_id)
        save_writers(writers, imdb_id)

        # Saving the Movie object
        movie.save

        puts "\n ************************************************ \n"
      end
    end
  end

  # Rake task to set up OMDB API base URL and key
  desc 'OMDB base URL and API key setup for environment'
  task omdb_api_setup: :environment do
    # Task to set up OMDB API base URL and key in the environment

    api_key = "1f724ce8"
    base_url = "http://www.omdbapi.com/"

    ENV['api_url'] = "#{base_url}?apikey=#{api_key}"

    puts "OMDB API Base URL created."
  end
end
