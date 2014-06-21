source "https://rubygems.org"

ruby "2.1.2"

gem "rails", "4.1.1"
gem "pg"
gem "slim-rails", "~> 2.1.5"
gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "jbuilder", "~> 2.0"
gem "bcrypt", "~> 3.1.7"
gem "nokogiri"
gem "geocoder"

group :production do
  gem "unicorn"
  gem "rails_12factor"
end

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
end

group :development do
  gem "spring"
end

group :test do
  gem "factory_girl_rails", "~> 4.4.1"
  gem "database_cleaner"
end

