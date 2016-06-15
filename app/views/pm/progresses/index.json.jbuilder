json.array!(@pm_progresses) do |pm_progress|
  json.extract! pm_progress, :id, :status, :percent, :content, :node, :node_id, :plan_id
  json.url pm_progress_url(pm_progress, format: :json)
end
