json.array!(@cl_headers) do |cl_header|
  json.extract! cl_header, :id, :name, :resource_type, :code, :order
  json.url cl_header_url(cl_header, format: :json)
end
