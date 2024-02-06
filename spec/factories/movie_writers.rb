FactoryBot.define do
    factory :movie_writer do
        # Define attributes for movie writer
        name { Faker::Name.name }

        # Define association with the movie
        movie
    end
end