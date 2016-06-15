#coding:utf-8
module Pm::ProgressesHelper
  def pm_progress_index_links(user, object)
    if object.wf
      if user.org.id == 1
        case object.wf.state
          when 'ipt'
            [{value: '查看', url: pm_progress_path(object)}]
          when 'rev'
            [{value: '查看', url: pm_progress_path(object)}, {value: '编辑', url: edit_pm_progress_path(object)}, {value: '同意', url: finish_pm_progress_path(object), confirm: '确定要同意吗?'}, {value: '退回', url: return_pm_progress_path(object), confirm: '确定要退回吗?'}, {value: '中止', url: close_pm_progress_path(object), confirm: '确定要中止吗?'}]
          when 'rej'
            [{value: '查看', url: pm_progress_path(object)}]
          when 'rec'
            [{value: '查看', url: pm_progress_path(object)}, {value: '编辑', url: edit_pm_progress_path(object)}, {value: '中止', url: close_pm_progress_path(object), confirm: '确定要中止吗?'}]
          when 'abo'
            [{value: '查看', url: pm_progress_path(object)}]
          else
            [{value: '查看', url: pm_progress_path(object)}]
        end

      else
        case object.wf.state
          when 'ipt'
            [{value: '查看', url: pm_progress_path(object)}, {value: '编辑', url: edit_pm_progress_path(object)}, {value: '提交', url: submit_pm_progress_path(object), confirm: '确定要提交吗?'}, {value: '删除', url: pm_progress_path(object), url_method: 'delete', confirm: '确定要删除吗?'}]
          when 'rev'
            [{value: '查看', url: pm_progress_path(object)}]
          when 'rej'
            [{value: '查看', url: pm_progress_path(object)}, {value: '编辑', url: edit_pm_progress_path(object)}, {value: '提交', url: submit_pm_progress_path(object), confirm: '确定要提交吗?'}, {value: '中止', url: close_pm_progress_path(object), confirm: '确定要中止吗?'}, {value: '删除', url: pm_progress_path(object), url_method: 'delete', confirm: '确定要删除吗?'}]
          when 'rec'
            [{value: '查看', url: pm_progress_path(object)}]
          when 'abo'
            [{value: '查看', url: pm_progress_path(object)}]
          else
            [{value: '查看', url: pm_progress_path(object)}]
        end

      end
    else
      [{value: '查看', url: pm_progress_path(object)}]
    end
  end
end
