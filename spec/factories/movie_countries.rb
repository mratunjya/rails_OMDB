FactoryBot.define do
    factory :movie_country do
        # Define attributes for movie country
        country { Faker::Lorem.word }

        # Define association with the movie
        movie
    end
end