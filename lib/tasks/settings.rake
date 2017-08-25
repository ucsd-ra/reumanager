namespace :settings do
  desc 'Load all the settings from the yaml file'
  task :load => :environment do
    unless ENV['RAILS_ENV'] == 'test' || ENV['RAILS_GROUPS'] == 'assets'
      # load all default settings to DB if the table exists
      if ActiveRecord::Base.connection.tables.include?('settings')
        default_settings = YAML::load(File.open(Rails.root.join 'config', 'settings.yml'))
        default_settings.map do |s|
          Setting.find_or_create_by(name:s[1]['name']) do |setting|
            setting.description = s[1]['description']
            setting.name = s[1]['name']
            setting.value = s[1]['value']
          end
        end
      end

      # load all default snippets to DB if the table exists
      if ActiveRecord::Base.connection.tables.include?('snippets')
        default_snippets = YAML::load(File.open(Rails.root.join 'config', 'snippets.yml'))
        default_snippets.map do |s|
          Snippet.find_or_create_by(name: s[1]['name']) do |snippet|
            snippet.description = s[1]['description']
            snippet.name = s[1]['name']
            snippet.value = s[1]['value']
          end
        end
      end
    end
  end
end
