#coding: utf-8
# after :hr_people do
  ActiveRecord::Base.connection_pool.with_connection do |c|
    name = 'hr_salaries'
    puts "truncating...#{name}"
    c.execute("truncate table #{name}")

    d = Proc.new {|age| sprintf("%.2f", rand(2000.01...3000.99)+(age-20)*rand(400.01...600.99)) }
    dd = Proc.new {|age| sprintf("%.2f", rand(200.01...2000.99)+(age-20)*rand(100.01...300.99)) }
    ddd = Proc.new {|age| sprintf("%.2f", rand(100.01...200.99)+(age-20)*rand(50.01...150.99)) }


    # post_salary: d.call(person.age),
    # full_attendance_bonus: d.call(person.age),
    # allowance: d.call(person.age),
    # basic_salary: d.call(person.age),
    # performance_standards: d.call(person.age),
    # performance_percent: d.call(person.age),
    # pay_for_performance: d.call(person.age),
    # overtime_hours: d.call(person.age),
    # overtime_pay: d.call(person.age),
    # holiday_overtime_hours: d.call(person.age),
    # holiday_overtime_pay: d.call(person.age),
    # total_overtime_pay: d.call(person.age),
    # gross_salary: d.call(person.age),
    # social_insurance: d.call(person.age),
    # housing_fund: d.call(person.age),
    # personal_income_tax: d.call(person.age),
    # leave_days: d.call(person.age),
    # leave: d.call(person.age),
    # late_times: d.call(person.age),
    # late: d.call(person.age),
    # other_deduction: d.call(person.age),
    # total_deduction: d.call(person.age),
    # net_salary: d.call(person.age)

    # basic_salary: d.call(person.age),
    # pay_for_performance: d.call(person.age),
    # total_overtime_pay: d.call(person.age),
    # gross_salary: d.call(person.age),
    # total_deduction: d.call(person.age),
    # net_salary: d.call(person.age)
    (2011..2016).to_a.each do |year|
      (1..12).to_a.each do |month|
        x = rand(0..10)
        y = rand(0..100)
        org = Fdn::Organization.find 4
        org.people.each do |person|
          Hr::Salary.create(person_id: person.id, year: year, month: month, status: 'Y',
                            post_salary: d.call(person.age),
                            full_attendance_bonus: dd.call(person.age),
                            allowance: dd.call(person.age),
                            performance_standards: dd.call(person.age),
                            performance_percent: 0.3,
                            overtime_hours: y,
                            overtime_pay: y*40,
                            holiday_overtime_hours: y,
                            holiday_overtime_pay: y*120,
                            social_insurance: dd.call(person.age),
                            housing_fund: dd.call(person.age),
                            personal_income_tax: ddd.call(person.age),
                            leave_days: x,
                            leave: x*40,
                            late_times: x,
                            late: x*10,
                            other_deduction: d.call(person.age))
        end

        [3, 6].each do |org_id|
          org = Fdn::Organization.find org_id
          org.people.each do |person|
            Hr::Salary.create(person_id: person.id, year: year, month: month, status: 'Y',
                              post_salary: d.call(person.age),
                              full_attendance_bonus: dd.call(person.age),
                              allowance: dd.call(person.age),
                              performance_standards: dd.call(person.age),
                              performance_percent: 0.3,
                              overtime_hours: y,
                              overtime_pay: y*40,
                              holiday_overtime_hours: y,
                              holiday_overtime_pay: y*120,
                              social_insurance: dd.call(person.age),
                              housing_fund: dd.call(person.age),
                              personal_income_tax: ddd.call(person.age),
                              leave_days: x,
                              leave: x*40,
                              late_times: x,
                              late: x*10,
                              other_deduction: d.call(person.age))
          end
        end
        [2, 4].each do |org_id|
          org = Fdn::Organization.find org_id
          org.people.each do |person|
            Hr::Salary.create(person_id: person.id, year: year, month: month, status: 'Y',
                              post_salary: d.call(person.age),
                              full_attendance_bonus: dd.call(person.age),
                              allowance: dd.call(person.age),
                              performance_standards: dd.call(person.age),
                              performance_percent: 0.3,
                              overtime_hours: y,
                              overtime_pay: y*40,
                              holiday_overtime_hours: y,
                              holiday_overtime_pay: y*120,
                              social_insurance: dd.call(person.age),
                              housing_fund: dd.call(person.age),
                              personal_income_tax: ddd.call(person.age),
                              leave_days: x,
                              leave: x*40,
                              late_times: x,
                              late: x*10,
                              other_deduction: d.call(person.age))
          end
        end
      end

    end
    puts "load completed...#{name}"
  end
# end