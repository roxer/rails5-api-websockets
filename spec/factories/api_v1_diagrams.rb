require 'faker'

FactoryGirl.define do
  factory :api_v1_diagram, :class => 'Api::V1::Diagram' do
    name 'default'
  end

end
