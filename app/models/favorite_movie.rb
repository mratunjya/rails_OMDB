class FavoriteMovie < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    after_save :save_notification
    after_destroy :destroy_notification

    private
        def save_notification
            # Saving the new notification to Favorite Movie Notification for marking a movie as favorite
            SendToggleFavoriteNotificationToUser.perform_async(self.movie_id, self.user_id, "You have marked #{self.movie.title} as your favorite movie")
        end

        def destroy_notification
            # Saving the new notification to Favorite Movie Notification for marking a movie as unfavorite
            SendToggleFavoriteNotificationToUser.perform_async(self.movie_id, self.user_id, "You have unmarked #{self.movie.title} as your favorite movie")
        end
end
