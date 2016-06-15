class Pm::Node < ActiveRecord::Base
  belongs_to :pm_plan, :class_name => 'Pm::Plan', foreign_key: 'plan_id'
  has_one :pm_progress, :class_name => 'Pm::Progress', foreign_key: 'node_id'
end
