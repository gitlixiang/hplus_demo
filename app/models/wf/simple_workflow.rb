#coding: utf-8
class Wf::SimpleWorkflow < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :start_org, :class_name => 'Fdn::Organization', foreign_key: :start_org_id
  belongs_to :current_org, :class_name => 'Fdn::Organization', foreign_key: :current_org_id
  has_many :wf_simple_operations, :class_name => 'Wf::SimpleOperation'

  def initialize(user, start_org)
    self.start_org_id = start_org.id
    self.current_org_id = start_org.id
    self.status = 'ipt'
    self.wf_simple_operations.create(org_id: start_org.id, user_id: user.id, operate: '填写')
  end

  def up(user, message=nil)
    parent = current_org.parent
    if parent.root?
      self.wf_simple_operations.create(org_id: current_org_id, user_id: user.id, operate: message||'完成')
      self.current_org.id = parent.id
      self.status = 'done'
      self.save
    else
      self.wf_simple_operations.create(org_id: current_org_id, user_id: user.id, operate: message||'提交')
      self.current_org.id = parent.id
      self.status = 'processing'
      self.save
    end
  end

  def down(user, message=nil)
    last_org_id = self.wf_simple_operations.last.org_id
    self.wf_simple_operations.create(org_id: current_org_id, user_id: user.id, operate: message||'退回')
    self.current_org.id = last_org_id
    self.status = 'processing'
    self.save
  end
end
