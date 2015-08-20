class RegistrationsController < Devise::RegistrationsController
  # before_filter :update_sanitized_params, only: [:update]

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # def update_sanitized_params
  #     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar, :subscribe) }
  #
  # end
  def after_update_path_for(resource)
    cabinet_profile_path

  end
  #
  # def user_update_params
  #   params[:user].permit(:email, :username, :avatar)
  #
  # end
end
