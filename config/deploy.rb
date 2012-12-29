require "bundler/capistrano"
require "rvm/capistrano"
require "whenever/capistrano"

default_run_options[:pty] = true

set :application, "surf" #matches names used in smf_template.erb
set :backup_path, "#{shared_path}/system"
set :db_credentials_file, "db_credentials_file.yml"
set :db_root_credentials_file, "root_db_credentials_file.yml"
set :db_server_app, "mysql"
set :db_database_name, 'reu_production'
set :db_username, 'reu'
set :deploy_to, "/var/www/#{application}" # I like this location
set :domain, '192.168.126.147'
set :keep_releases, 2
set :passenger_port, 4060
set :passenger_cmd,  "passenger"
set :rails_env,      "production"
set :repository,  "https://vishnu.ucsd.edu/svn/nsfreu/branches/surf"
set :scm, :subversion
set :rvm_ruby_string, "ree@#{application}"
set :rvm_type, :system
set :scm_passphrase, "5'utr $Saihung"
set :user, "ubuntu"
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

## modified for passenger standalone

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
