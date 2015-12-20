json.array!(@api_v1_diagrams) do |api_v1_diagram|
  json.extract! api_v1_diagram, :id, :name
  json.url api_v1_diagram_url(api_v1_diagram, format: :json)
end
