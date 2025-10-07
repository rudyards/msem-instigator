source "https://rubygems.org"

ruby ">= 2.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 6.0.1"
# Use SCSS for stylesheets
gem "sass-rails"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"

gem "bootstrap", "~> 4.3.1"
gem "rails-assets-tether"
gem "select2-rails"
gem 'concurrent-ruby', '1.3.4'
gem "net-smtp", require: false # Ruby 3.1 issue

# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Unicorn as the app server
# gem "unicorn"

gem "haml"
gem "will_paginate"
gem "damerau-levenshtein"
gem "famfamfam_flags_rails"
gem "nokogiri", "1.12.0"

gem "sprockets", "3.4.0"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "pry"
  gem "erb2haml"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "listen"
  gem "pathname-glob"
end

group :test do
  gem "rspec-rails"
end

group :production do
  gem "puma"
end
