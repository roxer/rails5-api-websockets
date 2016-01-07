require 'rails_helper'

RSpec.describe "api/v1/shapes/index", type: :view do
  before(:each) do
    assign(:api_v1_shapes, [
      FactoryGirl.create(:api_v1_shape, { label: 'lab 1' }),
      FactoryGirl.create(:api_v1_shape, { label: 'lab 2' }),
    ])
  end

  it "renders a list of api/v1/shapes" do
    render
    expect(rendered).to match_response_schema("shapes")
  end
end
