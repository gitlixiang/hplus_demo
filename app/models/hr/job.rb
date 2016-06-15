class Hr::Job < ActiveRecord::Base
  scope :actived, -> { where("status = 'Y'") }

  #职务名称
  def self.category_job()
    count = 0
    grouped_options = []
    @job = []
    Hr::Job.all.each do |name|
      @jobcol = Hr::Job.where(["type_code = ?", name.type_code]).collect { |a| [a.name, a.code] }
      grouped_options[count] = [@jobcol[0][0], @jobcol]
      count += 1
    end
    return grouped_options
  end
end
# == Schema Information
#
# Table name: hr_jobs
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  code       :string(255)
#  type_code  :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

