class Wf::ProcDef < ActiveRecord::Base
  self.table_name = 'ACT_RE_PROCDEF'
  self.primary_key = 'ID_'
  belongs_to :wf_deployment, :class_name => 'Wf::Deployment', foreign_key: 'DEPLOYMENT_ID_', primary_key: 'ID_'

  def self.list(deployment)
    WfActiviti[:repository].createProcessDefinitionQuery.deploymentId(deployment.singleResult.getId)
  end

  def self.active(deployment)
    self.list(deployment).active
  end
end