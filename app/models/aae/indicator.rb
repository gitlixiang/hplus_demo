class Aae::Indicator < ActiveRecord::Base

  belongs_to :financial_statement, :class_name => 'Aae::FinancialStatement'
  NOT_DIRECT = [3, 5, 6, 7, 14, 18, 21, 24]

  def year_compare(indicator_last_year, column)
    if !indicator_last_year.nil? && !indicator_last_year.send(column).blank? && indicator_last_year.send(column) != 0
      if !self.send(column).blank?
        t = (((self.send(column) - indicator_last_year.send(column)) / self.send(column))*100).round(2)
        return t.to_s + "%"
      else
        return "0%"
      end
    else
      return "0%"
    end
  end

  def month_compare(indicator_last_month, column)
    if !indicator_last_month.nil? && !indicator_last_month.send(column).blank? && indicator_last_month.send(column) != 0
      if !self.send(column).blank?
        t = (((self.send(column) - indicator_last_month.send(column)) / self.send(column))*100).round(2)
        return t.to_s + "%"
      else
        return "0%"
      end
    else
      return "0%"
    end
  end

  #取最好的那个记录
  def self.max_attr(seq, need_max, fs_id=nil)
    #正比是true
    if NOT_DIRECT.include?(seq)
      direct = false
    else
      direct = true
    end

    if fs_id
      #行业有交集的企业同期的fs
      ind = Aae::FinancialStatement.find(fs_id).same_industry_ent
      if direct || need_max
        max = eval("ind.sort_by!{|x| x.indicator_attr#{seq}}.last.indicator_attr#{seq}")
      else
        max = eval("ind.sort_by!{|x| x.indicator_attr#{seq}}.first.indicator_attr#{seq}")
      end
    else
      if direct || need_max
        max = eval("Aae::Indicator.all.to_a.sort_by!{|x| x.indicator_attr#{seq}}.last.indicator_attr#{seq}")
      else
        max = eval("Aae::Indicator.all.to_a.sort_by!{|x| x.indicator_attr#{seq}}.first.indicator_attr#{seq}")
      end
    end

    [max, direct]
  end

  def warning_css
    css = []
    if !self.indicator_attr1.nil?
      if self.indicator_attr1 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr1 >=0.5 && self.indicator_attr1 < 1
        css << 'btn-bad'
      elsif self.indicator_attr1 >=1 && self.indicator_attr1 < 1.5
        css << 'btn-normal'
      elsif self.indicator_attr1 >=1.5 && self.indicator_attr1 < 4
        css << 'btn-good'
      elsif self.indicator_attr1 >= 4
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr2.nil?
      if self.indicator_attr2 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr2 >=0.5 && self.indicator_attr2 < 0.8
        css << 'btn-bad'
      elsif self.indicator_attr2 >=0.8 && self.indicator_attr2 < 1.5
        css << 'btn-normal'
      elsif self.indicator_attr2 >=1.5 && self.indicator_attr2 < 3
        css << 'btn-good'
      elsif self.indicator_attr2 >= 3
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr3.nil?
      if self.indicator_attr3 > 85
        css << 'btn-worse'
      elsif self.indicator_attr3 > 70 && self.indicator_attr3 <= 85
        css << 'btn-bad'
      elsif self.indicator_attr3 > 50 && self.indicator_attr3 <= 70
        css << 'btn-normal'
      elsif self.indicator_attr3 > 25 && self.indicator_attr3 <= 50
        css << 'btn-good'
      elsif self.indicator_attr3 <= 25
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr4.nil?
      if self.indicator_attr4 < 0.15
        css << 'btn-worse'
      elsif self.indicator_attr4 >= 0.15 && self.indicator_attr4 < 0.3
        css << 'btn-bad'
      elsif self.indicator_attr4 >= 0.3 && self.indicator_attr4 < 0.5
        css << 'btn-normal'
      elsif self.indicator_attr4 >= 0.5 && self.indicator_attr4 < 0.75
        css << 'btn-good'
      elsif self.indicator_attr4 > 0.75
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr5.nil?
      if self.indicator_attr5 >= 0.75
        css << 'btn-bad'
      elsif self.indicator_attr5 >= 0.5 && self.indicator_attr5 < 0.75
        css << 'btn-normal'
      elsif self.indicator_attr5 >= 0.3 && self.indicator_attr5 < 0.5
        css << 'btn-normal'
      elsif self.indicator_attr5 >= 0.15 && self.indicator_attr5 < 0.3
        css << 'btn-normal'
      elsif self.indicator_attr5 < 0.15
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr6.nil?
      if self.indicator_attr6 <= 120
        css << 'btn-better'
      elsif self.indicator_attr6 > 120 && self.indicator_attr6 <= 140
        css << 'btn-good'
      elsif self.indicator_attr6 > 140 && self.indicator_attr6 <= 180
        css << 'btn-normal'
      elsif self.indicator_attr6 > 180 && self.indicator_attr6 <= 300
        css << 'btn-bad'
      elsif self.indicator_attr6 > 300
        css << 'btn-worse'
      end
    else
      css << ''
    end
    css << ''
    css << ''
    if !self.indicator_attr11.nil?
      if self.indicator_attr11 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr11 >= 0.5 && self.indicator_attr11 < 1
        css << 'btn-bad'
      elsif self.indicator_attr11 >= 1 && self.indicator_attr11 < 3
        css << 'btn-normal'
      elsif self.indicator_attr11 >= 3 && self.indicator_attr11 < 5
        css << 'btn-good'
      elsif self.indicator_attr11 >= 5
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr14.nil?
      if self.indicator_attr14 <= 100
        css << 'btn-better'
      elsif self.indicator_attr14 > 100 && self.indicator_attr14 <= 150
        css << 'btn-good'
      elsif self.indicator_attr14 > 150 && self.indicator_attr14 <= 250
        css << 'btn-normal'
      elsif self.indicator_attr14 > 250 && self.indicator_attr14 <= 350
        css << 'btn-bad'
      elsif self.indicator_attr14 > 350
        css << 'btn-worse'
      end
    else
      css << ''
    end
    if !self.indicator_attr15.nil?
      if self.indicator_attr15 >=5
        css << 'btn-better'
      elsif self.indicator_attr15 >= 3 && self.indicator_attr15 < 5
        css << 'btn-good'
      elsif self.indicator_attr15 >= 1 && self.indicator_attr15 < 3
        css << 'btn-normal'
      elsif self.indicator_attr15 >= 0.5 && self.indicator_attr15 < 1
        css << 'btn-bad'
      elsif self.indicator_attr15 < 0.5
        css << 'btn-worse'
      end
    else
      css << ''
    end
    if !self.indicator_attr18.nil?
      if self.indicator_attr18 <= 100
        css << 'btn-better'
      elsif self.indicator_attr18 > 100 && self.indicator_attr18 <= 150
        css << 'btn-good'
      elsif self.indicator_attr18 > 150 && self.indicator_attr18 <= 250
        css << 'btn-normal'
      elsif self.indicator_attr18 > 250 && self.indicator_attr18 <= 350
        css << 'btn-bad'
      elsif self.indicator_attr18 > 350
        css << 'btn-worse'
      end
    else
      css << ''
    end
    if !self.indicator_attr19.nil?
      if self.indicator_attr19 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr19 >= 0.5 && self.indicator_attr19 < 1
        css << 'btn-bad'
      elsif self.indicator_attr19 >= 1 && self.indicator_attr19 < 3
        css << 'btn-normal'
      elsif self.indicator_attr19 >= 3 && self.indicator_attr19 < 5
        css << 'btn-good'
      elsif self.indicator_attr19 >= 5
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr21.nil?
      if self.indicator_attr21 <= 90
        css << 'btn-better'
      elsif self.indicator_attr21 > 90 && self.indicator_attr21 <= 180
        css << 'btn-good'
      elsif self.indicator_attr21 > 180 && self.indicator_attr21 <= 270
        css << 'btn-normal'
      elsif self.indicator_attr21 > 270 && self.indicator_attr21 <= 360
        css << 'btn-bad'
      elsif self.indicator_attr21 > 360
        css << 'btn-worse'
      end
    else
      css << ''
    end
    css << ''
    if !self.indicator_attr23.nil?
      if self.indicator_attr23 < 0.8
        css << 'btn-worse'
      elsif self.indicator_attr23 >= 0.8 && self.indicator_attr23 < 1.2
        css << 'btn-bad'
      elsif self.indicator_attr23 >= 1.2 && self.indicator_attr23 < 1.5
        css << 'btn-normal'
      elsif self.indicator_attr23 >= 1.5 && self.indicator_attr23 < 4
        css << 'btn-good'
      elsif self.indicator_attr23 >= 4
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr24.nil?
      if self.indicator_attr24 <= 200
        css << 'btn-better'
      elsif self.indicator_attr24 > 200 && self.indicator_attr24 <= 290
        css << 'btn-good'
      elsif self.indicator_attr24 > 290 && self.indicator_attr24 <= 380
        css << 'btn-normal'
      elsif self.indicator_attr24 > 380 && self.indicator_attr24 <= 470
        css << 'btn-bad'
      elsif self.indicator_attr24 > 470
        css << 'btn-worse'
      end
    else
      css << ''
    end
    if !self.indicator_attr43.nil?
      if self.indicator_attr43 < 3
        css << 'btn-worse'
      elsif self.indicator_attr43 >= 3 && self.indicator_attr43 < 5
        css << 'btn-bad'
      elsif self.indicator_attr43 >= 5 && self.indicator_attr43 < 10
        css << 'btn-normal'
      elsif self.indicator_attr43 >= 10 && self.indicator_attr43 < 30
        css << 'btn-good'
      elsif self.indicator_attr43 >= 30
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr38.nil?
      if self.indicator_attr38 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr38 >= 0.5 && self.indicator_attr38 < 1
        css << 'btn-bad'
      elsif self.indicator_attr38 >= 1 && self.indicator_attr38 < 1.5
        css << 'btn-normal'
      elsif self.indicator_attr38 >= 1.5 && self.indicator_attr38 < 5
        css << 'btn-good'
      elsif self.indicator_attr38 >= 5
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr39.nil?
      if self.indicator_attr39 < 0.5
        css << 'btn-worse'
      elsif self.indicator_attr39 >= 0.5 && self.indicator_attr39 < 1
        css << 'btn-bad'
      elsif self.indicator_attr39 >= 1.5 && self.indicator_attr39 < 3
        css << 'btn-normal'
      elsif self.indicator_attr39 >= 3 && self.indicator_attr39 < 5
        css << 'btn-good'
      elsif self.indicator_attr39 >= 5
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr40.nil?
      if self.indicator_attr40 < -5
        css << 'btn-worse'
      elsif self.indicator_attr40 >= -5 && self.indicator_attr40 < 0
        css << 'btn-bad'
      elsif self.indicator_attr40 >= 0 && self.indicator_attr40 < 0.25
        css << 'btn-normal'
      elsif self.indicator_attr40 >= 0.25 && self.indicator_attr40 < 2
        css << 'btn-good'
      elsif self.indicator_attr40 >= 2
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr41.nil?
      if self.indicator_attr41 < 0.03
        css << 'btn-worse'
      elsif self.indicator_attr41 >= 0.03 && self.indicator_attr41 < 0.25
        css << 'btn-bad'
      elsif self.indicator_attr41 >= 0.25 && self.indicator_attr41 < 1
        css << 'btn-normal'
      elsif self.indicator_attr41 >= 1 && self.indicator_attr41 < 4
        css << 'btn-good'
      elsif self.indicator_attr41 >= 4
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr42.nil?
      if self.indicator_attr42 < 0
        css << 'btn-worse'
      elsif self.indicator_attr42 >= 0 && self.indicator_attr42 < 2
        css << 'btn-bad'
      elsif self.indicator_attr42 >= 2 && self.indicator_attr42 < 6
        css << 'btn-normal'
      elsif self.indicator_attr42 >= 6 && self.indicator_attr42 < 12
        css << 'btn-good'
      elsif self.indicator_attr42 >= 12
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr25.nil?
      if self.indicator_attr25 <= -50
        css << 'btn-worse'
      elsif self.indicator_attr25 > -50 && self.indicator_attr25 <= 0
        css << 'btn-bad'
      elsif self.indicator_attr25 > 0 && self.indicator_attr25 <= 20
        css << 'btn-normal'
      elsif self.indicator_attr25 > 20 && self.indicator_attr25 <= 60
        css << 'btn-good'
      elsif self.indicator_attr25 > 60
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr26.nil?
      if self.indicator_attr26 <= -50
        css << 'btn-worse'
      elsif self.indicator_attr26 > -50 && self.indicator_attr26 <= 0
        css << 'btn-bad'
      elsif self.indicator_attr26 > 0 && self.indicator_attr26 <= 20
        css << 'btn-normal'
      elsif self.indicator_attr26 > 20 && self.indicator_attr26 <= 60
        css << 'btn-good'
      elsif self.indicator_attr26 > 60
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr27.nil?
      if self.indicator_attr27 < -50
        css << 'btn-worse'
      elsif self.indicator_attr27 > -50 && self.indicator_attr27 <= 0
        css << 'btn-bad'
      elsif self.indicator_attr27 > 0 && self.indicator_attr27 <= 20
        css << 'btn-normal'
      elsif self.indicator_attr27 > 20 && self.indicator_attr27 <= 60
        css << 'btn-good'
      elsif self.indicator_attr27 > 60
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr28.nil?
      if self.indicator_attr28 < -20
        css << 'btn-worse'
      elsif self.indicator_attr28 >= -20 && self.indicator_attr28 < 0
        css << 'btn-bad'
      elsif self.indicator_attr28 >= 0 && self.indicator_attr28 < 10
        css << 'btn-normal'
      elsif self.indicator_attr28 >= 10 && self.indicator_attr28 < 20
        css << 'btn-good'
      elsif self.indicator_attr28 >= 20
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr29.nil?
      if self.indicator_attr29 <= -10
        css << 'btn-worse'
      elsif self.indicator_attr29 > -10 && self.indicator_attr29 <= 0
        css << 'btn-bad'
      elsif self.indicator_attr29 > 0 && self.indicator_attr29 < 5
        css << 'btn-normal'
      elsif self.indicator_attr29 >= 5 && self.indicator_attr29 < 7
        css << 'btn-good'
      elsif self.indicator_attr29 >= 7
        css << 'btn-better'
      end
    else
      css << ''
    end
    if !self.indicator_attr30.nil?
      if self.indicator_attr30 < 1
        css << 'btn-worse'
      elsif self.indicator_attr30 == 1
        css << 'btn-normal'
      elsif self.indicator_attr30 > 1
        css << 'btn-better'
      end
    else
      css << ''
    end
    return css
  end

  def check_attr(num)
    return self.warning_css[num].split('-')[1]
  end

end
