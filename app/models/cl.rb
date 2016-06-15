#coding: utf-8
module Cl
  def self.table_name_prefix
    'cl_'
  end

  def year_ary(model, method)
    year = model.minimum(method)
    if year && year < (Time.now.year-5)
      result = (year..(Time.now.year+1)).to_a.map { |year| [year.to_s+'年', year] }
    else
      result = (Time.now.year-3..Time.now.year+1).to_a.map { |year| [year.to_s+'年', year] }
    end
    result
  end


  module_function :year_ary
end
