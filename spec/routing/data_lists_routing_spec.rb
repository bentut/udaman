require "spec_helper"

describe DataListsController do
  describe "routing" do

    it "routes to #index" do
      get("/data_lists").should route_to("data_lists#index")
    end

    it "routes to #new" do
      get("/data_lists/new").should route_to("data_lists#new")
    end

    it "routes to #show" do
      get("/data_lists/1").should route_to("data_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/data_lists/1/edit").should route_to("data_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/data_lists").should route_to("data_lists#create")
    end

    it "routes to #update" do
      put("/data_lists/1").should route_to("data_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/data_lists/1").should route_to("data_lists#destroy", :id => "1")
    end

  end
end
