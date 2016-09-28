# encoding: utf-8
# frozen_string_literal: true
json.array!(@api_v1diagrams) do |api_v1diagram|
  json.extract! api_v1diagram, :id, :name
end
