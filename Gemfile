source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "dotenv-rails"
gem "omniauth"
gem "omniauth-github"
gem "omniauth-vkontakte"
gem "omniauth-rails_csrf_protection"
gem "image_processing", ">= 1.2"
gem "mailjet"
gem "ruby-vips"
gem "activestorage-validator"
gem "aws-sdk-s3"
gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "resque"
gem "pundit"
gem "jsbundling-rails"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "rails-i18n"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "letter_opener"
  gem "rspec-rails"
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "capistrano", "~> 3.0"
  gem "capistrano-rbenv"
  gem "capistrano-nvm", require: false
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-bundler"
  gem "capistrano-yarn"
  gem "capistrano-resque", require: false
  gem "web-console"
end

group :production do
  gem "pg"
end
