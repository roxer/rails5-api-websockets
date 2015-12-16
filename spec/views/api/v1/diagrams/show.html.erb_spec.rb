require 'rails_helper'

RSpec.describe "api/v1s/show", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Diagram.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
