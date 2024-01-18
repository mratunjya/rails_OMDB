class ApplicationController < ActionController::Base
        # Before action to configure permitted parameters for Devise controllers.
        before_action :configure_permitted_parameters, if: :devise_controller?

        # Include DeviseTokenAuth concern to set the user based on the token.
        include DeviseTokenAuth::Concerns::SetUserByToken

        # Protect from CSRF attacks by using a null session.
        protect_from_forgery with: :null_session

        protected

        # Method to configure permitted parameters for Devise sign-up.
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
end