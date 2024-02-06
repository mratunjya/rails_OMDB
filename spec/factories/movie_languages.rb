FactoryBot.define do
    factory :movie_language do
        # Define attributes for movie language
        language { Faker::Lorem.word }

        # Define association with the movie
        movie
    end
end