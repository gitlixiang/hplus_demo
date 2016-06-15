FactoryGirl.define do
  factory :wf_simple_workflow, :class => 'Wf::SimpleWorkflow' do
    resource_type "MyString"
    resource_id 1
    start_org 1
    current_org 1
    status "MyString"
  end

end
