require "rails_helper"

RSpec.describe Api::V1::DiagramsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/api/v1/diagrams.json")
             .to route_to("api/v1/diagrams#index", format: "json")
    end

  end
end
