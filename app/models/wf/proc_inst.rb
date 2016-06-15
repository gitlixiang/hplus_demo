class Wf::ProcInst < ActiveRecord::Base
  self.table_name = 'ACT_HI_PROCINST'
  self.primary_key = 'ID_'
  has_one :proc_resource, :class_name => 'Wf::ProcResource', foreign_key: 'inst_id'
  has_many :wf_tasks, :class_name => 'Wf::Task', foreign_key: 'PROC_INST_ID_'
  # has_one :resource, through: :proc_resource

  after_create :create_proc_inst

  def create_proc_inst

  end

  # 启动一个流程实例
  def self.start(definition, hash={})
    begin
      variables = java.util.HashMap.new(hash)
      instance = WfActiviti[:runtime].startProcessInstanceById definition.getId, nil, variables
      return instance.getId
    rescue Exception => e
      return e.message
    end
  end

  # 列出一个流程定义下的所有实例
  def self.list(definition)
    WfActiviti[:runtime].createProcessInstanceQuery.processDefinitionId(definition.getId)
  end

  # 获得当前流程图和流程位置
  def self.image_stream(instance)
    execution = WfActiviti[:runtime].createExecutionQuery.processInstanceId(instance.getId).singleResult
    definition = WfActiviti[:repository].createProcessDefinitionQuery.processDefinitionId(instance.getProcessDefinitionId).singleResult if instance
    bpmn_model = WfActiviti[:repository].getBpmnModel(instance.getProcessDefinitionId) if instance
    if instance and execution and definition and bpmn_model
      stream = org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator.generateDiagram(
          bpmn_model, 'png', WfActiviti[:runtime].getActiveActivityIds(execution.getId)
      )
      size = stream.available
      bytes = Java::byte[size].new
      stream.read bytes, 0, size
      bytes
    else
      return 'not found'
    end
  end

  #获得业务对象的流程实例
  def self.find_by_resource(object)
    WfActiviti[:history].createHistoricProcessInstanceQuery.processInstanceId(object.wf_proc_resource.inst_id.to_s).singleResult
  end

end