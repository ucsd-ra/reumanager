require 'erb'
require 'config/ubuntu-server/ubuntu_tasks'
 
set :application, "nsfreu" #matches names used in smf_template.erb
set :repository,  "https://www.be.ucsd.edu/svn/nsfreu/trunk"
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/rails/#{application}" # I like this location
set :user, "jgrevich"
set :group, 'www-data'
 
set :domain, 'be.ucsd.edu'
 
role :app, domain
role :web, domain
role :db,  domain, :primary => true
 
set :server_name, "be.ucsd.edu"
 
deploy.task :restart do
  ubuntu.restart_mongrel
  ubuntu.restart_apache
end
 
deploy.task :start do
  ubuntu.start_mongrel
  ubuntu.restart_apache
end
 
deploy.task :stop do
  ubuntu.stop_mongrel
  ubuntu.restart_apache
end

after :deploy, 'deploy:cleanup'