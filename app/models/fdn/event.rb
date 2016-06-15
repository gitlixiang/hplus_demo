module Fdn
  class Event < ActiveRecord::Base
    #validates_presence_of :name
    belongs_to :resource, :polymorphic => true
    belongs_to :fdn_file_resource, :class_name => 'Fdn::FileResource', foreign_key: 'resource_id'
    #has_event_calendar
  end
end
# == Schema Information
#
# Table name: fdn_events
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  start_at      :datetime
#  end_at        :datetime
#  resource_type :string(255)
#  resource_id   :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#  created_by    :integer(4)
#  updated_by    :integer(4)
#

