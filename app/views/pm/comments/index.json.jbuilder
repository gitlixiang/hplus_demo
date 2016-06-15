json.array!(@pm_comments) do |pm_comment|
  json.extract! pm_comment, :id, :content, :comment_time, :user_id, :resource_id
  json.url pm_comment_url(pm_comment, format: :json)
end
