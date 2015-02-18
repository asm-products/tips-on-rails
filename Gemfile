source 'https://rubygems.org'

#Ruby version
ruby '2.1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use mysql as the database for Active Record
gem 'mysql2' 
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Oauth gem for GitHub
gem 'omniauth-github', '~> 1.1.2'
# Devise
gem 'devise'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
#Twitter Boostrap
gem 'bootstrap-sass'
gem 'sprockets'
# Draper adds an object-oriented layer of presentation logic. Instructions: https://github.com/drapergem/draper
gem 'draper'
# Exception notification for Rails apps
gem 'exception_notification'
#Authorization
gem 'cancancan', '~> 1.8'
gem 'pygments.rb'
gem 'redcarpet'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'sitemap_generator'
# Makes sending HTML emails a little less painful by inlining stylesheets and rewriting relative URLs
gem 'roadie-rails', '~> 1.0.4'

gem 'friendly_id', '~> 5.1.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'thin'
  #preview email in the browser instead of sending it.
  gem 'letter_opener'
 #Better Errors replaces the standard Rails error page with a much better and more useful error page.
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
end
