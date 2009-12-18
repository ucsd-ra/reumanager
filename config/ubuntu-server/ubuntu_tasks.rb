Capistrano::Configuration.instance(:must_exist).load do
  namespace :ubuntu do
    
    desc "Adds mongrel_cluster.yml for startup"
    task :create_mongrel_startup, :roles => :app do
      sudo "chown -R mongrel.www-data #{deploy_to}"
      sudo "ln -fs #{current_path}/config/mongrel_cluster.yml /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
    end
  
    desc "Creates an Apache 2.2 compatible virtual host configuration file"
    task :create_vhost, :roles => :web do
      public_ip = "132.239.236.123"
      cluster_info = YAML.load(File.read('config/mongrel_cluster.yml'))

      start_port = cluster_info['port'].to_i
      end_port = start_port + cluster_info['servers'].to_i - 1
      public_path = "#{current_path}/public"
      
      template = File.read("config/ubuntu-server/apache_vhost.erb")
      buffer = ERB.new(template).result(binding)
      
      put buffer, "#{shared_path}/#{application}-apache-vhost.conf"
      sudo "cp #{shared_path}/#{application}-apache-vhost.conf /etc/apache2/sites-available/#{application}"
      sudo "a2ensite #{application}"
      sudo "chown -R mongrel.www-data #{deploy_to}"
      restart_apache
    end
    
    desc "Restarts apache"
    task :restart_apache, :roles => :web do
      sudo "apache2ctl graceful"
    end
    
    desc "Stops the mongrel cluster"
    task :stop_mongrel, :roles => :app do
      sudo "/usr/bin/mongrel_rails cluster::stop -C /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
    end
  
    desc "Starts the mongrel cluster"
    task :start_mongrel, :roles => :app do
      sudo "chown -R mongrel.www-data #{deploy_to}"      
      sudo "/usr/bin/mongrel_rails cluster::start -C /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
    end
  
    desc "Restarts the mongrel cluster"
    task :restart_mongrel do
      sudo "chown -R mongrel.www-data #{deploy_to}"
      sudo "/usr/bin/mongrel_rails cluster::restart -C /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
    end
 
    desc "Deletes the mongrel cluster configuration from the system startup"
    task :delete_mongrel, :roles => :app do
      sudo "rm /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
    end
    
    desc "After setup, creates mongrel config file and adds Apache vhost"
    task :setup_mongrel_and_vhost do
      create_mongrel_startup
      create_vhost
    end
    
    desc "Updates mongrel_cluster.yml for startup"
    task :update_mongrel_startup, :roles => :app do
      sudo "ln -fs #{current_path}/config/mongrel_cluster.yml /etc/mongrel_cluster/#{application}-mongrel_cluster.yml"
      sudo "chown -R mongrel.www-data #{deploy_to}"
    end
  end
  
  after 'deploy:setup', 'ubuntu:setup_mongrel_and_vhost'
  after 'deploy:cold', 'ubuntu:update_mongrel_startup'
  before 'deploy:start','ubuntu:update_mongrel_startup'
  
end