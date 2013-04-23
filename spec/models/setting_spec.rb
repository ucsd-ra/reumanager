require 'spec_helper'

describe Setting do
  
  describe '@@available_settings' do
    it 'loads the application.yml file from the rails config dir' do
      defaults = YAML::load(File.open(Rails.root.join 'config', 'application.yml'))
      expect(defaults).to be_a_kind_of(Hash)
    end

    it 'returns the default settings from the loaded yaml file' do
      expect(Setting.available_settings).to be_a_kind_of(Hash)
    end

  end

  describe 'self.[]' do
    before(:each) { Setting[:app_title] = 'this is only a test'}
  
    it 'returns the value for the given setting name' do
      expect(Setting['app_title']).to be_a_kind_of(String)
      expect(Setting['app_title']).to eq("this is only a test")
    end

    it 'accepts a string or symbol for the name value' do
      expect(Setting['app_title']).to be_a_kind_of(String)
      expect(Setting['app_title']).to eq("this is only a test")

      expect(Setting[:app_title]).to be_a_kind_of(String)
      expect(Setting[:app_title]).to eq("this is only a test")
    end
    
    it 'returns the default value from the yaml file when no db setting exists' do
      Setting.find_by_name("app_name").destroy if Setting.find_by_name("app_name")

      expect(Setting[:app_title]).to be_a_kind_of(String)
      expect(Setting[:app_title]).to eq("this is only a test")
    end
    
  end
  
  describe 'self.[]=' do
    it 'returns the value for the given setting name' do
      Setting['app_title'] = 'this is only a test'

      expect(Setting['app_title']).to be_a_kind_of(String)
      expect(Setting['app_title']).to eq("this is only a test")
    end

    it 'accepts a string or symbol for the name value' do
      Setting['app_title'] = 'this is only another test'
      expect(Setting['app_title']).to be_a_kind_of(String)
      expect(Setting['app_title']).to eq("this is only another test")

      Setting[:app_title] = 'this is only another and another test'
      expect(Setting[:app_title]).to be_a_kind_of(String)
      expect(Setting[:app_title]).to eq("this is only another and another test")
    end
  end
  
end