require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # Devise Token Auth routes for User authentication
  # Generates authentication routes like /auth/sign_in, /auth/sign_out, etc.
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    # Define movies resource with only the index action
    # This will create routes like /api/movies (GET)
    resources :movies,  only: [:index]

    # Define favorite_movies resource with only the index, toggle_favorite action
    # This will create routes like /api/favorite_movies (GET)
    #                              /api/favorite_movies/toggle_favorite (POST)
    resources :favorite_movies, only: [:index] do
      post 'toggle_favorite', on: :collection
    end
  end
end