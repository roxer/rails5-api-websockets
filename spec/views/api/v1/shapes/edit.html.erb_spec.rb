require 'rails_helper'

RSpec.describe "api/v1s/edit", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Shape.create!(
      :label => "MyString",
      :type => "",
      :canvas => nil
    ))
  end

  it "renders the edit api_v1 form" do
    render

    assert_select "form[action=?][method=?]", api_v1_path(@api_v1), "post" do

      assert_select "input#api_v1_label[name=?]", "api_v1[label]"

      assert_select "input#api_v1_type[name=?]", "api_v1[type]"

      assert_select "input#api_v1_canvas_id[name=?]", "api_v1[canvas_id]"
    end
  end
end
