class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  require 'mailchimp'


  protect_from_forgery with: :exception

  before_action :setup_mcapi
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # after_filter :store_location , if: proc{params[:controller]== "sessions"}
  

  def setup_mcapi
    @mc = Mailchimp::API.new('aa3920184d9c25995efadfdda3f13803-us11')
    @list_id = "06501061ee"
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :middle_name, :phone_number, :email, :password, :password_confirmation, :remember_me, :subscribe) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :middle_name, :phone_number, :email, :password, :password_confirmation, :current_password, :avatar, :subscribe) }
    end


after_filter :store_location

 def store_location
   # store last url - this is needed for post-login redirect to whatever the user last visited.
   return unless request.get?
   if (request.path != "/users/sign_in" &&
       request.path != "/users/sign_up" &&
       request.path != "/users/password/new" &&
       request.path != "/users/password/edit" &&
       request.path != "/users/confirmation" &&
       request.path != "/users/sign_out" &&
       !request.xhr?) # don't store ajax calls
     session[:previous_url] = request.fullpath
   end
 end

 def after_sign_in_path_for(resource)
   session[:previous_url] || root_path
 end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
    # render template: "errors/access_denied", layout: "not_found"
  end
  # def store_location
  #   # store last url as long as it isn't a /users path
  #   session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  # end
  #
  # def after_sign_in_path_for(resource)
  #   session[:previous_url] || root_path
  # end
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
