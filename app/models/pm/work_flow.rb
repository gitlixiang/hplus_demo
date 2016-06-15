#coding: utf-8
class Pm::WorkFlow < ActiveRecord::Base
  STATUS_LIST = %w(ipt rev rej rec abo)
  HIGH_STATE = %w(rev rec)
  LOW_STATE = %w(ipt rej)

  STATUS_HASH = {'ipt' => '填写中', 'rev' => '待审核', 'rej' => '已退回', 'rec' => '已同意', 'abo' => '已中止'}

  belongs_to :wfable, polymorphic: true
  belongs_to :user, :class_name => 'Fdn::User', foreign_key: 'created_by'

  delegate :wf_title, to: :wfable

  acts_as_state_machine :initial => :ipt, :column => 'state'
  #五种状态
  #ipt 企业输入 rev 财政局审阅 rej 财政局拒绝 rec 财政局通过 abo 企业放弃修改

  state :ipt
  state :rev
  state :rej
  state :rec, :enter => Proc.new { |o| o.wfable.try(:after_finish) }
  state :abo

  event :submit do
    transitions :to => :rev, :from => [:ipt, :rej]
  end

  event :return do
    transitions :to => :rej, :from => :rev
  end

  event :finish do
    transitions :to => :rec, :from => :rev
  end

  event :close do
    transitions :to => :abo, :from => [:rev, :rej, :rec]
  end

  def can_edit?(user)
    if (Fdn::User::HIGH_ROLES & user.roles.map { |r| r.code }).size > 0
      HIGH_STATE.include?(status)
    elsif (Fdn::User::LOW_ROLES & user.roles.map { |r| r.code }).size > 0
      LOW_STATE.include?(status)
    else
      false
    end
  end

  def ipt?
    self.state == 'ipt'
  end

  def rev?
    self.state == 'rev'
  end

  def rej?
    self.state == 'rej'
  end

  def rec?
    self.state == 'rec'
  end

  def abo?
    self.state == 'abo'
  end

  def status_value
    case status
      when 'ipt'
        '录入'
      when 'rev'
        '审阅'
      when 'rej'
        '拒绝'
      when 'rec'
        '接受'
      when 'abo'
        '终止'
      else
        '状态错误'
    end
  end

  # def method_missing(method_id, *args)
  #   if match = is_status?(method_id)
  #     p 'aaaaaaaaaaaaaaaa'
  #     p match
  #     p match.captures
  #     split_string(match.captures.first).each do |role|
  #       return true if roles.detect { |fdn_role| fdn_role.code == role }
  #     end
  #     return false
  #   else
  #     super
  #   end
  # end
  #
  # def is_status?(method_id)
  #   /^is_?([a-zA-Z]\w*)\?$/.match(method_id.to_s)
  # end
end
