FactoryGirl.define do
  factory :hr_salary_budget, :class => 'Hr::SalaryBudget' do
    org_id 1
    year 1
    status "MyString"
    remark "MyString"
    basic_salary "9.99"
    pay_for_performance "9.99"
    total_overtime_pay "9.99"
    gross_salary "9.99"
    social_insurance "9.99"
    housing_fund "9.99"
    personal_income_tax "9.99"
    total_deduction "9.99"
    net_salary "9.99"
    remark "9.99"
  end

end
