git_source(:github) { |repo| "https://github.com/#{repo}.git" }
source "https://rubygems.org"

ruby "3.4.2"
gem "rails", "~> 8.0.2"

gem "bcrypt", "~> 3.1"
gem 'sendgrid-ruby' # Required for sending password resets and confirmations

gem "jsbundling-rails"
gem "cssbundling-rails"
gem "propshaft"

gem "sqlite3"
gem "puma"
gem "paranoia"

gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"

# For notifications
gem "apnotic", "~> 1.7"
gem "noticed", "~> 2.6"
gem "googleauth" # For Google App Notifications

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis"

gem 'kaminari'

# Using: https://cloud.linode.com/object-storage/buckets
gem "aws-sdk-s3"

# To get City or County from profile LAT/LON
gem "geocoder"

# To generate QR codes for events
gem "rqrcode"

# to generate unique slugs for groups
gem "nanoid"

# Allows us to sort with SortableJS
gem "acts_as_list"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing"

group :production do
  gem 'mini_racer'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]

  gem "faker"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Open emails in browser in dev mode
  gem "letter_opener"

  gem "ruby-lsp"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"

  # allow assert_called
  gem "minitest-mock_expectations"
end
