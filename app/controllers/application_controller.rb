class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'mailchimp'

  protect_from_forgery with: :exception

  before_action :setup_mcapi

  def setup_mcapi
    @mc = Mailchimp::API.new('aa3920184d9c25995efadfdda3f13803-us11')
    @list_id = "06501061ee"
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :card, :subscribe_to,:password_confirmation, :last_name, :email, :password, :phone) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :card, :subscribe_to,:password_confirmation, :last_name, :email, :password, :phone, :current_password, :is_female, :date_of_birth) }
    end


end
