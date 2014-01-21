unless ENV['RAILS_ENV'] == 'test' || ENV['RAILS_GROUPS'] == 'assets'
  # load all default settings to DB if the table exists
  if ActiveRecord::Base.connection.tables.include?('settings')
    default_settings = YAML::load(File.open(Rails.root.join 'config', 'settings.yml'))
    default_settings.map {|s| Setting.find_or_create_by_name description: s[1]['description'], name: s[1]['name'], value: s[1]['value']}
  end

  # load all default snippets to DB if the table exists
  if ActiveRecord::Base.connection.tables.include?('snippets')
    default_snippets = YAML::load(File.open(Rails.root.join 'config', 'snippets.yml'))
    default_snippets.map {|s| Snippet.find_or_create_by_name description: s[1]['description'], name: s[1]['name'], value: s[1]['value']}
  end
end
