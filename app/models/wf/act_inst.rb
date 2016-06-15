class Wf::ActInst < ActiveRecord::Base
  self.table_name = 'ACT_HI_ACTINST'
  self.primary_key = 'ID_'

  belongs_to :wf_proc_inst, :class_name => 'Wf::ProcInst', foreign_key: 'PROC_INST_ID_'
  belongs_to :wf_task, :class_name => 'Wf::Task', foreign_key: 'TASK_ID_'


  # 查询待办任务
  def self.find_ntd_by_user(user)
    self.where(ASSIGNEE_: user.wf_id, END_TIME_: nil).map { |t| t.wf_proc_inst.proc_resource.resource if t.wf_proc_inst.proc_resource }
  end

  # 查询已办任务
  def self.find_hd_by_user(user)
    ids = WfActiviti[:history].createHistoricProcessInstanceQuery.involvedUser(user.wf_id).unfinished.list.map { |p| p.getId }
    Wf::ProcResource.where(inst_id: ids).map(&:resource) - self.find_ntd_by_user(user)
    # self.joins(:wf_task).where('ACT_HI_ACTINST.ASSIGNEE_ = ?  and ACT_HI_ACTINST.END_TIME_ is not null and ACT_HI_TASKINST.END_TIME_ is not null',user.wf_id).map{|t|t.wf_proc_inst.proc_resource.resource}
  end

  # 查询办结任务
  def self.find_f_by_user(user)
    ids = WfActiviti[:history].createHistoricProcessInstanceQuery.involvedUser(user.wf_id).finished.list.map { |p| p.getId }
    Wf::ProcResource.where(inst_id: ids).map(&:resource)
    # self.joins(:wf_task).where('ACT_HI_ACTINST.ASSIGNEE_ = ?  and ACT_HI_ACTINST.END_TIME_ is not null and ACT_HI_TASKINST.END_TIME_ is null',user.wf_id).map{|t|t.wf_proc_inst.proc_resource.resource}
  end

  # 查询办结任务(非user)
  def self.find_f
    ids = WfActiviti[:history].createHistoricProcessInstanceQuery.finished.list.map { |p| p.getId }
    Wf::ProcResource.where(inst_id: ids).map(&:resource)
    # self.joins(:wf_task).where('ACT_HI_ACTINST.ASSIGNEE_ = ?  and ACT_HI_ACTINST.END_TIME_ is not null and ACT_HI_TASKINST.END_TIME_ is null',user.wf_id).map{|t|t.wf_proc_inst.proc_resource.resource}
  end
end