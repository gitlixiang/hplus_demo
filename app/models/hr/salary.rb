class Hr::Salary < ActiveRecord::Base
  belongs_to :hr_person, :class_name => 'Hr::Person', foreign_key: :person_id
  # budget  final
  scope :person, ->(person_id) { where(person_id: person_id) }
  scope :persons, ->(ids) { where('person_id in (?)', ids) }
  scope :year, ->(year) { where(year: year) }
  scope :month, ->(month) { where(month: month) }
  scope :lt_month, ->(month) { where('month < ?', month) }
  scope :lteq_month, ->(month) { where('month <= ?', month) }
  default_scope -> { order('year desc ,month') }

  before_save :bs

  def bs
    basic_salary = self.post_salary+self.full_attendance_bonus+self.allowance
    pay_for_performance = self.performance_standards*self.performance_percent
    total_overtime_pay = self.overtime_pay+self.holiday_overtime_pay

    gross_salary = basic_salary+pay_for_performance+total_overtime_pay
    total_deduction = self.social_insurance+self.housing_fund+self.personal_income_tax+self.leave+self.late+self.other_deduction
    net_salary = gross_salary-total_deduction

    self.basic_salary = basic_salary
    self.pay_for_performance = pay_for_performance
    self.total_overtime_pay = total_overtime_pay

    self.gross_salary = gross_salary
    self.total_deduction = total_deduction
    self.net_salary = net_salary
  end

  def total_budget
    (self.gross_salary||0) + (self.total_deduction||0)
  end
end
