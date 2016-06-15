#coding: utf-8
module Oa
  class RecvDocument < ActiveRecord::Base
    belongs_to :doc_type, :class_name => 'Oa::Lookups::DocType', :foreign_key => 'doc_type_code', :primary_key => 'code'
    belongs_to :secret_level, :class_name => 'Oa::Lookups::SecretLevel', :foreign_key => 'secret_level_code', :primary_key => 'code'
    belongs_to :doc_urgency, :class_name => 'Oa::Lookups::DocUrgency', :foreign_key => 'doc_urgency_code', :primary_key => 'code'

    belongs_to :creator, :class_name => 'Fdn::User', :foreign_key => 'created_by'
    belongs_to :updater, :class_name => 'Fdn::User', :foreign_key => 'updated_by'

    belongs_to :organization, :class_name => 'Fdn::Organization', :foreign_key => 'sent_organization_id'

    has_many :file_resources, :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
    accepts_nested_attributes_for :file_resources, :allow_destroy => true

    scope :by_user_id, lambda { |user_id| where("created_by = ?", user_id) }
  end
end
# == Schema Information
#
# Table name: oa_recv_documents
#
#  id                   :integer(4)      not null, primary key
#  doc_type             :string(255)
#  doc_type_code        :string(255)
#  doc_class_code       :string(255)
#  doc_word             :string(255)
#  year                 :integer(4)
#  no                   :integer(4)
#  secret_level         :string(255)
#  secret_level_code    :string(255)
#  doc_urgency          :string(255)
#  doc_urgency_code     :string(255)
#  sent_organization_id :integer(4)
#  signer               :string(255)
#  content              :text
#  title                :string(255)
#  content_time         :datetime
#  sign_time            :datetime
#  memo                 :text
#  keyword              :string(255)
#  writer               :string(255)
#  print_time           :datetime
#  print_count          :integer(4)
#  print_org_id         :integer(4)
#  finished_time        :datetime
#  sent_document_id     :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#  created_by           :integer(4)
#  updated_by           :integer(4)
#

