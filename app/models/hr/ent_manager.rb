class Hr::EntManager < ActiveRecord::Base

  attr_accessor :ent_name
  belongs_to :job, :class_name => 'Hr::Lookups::JobType', :foreign_key => 'job_id', :primary_key => 'code'
  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'

  has_one :treatment, :class_name => "Hr::Treatment", :foreign_key => 'manager_id', :dependent => :destroy
  accepts_nested_attributes_for :treatment

  scope :by_ent_id, proc { |ent_id| where("ent_id = ?", ent_id) }
end
