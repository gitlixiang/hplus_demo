class Fdn::LegendMenhu < ActiveRecord::Base
  belongs_to :category, :class_name => 'Fdn::LegendCategory', foreign_key: 'legend_category_id'

  def category_name
    self.category ? self.category.name : ''
  end

end
