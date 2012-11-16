require "bundler/capistrano"
require "rvm/capistrano"

set :rvm_ruby_string, "1.9.3@microcirculation"
set :rvm_type, :user

default_run_options[:pty] = true

set :application, "reu"
set :deploy_to, "/var/rails/#{application}" # I like this location
set :domain, "vishnu.ucsd.edu"
set :keep_releases, 2
set :repository,  "https://vishnu.ucsd.edu/svn/#{application}/trunk"
set :scm, :subversion
set :user, 'ubuntu'
set :use_sudo, false

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R ubuntu:www-data #{deploy_to}"
    sudo "chmod -R 770 #{deploy_to}"
  end
  
  namespace :assets do

#      task :precompile, :roles => :web, :except => { :no_release => true } do
      # unquote to precompile assets on deploy   
 #      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      # logger.info "Skipping asset pre-compilation because there were no asset changes"
#     end

     desc 'Run the precompile task locally and rsync with shared'
     task :precompile, :roles => :web, :except => { :no_release => true } do
       %x{bundle exec rake assets:precompile}
       %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{domain}:#{shared_path}}
       %x{bundle exec rake assets:clean}
     end
  end
  
end

after "deploy:update", "deploy:cleanup"
after :deploy, 'deploy:chown'