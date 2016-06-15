FactoryGirl.define do
  factory :pm_task, :class => 'Pm::Task' do
    name "MyString"
    content "MyString"
    org_id 1
    resource nil
  end

end
