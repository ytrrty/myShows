class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:login, :email, :password)
    #devise_parameter_sanitizer.for(:edit).push(:login, :email, :password)

  end



end