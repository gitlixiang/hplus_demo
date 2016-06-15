class Wf::Task < ActiveRecord::Base
  self.table_name = 'ACT_HI_TASKINST'
  self.primary_key = 'ID_'
  belongs_to :wf_proc_inst, :class_name => 'Wf::ProcInst', foreign_key: 'PROC_INST_ID_'
  has_many :task_opinions, :class_name => 'Wf::TaskOpinion', dependent: :destroy
  accepts_nested_attributes_for :task_opinions, :allow_destroy => true

  #列出代办任务
  def self.list(instance, params)
    query = WfActiviti[:task].createTaskQuery()
    query = query.processInstanceId(instance.getId)
    query = query.taskUnassigned if params[:unassigned].to_s == 'true'
    [:assignee, :candidate_user, :name_like,
     :candidate_group, :candidate_group_in, :name].each do |item|
      query = query.send('task' + item.to_s.camelize, params[item]) if params[item]
    end

    query.list.map do |task|
      {
          :id => task.getId,
          :name => task.getName,
          :execution_id => task.getExecutionId,
          :process_instance_id => task.getProcessInstanceId,
          :parent_task_id => task.getParentTaskId,
          :owner => task.getOwner,
          :create_date => Time.at(task.getCreateTime.getTime/1000),
          :assignee => task.getAssignee,
          :description => task.getDescription
      }
    end
  end

  def ent_user_name
    if !self.ASSIGNEE_.blank?
      x = self.ASSIGNEE_.split('-')
      org = Fdn::Organization.where(code: x[0]).first
      user = org.users.where(username: x[1]).first
      return org.name+'-'+user.full_name
    end
  end

  def opinion
    varinst = Wf::VarInst.where(NAME_: 'opinion', EXECUTION_ID_: self.EXECUTION_ID_).first
    if varinst
      return varinst.TEXT_
    else
      return ''
    end
  end

  #认领任务
  def self.claim(task_id, user_wf_id)
    task = WfActiviti[:task].createTaskQuery().taskId(task_id.to_s).singleResult
    if task
      begin
        WfActiviti[:task].claim task.getId, user_wf_id.to_s
      rescue Exception => e
        return e.message
      end
    else
      return 'task not found'
    end
  end

  # #完成任务
  # def self.complete(task_id, hash)
  #   task = WfActiviti[:task].createTaskQuery().taskId(task_id).singleResult
  #   if task
  #     begin
  #       variables = java.util.HashMap.new(hash)
  #       WfActiviti[:task].complete task.getId, variables
  #     rescue Exception => e
  #       return e.message
  #     end
  #   else
  #     return 'task not found'
  #   end
  # end

  # 完成任务
  def self.complete(object, user, hash)
    instance = Wf::ProcInst.find_by_resource(object)
    task = Wf::Task.find_by(PROC_INST_ID_: instance.getId, ASSIGNEE_: user.wf_id, END_TIME_: nil)
    variables = java.util.HashMap.new(hash)
    WfActiviti[:task].complete task.id, variables
  end

  # # 根据指定的用户查询待办任务
  # def self.find_by_user(user)
  #   WfActiviti[:task].createTaskQuery().taskAssignee(user.wf_id).list.map{|t|t.getProcessInstanceId()}.map{|inst_id|Wf::ProcInst.find(inst_id).proc_resource.resource}
  # end
end