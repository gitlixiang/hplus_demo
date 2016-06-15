#coding: utf-8
class Rad::CorporateBond < ActiveRecord::Base
  attr_accessor :ent_name
  has_many :file_resources, :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :file_resources, :allow_destroy => true

  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'
  has_one :organization, :class_name => 'Fdn::Organization', :through => :ent

  #工作流
  has_one :wf_proc_resource, :class_name => 'Wf::ProcResource', as: :resource, dependent: :destroy
  has_one :proc_inst, :class_name => 'Wf::ProcInst', through: :wf_proc_resource

  #项目管理
  has_one :pm_plan, :class_name => 'Pm::Plan', as: :resource, dependent: :destroy

  #还款信息
  has_many :rad_repayments, :class_name => 'Rad::Repayment', :foreign_key => 'cor_bond_id', :dependent => :destroy

  scope :by_ent_id, proc { |ent_id| where("ent_id = ?", ent_id) }
  scope :by_bond_type, proc { |bond_type| where("bond_type = ?", bond_type) }
  scope :by_used, proc { |used| where("used = ?", used) }
  scope :by_ids, proc { |ids| where(" rad_corporate_bonds.id in (?) ", ids) }

  BOND_TYPE = [['长期', '长期'], ['中期', '中期'], ['短期', '短期']]
  USED = [['投资', '投资'], ['房地产', '房地产'], ['教育', '教育'], ['金融市场', '金融市场'], ['其他', '其他']]

  def ent_name
    self.ent.name if self.is_ent?
  end

  def is_ent?
    self.ent_id
  end

  #工作流名称
  def project_name
    return self.ent_name + '发债'
  end

  def repay_money
    sum = 0
    self.rad_repayments.map { |repay| sum += repay.money }
    return sum
  end

  def repay_interest
    sum = 0
    self.rad_repayments.map { |repay| sum += repay.interest }
    return sum
  end

end