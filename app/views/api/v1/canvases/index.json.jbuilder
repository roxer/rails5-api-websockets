# frozen_string_literal: true
json.array!(@api_v1_canvases) do |api_v1_canvas|
  json.extract! api_v1_canvas, :id, :name, :diagram_id
  json.url api_v1_canvas_url(api_v1_canvas, format: :json)
end
