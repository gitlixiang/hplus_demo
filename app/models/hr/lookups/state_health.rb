class Hr::Lookups::StateHealth < Fdn::Lookup
  # To change this template use File | Settings | File Templates.
  #健康状况
  def self.state_health()
    descriptions = Hr::Lookups::StateHealth.where("parent_id is null")
    count = 0
    grouped_options = []

    descriptions.each do |description|
      health = Hr::Lookups::StateHealth.where(["parent_id = ?", description.id]).collect { |a| [a.value, a.code] }
      grouped_options[count] = [description.description, health]
      count += 1
    end
    return grouped_options
  end
end