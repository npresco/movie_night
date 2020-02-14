# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "chartkick"
gem "differ", require: false
gem "httparty"
gem "jbuilder", "~> 2.5"
gem "pagy"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "premailer-rails"
gem "puma", "~> 3.12"
gem "rails", "~> 6.0.0"
gem "themoviedb-api"
gem "turbolinks", "~> 5"
gem "turbolinks_render"
gem "webpacker", "~> 4.0"
gem "whenever", require: false

gem "capistrano", "~> 3.11"
gem "capistrano-passenger", "~> 0.2.0"
gem "capistrano-rails", "~> 1.4"
gem "capistrano-rbenv", "~> 2.1", ">= 2.1.4"

gem "prometheus-client"
gem "yabeda-prometheus"
gem "yabeda-rails"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "awesome_print"
  gem "brakeman"
  gem "faker"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "pry-rails"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "webdrivers"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
end
