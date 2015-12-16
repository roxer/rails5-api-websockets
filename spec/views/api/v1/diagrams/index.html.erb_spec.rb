require 'rails_helper'

RSpec.describe "api/v1s/index", :type => :view do
  before(:each) do
    assign(:api_v1_diagrams, [
      Api::V1::Diagram.create!(
        :name => "Name"
      ),
      Api::V1::Diagram.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of api/v1s" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
