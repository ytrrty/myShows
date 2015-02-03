class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:login, :email, :password, :avatar)
    devise_parameter_sanitizer.for(:account_update).push(:login, :email, :password, :avatar)

  end

end