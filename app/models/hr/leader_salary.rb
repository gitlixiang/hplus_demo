class Hr::LeaderSalary < ActiveRecord::Base
  belongs_to :hr_person, :class_name => 'Hr::Person', foreign_key: :person_id
  has_one :wf_simple_workflow, :class_name => 'Wf::SimpleWorkflow'

  # budget  final
  scope :person, ->(person_id) { where(person_id: person_id) }
  scope :persons, ->(ids) { where('person_id in (?)', ids) }
  scope :year, ->(year) { where(year: year) }
  default_scope -> { order('year desc') }

  before_save :cal_number

  def cal_number
    self.total = basic_annual_salary+performance_annual_salary+other_income
  end
end
