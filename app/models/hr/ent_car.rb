class Hr::EntCar < ActiveRecord::Base
  attr_accessor :ent_name

  belongs_to :rent, :class_name => 'Hr::Lookups::RentType', :foreign_key => 'is_rent', :primary_key => 'code'
  belongs_to :c_status, :class_name => 'Hr::Lookups::CarStatus', :foreign_key => 'car_status', :primary_key => 'code'
  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'

  scope :by_ent_id, proc { |ent_id| where("ent_id = ?", ent_id) }
end
