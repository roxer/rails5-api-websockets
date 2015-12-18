require 'rails_helper'

RSpec.describe "api/v1s/index", :type => :view do
  before(:each) do
    assign(:api_v1_canvases, [
      Api::V1::Canvas.create!(
        :name => "Name",
        :diagram => nil
      ),
      Api::V1::Canvas.create!(
        :name => "Name",
        :diagram => nil
      )
    ])
  end

  it "renders a list of api/v1s" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
