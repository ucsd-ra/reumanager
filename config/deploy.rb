require "bundler/capistrano"
require "rvm/capistrano"

#set :application, "reu_surf" #matches names used in smf_template.erb
set :application, "surf" #matches names used in smf_template.erb
set :repository,  "https://github.com/ucsd-ra/reumanager.git"
set :branch, :surf
set :domain, "indra.ucsd.edu"
set :deploy_to, "/var/www/#{application}" # I like this location
set :deploy_via, :remote_cache
set :user, "ubuntu"
set :keep_releases, 3
set :rvm_ruby_string, "ree@#{application}"
set :rvm_type, :system
set :scm, :git

default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true

## modified for passenger standalone
set :rails_env,      "production"
set :thin_port, 4020
set :thin_cmd,  "bundle exec thin"
set :whenever_command, "bundle exec whenever"

# variables for cap-db
set :backup_path, "#{shared_path}/system"
set :db_credentials_file, "db_credentials_file.yml"
set :db_root_credentials_file, "root_db_credentials_file.yml"
set :db_server_app, "mysql"
set :db_database_name, 'surf_production'
set :db_username, 'surf'

namespace :deploy do

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R #{user}:www-data #{deploy_to}"
    sudo "chmod -R 770 #{deploy_to}"
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{thin_cmd} start -e #{rails_env} -p #{thin_port} -d"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{thin_cmd} stop -p #{thin_port}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    chown
    run "cd #{current_path} && #{thin_cmd} restart"
  end
end
