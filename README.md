# Movie Management Application

## Overview

This application allows users to browse through a list of movies, mark their favorite movies, and receive notifications when they mark or unmark a movie as their favorite.

## Features

- User authentication using [Devise gem](https://github.com/heartcombo/devise)
- API endpoints to:
  - Fetch top 100 movie details from [OMDB API](https://www.omdbapi.com/) and save in the local database
  - List all movies with search functionality by title, actor, genre, and release date with pagination
  - Mark/unmark favorite movies
  - Fetch the user's favorite movie list
- Background job processing for sending notifications to users using [Sidekiq worker](https://github.com/mperham/sidekiq)
- Rake task to fetch and save movie details from OMDB API to the database

## System Requirements

- Ruby version: 3.3.0
- Rails version: 7.0.8
- MySQL database

## Installation

1. Clone the repository.
2. Install dependencies using Bundler:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   rails@ruby:~$ rails db:create
   rails@ruby:~$ rails db:migrate
   ```
4. Start the Rails server:
   ```bash
   rails@ruby:~$ rails server
   ```

## Database Schema

The database schema is auto-generated from the current state of the database. Below is a brief overview of the tables:

### Users Table

- Stores user authentication details
- Attributes:
    - `id`: User ID
    - `provider`: Authentication provider (default: "email")
    - `uid`: Unique user identifier
    - `encrypted_password`: Encrypted password
    - `reset_password_token`: Token for resetting password
    - `reset_password_sent_at`: Timestamp when the reset password token was sent
    - `allow_password_change`: Flag indicating whether the user is allowed to change the password (default: false)
    - `remember_created_at`: Timestamp for remembering user session
    - `confirmation_token`: Token for confirming user's email address
    - `confirmed_at`: Timestamp when the user's email address was confirmed
    - `confirmation_sent_at`: Timestamp when the confirmation token was sent
    - `unconfirmed_email`: Unconfirmed email address
    - `name`: User's name
    - `email`: User's email address
    - `tokens`: Tokens for authentication
    - `created_at`: Timestamp for user creation
    - `updated_at`: Timestamp for user updates

### Movies Table

- Stores movie details fetched from the OMDB API
- Attributes:
  - `id`: Movie ID
  - `title`: Movie title
  - `year`: Release year
  - `plot`: Movie plot
  - `poster`: URL of movie poster image
  - `awards`: Awards received by the movie
  - `box_office`: Box office earnings
  - `dvd_release`: DVD release date
  - `imdb_id`: IMDB identifier
  - `imdb_rating`: IMDB rating
  - `imdb_votes`: Number of IMDB votes
  - `metascore`: Metascore rating
  - `production`: Production company
  - `rated`: Movie rating
  - `released`: Release date
  - `runtime`: Duration of the movie
  - `website`: Movie website URL
  - `created_at`, `updated_at`: Timestamps

### FavoriteMovies Table

- Associates users with their favorite movies
- Attributes:
  - `id`: Favorite Movie ID
  - `user_id`: Foreign key referencing the Users table
  - `movie_id`: Foreign key referencing the Movies table

### FavoriteMovieNotifications Table

- Stores notifications related to favorite movies
- Attributes:
  - `id`: Notification ID
  - `user_id`: Foreign key referencing the Users table
  - `movie_id`: Foreign key referencing the Movies table
  - `message`: Notification message
  - `created_at`, `updated_at`: Timestamps

### Other Tables

- `MovieActors`, `MovieDirectors`, `MovieGenres`, etc.: Store additional movie details like actors, directors, genres, etc.
- Attributes:
  - `id`: Record ID
  - `movie_id`: Foreign key referencing the Movies table
  - Attribute(s) specific to the respective entity (e.g., actor name, director name, genre, etc.)

# Testing

## Introduction

This document provides an overview of the testing strategies and tools used in the application.

## Types of Testing

### 1. Unit Testing

- **Description**: Unit tests focus on testing individual units or components of the application in isolation.
- **Tools**: [RSpec](https://rspec.info/), [Factory Bot](https://github.com/thoughtbot/factory_bot), [Faker](https://github.com/faker-ruby/faker)

### 2. Integration Testing

- **Description**: Integration tests verify the interaction between different components or modules of the application.
- **Tools**: [RSpec](https://rspec.info/), [Capybara](https://github.com/teamcapybara/capybara), [Selenium WebDriver](https://www.selenium.dev/documentation/en/webdriver/)

### 3. System Testing

- **Description**: System tests ensure that the application functions correctly as a whole, including all integrated components.
- **Tools**: [RSpec](https://rspec.info/), [Capybara](https://github.com/teamcapybara/capybara), [Selenium WebDriver](https://www.selenium.dev/documentation/en/webdriver/)

### 4. Acceptance Testing

- **Description**: Acceptance tests validate that the application meets the requirements specified by stakeholders.
- **Tools**: [RSpec](https://rspec.info/), [Capybara](https://github.com/teamcapybara/capybara), [Selenium WebDriver](https://www.selenium.dev/documentation/en/webdriver/)

## Running the Test Suite

To run the entire test suite, execute the following command:

```bash
rails@ruby:~$ bundle exec rspec
```

## Testing Environment Setup

### Development and Test Gems

- **rspec-rails**: Testing framework for Rails applications.
- **factory_bot_rails**: Provides utilities for creating test data.
- **faker**: Generates fake data for testing purposes.
- **capybara**: Helps in simulating user interactions with the application.
- **selenium-webdriver**: WebDriver implementation for browser automation.

### Configuration

- **rails_helper.rb**: Configuration file for RSpec.
- **spec/support**: Directory for storing additional test support files.

## Test Coverage

### SimpleCov

- **SimpleCov**: Ruby gem for code coverage analysis.
- **RSpec Formatter**: Integration with RSpec for generating coverage reports.
- **Thresholds**: Set minimum coverage thresholds for maintaining code quality.

## Continuous Integration

### GitHub Actions

- **Workflow Setup**: Configure GitHub Actions workflow for automated testing.
- **RSpec Jobs**: Define jobs for running RSpec test suite.
- **Test Coverage Job**: Include a job for generating and publishing test coverage reports.

## Best Practices

### RSpec Best Practices

- **Descriptive Examples**: Write descriptive example descriptions for clarity.
- **Focused Tests**: Use `focus` tag to run specific tests during development.
- **Shared Contexts**: Utilize shared contexts for common setup across tests.
- **Mocking and Stubbing**: Apply mocking and stubbing techniques for isolating dependencies.
- **Distributed Testing**: Consider distributed testing with parallelization for faster execution.

## Dependencies

### Gemfile

```ruby
source "https://rubygems.org"

ruby "3.3.0"

# Rails framework
gem 'rails', '7.0.8'

# Database adapter
gem "mysql2", "~> 0.5"

# Web server
gem "puma", ">= 5.0"

# Authentication
gem 'devise'
gem 'devise_token_auth'

# CORS
gem 'rack-cors', :require => 'rack/cors'

# Background processing
gem "sidekiq", "~> 7.2"

# JSON Web Tokens
gem "base64", "~> 0.2.0"

# Test and development dependencies
group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "byebug", "~> 11.1"
  gem 'rspec-rails', '~> 6.1.0'
  gem "factory_bot_rails", "~> 6.4"
  gem 'faker'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
```

## Contributing

Contributions are welcome! Here's how you can contribute to this project:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/feature-name`)
3. Make your changes
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/feature-name`)
6. Create a new Pull Request

Please make sure to update tests as appropriate.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE.md](LICENSE.md) file for details.