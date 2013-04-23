class Setting < ActiveRecord::Base
  attr_accessible :name, :object_class, :value
  cattr_accessor :available_settings
  @@available_settings = YAML::load(File.open(Rails.root.join 'config', 'application.yml'))

    validates_uniqueness_of :name

    # Returns the value of the setting named name
    def self.[](name)
      name = name.to_s
      setting = find_by_name(name)
      setting ? find_by_name(name).value : @@available_settings[name]
    end

    def self.[]=(name, v)
      # find setting if it exists or load from defaults
      setting = find_or_default(name)
      # set value to '' unless it already existss
      setting.value = (v ? v : "")
      # store object class
 #     setting.object_class = v.class.to_s
      # set the value of the setting to nil in the defaults
    #  @@available_settings[name] = nil
      # save the setting
      setting.save
      # return the value
      setting.value
    end

    # Defines getter and setter for each setting
    # Then setting values can be read using: Setting.some_setting_name
    # or set using Setting.some_setting_name = "some value"
    @@available_settings.each do |name, params|
      src = <<-END_SRC
      def self.#{name}
        self[:#{name}]
      end

      def self.#{name}?
        self[:#{name}].to_i > 0
      end

      def self.#{name}=(value)
        self[:#{name}] = value
      end
      END_SRC
      class_eval src, __FILE__, __LINE__
    end

  private
    # Returns the Setting instance for the setting named name
    # (record found in database or new record with default value)
    def self.find_or_default(name)
      name = name.to_s
      raise "There's no setting named #{name}" unless @@available_settings.has_key?(name) || find_by_name(name)
      setting = find_by_name(name)
      setting ||= create(:name => name, :value => @@available_settings[name]) if @@available_settings.has_key?(name)
    end
end
