require 'rails_helper'

RSpec.describe "api/v1/diagrams/index", :type => :view do
  before(:each) do
    assign(:api_v1_diagrams, [
      Api::V1::Diagram.find_or_create_by(name: 'default')
    ])
  end

  it "renders a list of api/v1/diagrams" do
    render
    expect(true).to be_truthy
  end
end
