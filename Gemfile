if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'http://gems.github.com'
source 'https://rubygems.org'

gem 'rails'

gem 'addressable'
gem 'carmen-rails', github: 'jim/carmen-rails', :branch => 'master'
gem 'rails4_client_side_validations', github: "kalkov/rails4_client_side_validations", :branch => "master"
gem 'cocaine', :git => 'git://github.com/thoughtbot/cocaine.git' 
gem 'capistrano'
gem 'devise', github: 'wesvetter/devise', :branch => 'v2.2'
gem 'factory_girl_rails'
gem 'faker'
gem 'haml'
gem 'jquery-rails'
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

# Old assets group
gem 'bootstrap-sass', '~> 2.0.4.2'
gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails', :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
gem 'libv8'
gem 'modernizr-rails'
gem 'therubyracer'
gem 'sass-rails'
gem 'uglifier'

# Gems for smooth transition to Rails 4
gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'

group :development do
  gem 'awesome_print'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'bond'
  gem 'crack'
  gem 'hirb-unicode'
  gem 'meta_request'
  gem 'net-http-spy'
  gem 'pry'
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
  gem "rspec-rails"
end

group :test do
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'mocha', require: "mocha/api"
  gem 'shoulda'
  gem 'sqlite3'
end
