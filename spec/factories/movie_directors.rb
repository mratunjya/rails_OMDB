FactoryBot.define do
    factory :movie_director do
        # Define attributes for movie director
        name { Faker::Name.name }

        # Define association with the movie
        movie
    end
end