FactoryBot.define do
    factory :movie_rating do
        # Define attributes for movie rating
        source { Faker::Lorem.word }
        value { Faker::Number.decimal(l_digits: 1, r_digits: 2) }

        # Define association with the movie
        movie
    end
end