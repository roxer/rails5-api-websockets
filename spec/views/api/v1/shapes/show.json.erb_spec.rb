require 'rails_helper'

RSpec.describe "api/v1/shapes/show", type: :view do
  before(:each) do
    @api_v1_shape = assign(:api_v1_shape, FactoryGirl.create(:api_v1_shape))
  end

  it "renders attributes for shape and check json schema" do
    render
    expect(rendered).to match_response_schema("shape")

  end
end
