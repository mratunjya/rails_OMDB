class SendToggleFavoriteNotificationToUser
    include Sidekiq::Worker

    def perform(movie_id, user_id, message)
        begin
            user = User.find(user_id)

            user.favorite_movie_notifications.create!({
                movie_id: movie_id,
                message: message
            })
        rescue => e
            puts e
            Rails.logger.error e
        end
    end
end