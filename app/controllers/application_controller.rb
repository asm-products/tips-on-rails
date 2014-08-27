class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test_exception_notifier
    raise 'This is just a test to make sure Exception Notifier is working properly.'
  end

  def authenticate_admin!
    if current_user.try(:admin?)
    raise "error" unless current_user and current_user.admin?
  end
end

private

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:last_name, :first_name, :email, :password, :password_confirmation) }
	end
end