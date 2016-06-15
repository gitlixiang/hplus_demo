class Hr::JobLevel < ActiveRecord::Base
  def self.category_joblevel()
    jobs = Hr::JobLevel.all.collect { |a| [a.name, a.code] }
    jobs
  end
end
# == Schema Information
#
# Table name: hr_job_levels
#
#  id          :integer(4)      not null, primary key
#  code        :string(255)
#  name        :string(255)
#  status      :string(255)
#  major_class :string(255)
#  minor_class :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

