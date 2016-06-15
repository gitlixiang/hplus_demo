class Rad::Investment < ActiveRecord::Base
  attr_accessor :ent_name, :parent_name

  acts_as_ordered_tree

  has_many :file_resources, :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :file_resources, :allow_destroy => true

  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'
  has_one :organization, :class_name => 'Fdn::Organization', :through => :ent

  belongs_to :pro_type, :class_name => 'Rad::Lookups::ProjectType', :foreign_key => 'project_type', :primary_key => 'code'

  belongs_to :person_begin, :class_name => 'Rad::Lookups::RadJobType', :foreign_key => 'person_begin_code', :primary_key => 'code'

  belongs_to :show_type, :class_name => 'Rad::Lookups::OpinionType', :foreign_key => 'show_type_code', :primary_key => 'code'

  #工作流
  has_one :wf_proc_resource, :class_name => 'Wf::ProcResource', as: :resource, dependent: :destroy
  has_one :proc_inst, :class_name => 'Wf::ProcInst', through: :wf_proc_resource

  has_many :jw_opinions, -> { where("status = 'Rad::Investment'") }, class_name: 'Rad::JwOpinion', foreign_key: 'resource_id'
  accepts_nested_attributes_for :jw_opinions, :allow_destroy => true

  #项目管理
  has_one :pm_plan, :class_name => 'Pm::Plan', as: :resource, dependent: :destroy

  def ent_name
    self.ent.name if self.is_ent?
  end

  def is_ent?
    self.ent_id
  end

  def parent_name
    if self.parent_id.blank?
      return ''
    else
      return self.parent.project_name
    end
  end

  has_many :fir_files, -> { where("fdn_file_resources.file_template_id in
                               (select fft.id from fdn_file_templates fft
                                where fft.template_type = \'FIR\' and fft.id = fdn_file_resources.file_template_id)") },
           :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :fir_files, :allow_destroy => true

  has_many :sec_files, -> { where("fdn_file_resources.file_template_id in
                               (select fft.id from fdn_file_templates fft
                                where fft.template_type = \'SEC\' and fft.id = fdn_file_resources.file_template_id)") },
           :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :sec_files, :allow_destroy => true

  has_many :thr_files, -> { where("fdn_file_resources.file_template_id in
                               (select fft.id from fdn_file_templates fft
                                where fft.template_type = \'THR\' and fft.id = fdn_file_resources.file_template_id)") },
           :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :thr_files, :allow_destroy => true

  has_many :oth_files, -> { where("fdn_file_resources.file_template_id is null") },
           :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :oth_files, :allow_destroy => true

  scope :by_ent_id, proc { |ent_id| where("ent_id = ?", ent_id) }
end
