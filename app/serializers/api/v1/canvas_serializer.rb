class Api::V1::CanvasSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :diagram
end
