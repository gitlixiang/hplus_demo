json.array!(@hr_salary_budgets) do |hr_salary_budget|
  json.extract! hr_salary_budget, :id, :org_id, :year, :status, :remark, :basic_salary, :pay_for_performance, :total_overtime_pay, :gross_salary, :social_insurance, :housing_fund, :personal_income_tax, :total_deduction, :net_salary, :remark
  json.url hr_salary_budget_url(hr_salary_budget, format: :json)
end
