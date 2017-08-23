class Setting < ApplicationRecord
  attr_accessor :display_name
  attr_accessible :name, :description, :value, :display_name
  validates_uniqueness_of :name

  # Returns the value of the setting named name
  def self.[](name)
    name = name.to_s
    setting = find_by_name(name)

    setting ? setting.value : nil
  end

  def display_name
    name.gsub('_',' ').titleize
  end

end
