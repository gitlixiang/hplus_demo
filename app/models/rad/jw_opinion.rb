class Rad::JwOpinion < ActiveRecord::Base
  belongs_to :rad_investment, :class_name => 'Rad::Investment', foreign_key: 'resource_id'

end
