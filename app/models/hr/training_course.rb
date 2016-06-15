class Hr::TrainingCourse < ActiveRecord::Base
  has_many :training_infos, :class_name => 'Hr::TrainingInfo', :foreign_key => 'tc_id', :dependent => :destroy
end
