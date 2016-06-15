class Hr::TrainingInfo < ActiveRecord::Base
  belongs_to :training_course, :class_name => 'Hr::TrainingCourse', :foreign_key => 'tc_id'

  serialize :people

  def course_name
    if self.training_course
      return self.training_course.name
    else
      return ''
    end
  end

  def people_name
    Hr::EntTalent.where(id: self.people).map(&:name).join(',')
  end
end
