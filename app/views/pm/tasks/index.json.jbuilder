json.array!(@pm_tasks) do |pm_task|
  json.extract! pm_task, :id, :name, :content, :org_id, :resource_id
  json.url pm_task_url(pm_task, format: :json)
end
