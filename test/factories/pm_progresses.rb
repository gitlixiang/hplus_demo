FactoryGirl.define do
  factory :pm_progress, :class => 'Pm::Progress' do
    status 1
    percent 1
    content "MyString"
    node "MyString"
    node_id 1
    plan_id 1
  end

end
