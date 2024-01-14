require 'json'
require 'net/http'

namespace :omdb do
  # Method to save actors to the database
  def save_actors(actors, id)
    puts "Saving Actors..."
    actors.each do |actor|
      new_actor = MovieActor.new
      new_actor.name = actor
      new_actor.movie_id = id

      if new_actor.save
        # Print specific attributes of new_actor
        puts "Actor Name: #{new_actor.name}, IMDb Movie ID: #{new_actor.movie_id}"
      else
        puts new_actor.errors.full_messages
      end
    end
  end

  # Method to save countries to the database
  def save_countries(countries, id)
    puts "Saving Countries..."
    countries.each do |country|
      new_country = MovieCountry.new
      new_country.name = country
      new_country.movie_id = id

      if new_country.save
        # Print specific attributes of new_country
        puts "Country Name: #{new_country.name}, IMDb Movie ID: #{new_country.movie_id}"
      else
        puts new_country.errors.full_messages
      end
    end
  end

  # Method to save directors to the database
  def save_directors(directors, id)
    puts "Saving Directors..."
    directors.each do |director|
      new_director = MovieDirector.new
      new_director.name = director
      new_director.movie_id = id

      if new_director.save
        # Print specific attributes of new_director
        puts "Director Name: #{new_director.name}, IMDb Movie ID: #{new_director.movie_id}"
      else
        puts new_director.errors.full_messages
      end
    end
  end

  # Method to save genres to the database
  def save_genres(genres, id)
    puts "Saving Genres..."
    genres.each do |genre|
      new_genre = MovieGenre.new
      new_genre.genre = genre
      new_genre.movie_id = id

      if new_genre.save
        # Print specific attributes of new_genre
        puts "Genre: #{new_genre.genre}, IMDb Movie ID: #{new_genre.movie_id}"
      else
        puts new_genre.errors.full_messages
      end
    end
  end

  # Method to save writers to the database
  def save_writers(writers, id)
    puts "Saving Writers..."
    writers.each do |writer|
      new_writer = MovieWriter.new
      new_writer.name = writer
      new_writer.movie_id = id

      if new_writer.save
        # Print specific attributes of new_writer
        puts "Writer Name: #{new_writer.name}, IMDb Movie ID: #{new_writer.movie_id}"
      else
        puts new_writer.errors.full_messages
      end
    end
  end

  # Method to save movie details to the database
  def save_movie_details(movie_details)
    awards = movie_details['Awards']
    id = movie_details['imdbID']
    imdb_rating = movie_details['imdbRating']
    imdb_votes = movie_details['imdbVotes']
    media_type = movie_details['Type']
    metascore = movie_details['Metascore']
    ratings = movie_details['Ratings']
    plot = movie_details['Plot']
    poster = movie_details['Poster']
    rated = movie_details['Rated']
    released = movie_details['Released']
    runtime = movie_details['Runtime']
    title = movie_details['Title']
    total_seasons = movie_details['totalSeasons']

    new_movie = Movie.new

    new_movie.awards = awards
    new_movie.id = id
    new_movie.imdb_rating = imdb_rating
    new_movie.imdb_votes = imdb_votes
    new_movie.media_type = media_type
    new_movie.metascore = metascore
    new_movie.plot = plot
    new_movie.poster = poster
    new_movie.rated = rated
    new_movie.released = released
    new_movie.runtime = runtime
    new_movie.title = title
    new_movie.total_seasons = total_seasons

    if new_movie.save
      # Print specific attributes of new_movie
      puts "Title: #{new_movie.title}, IMDb ID: #{new_movie.id}"
    else
      puts new_movie.errors.full_messages
    end
  end

  # Method to fetch movie details from the OMDB API
  def fetch_movie_details(movie, api_url)
    id = movie['imdbID']

    puts "Fetching movie details with id: #{id}"

    url_params = URI.encode_www_form(i: id)
    url = "#{api_url}&#{url_params}"
    uri = URI(url)

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      puts "Failed to fetch movie data from #{url}. HTTP Status: #{response.code}"
      nil
    end
  end

  # Method to fetch a list of movies from the OMDB API
  def fetch_movies_list(search_str)
    api_url = ENV['api_url']

    url_params = URI.encode_www_form(s: search_str)
    url = "#{api_url}&#{url_params}"
    uri = URI(url)

    puts "Fetching Movies List for the search string '#{search_str}'..."
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)

      error = data['Error']

      if error
        puts "error: #{error}"
        puts "api url: #{url}"
        return
      end

      movies_list = data['Search']

      movie_counter = 1

      movies_list.each do |movie|
        movie_details = fetch_movie_details(movie, api_url)

        unless movie_details
          next
        end

        error = movie_details['Error']

        if error
          puts "error: #{error}"
          puts "api url: #{url}"
          return
        end

        actors = movie_details['Actors'].split(', ')
        countries = movie_details['Country'].split(', ')
        directors = movie_details['Director'].split(', ')
        genres = movie_details['Genre'].split(', ')
        id = movie_details['imdbID']
        languages = movie_details['Language'].split(', ')
        writers = movie_details['Writer'].split(', ')

        puts "Movie Count: #{movie_counter} for #{search_str}"

        save_actors(actors, id)
        save_countries(countries, id)
        save_directors(directors, id)
        save_genres(genres, id)
        save_writers(writers, id)

        puts "Saving Movie..."
        save_movie_details(movie_details)

        puts "\n\n"

        movie_counter += 1
      end
    else
      puts "Failed to fetch movies list from #{url}. HTTP Status: #{response.code}"
    end
  end

  # Rake task to save a list of movies to the database
  desc 'This task file is use to save and store the movies list of 100 movies using OMDB Api'
  task save_movies_list_to_db: [:environment, :omdb_api_setup] do
    search_strs = [
      "Marvel",
      "Batman",
      "Superwoman",
      "Avengers",
      "Harry Potter",
      "Money",
      "Game",
      "Dhoom",
      "Spider",
      "Venom"
    ]

    search_strs.each do |search_str|
      puts "Searching #{search_str} using OMDB api..."
      fetch_movies_list(search_str.downcase)
    end
  end

  # Rake task to set up OMDB API base URL and key
  desc 'OMDB base URL and API set for env'
  task omdb_api_setup: :environment do
    api_key = "1f724ce8"
    base_url = "http://www.omdbapi.com/"
    ENV['api_url'] = "#{base_url}?apikey=#{api_key}"
    puts "OMBD Api Base URL created."
  end
end