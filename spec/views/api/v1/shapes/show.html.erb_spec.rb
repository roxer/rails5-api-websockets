require 'rails_helper'

RSpec.describe "api/v1s/show", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Shape.create!(
      :label => "Label",
      :type => "Type",
      :canvas => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Label/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
  end
end
