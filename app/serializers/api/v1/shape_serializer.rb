# encoding: utf-8
# frozen_string_literal: true
class Api::V1::ShapeSerializer < ActiveModel::Serializer
  attributes :id, :label, :type
  has_one :canvas
end
