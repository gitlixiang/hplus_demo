class Pm::Plan < ActiveRecord::Base
  has_many :pm_progresses, :class_name => 'Pm::Progress', foreign_key: :plan_id
  has_many :pm_comments, :class_name => 'Pm::Comment', as: :resource, dependent: :destroy
  has_one :wf, :class_name => 'Pm::WorkFlow', :as => :wfable, :dependent => :destroy
  has_many :pm_nodes, :class_name => 'Pm::Node', foreign_key: 'plan_id'
  accepts_nested_attributes_for :pm_nodes

  belongs_to :resource, polymorphic: true

  # after_update :create_progresses
  # def create_progresses
  #   a = self.stage
  #   b = self.pm_progresses.size
  #   if a > b
  #     (a-b).times do
  #       self.pm_progresses.create
  #     end
  #   end
  # end

  after_create :init_process

  def init_process
    self.create_wf unless self.wf
  end

  def newest_percent
    if self.pm_progresses.size > 0 && self.pm_progresses.select { |p| p.wf.rec? }.size >0
      self.pm_progresses.select { |p| p.wf.rec? }.map(&:percent).max
    else
      0
    end
  end
end
