class Wf::SimpleOperation < ActiveRecord::Base
  belongs_to :wf_simple_workflow, :class_name => 'Wf::SimpleWorkflow', foreign_key: :workflow_id
  belongs_to :fdn_organization, :class_name => 'Fdn::Organization', foreign_key: :org_id
  belongs_to :parent, :class_name => 'Wf::SimpleOperation', foreign_key: :parent_id
  belongs_to :fdn_user, :class_name => 'Fdn::User', foreign_key: :user_id
end
