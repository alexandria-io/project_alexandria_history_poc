source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '~> 3.2.18'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'railroady'
end

group :production do
  gem 'pg'
end

gem 'haml-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'underscore-rails', '~> 1.4.4'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :test do 
  gem 'rspec-rails' 
  gem 'factory_girl_rails'
end

group :test do 
  gem 'faker' 
  gem 'capybara' 
  gem 'guard-rspec' 
  gem 'launchy' 
end

# ENV vars
gem 'figaro', '~> 0.7.0'

# Performance Monitoring
gem 'newrelic_rpm'

# Twitter OmniAuth
gem 'omniauth-twitter'

# HTTP Webservice Gem
gem 'httparty', '~> 0.13.0'

gem 'twitter'
