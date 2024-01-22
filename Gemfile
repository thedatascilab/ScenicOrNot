# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.1.4"

gem "activerecord-import", "~> 1.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", ">= 4.3.1"
gem "coffee-rails", "~> 5.0"
gem "cssbundling-rails", "~> 1.3"
gem "high_voltage"
gem "jbuilder", "~> 2.11"
gem "jquery-rails"
gem "jsbundling-rails", "~> 1.3"
gem "lograge", "~> 0.14"
gem "pg"
gem "pry-rails"
gem "mini_racer"
gem "puma", "~> 6.4"
gem "rollbar"
gem "rails", "~> 7.1.3"
gem "smarter_csv", "~> 1.10"
gem "dartsass-sprockets"
gem "sprockets-rails", ">=2.3.2"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "uglifier", ">= 1.3.0"
gem "sd_notify"

group :development do
  gem "better_errors"
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "rails_layout"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "standard"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "climate_control"
end
