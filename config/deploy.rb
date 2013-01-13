require "bundler/capistrano"
require "rvm/capistrano"
require "whenever/capistrano"

set :application, "be" #matches names used in smf_template.erb
set :repository,  "https://vishnu.ucsd.edu/svn/nsfreu/branches/ucsd_bioengineering"
set :domain, "192.168.10.103"
set :deploy_to, "/var/www/#{application}" # I like this location
set :user, "ubuntu"
set :keep_releases, 2
set :rvm_ruby_string, "ree@#{application}"
set :rvm_type, :system
set :scm, :subversion

default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true

## modified for passenger standalone
set :rails_env,      "production"
set :passenger_port, 4010
set :passenger_cmd,  "bundle exec passenger"
set :whenever_command, "bundle exec whenever"

# variables for cap-db
set :backup_path, "#{shared_path}/system"
set :db_credentials_file, "db_credentials_file.yml"
set :db_root_credentials_file, "root_db_credentials_file.yml"
set :db_server_app, "mysql"
set :db_database_name, 'reu_demo_production'
set :db_username, 'reu_be'


namespace :deploy do
  
  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R #{user}:www-data #{deploy_to}"
    sudo "chmod -R 770 #{deploy_to}"
  end
  
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    chown
    run <<-CMD
      if [[ -f #{current_path}/tmp/pids/passenger.#{passenger_port}.pid ]];
      then
        cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port};
      fi
    CMD
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end
end
