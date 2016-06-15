json.array!(@hr_salaries) do |hr_salary|
  json.extract! hr_salary, :id, :post_salary, :full_attendance_bonus, :allowance, :basic_salary, :performance_standards, :performance_percent, :pay_for_performance, :overtime_hours, :overtime_pay, :holiday_overtime_hours, :holiday_overtime_pay, :total_overtime_pay, :gross_salary, :social_insurance, :housing_fund, :personal_income_tax, :leave_days, :leave, :late_times, :late, :other_deduction, :total_deduction, :net_salary
  json.url hr_salary_url(hr_salary, format: :json)
end
