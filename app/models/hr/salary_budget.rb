#coding: utf-8
class Hr::SalaryBudget < ActiveRecord::Base
  # validates_uniqueness_of :year, scope: :org_id, message: '企业在某年度只能上报一次预算!'
  has_one :wf_simple_workflow, :class_name => 'Wf::SimpleWorkflow'
  belongs_to :fdn_organization, :class_name => 'Fdn::Organization', foreign_key: :org_id

  scope :org, ->(org_id) { where(org_id: org_id) }
  scope :orgs, ->(ids) { where('org_id in (?)', ids) }
  scope :year, ->(year) { where(year: year) }

  before_save :bs

  def bs
    gross_salary = self.basic_salary+self.pay_for_performance+self.total_overtime_pay
    total_deduction = self.social_insurance+self.housing_fund+self.personal_income_tax
    net_salary = gross_salary-total_deduction
    self.gross_salary = gross_salary
    self.total_deduction = total_deduction
    self.net_salary = net_salary
  end

  def total_budget
    (self.gross_salary||0) + (self.total_deduction||0)
  end

end
