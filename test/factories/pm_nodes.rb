FactoryGirl.define do
  factory :pm_node, :class => 'Pm::Node' do
    percent 1
    content "MyText"
    name "MyString"
    plan_id 1
    sort_seq 1
    start_date "2015-09-13"
    end_date "2015-09-13"
  end

end
