class Pm::Comment < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :user, :class_name => 'Fdn::User', foreign_key: 'user_id'

  default_scope -> { order('created_at') }
end
