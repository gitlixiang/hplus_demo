#coding: utf-8
module Fdn
  class FileTemplate < ActiveRecord::Base
    FILE_TYPES = [['必须', 'REQ'], ["标准", 'STD'], ['其他', 'OTH']]
    DEF_CLASS = 'DEF'
    LEG_CLASS = 'LEG'

    EVENT_FIR_TEM = [['FIR1', '提起议案'], ['FIR2', '调研论证'], ['FIR3', '听取意见'], ['FIR4', '提前告知']]
    EVENT_SEC_TEM = [['SEC1', '会议决策'], ['SEC2', '临时决策'], ['SEC3', '记录存档']]

    scope :by_resource_type, proc { |resource_type| where("resource_type = ? ", resource_type) }
    scope :by_template_type, proc { |template_type| where("template_type = ? ", template_type) }
    scope :by_template_class, proc { |template_class| where("template_class = ? ", template_class) }

    scope :std_templates, lambda { |resource_type| where("resource_type = ? and status = 'Y' and template_type <> 'OTH'", resource_type).order("seq") }
    scope :template_class_value, lambda { |resource_type, template_class| where("resource_type = ? and template_class = ?", resource_type, template_class).order("seq") }
    scope :template_type_value, lambda { |resource_type, template_type| where("resource_type = ? and template_type = ?", resource_type, template_type).order("seq") }
    scope :std_class_templates, lambda { |resource_type, file_class| where(["resource_type = ? and template_class = ?  and status = 'Y' and template_type <> 'OTH'", resource_type, file_class]).order("seq") }
    scope :req_templates, lambda { |resource_type| where("resource_type = ? and status = 'Y' and template_type = 'REQ'", resource_type).order("seq") }
    scope :req_class_templates, lambda { |resource_type, file_class| where(["resource_type = ? and template_class = ?  and status = 'Y' and template_type = 'REQ'", resource_type, file_class]).order("seq") }
    scope :oth_templates, lambda { |resource_type| where("resource_type = ? and status = 'Y' and template_type = 'OTH'", resource_type).order("seq") }
    scope :oth_class_templates, lambda { |resource_type, file_class| where(["resource_type = ? and template_class = ?  and status = 'Y' and template_type = 'OTH'", resource_type, file_class]).order("seq") }

    def self.file_name_list(template_class)
      return Fdn::FileTemplate.by_template_class(template_class).select('distinct file_name')
    end


  end
end

