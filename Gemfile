source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'bundler', '>= 1.8.4'

gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'mandrill-api'

gem 'bcrypt', :require => 'bcrypt'

gem 'jquery-datatables-rails', github: "rweng/jquery-datatables-rails", branch: "master"

gem 'slim'

gem 'browserify-rails'

gem 'ffaker'

gem 'gretel'

group :production do
  gem 'puma'
end

group :development, :test do
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'rspec-rails', '~> 3.3.3'
  gem 'capybara', '~> 2.4.4'
  gem 'guard-rspec', '~> 4.6.3'
  gem 'growl'
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'mocha'
  gem 'rubocop'
  gem 'database_cleaner'
  gem 'timecop', '~>0.8.0'
end

group :development do
  gem 'guard-bundler', require: false
  gem 'rb-readline'
  gem 'capistrano', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-npm', require: false
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]

gem 'rack-cors',
:require => 'rack/cors'
