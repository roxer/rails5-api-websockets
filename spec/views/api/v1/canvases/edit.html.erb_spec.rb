require 'rails_helper'

RSpec.describe "api/v1s/edit", :type => :view do
  before(:each) do
    @api_v1 = assign(:api_v1, Api::V1::Canvas.create!(
      :name => "MyString",
      :diagram => nil
    ))
  end

  it "renders the edit api_v1 form" do
    render

    assert_select "form[action=?][method=?]", api_v1_path(@api_v1), "post" do

      assert_select "input#api_v1_name[name=?]", "api_v1[name]"

      assert_select "input#api_v1_diagram_id[name=?]", "api_v1[diagram_id]"
    end
  end
end
