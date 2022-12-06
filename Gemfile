# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.4'
gem 'zeitwerk', '~> 2.6.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'grape'
gem 'grape_on_rails_routes'
gem 'devise'
gem 'devise-jwt'
gem 'rack-cors'
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false
gem 'sendgrid-actionmailer'
gem 'twilio-ruby'
gem 'phonelib'
gem 'grape-entity'
gem 'grape-swagger-entity'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'pundit'
gem 'blueprinter'
gem 'kaminari'
gem 'countries', require: 'countries/global'

# Soft delete
gem 'discard', '~> 1.2'

group :development, :test do
  gem 'rspec-rails'

  gem 'pundit-matchers', '~> 1.7.0'
  gem 'rubocop', '~> 1.36', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'timecop'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'reek'
end

group :test do
  gem 'super_diff'
end
