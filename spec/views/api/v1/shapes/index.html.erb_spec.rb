require 'rails_helper'

RSpec.describe "api/v1s/index", :type => :view do
  before(:each) do
    assign(:api_v1_shapes, [
      Api::V1::Shape.create!(
        :label => "Label",
        :type => "Type",
        :canvas => nil
      ),
      Api::V1::Shape.create!(
        :label => "Label",
        :type => "Type",
        :canvas => nil
      )
    ])
  end

  it "renders a list of api/v1s" do
    render
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
