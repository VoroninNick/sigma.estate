class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'mailchimp'

  protect_from_forgery with: :exception

  before_action :setup_mcapi
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def setup_mcapi
    @mc = Mailchimp::API.new('aa3920184d9c25995efadfdda3f13803-us11')
    @list_id = "06501061ee"
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar) }
    end
end
