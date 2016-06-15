class Hr::EntTalent < ActiveRecord::Base

  attr_accessor :ent_name
  validates_presence_of :ent_id
  validates_uniqueness_of :seq, :scope => :ent_id
  has_many :file_resources, :class_name => 'Fdn::FileResource', :as => :resource, :dependent => :destroy
  accepts_nested_attributes_for :file_resources, :allow_destroy => true
  has_many :hr_salaries, :class_name => 'Hr::Salary', foreign_key: :person_id
  belongs_to :ent, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'

  belongs_to :tal_type, :class_name => 'Hr::Lookups::TalType', :foreign_key => 'type_code', :primary_key => 'code'
  belongs_to :education_type, :class_name => 'Hr::Lookups::EducationType', :foreign_key => 'education', :primary_key => 'code'
  belongs_to :nationality, :class_name => 'Fdn::Lookups::Nationality', :foreign_key => 'national_code', :primary_key => 'code'

  scope :by_ent_id, proc { |ent_id| where("hr_ent_talents.ent_id = ?", ent_id) }

  scope :active, -> { where("hr_ent_talents.status = 'Y'") }

  before_save :bs

  def bs
    if self.seq.blank?
      seq = Hr::EntTalent.where(ent_id: self.ent_id).map(&:seq).max || 0
      self.seq = seq + 1
    end
  end

  EXPORT_PATH = Rails.root.join("attAcHmS", "export_file")

  def ent_name
    self.ent.name if self.is_ent?
  end

  def full_name
    self.ent_name+'-'+self.name
  end

  def is_ent?
    self.ent_id
  end

  def age
    if self.birthday
      return self.birthday.yday >= Time.now.yday ? (Time.now.year-self.birthday.year-1) : (Time.now.year-self.birthday.year)
    else
      return ''
    end
  end

  def change_talent_seq(change_type)
    if change_type == 'up'
      change_talent = Hr::EntTalent.where(ent_id: self.ent_id, seq: (self.seq - 1)).first
      if change_talent
        self.seq = self.seq - 1
        self.save(validate: false)
        change_talent.seq = change_talent.seq + 1
        change_talent.save(validate: false)
      end
    elsif change_type == 'down'
      change_talent = Hr::EntTalent.where(ent_id: self.ent_id, seq: (self.seq + 1)).first
      if change_talent
        self.seq = self.seq + 1
        self.save(validate: false)
        change_talent.seq = change_talent.seq - 1
        change_talent.save(validate: false)
      end
    end

  end

  def self.training_talent
    @group_opinions = Hash.new
    Fdn::Organization.search_ent.each do |org|
      @group_opinions[org.short_name] = Hr::EntTalent.by_ent_id(org.resource_id).active.map { |o| [o.name, o.id] }
    end
    return @group_opinions
  end
end
