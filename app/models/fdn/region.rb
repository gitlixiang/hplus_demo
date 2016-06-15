module Fdn
  class Region < ActiveRecord::Base
    #   acts_as_tree
    #
    #   scope :by_province, lambda{|province| where("province=?", province)}
    #   scope :by_city, lambda{|city| where("city=?", city)}
    #   scope :by_district, lambda{|district| where("district=?", district)}
    #   scope :by_country, lambda{|country| where("country=?", country)}
    #
    #   #得到拼接后的区域名称
    #   def region_name(has_country = false)
    #    out = province
    #    out += !city.blank? ? '-' + city : ''
    #    out += !district.blank? ? '-' + district : ''
    #     if has_country
    #       out = country + '-' + out
    #     end
    #     out
    #   end
    #
    #   def region_desc(has_country = false)
    #     "#{self.region_code} #{region_name(has_country)}"
    #   end
    #
    #   def self.find_by_region_name(region_name, has_country = false)
    #     regions = region_name.split('-')
    #     if has_country
    #       r = by_country(regions[0])
    #       r = r.by_province(regions[1]) if regions[1]
    #       r = r.by_city(regions[2]) if regions[2]
    #       r = r.by_district(regions[3]) if regions[3]
    #     else
    #       r = r.by_province(regions[0])
    #       r = r.by_city(regions[1]) if regions[1]
    #       r = r.by_district(regions[2]) if regions[2]
    #     end
    #     r
    #   end
    #
    #   #籍贯
    #   def self.category_region()
    #     provinces = Fdn::Region.all(:select=>'distinct province',:order=> "region_code")
    #     count = 0
    #     grouped_options = []
    #     provinces.each do |province|
    #       citys = Fdn::Region.where(["province = ?", province.province]).collect {|a| [a.region_name,a.region_code] }
    #       grouped_options[count] =  [province.province, citys]
    #       count += 1
    #     end
    #     return grouped_options
    #   end
  end
end
# == Schema Information
#
# Table name: fdn_regions
#
#  id          :integer(4)      not null, primary key
#  region_code :string(255)
#  country     :string(255)
#  province    :string(255)
#  city        :string(255)
#  district    :string(255)
#  parent_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

