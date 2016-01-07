require 'rails_helper'

RSpec.describe "Api::V1::Canvases", type: :request do

  describe "GET /api/v1/canvases" do
    it "works! (now write some real specs)" do
      get api_v1_canvases_path
      expect(response.status).to be(200)
    end
  end
end
