class MovieLanguage < ApplicationRecord
    belongs_to :movie, inverse_of: :movie_languages
end