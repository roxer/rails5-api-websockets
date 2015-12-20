require 'rails_helper'

RSpec.describe "api/v1s/new", :type => :view do
  before(:each) do
    assign(:api_v1, Api::V1::Shape.new(
      :label => "MyString",
      :type => "",
      :canvas => nil
    ))
  end

  it "renders new api_v1 form" do
    render

    assert_select "form[action=?][method=?]", api_v1_shapes_path, "post" do

      assert_select "input#api_v1_label[name=?]", "api_v1[label]"

      assert_select "input#api_v1_type[name=?]", "api_v1[type]"

      assert_select "input#api_v1_canvas_id[name=?]", "api_v1[canvas_id]"
    end
  end
end
