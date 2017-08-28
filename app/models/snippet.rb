class Snippet < ApplicationRecord
  attr_accessible :description, :name, :value, :display_name
  attr_accessor :display_name
  cattr_accessor :available_snippets

  validates_uniqueness_of :name

  # Returns the value of the setting named name
  def self.[](name)
    name = name.to_s
    setting = find_by_name(name)
    setting ? setting.value : nil
  end

  def self.load_from_yaml
    default_snippets = YAML::load(File.open(Rails.root.join 'config', 'snippets.yml'))
    default_snippets.map do |s|
      Snippet.find_or_create_by(name: s[1]['name']) do |snippet|
        snippet.description = s[1]['description']
        snippet.name = s[1]['name']
        snippet.value = s[1]['value']
      end
    end
  end

  def display_name
    name.gsub('_',' ').titleize
  end

end
