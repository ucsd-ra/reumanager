require "rails_helper"

RSpec.describe GrantSnippetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/grant_snippets").to route_to("grant_snippets#index")
    end

    it "routes to #new" do
      expect(:get => "/grant_snippets/new").to route_to("grant_snippets#new")
    end

    it "routes to #show" do
      expect(:get => "/grant_snippets/1").to route_to("grant_snippets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/grant_snippets/1/edit").to route_to("grant_snippets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/grant_snippets").to route_to("grant_snippets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/grant_snippets/1").to route_to("grant_snippets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/grant_snippets/1").to route_to("grant_snippets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/grant_snippets/1").to route_to("grant_snippets#destroy", :id => "1")
    end

  end
end
