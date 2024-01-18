Rails.application.routes.draw do
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
  end

end
