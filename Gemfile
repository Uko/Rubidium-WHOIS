source 'http://rubygems.org'

gem 'rails', '3.2.3'
gem 'whois', :git => 'git://github.com/Uko/whois.git'
gem 'haml', '~> 3.1.5'

group :production do
  gem 'thin', '~> 1.3.1'
  gem 'exception_notification', '~> 2.6.1'
  gem 'newrelic_rpm'
  gem 'google-analytics-rails'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',           '>= 1.0.3'
  gem 'twitter-bootstrap-rails', '~> 2.0.7'
end

gem 'jquery-rails'

group :test, :development do
  gem 'rspec-rails', '~> 2.0'
end

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  # gem 'database_cleaner'
end