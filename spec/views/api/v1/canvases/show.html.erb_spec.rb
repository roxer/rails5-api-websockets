require 'rails_helper'

RSpec.describe "api/v1s/show", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Canvas.create!(
      :name => "Name",
      :diagram => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
