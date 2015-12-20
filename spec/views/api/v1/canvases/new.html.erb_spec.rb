require 'rails_helper'

RSpec.describe "api/v1s/new", :type => :view do
  before(:each) do
    assign(:api_v1, Api::V1::Canvas.new(
      :name => "MyString",
      :diagram => nil
    ))
  end

  it "renders new api_v1 form" do
    render

    assert_select "form[action=?][method=?]", api_v1_canvases_path, "post" do

      assert_select "input#api_v1_name[name=?]", "api_v1[name]"

      assert_select "input#api_v1_diagram_id[name=?]", "api_v1[diagram_id]"
    end
  end
end
