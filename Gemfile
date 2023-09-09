source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg'
gem 'puma', '~> 4.1'
gem 'psych', '~> 3.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'webpacker', '~> 5.0'

gem 'rake'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'spring-commands-rspec'
  gem 'webdrivers', '5.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
