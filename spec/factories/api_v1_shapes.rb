require 'faker'

FactoryGirl.define do
  factory :api_v1_shape, :class => 'Api::V1::Shape' do
    label { Faker::Hacker.noun }
    shape_type 'Circle'
    pos_x { Faker::Number.number(2) }
    pos_y { Faker::Number.number(2) }
    descriptors '{ "radius": 10 }'
    canvas { Api::V1::Canvas.first || association(:api_v1_canvas) }
  end

end
