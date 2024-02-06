FactoryBot.define do
    factory :movie_actor do
        # Define attributes for movie actors
        name { Faker::Name.name }

        # Define association with the movie
        movie
    end
end