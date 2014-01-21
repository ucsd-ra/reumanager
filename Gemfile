if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'http://rubygems.org'
source 'http://gems.github.com'

gem 'rails', '~>3.2.12'

gem 'addressable'
gem 'carmen-rails'
gem 'client_side_validations'
gem 'cocaine', :git => 'git://github.com/thoughtbot/cocaine.git' 
gem 'capistrano'
gem 'devise'
gem 'factory_girl_rails'
gem 'faker'
gem 'haml'
gem 'jquery-rails', '~> 2.1.0'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'mysql2'
gem 'paperclip'
gem 'paper_trail'
gem 'rails_admin'
gem 'redcarpet'
gem 'rich'
gem 'rvm-capistrano'
gem 'state_machine'
gem 'whenever', :require => false
gem 'validates_email_format_of'

group :assets do
  gem 'bootstrap-sass', '~> 2.1.1.0'
  gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails', :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'font-awesome-sass-rails'
  gem 'libv8', '~> 3.11.8'
  gem 'modernizr-rails'
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'awesome_print'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'bond'
  gem 'crack'
  gem 'hirb-unicode'
  gem 'meta_request'
  gem 'net-http-spy'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'ruby_gntp'
  gem 'ruby-graphviz', :require => 'graphviz' 
  gem 'simplecov'
  gem 'what_methods'
	gem 'wirble'
end

group :test, :development do
  gem 'capybara'
  gem "capybara-webkit"
  gem 'database_cleaner'
  gem 'debugger'
  gem 'launchy'
  gem 'poltergeist'
  gem "rspec-rails", "~> 2.0"
end

group :test do
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'mocha', require: "mocha/api"
  gem 'shoulda'
  gem 'sqlite3'
end
