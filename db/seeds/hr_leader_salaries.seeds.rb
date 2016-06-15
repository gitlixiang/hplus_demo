#coding: utf-8
# after :hr_people do
ActiveRecord::Base.connection_pool.with_connection do |c|
  name = 'hr_leader_salaries'
  puts "truncating...#{name}"
  c.execute("truncate table #{name}")

  a = Proc.new { sprintf("%.2f", rand(100000.01...200000.99)) }
  aa = Proc.new { sprintf("%.2f", rand(20000.01...80000.99)) }
  aaa = Proc.new { sprintf("%.2f", rand(0.11...1)) }

  [:basic_annual_salary, :performance_annual_salary, :coefficient,
   :cash_amount, :other_income, :total]

  (2011..2016).to_a.each do |year|
    Fdn::Organization.all[1..5].each do |org|
      org.people.select { |p| p.age >45 }.each do |person|
        Hr::LeaderSalary.create(person_id: person.id, year: year, status: 'Y',
                                basic_annual_salary: a.call, performance_annual_salary: a.call, coefficient: aaa.call,
                                cash_amount: aa.call, other_income: aa.call, total: aa.call)
      end
    end
  end

  puts "load completed...#{name}"
end
# end