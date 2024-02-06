require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsOmdb
  class Application < Rails::Application
    # Initialize configuration defaults for Rails 7.0.
    config.load_defaults 7.0

    # Add the 'lib' subdirectory to the autoload paths.
    config.autoload_paths << Rails.root.join('lib')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"

    # Uncomment and add eager load paths if needed.
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure Rack::Cors middleware for handling Cross-Origin Resource Sharing (CORS).
    config.middleware.use Rack::Cors do
      allow do
        origins '*' # Allow requests from any origin.
        resource '*',
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          methods: [:get, :post, :options, :delete, :put]
      end
    end

    config.generators do |g|
      g.test_framework(
        :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        )
    end
  end
end