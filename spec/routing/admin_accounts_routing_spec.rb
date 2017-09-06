require "rails_helper"

RSpec.describe AdminAccountsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin_accounts").to route_to("admin_accounts#index")
    end

    it "routes to #new" do
      expect(:get => "/admin_accounts/new").to route_to("admin_accounts#new")
    end

    it "routes to #show" do
      expect(:get => "/admin_accounts/1").to route_to("admin_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin_accounts/1/edit").to route_to("admin_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin_accounts").to route_to("admin_accounts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin_accounts/1").to route_to("admin_accounts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin_accounts/1").to route_to("admin_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_accounts/1").to route_to("admin_accounts#destroy", :id => "1")
    end

  end
end
