FactoryBot.define do
    factory :movie_genre do
        # Define attributes for movie genre
        genre { Faker::Lorem.word }

        # Define association with the movie
        movie
    end
end