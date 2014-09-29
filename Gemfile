source 'https://rubygems.org'
ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.4'
gem 'pg', '~> 0.17.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'devise', '~> 3.2.4'
gem 'unicorn', '~> 4.8.2'
# Visual email testing
# [mail_view](https://github.com/37signals/mail_view)
gem 'mail_view', '~> 2.0.4'

# Send your application errors to our hosted service and reclaim your i...
# [airbrake](http://www.airbrake.io)
gem 'airbrake', '~> 4.1.0'

group :development, :test do
  gem 'spring', '~> 1.1.3'
  gem 'capybara', '~> 2.2.1'
  gem 'poltergeist', '~> 1.5.0'
  gem 'mocha', '~> 1.1.0', :require => false
  gem 'minitest-rails', '~> 2.1.0'
  gem 'database_cleaner'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'dotenv-rails', '~> 0.10.0'
  gem 'pry-rails', '~> 0.3.2'
end

group :production do
  # Run Rails the 12factor way
  # [rails_12factor](https://github.com/heroku/rails_12factor)
  gem 'rails_12factor', '~> 0.0.2'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
