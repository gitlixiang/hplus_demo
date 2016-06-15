class HandsonTable < ActiveRecord::Base
  attr_accessor :formula

  def initialize(formula)
    @formula = formula
  end

  def calculate_formula
    handson_rows.each do |row|
      @formula.each do |key, value|

      end
    end
  end

  def excel_output(ary, size)
    result = []
    ary.each do |obj|
      result << SORT.take(size).map { |col| obj.send(col) }
    end
    result.each do |row|
      row.map! { |value| (value.is_a?(BigDecimal) || value.is_a?(Float)) ? value.round(2).to_s : value }
      row.map! { |value| value.nil? ? '' : value }
    end
    result
  end

end