json.array!(@hr_person_histories) do |hr_person_history|
  json.extract! hr_person_history, :id, :full_name
  json.url hr_person_history_url(hr_person_history, format: :json)
end
