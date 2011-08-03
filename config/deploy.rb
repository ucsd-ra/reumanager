require 'erb'
require 'config/ubuntu-server/ubuntu_tasks'
default_run_options[:pty] = true

set :application, "nsfreu" #matches names used in smf_template.erb
set :repository,  "https://www.be.ucsd.edu/svn/nsfreu/trunk"
set :domain, 'laguna.ucsd.edu'
set :deploy_to, "/var/rails/#{application}" # I like this location
set :user, "beadmin"
set :keep_releases, 2

role :app, domain
role :web, domain
role :db,  domain, :primary => true
 
set :server_name, "fortuna.ucsd.edu"

deploy.task :restart do
  ubuntu.restart
end
 
deploy.task :start do
  ubuntu.start
end
 
deploy.task :stop do
  ubuntu.stop
end

after :deploy, 'deploy:cleanup'
after :deploy, 'ubuntu:chown'