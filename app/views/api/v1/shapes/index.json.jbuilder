json.array!(@api_v1_shapes) do |api_v1_shape|
  json.extract! api_v1_shape, :id, :label, :shape_type, :canvas_id,
                              :pos_x, :pos_y, :descriptors
  json.url api_v1_shape_url(api_v1_shape, format: :json)
end
