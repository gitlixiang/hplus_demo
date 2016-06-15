class Fdn::JqUser < ActiveRecord::Base
  validates_presence_of :user_name

  #validates_uniqueness_of :status, :scope => [:resource_id,:resource_type]
  after_create :ac
  before_update :bu


  belongs_to :user, :class_name => 'Fdn::User', :foreign_key => 'resource_id'
  scope :show, -> { where("fdn_jq_users.status = 'Y'") }
  scope :cq_users, -> { where("fdn_jq_users.resource_type = 'cq_user'") }
  scope :kb_users, -> { where("fdn_jq_users.resource_type = 'kb_user'") }
  scope :nb_users, -> { where("fdn_jq_users.resource_type = 'nb_user'") }
  scope :ys_users, -> { where("fdn_jq_users.resource_type = 'ys_user'") }
  scope :js_users, -> { where("fdn_jq_users.resource_type = 'js_user'") }

  def bu
    self.status == 'Y' ? self.status = 'Y' : self.status = self.id
  end

  def ac
    self.status == 'Y' ? self.status = 'Y' : self.status = self.id
    self.save
  end
end
