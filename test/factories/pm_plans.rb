FactoryGirl.define do
  factory :pm_plan, :class => 'Pm::Plan' do
    name "MyString"
    contact "MyString"
    phone 1
    content "MyText"
    org_id 1
  end

end
