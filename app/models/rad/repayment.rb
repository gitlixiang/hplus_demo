class Rad::Repayment < ActiveRecord::Base

  belongs_to :cor_bond, :class_name => 'Rad::CorporateBond', :foreign_key => 'cor_bond_id'

  scope :by_bond_id, proc { |bond_id| where("cor_bond_id = ?", bond_id) }
  scope :by_lt_date, proc { |date| where("repay_date < ?", date) }
  scope :by_lt_eq_date, proc { |date| where("repay_date <= ?", date) }


  def money
    return (self.repayments||0)+(self.interest||0)
  end

  #已还
  def count_repayments
    return self.cor_bond.rad_repayments.by_lt_date(self.repay_date).sum('repayments')
  end

  #累计已还
  def count_repayments_now
    return self.cor_bond.rad_repayments.by_lt_eq_date(self.repay_date).sum('repayments')
  end
end
