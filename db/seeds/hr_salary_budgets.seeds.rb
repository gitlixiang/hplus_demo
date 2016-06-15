#coding: utf-8
# after :hr_people do
ActiveRecord::Base.connection_pool.with_connection do |c|
  name = 'hr_salary_budgets'
  puts "truncating...#{name}"
  c.execute("truncate table #{name}")

  a = Proc.new { |num| sprintf("%.2f", (5000+rand(2000.01...3000.99)+5000+(rand(200.01...2000.99)+2000+(rand(100.01...200.99)+1000+1000)))*12*num) }
  aa = Proc.new { |num| sprintf("%.2f", (2000+rand(200.01...2000.99)+2000+(rand(100.01...200.99)+1000+1000))*12*num) }
  aaa = Proc.new { |num| sprintf("%.2f", (rand(100.01...200.99)+1000+1000)*12*num) }

  # basic_salary:a.call, pay_for_performance:a.call, total_overtime_pay:a.call, gross_salary:a.call, social_insurance:a.call, housing_fund:a.call, personal_income_tax:a.call, total_deduction:a.call, net_salary:a.call
  (2011..2016).to_a.each do |year|
    #三级企业
    Hr::SalaryBudget.create(org_id: 4, year: year, status: 'Y',
                            basic_salary: a.call(100), pay_for_performance: aa.call(100).to_f*0.3, total_overtime_pay: aa.call(100),
                            social_insurance: aa.call(100), housing_fund: aa.call(100), personal_income_tax: aaa.call(100))
    #二级企业
    [3, 6].each do |org_id|
      Hr::SalaryBudget.create(org_id: org_id, year: year, status: 'Y',
                              basic_salary: a.call(500), pay_for_performance: aa.call(500).to_f*0.3, total_overtime_pay: aa.call(500),
                              social_insurance: aa.call(500), housing_fund: aa.call(500), personal_income_tax: aaa.call(500))
    end
    #一级企业
    [2, 4].each do |org_id|
      Hr::SalaryBudget.create(org_id: org_id, year: year, status: 'Y',
                              basic_salary: a.call(1000), pay_for_performance: aa.call(1000).to_f*0.3, total_overtime_pay: aa.call(1000),
                              social_insurance: aa.call(1000), housing_fund: aa.call(1000), personal_income_tax: aaa.call(1000))
    end
  end

  puts "load completed...#{name}"
end
# end