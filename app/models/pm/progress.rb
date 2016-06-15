class Pm::Progress < ActiveRecord::Base
  belongs_to :pm_plan, :class_name => 'Pm::Plan', foreign_key: :plan_id
  belongs_to :pm_node, :class_name => 'Pm::Node', foreign_key: :node_id
  has_one :wf, :class_name => 'Pm::WorkFlow', :as => :wfable, :dependent => :destroy

  default_scope -> { order('sort_seq,created_at') }
  # after_create :update_plan_stage
  # after_destroy :update_plan_stage
  # def update_plan_stage
  #   plan = self.pm_plan
  #   size = plan.pm_progresses.size
  #   if plan.stage != size
  #     plan.update_column(:stage, size)
  #   end
  # end

  after_create :init_process

  def init_process
    self.create_wf unless self.wf
  end
end
