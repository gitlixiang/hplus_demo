#coding: utf-8
class Aae::CashFlow < ActiveRecord::Base

  belongs_to :financial_statement, :class_name => 'Aae::FinancialStatement'

  validate :validate_attr84_55
  validate :validate_attr75_26

  def validate_attr84_55
    #if self.attr84 != self.attr55
    #  errors.add(:attr84_55, "现金及现金等价物净增加额不相等（55行与84行）")
    #end
  end



  def validate_attr75_26
    #if self.attr75 != self.attr26
    #  errors.add(:attr75_26, "经营活动产生的现金流量净额不相等（26行与75行）")
    #end
  end
end
