FactoryBot.define do
    factory :movie do
        # Define attributes for a movie
        awards { Faker::Lorem.sentence }
        box_office { Faker::Number.number(digits: 8) }
        dvd_release { Faker::Date.forward(days: 30).to_s }
        imdb_id { Faker::Alphanumeric.alphanumeric(number: 9) }
        imdb_rating { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
        imdb_votes { Faker::Number.number(digits: 6) }
        metascore { Faker::Number.number(digits: 2) }
        plot { Faker::Lorem.paragraph }
        poster { Faker::Internet.url }
        production { Faker::Company.name }
        rated { %w[G PG PG-13 R NC-17].sample }
        released { Faker::Date.backward(days: 365).to_s }
        runtime { "#{Faker::Number.number(digits: 2)} min" }
        title { Faker::Movie.title }
        website { Faker::Internet.url }
        year { Faker::Number.between(from: 1900, to: Date.current.year) }

        # Define associations with movie_actors, movie_countries, movie_directors, etc.
        transient do
            # Define counts for associated records
            actors_count { rand(3) + 1 }
            countries_count { rand(2) + 1 }
            directors_count { 1 }
            genres_count { rand(3) + 1 }
            languages_count { 1 }
            ratings_count { rand(3) + 1 }
            writers_count { rand(5) + 1 }
        end

        after(:create) do |movie, evaluator|
            # Create associated records after creating a movie
            create_list(:movie_actor, evaluator.actors_count, movie: movie)
            create_list(:movie_country, evaluator.countries_count, movie: movie)
            create_list(:movie_director, evaluator.directors_count, movie: movie)
            create_list(:movie_genre, evaluator.genres_count, movie: movie)
            create_list(:movie_language, evaluator.languages_count, movie: movie)
            create_list(:movie_rating, evaluator.ratings_count, movie: movie)
            create_list(:movie_writer, evaluator.writers_count, movie: movie)
        end
    end
end
