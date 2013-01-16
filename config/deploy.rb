require "bundler/capistrano"
require "rvm/capistrano"
require 'capistrano/ext/database'

set :rvm_ruby_string, "1.9.3@reu"
set :rvm_type, :system

default_run_options[:pty] = true

set :application, "reu"
set :deploy_to, "/var/www/#{application}" # I like this location
#set :domain, "vishnu.ucsd.edu"
set :domain, "192.168.10.103"
set :keep_releases, 2
set :repository,  "https://vishnu.ucsd.edu/svn/nsfreu/branches/#{application}"
set :scm, :subversion
set :user, 'ubuntu'

set :db_credentials_file, "db_credentials_file.yml"
set :db_root_credentials_file, "root_db_credentials_file.yml"
set :db_server_app, "mysql"
set :db_database_name, 'reu_production'
set :db_username, 'reu'
set :backup_path, "#{shared_path}/system"

# set :mysqldump_bin, "/usr/local/mysql/bin/mysqldump"
#set :mysqldump_remote_tmp_dir, "/tmp"
#set :mysqldump_local_tmp_dir, "/tmp"
#set :mysqldump_location, :remote

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    chown
    symlink_sub_uri
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R #{user}:www-data #{deploy_to}"
    sudo "chmod -R 770 #{deploy_to}"
  end
  
  desc "Create symlinks for sites that run from sub-uris"
  task :symlink_sub_uri do
    run "ln -s /var/rails/be/current/public #{current_path}/public/be"
    run "ln -s /var/rails/git/current/public #{current_path}/public/git"
    run "ln -s /var/rails/reu3/current/public #{current_path}/public/reu3"
    run "ln -s /var/rails/surf/current/public #{current_path}/public/surf"
    run "ln -s /var/rails/uf/current/public #{current_path}/public/uf"
  end
  
  namespace :assets do

      # task :precompile, :roles => :web, :except => { :no_release => true } do
      #   unquote to precompile assets on deploy   
      #   run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      #   logger.info "Skipping asset pre-compilation because there were no asset changes"
      # end

     desc 'Run the precompile task locally and rsync with shared'
     task :precompile, :roles => :web, :except => { :no_release => true } do
       %x{bundle exec rake assets:precompile}
       %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{domain}:#{shared_path}}
       %x{bundle exec rake assets:clean}
     end
  end
  
end

after "deploy:update", "deploy:cleanup" 