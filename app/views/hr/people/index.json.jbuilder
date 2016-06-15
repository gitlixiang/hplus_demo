json.array!(@hr_people) do |hr_person|
  json.extract! hr_person, :id, :full_name
  json.url hr_person_url(hr_person, format: :json)
end
