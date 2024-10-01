class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [ :username, :email, :password, :password_confirmation ])
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [ :login, :password, :password_confirmation ])
      devise_parameter_sanitizer.permit(:account_update,
        keys: [ :username, :email, :password_confirmation, :current_password ])
    end
end
