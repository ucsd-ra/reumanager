namespace :settings do
  desc 'Load all the settings from the yaml file'
  task :load => :environment do
    unless ENV['RAILS_ENV'] == 'test' || ENV['RAILS_GROUPS'] == 'assets'
      # load all default settings to DB if the table exists
      if ActiveRecord::Base.connection.tables.include?('settings')
        Setting.load_from_yaml
      end

      # load all default snippets to DB if the table exists
      if ActiveRecord::Base.connection.tables.include?('snippets')
        Snippet.load_from_yaml
      end
    end
  end
end
