# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Specify ActionMailer sending defaults to use Sendgrid
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['MAIL_USERNAME'],
  :password => ENV['MAIL_PASSWORD'],
  :domain => "tipsonrails.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}