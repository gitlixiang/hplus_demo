json.array!(@cl_contents) do |cl_content|
  json.extract! cl_content, :id, :name, :row, :col, :rows, :cols, :code, :header_id
  json.url cl_content_url(cl_content, format: :json)
end
