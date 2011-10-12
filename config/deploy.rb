require "bundler/capistrano"
require "rvm/capistrano"
set :application, "nsfreu" #matches names used in smf_template.erb
set :repository,  "https://vishnu.ucsd.edu/svn/#{application}/trunk"
set :domain, 'vishnu.ucsd.edu'
set :deploy_to, "/var/rails/#{application}" # I like this location
set :user, "ubuntu"
set :keep_releases, 2
set :rvm_ruby_string, "ree@#{application}"
set :server_name, "vishnu.ucsd.edu"

default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true

## modified for passenger standalone
set :rails_env,      "production"
set :passenger_port, 4010
set :passenger_cmd,  "passenger"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [[ -f #{current_path}/tmp/pids/passenger.#{passenger_port}.pid ]];
      then
        cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port};
      fi
    CMD
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end
end
