class Cl::Header < ActiveRecord::Base
  serialize :data
  serialize :merges
  serialize :aligns
  serialize :comments
  has_many :cl_contents, :class_name => 'Cl::Content', foreign_key: :header_id
  before_save :clean_data

  def clean_data

  end

  after_save :update_content

  def update_content

  end
end
