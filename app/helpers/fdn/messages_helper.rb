#coding:utf-8
module Fdn::MessagesHelper
  def box_out_links(msg)
    [{value: '阅读情况', url: url_for(:action => :read_info, :id => msg.id, :tab_idx => 1), method: 'get'},
     {value: '删除', url: fdn_message_path(msg, :tab_idx => 2), url_method: 'delete', :confirm => '确定要删除吗？'}]
  end

  def box_in_links(msg)
    [{value: '删除', url: fdn_received_message_path(msg, :tab_idx => 0), url_method: 'delete', :confirm => '确定要删除吗？'}]
  end
end