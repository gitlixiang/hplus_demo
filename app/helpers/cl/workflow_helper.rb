#coding: utf-8
module Cl::WorkflowHelper
  def ent_index_btn(org_id)
    org = Fdn::Organization.find org_id
    if org.changing
      state = org.the_changing.wf.status
      case state
        when 'ipt'
          bs_button('bn_show_his', '历史记录', :url => show_his_fdn_ent_changes_path(org_id: org_id), :icon => 'search') +
              bs_button('bn_edit', '继续编辑', :url => edit_fdn_ent_change_path(org.the_changing), :icon => 'pencil')+
              bs_button('bn_trash', '放弃编辑', :url => trash_fdn_ent_change_path(org.the_changing), :icon => 'stop')
        when 'rev'
          bs_button('bn_show_his', '历史记录', :url => show_his_fdn_ent_changes_path(org_id: org_id), :icon => 'search') +
              bs_button('bn_wait', '等待审核', :onclick => '', :icon => 'pause')
        when 'rej'
          bs_button('bn_show_his', '历史记录', :url => show_his_fdn_ent_changes_path(org_id: org_id), :icon => 'search') +
              bs_button('bn_edit', '审核失败，继续编辑', :url => edit_fdn_ent_change_path(org.the_changing), :icon => 'pencil')
        else
          ''
      end
    else
      bs_button('bn_show_his', '历史记录', :url => show_his_fdn_ent_changes_path(org_id: org_id), :icon => 'search') +
          bs_button('bn_edit', '申请编辑', :url => new_fdn_ent_change_path(id: org_id), :icon => 'pencil')
    end
  end
end