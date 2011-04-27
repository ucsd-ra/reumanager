Capistrano::Configuration.instance(:must_exist).load do
  namespace :ubuntu do
    
    desc "Start Application"
    task :start, :roles => :app do
      run "touch #{current_release}/tmp/restart.txt"
    end

    desc "Stop Application"
    task :stop, :roles => :app do
      # Do nothing.
    end

    desc "Restart Application"
    task :restart, :roles => :app do
      run "touch #{current_release}/tmp/restart.txt"
    end
    
    desc "Creates an Apache 2.2 compatible virtual host configuration file"
    task :create_vhost, :roles => :web do
      template = File.read("config/ec2/apache_vhost.erb")
      buffer = ERB.new(template).result(binding)
      chown
      put buffer, "#{shared_path}/#{application}_apache_vhost.conf"
      sudo "cp #{shared_path}/#{application}_apache_vhost.conf /etc/apache2/sites-available/200-#{application}"
    end
    
    desc "Enables vhost"
    task :enable_vhost, :roles => :web do
      run "cd /etc/apache2/sites-available/"
      sudo "a2ensite 200-#{application}"
      reload_apache
    end
    
    desc "Disables vhost"
    task :disable_vhost, :roles => :web do
      run "cd /etc/apache2/sites-available/"
      sudo "a2dissite 200-#{application}"
      reload_apache
    end
    
    desc "Restart apache"
    task :restart_apache, :roles => :web do
      sudo "apache2ctl restart"
    end

    desc "Reload apache"
    task :reload_apache, :roles => :web do
      sudo "apache2ctl graceful"
    end
    
    desc "chown & chmod to www-data"
    task :chown do
      sudo "chown -R www-data:www-data #{deploy_to}"
      sudo "chmod -R 770 #{deploy_to}"
    end
  end
  
end