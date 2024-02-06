FactoryBot.define do
    factory :user do
        # Define attribute for user
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { 'password123' }
    end
end