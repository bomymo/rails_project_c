class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    ## To permit attributes while registration i.e. sign up (app/views/devise/registrations/new.html.erb)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    ## To permit attributes while editing a registration (app/views/devise/registrations/edit.html.erb)
    #devise_parameter_sanitizer.permit(:account_update) << :first_name << :last_name
  end
end
