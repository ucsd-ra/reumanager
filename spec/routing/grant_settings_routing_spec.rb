require "rails_helper"

RSpec.describe GrantSettingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/grant_settings").to route_to("grant_settings#index")
    end

    it "routes to #new" do
      expect(:get => "/grant_settings/new").to route_to("grant_settings#new")
    end

    it "routes to #show" do
      expect(:get => "/grant_settings/1").to route_to("grant_settings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/grant_settings/1/edit").to route_to("grant_settings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/grant_settings").to route_to("grant_settings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/grant_settings/1").to route_to("grant_settings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/grant_settings/1").to route_to("grant_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/grant_settings/1").to route_to("grant_settings#destroy", :id => "1")
    end

  end
end
