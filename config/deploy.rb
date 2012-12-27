require "bundler/capistrano"
require "rvm/capistrano"
require 'capistrano/ext/database'

set :rvm_ruby_string, "1.9.3@reu"
set :rvm_type, :system

default_run_options[:pty] = true

set :application, "reu3" #matches names used in smf_template.erb
set :deploy_to, "/var/www/#{application}" # I like this location
set :domain, "192.168.126.147"
set :keep_releases, 2
set :repository,  "https://vishnu.ucsd.edu/svn/nsfreu/branches/#{application}"
set :scm, :subversion
set :scm_passphrase, "5'utr $Saihung"
set :user, 'ubuntu'
set :use_sudo, false

set :db_credentials_file, "db_credentials_file.yml"
set :db_root_credentials_file, "root_db_credentials_file.yml"
set :db_server_app, "mysql"
set :db_database_name, 'reu_production'
set :db_username, 'reu'
set :backup_path, "#{shared_path}/system"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R ubuntu:www-data #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end
end
