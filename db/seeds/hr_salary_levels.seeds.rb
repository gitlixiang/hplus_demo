#coding: utf-8
require 'csv'
directory = File.join(Rails.root, 'db/csv_data')

ActiveRecord::Base.connection_pool.with_connection do |c|
  name = 'hr_salary_levels'
  puts "truncating...#{name}"
  c.execute("truncate table #{name}")
  CSV.foreach(directory+'/'+name+'.csv', headers: true) do |row|
    obj = Hr::SalaryLevel.new row.to_hash.merge!({'created_at' => '2013-12-10 11:18:40', 'updated_at' => '2013-12-10 11:18:40'})
    obj.save(validate: false)
  end

  puts "load completed...#{name}"
end