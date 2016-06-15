#coding: utf-8
# after :hr_people do
ActiveRecord::Base.connection_pool.with_connection do |c|
  name = 'hr_person_histories'
  puts "truncating...#{name}"
  c.execute("truncate table #{name}")
  entry_ways_code = Proc.new { %w(01 02 03 04 05 06).sample }
  entry_ways_date = Proc.new { Time.now.change(year: rand(1996..2015), month: rand(1..12), day: rand(1..28)) }
  job_id = Proc.new { Hr::Job.all.map(&:code).sample }
  myself_status = Proc.new { Hr::Lookups::MyselfStatus.all.map(&:code).sample }
  Hr::Person.all.sample(10).each do |p|
    (2..4).to_a.sample.times do
      p.update_attributes(job_id: job_id.call, myself_status: myself_status.call, entry_ways_code: entry_ways_code.call, entry_ways_date: entry_ways_date.call)
    end
  end

  puts "load completed...#{name}"
end
# end