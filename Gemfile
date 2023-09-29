source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8"
gem 'redis', '~> 5.0', '>= 5.0.7'
gem 'redis-namespace', '~> 1.11'
gem 'rest-client', '~> 2.1'
gem 'rufus-scheduler', '~> 3.9', '>= 3.9.1'
gem 'sidekiq', '~> 7.1', '>= 7.1.4'
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'vcr', '~> 6.2'
gem 'webmock', '~> 3.19', '>= 3.19.1'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rubocop', '~> 1.56', '>= 1.56.3', require: false
  gem 'rubocop-rails', '~> 2.21', '>= 2.21.1', require: false
  gem 'rubocop-rspec', '~> 2.24', '>= 2.24.1', require: false
end

group :development do; end
