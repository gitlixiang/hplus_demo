#coding: utf-8
class Hr::Person < ActiveRecord::Base
  SEX = [["男", 'M'], ["女", 'F']]
  belongs_to :fdn_organization, :class_name => 'Fdn::Organization', foreign_key: :org_id
  has_many :hr_person_histories, :class_name => 'Hr::PersonHistory', foreign_key: :hr_person_id

  belongs_to :political_landscape, :class_name => 'Hr::Lookups::PoliticalLandscapeCode', :foreign_key => 'political_landscape_code', :primary_key => 'code'
  belongs_to :nationality, :class_name => 'Fdn::Lookups::Nationality', :foreign_key => 'nationality_code', :primary_key => 'code'
  belongs_to :preparation, :class_name => 'Hr::Lookups::PreparationClass', :foreign_key => 'preparation_class', :primary_key => 'code'
  belongs_to :myself, :class_name => 'Hr::Lookups::MyselfStatus', :foreign_key => 'myself_status', :primary_key => 'code'
  belongs_to :job_status, :class_name => 'Hr::Lookups::JobStatusCode', :foreign_key => 'job_status_code', :primary_key => 'code'
  belongs_to :cadres_category, :class_name => 'Hr::Lookups::CadresCategoryCode', :foreign_key => 'cadres_category_code', :primary_key => 'code'
  belongs_to :demob_class, :class_name => 'Hr::Lookups::DemobClassCode', :foreign_key => 'demob_class_code', :primary_key => 'code'
  belongs_to :pf_area, :class_name => 'Hr::Lookups::PfAreaFlag', :foreign_key => 'pf_area_flag', :primary_key => 'code'
  belongs_to :pf_sp_exam, :class_name => 'Hr::Lookups::PfSpExamFlag', :foreign_key => 'pf_sp_exam_flag', :primary_key => 'code'
  belongs_to :medical_insurance, :class_name => 'Hr::Lookups::MedicalInsuranceCode', :foreign_key => 'medical_insurance_code', :primary_key => 'code'
  belongs_to :endowment_insurance, :class_name => 'Hr::Lookups::EndowmentInsuranceCode', :foreign_key => 'endowment_insurance_code', :primary_key => 'code'
  belongs_to :pf_category, :class_name => 'Hr::Lookups::PfCategoryCode', :foreign_key => 'pf_category_code', :primary_key => 'code'
  belongs_to :financial_position, :class_name => 'Hr::Lookups::PfSpExamFlag', :foreign_key => 'financial_position_flag', :primary_key => 'code'
  belongs_to :payrol, :class_name => 'Hr::Lookups::PfSpExamFlag', :foreign_key => 'payrol_flag', :primary_key => 'code'
  belongs_to :native_place, :class_name => 'Fdn::Region', :foreign_key => 'native_place_code', :primary_key => 'region_code'
  belongs_to :place_birth, :class_name => 'Fdn::Region', :foreign_key => 'place_of_birth', :primary_key => 'region_code'
  belongs_to :state_health, :class_name => 'Hr::Lookups::StateHealth', :foreign_key => 'state_of_health', :primary_key => 'code'
  belongs_to :entry_ways, :class_name => 'Hr::Lookups::EntryWaysCode', :foreign_key => 'entry_ways_code', :primary_key => 'code'
  belongs_to :people_category, :class_name => 'Hr::Lookups::CategoryPerson', :foreign_key => 'people_category_code', :primary_key => 'code'
  belongs_to :degree, :class_name => 'Hr::Lookups::DegreeCode', :foreign_key => 'degree_code', :primary_key => 'code'
  belongs_to :job, :class_name => 'Hr::Job', :foreign_key => 'job_id', :primary_key => 'code'
  belongs_to :job_level, :class_name => 'Hr::JobLevel', :foreign_key => 'job_level_id', :primary_key => 'code'
  belongs_to :dept, :class_name => 'Hr::Lookups::DeptId', :foreign_key => 'dept_id', :primary_key => 'code'
  belongs_to :ass_class, :class_name => 'Hr::Lookups::AssessesClass', :foreign_key => 'assesses_class', :primary_key => 'code'

  before_update :bu

  def bu
    self.hr_person_histories.create(Hr::Person.find(self.id).attributes.except('id', 'created_by', 'updated_by', 'created_at', 'updated_at'))
  end

  def age
    if self.birth_date
      self.birth_date.yday >= Time.now.yday ? (Time.now.year-self.birth_date.year-1) : (Time.now.year-self.birth_date.year)
    else
      ''
    end
  end

  def sex_han
    if self.sex
      Hr::Person::SEX.map(&:first)[Hr::Person::SEX.map(&:last).index(self.sex)]
    end
  end
end
