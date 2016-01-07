require "rails_helper"

RSpec.describe Api::V1::ShapesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/api/v1/shapes.json")
             .to route_to("api/v1/shapes#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/api/v1/shapes/1.json")
             .to route_to("api/v1/shapes#show", id: "1", format: "json")
    end

    it "routes to #create" do
      expect(post: "/api/v1/shapes.json")
             .to route_to("api/v1/shapes#create", format: "json")
    end

    it "routes to #update" do
      expect(:put => "/api/v1/shapes/1.json")
             .to route_to("api/v1/shapes#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/shapes/1.json")
             .to route_to("api/v1/shapes#destroy", id: "1", format: "json")
    end

  end
end
