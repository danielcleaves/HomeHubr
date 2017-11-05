class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :check_phone_number, if: :current_user
  skip_before_action :check_phone_number, if: :devise_controller?
  protected

  def after_sign_in_path_for(_resource_or_scope)
    dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname phone_number description image])
  end

  def check_phone_number
    return if current_user.phone_number.present?
    redirect_to add_phone_number_path, alert: 'Please Update Phone number'
  end
end
