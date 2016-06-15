#coding: utf-8
module Wf::SimpleWorkflowHelper
  def index_btn(workflow)
    if workflow.status == 'ipt'
      bs_confirm_window(up_wf_simple_workflows_path, '提交', 'workflow_id:'+workflow.id.to_s, 'fa fa-check', '确定?')
    else
      bs_confirm_window(up_wf_simple_workflows_path, '提交', 'workflow_id:'+workflow.id.to_s, 'fa fa-check', '确定?')+
          bs_confirm_window(down_wf_simple_workflows_path, '退回', 'workflow_id:'+workflow.id.to_s, 'fa fa-return', '确定?')
    end
  end
end