require 'faker'

FactoryGirl.define do
  factory :api_v1_canvas, :class => 'Api::V1::Canvas' do
    name { Faker::Hacker.noun }
    diagram { Api::V1::Diagram.find_by_name('default') || association(:api_v1_diagram) }
  end

end
