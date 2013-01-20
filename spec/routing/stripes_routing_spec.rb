require "spec_helper"

describe StripesController do
  describe "routing" do

    it "routes to #index" do
      get("/stripes").should route_to("stripes#index")
    end

    it "routes to #new" do
      get("/stripes/new").should route_to("stripes#new")
    end

    it "routes to #show" do
      get("/stripes/1").should route_to("stripes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stripes/1/edit").should route_to("stripes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stripes").should route_to("stripes#create")
    end

    it "routes to #update" do
      put("/stripes/1").should route_to("stripes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stripes/1").should route_to("stripes#destroy", :id => "1")
    end

  end
end
