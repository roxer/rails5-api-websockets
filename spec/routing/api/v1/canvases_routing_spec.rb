require "rails_helper"

RSpec.describe Api::V1::CanvasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/api/v1/canvases.json")
             .to route_to("api/v1/canvases#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/api/v1/canvases/1.json")
             .to route_to("api/v1/canvases#show", id: "1", format: "json")
    end

    it "routes to #create" do
      expect(post: "/api/v1/canvases.json")
             .to route_to("api/v1/canvases#create", format: "json")
    end

    it "routes to #update" do
      expect(put: "/api/v1/canvases/1.json")
             .to route_to("api/v1/canvases#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/canvases/1.json")
             .to route_to("api/v1/canvases#destroy", id: "1", format: "json")
    end

  end
end
