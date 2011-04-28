raw_config = File.read(RAILS_ROOT + "/config/settings.yml")
APP_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
