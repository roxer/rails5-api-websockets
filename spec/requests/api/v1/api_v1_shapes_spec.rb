require 'rails_helper'

RSpec.describe "Api::V1::Shapes", :type => :request do

  describe "GET /api/v1/shapes" do
    it "works! (now write some real specs)" do
      get api_v1_shapes_path
      expect(response.status).to be(204)
    end
  end
end
