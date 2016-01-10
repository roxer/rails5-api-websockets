require 'rails_helper'

RSpec.describe "api/v1/canvases/show", type: :view do
  before(:each) do
    @api_v1_canvas = assign(:api_v1_canvas, Api::V1::Canvas.create!(
      name: "Name"
    ))
  end

  it "renders attributes " do
    render
    expect(rendered).to match_response_schema("canvas")
  end
end
