class Hr::Lookups::CategoryPerson < Fdn::Lookup
  # To change this template use File | Settings | File Templates.
  #增加减少人员途径
  def self.category_person()
    descriptions = Hr::Lookups::CategoryPerson.where("parent_id is null")
    count = 0
    grouped_options = []

    descriptions.each do |description|
      health = Hr::Lookups::CategoryPerson.where(["parent_id = ?", description.id]).collect { |a| [a.value, a.code] }
      grouped_options[count] = [description.description, health]
      count += 1
    end
    return grouped_options
  end
end