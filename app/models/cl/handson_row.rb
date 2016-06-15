class HandsonRow < ActiveRecord::Base
  SORT = ('a'..'z').to_a+('a'..'z').to_a.map { |left| ('a'..'z').to_a.map { |right| left+right } }.flatten
  SORT.map(&:to_sym).each do |attr|
    attr_accessor attr
  end
  #first last 记录第一个和最后一个child
  #children 记录type=group时的子项目
  #resource 保存业务对象
  #type 自己决定内容，用来区分每一行的类型
  #row_index 该行在excel中的行数
  attr_accessor :resource_type, :resource_id, :type, :row_index, :first, :last, :children

  def initialize(type='other', ary=[])
    @type = type
    ary.each_with_index do |obj, index|
      attr = SORT[index]
      self.send(attr+'=', obj)
    end
    @children = []
  end

  def resource
    resource_type.constantize.find(resource_id)
  end

  #排序,获得行数
  def self.sort_rows(ary)
    ary.each_with_index do |row, index|
      row.row_index = index+1 if row.is_a?(HandsonRow)
    end
  end

  #取指定列数,两位小数
  def self.excel_output(ary, size)
    result = []
    ary.each do |obj|
      result << SORT.take(size).map { |col| obj.send(col) }
    end
    result.each do |row|
      # row.map! { |value| value.eql?(0) ? '' : value }
      row.map! { |value| (value.is_a?(BigDecimal) || value.is_a?(Float)) ? value.round(2).to_s : value }
      row.map! { |value| value.nil? ? '' : value }
    end
    result
  end

  #计算每行的公式
  def self.calculate_formula(ary, formula, *type)
    ary.each do |row|
      if type.blank? || type.include?(row.type)
        formula.each do |key, value|
          row.send(key.to_s+'=', value.upcase.gsub('@', (row.row_index).to_s)) if row.type!='header'
        end
      end
    end
  end

  #计算若干列的合计
  def self.calculate_sum(ary, columns)
    ary.each do |row|
      if row.first && row.last
        columns.each do |column|
          row.send(column+'=', "=SUM(#{column.upcase}#{row.first.row_index}:#{column.upcase}#{row.last.row_index})")
        end
      elsif !row.children.blank?
        columns.each do |column|
          row.send(column+'=', "=#{row.children.map { |c| column.upcase+c.row_index.to_s }.join('+')}")
        end
      end
    end
  end

  def sum_ary(type, ary, range)
    HandsonRow.new(type, range.map { |attr| ary.sum(attr.to_sym) })
  end

  def self.set_number(str)
    Integer(str) rescue false
    Float(str) rescue false
  end
end


