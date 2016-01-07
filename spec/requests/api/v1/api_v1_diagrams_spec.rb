require 'rails_helper'

RSpec.describe "Api::V1::Diagrams", :type => :request do

  describe "GET /api/v1/diagrams" do
    it "works! (now write some real specs)" do
      get api_v1_diagrams_path
      expect(response.status).to be(204)
    end
  end
end
