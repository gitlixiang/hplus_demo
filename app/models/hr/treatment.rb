class Hr::Treatment < ActiveRecord::Base
  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'
  belongs_to :manager, :class_name => 'Hr::EntManager', :foreign_key => 'manager_id'
  belongs_to :car, :class_name => 'Hr::EntCar', :foreign_key => 'car_id'
end
