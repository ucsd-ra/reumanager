require "spec_helper"

describe GrantsController do
  describe "routing" do

    it "routes to #index" do
      get("/grants").should route_to("grants#index")
    end

    it "routes to #new" do
      get("/grants/new").should route_to("grants#new")
    end

    it "routes to #show" do
      get("/grants/1").should route_to("grants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/grants/1/edit").should route_to("grants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/grants").should route_to("grants#create")
    end

    it "routes to #update" do
      put("/grants/1").should route_to("grants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/grants/1").should route_to("grants#destroy", :id => "1")
    end

  end
end
