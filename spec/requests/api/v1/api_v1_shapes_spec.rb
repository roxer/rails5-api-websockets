require 'rails_helper'

RSpec.describe "Api::V1::Shapes", :type => :request do
  describe "GET /api_v1_shapes" do
    it "works! (now write some real specs)" do
      get api_v1_shapes_path
      expect(response.status).to be(200)
    end
  end
end
