class Wf::ProcResource < ActiveRecord::Base
  belongs_to :proc_inst, :class_name => 'Wf::ProcInst', foreign_key: 'inst_id'
  belongs_to :resource, polymorphic: true
  serialize :variables

  after_destroy :destroy_proc_inst

  def destroy_proc_inst
    WfActiviti[:runtime].deleteProcessInstance(self.inst_id.to_s, 'resource has been destroyed')
  end

  before_create :create_proc_inst

  def create_proc_inst
    deployment = Wf::Deployment.use(self.deployment_name)
    definition = Wf::ProcDef.list(deployment).singleResult
    instance = Wf::ProcInst.start(definition, self.variables)
    self.proc_inst = Wf::ProcInst.find(instance)
  end
end