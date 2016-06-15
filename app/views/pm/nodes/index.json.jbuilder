json.array!(@pm_nodes) do |pm_node|
  json.extract! pm_node, :id, :percent, :content, :name, :plan_id, :sort_seq, :start_date, :end_date
  json.url pm_node_url(pm_node, format: :json)
end
