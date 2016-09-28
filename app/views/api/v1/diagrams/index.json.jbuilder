# frozen_string_literal: true
json.array!(@api_v1_diagrams) do |api_v1_diagram|
  json.extract! api_v1_diagram, :id, :name
end
