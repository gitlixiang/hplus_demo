class Wf::Deployment < ActiveRecord::Base
  self.table_name = 'ACT_RE_DEPLOYMENT'
  self.primary_key = 'ID_'
  has_one :wf_proc_def, :class_name => 'Wf::ProcDef', foreign_key: 'DEPLOYMENT_ID_', primary_key: 'ID_'

  # 部署一个流程
  def self.deploy(args)
    if args[:name] && args[:path]
      # 查询部署，如果没有就新建
      deployment = WfActiviti[:repository].createDeploymentQuery.deploymentName(args[:name])
      # 删除部署
      # WfActiviti[:repository].deleteDeployment 1, true

      if deployment.count == 0
        begin
          WfActiviti[:repository].createDeployment
          .addClasspathResource(args[:path]) #VacationRequest  test
          .category(args[:group_name])
          .name(args[:name])
          .deploy
          WfActiviti[:repository].createDeploymentQuery.deploymentName(args[:name])
        rescue Exception => e
          return e.message
        end
      else
        deployment
      end
    else
      raise 'need params: name and path'
    end
  end

  # 使用一个流程
  def self.use(name)
    WfActiviti[:repository].createDeploymentQuery.deploymentName(name)
  end

  # 列出所有部署
  def self.list
    WfActiviti[:repository].createDeploymentQuery.list.map do |item|
      {
          id: item.getId,
          name: item.getName,
          deployment_time: item.getDeploymentTime,
          category: item.getCategory
      }
    end
  end

  # 下载流程图
  def self.image_stream(definition)
    stream = WfActiviti[:repository].getResourceAsStream(definition.getDeploymentId(), definition.getDiagramResourceName())
    size = stream.available
    bytes = Java::byte[size].new
    stream.read bytes, 0, size
    bytes
  end

  def self.model(definition)
    if definition
      model = WfActiviti[:repository].getBpmnModel(definition.getId)
      elements = model.getMainProcess.getFlowElements

      nodes = elements.find_all { |el| el.is_a? org.activiti.bpmn.model.FlowNode }.map do |el|
        if el.is_a? org.activiti.bpmn.model.StartEvent
          properties = el.getFormProperties.map do |item|
            {
                name: item.getName,
                variable: item.getVariable,
                type: item.getType,
                default_expression: item.getDefaultExpression,
                required: item.isRequired,
                readable: item.isReadable,
                writeable: item.isWriteable,
                form_values: item.getFormValues.map { |v| v.getName }
            }
          end
          {
              name: el.getName,
              documentation: el.getDocumentation,
              type: :start_event,
              form_properties: properties
          }
        elsif el.is_a? org.activiti.bpmn.model.EndEvent
          {
              name: el.getName,
              documentation: el.getDocumentation,
              type: :end_event
          }
        elsif el.is_a? org.activiti.bpmn.model.UserTask
          properties = el.getFormProperties.map do |item|
            {
                name: item.getName,
                variable: item.getVariable,
                type: item.getType,
                default_expression: item.getDefaultExpression,
                required: item.isRequired,
                readable: item.isReadable,
                writeable: item.isWriteable,
                form_values: item.getFormValues.map { |v| v.getName }
            }
          end
          {
              name: el.getName,
              documentation: el.getDocumentation,
              type: :user_task,
              assignee: el.getAssignee,
              priority: el.getPriority,
              due_date: el.getDueDate,
              candidate_users: el.getCandidateUsers.to_a,
              candidate_groups: el.getCandidateGroups.to_a,
              form_properties: properties
          }
        else
          {
              name: el.getName,
              documentation: el.getDocumentation,
              type: el.class.to_s.split('::').last.underscore
          }
        end
      end
      return nodes
    else
      return 'not found'
    end
  end

  # 获取流程定义文件
  def self.bpmn(definition)
    if definition
      stream = WfActiviti[:repository].getResourceAsStream(
          definition.getDeploymentId, definition.getResourceName
      )
      size = stream.available
      bytes = Java::byte[size].new
      stream.read bytes, 0, size
      bytes
    end
  end

end