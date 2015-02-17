class ApplicationController < ActionController::Base
  before_action :authenticate_admin!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test_exception_notifier
    fail 'This is just a test to make sure Exception Notifier is working properly.'
  end

  def authenticate_admin!
    return unless current_user.try(:admin?)
    fail 'error' unless current_user && current_user.admin?
  end
end
