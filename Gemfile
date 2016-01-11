source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '5.0.0.beta1'
gem 'sprockets-rails', github: "rails/sprockets-rails"
gem 'sprockets', github: "rails/sprockets"
gem 'sass-rails', github: "rails/sass-rails"
gem 'arel', github: "rails/arel"
gem 'rack', github: "rack/rack"

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'pg'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', github: "rails/coffee-rails"
gem 'puma'
gem 'redis'
gem 'rack-cors'
gem 'coveralls', require: false
gem 'activerecord_json_validator'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'active_model_serializers', '~> 0.10.0.rc2'
gem 'swagger-docs'
gem 'rails-controller-testing'

group :production do
  gem 'skylight'
  gem 'rollbar', '~> 2.7.1'
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'dotenv-rails'
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'simplecov', require: false
  gem 'rubocop', require: false
  gem 'reek', require: false
  gem 'yard', '~> 0.8.7.6'
  gem 'factory_girl_rails'
  # help to kill N+1 queries and unused eager loading
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', github: 'rails/web-console'
  gem 'quiet_assets'
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  # Loading the listen gem enables an evented file system monitor. Check
  # https://github.com/guard/listen#listen-adapters if on Windows or *BSD.
  # gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'json-schema'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
