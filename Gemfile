# frozen_string_literal: true

ruby '2.5.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.8'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'serviceworker-rails',
    git: 'https://github.com/rossta/serviceworker-rails.git',
    ref: '757db5354c9e47a144397c4655f3d1cab6046bc0'
gem 'webpacker', '~> 4.0'
gem 'webpush', '~> 0.3.7'

gem 'clearance'
gem 'clockwork'
gem 'ddtrace'
gem 'delayed_job_active_record'
gem 'easypost'
gem 'geocoder'
gem 'google-api-client'
gem 'google-cloud-pubsub'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'rest-client'
gem 'scenic'
gem 'sentry-raven'
gem 'simple_form'
gem 'tracking_number'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rubocop-coreyja', '0.3.0'

  gem 'capybara'
  gem 'capybara-selenium'
  gem 'factory_bot_rails'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'webvalve'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.1.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'flamegraph'
  gem 'rack-mini-profiler', require: false
  gem 'stackprof'

  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'rubocop-junit-formatter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
