json.array!(@pm_plans) do |pm_plan|
  json.extract! pm_plan, :id, :name, :contact, :phone, :content, :org_id
  json.url pm_plan_url(pm_plan, format: :json)
end
