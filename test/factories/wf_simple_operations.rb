FactoryGirl.define do
  factory :wf_simple_operation, :class => 'Wf::SimpleOperation' do
    workflow_id 1
    org_id 1
    parent_id 1
    user_id 1
    message "MyString"
    operate "MyString"
  end

end
