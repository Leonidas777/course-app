class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :choose_layout

  private

  def choose_layout
    devise_controller? ? 'devise' : 'application'
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update) do |user_params|
  #     user_params.permit(:password, :password_confirmation, profile: [ :first_name, :last_name, :photo ])
  #   end
  # end
end
