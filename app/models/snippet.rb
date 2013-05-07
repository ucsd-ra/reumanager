class Snippet < ActiveRecord::Base
  attr_accessible :description, :name, :value
  cattr_accessor :available_snippets

  validates_uniqueness_of :name

  # Returns the value of the setting named name
  def self.[](name)
    name = name.to_s
    setting = find_by_name(name)
    setting ? setting.value : nil
  end
end
