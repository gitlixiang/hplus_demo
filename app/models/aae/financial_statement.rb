#coding: utf-8
class Aae::FinancialStatement < ActiveRecord::Base

  belongs_to :enterprise, :class_name => 'Fdn::Enterprise', :foreign_key => 'ent_id'
  attr_accessor :ent_name

  has_one :balance, :class_name => "Aae::Balance", :foreign_key => 'fs_id', :dependent => :destroy
  accepts_nested_attributes_for :balance

  has_one :profit, :class_name => "Aae::Profit", :foreign_key => 'fs_id', :dependent => :destroy
  accepts_nested_attributes_for :profit

  has_one :cash_flow, :class_name => "Aae::CashFlow", :foreign_key => 'fs_id', :dependent => :destroy
  accepts_nested_attributes_for :cash_flow

  has_one :indicator, :class_name => "Aae::Indicator", :foreign_key => 'fs_id', :dependent => :destroy
  accepts_nested_attributes_for :indicator

  validates_uniqueness_of :month, :scope => [:year, :ent_id]

  after_update :au
  scope :by_ent_id, proc { |org_id| where('aae_financial_statements.ent_id = ?', org_id) }
  scope :by_year, proc { |year| where('year = ?', year) }
  scope :by_month, proc { |month| where('month = ?', month) }
  scope :by_quarter, -> { where('month in (3,6,9,12)') }


  def ent_name
    enterprise.name if enterprise
  end

  def year_month_date
    return self.year.to_s + '.' + self.month.to_s
  end

  LONG_HAS_CHART = [3, 4, 5, 6, 7, 9]
  ASSESS_HAS_CHART = [11, 14, 19, 21, 23, 24]

  #财务分析所有attr
  WARNING_SHOW = [1, 2, 3, 4, 5, 6, 7, 9, 11, 14, 15, 18, 19, 21, 22, 23, 24, 43, 38, 39, 40, 41, 42, 25, 26, 27, 28, 29, 30]
  #预警分析attr
  WARNING_SHOW = [1, 2, 3, 4, 5, 6, 11, 14, 19, 21, 23, 24, 43, 38, 39, 40, 41, 42, 25, 26, 27, 28, 29, 30]
  #短期偿债能力分析/短期偿债能力预警
  SHORT_TERM = [1, 2]
  SHORT_TERM_WARNING = [1, 2]
  #长期偿债能力分析/长期偿债能力预警
  LONG_TERM = [3, 4, 5, 6, 7, 9]
  LONG_TERM_WARNING = [3, 4, 5, 6]
  #经营业绩考核分析/经营业绩考核预警
  PERFORMANCE_EVALUATION = [11, 14, 15, 18, 19, 21, 22, 23, 24]
  PERFORMANCE_EVALUATION_WARNING = [11, 14, 15, 18, 19, 21, 23, 24]
  #发展能力分析/发展能力预警
  DEVELOPMENT_ABILITY = [43]
  DEVELOPMENT_ABILITY_WARNING = [43]
  #现金流量结构分析/现金流量结构分析预警
  CASH_FLOW_STRUCTURE = [38, 39, 40, 41, 42]
  CASH_FLOW_STRUCTURE_WARNING = [38, 39, 40, 41, 42]
  #经济情况分析/经济情况分析预警
  ECONOMIC_SITUATION = [25, 26, 27, 28, 29, 30]
  ECONOMIC_SITUATION_WARNING = [25, 26, 27, 28, 29, 30]

  COLOR_LEVEL = [['很好', 'btn-better'], ['好', 'btn-good'], ['一般', 'btn-normal'], ['差', 'btn-bad'], ['很差', 'btn-worse']]

  def au
    @indicator = self.indicator.blank? ? Aae::Indicator.new : self.indicator
    @indicator.fs_id = self.id
    #1.流动比率
    if !self.balance.blank? && self.balance.end_attr95.to_f != 0
      @indicator.indicator_attr1 = self.balance.end_attr27.to_f / self.balance.end_attr95.to_f
    end
    #2.速动比率
    if !self.balance.blank? && self.balance.end_attr95.to_f != 0
      @indicator.indicator_attr2 = (self.balance.end_attr27.to_f - self.balance.end_attr20.to_f - self.balance.end_attr12.to_f - self.balance.end_attr24.to_f) / self.balance.end_attr95.to_f
    end
    #3.资产负债率
    if !self.balance.blank? && self.balance.end_attr66.to_f != 0
      @indicator.indicator_attr3 = (self.balance.end_attr105.to_f / self.balance.end_attr66.to_f) * 100
    end
    #4.权益比率
    if !self.balance.blank? && self.balance.end_attr66.to_f != 0
      @indicator.indicator_attr4 = self.balance.end_attr131.to_f / self.balance.end_attr66.to_f
    end
    #5.权益成数
    if !self.balance.blank? && self.balance.end_attr131.to_f != 0
      @indicator.indicator_attr5 = self.balance.end_attr66.to_f / self.balance.end_attr131.to_f
    end
    #6.产权比率
    if !self.balance.blank? && self.balance.end_attr131.to_f != 0
      @indicator.indicator_attr6 = (self.balance.end_attr105.to_f / self.balance.end_attr131.to_f) * 100
    end
    #7.有形净值负债率
    if !self.balance.blank? && (self.balance.end_attr131-self.balance.end_attr46.to_f) != 0
      @indicator.indicator_attr7 = self.balance.end_attr105.to_f / (self.balance.end_attr131.to_f - self.balance.end_attr46.to_f)
    end
    #9.利息保障倍数
    if !self.profit.blank? && self.profit.y_attr24.to_f != 0
      @indicator.indicator_attr9 = (self.profit.y_attr2.to_f - self.profit.y_attr9.to_f) / self.profit.y_attr24.to_f
    end
    #11.应收账款周转率
    if !self.balance.blank? && !self.profit.nil? && (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f+self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) != 0
      @indicator.indicator_attr11 = self.profit.y_attr2.to_f / (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f+self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) *2
    end
    #14.应收账款周转天数
    if !self.balance.blank? && !self.profit.nil? && (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f + self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) !=0 && self.profit.y_attr2.to_f != 0
      @indicator.indicator_attr14 = 360 / (self.profit.y_attr2.to_f / (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f + self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) *2)
    end
    #15.存货周转率
    if !self.profit.blank? && !self.balance.nil? && (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f) != 0
      @indicator.indicator_attr15 = self.profit.y_attr9.to_f / (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f)*2
    end
    #18.存货周转天数
    if !self.profit.blank? && !self.balance.nil? && self.profit.y_attr9.to_f != 0 && (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f) != 0
      @indicator.indicator_attr18 = 360/(self.profit.y_attr9.to_f / (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f)*2)
    end
    #19.流动资产周转率
    if !self.profit.blank? && !self.balance.blank? && (self.balance.end_attr27.to_f+self.balance.start_attr27.to_f) !=0
      @indicator.indicator_attr19 = self.profit.y_attr2.to_f / (self.balance.end_attr27.to_f+self.balance.start_attr27.to_f)*2
    end
    #21.流动资产周转天数
    if !self.profit.blank? && !self.balance.blank? && self.profit.y_attr2.to_f != 0 && (self.balance.end_attr27.to_f+self.balance.start_attr27.to_f) != 0
      @indicator.indicator_attr21 = 360 / (self.profit.y_attr2.to_f / ((self.balance.end_attr27.to_f+self.balance.start_attr27.to_f)*2))
    end
    #22.固定资产收入率
    if !self.profit.nil? && !self.balance.nil? && (self.balance.end_attr53.to_f+self.balance.start_attr53.to_f) != 0
      @indicator.indicator_attr22 = self.profit.y_attr2.to_f / ((self.balance.end_attr53.to_f+self.balance.start_attr53.to_f) / 2) * 100
    end
    #23.总资产周转率
    if !self.profit.nil? && !self.balance.nil? && (self.balance.end_attr66.to_f+self.balance.start_attr66.to_f) != 0
      @indicator.indicator_attr23 = self.profit.y_attr1.to_f / ((self.balance.end_attr66.to_f+self.balance.start_attr66.to_f) / 2)
    end
    #24.营业周期
    if !self.profit.nil? && !self.balance.nil? && self.profit.y_attr9.to_f != 0 && (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f) != 0 && (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f+self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) && self.profit.y_attr2.to_f != 0
      @indicator.indicator_attr24 = 360/(self.profit.y_attr9.to_f / (self.balance.end_attr20.to_f+self.balance.start_attr20.to_f)*2)+ 360 / (self.profit.y_attr2.to_f / (self.balance.end_attr11.to_f+self.balance.end_attr8.to_f+self.balance.start_attr11.to_f+self.balance.start_attr8.to_f) *2)
    end
    #25.销售净利率
    if !self.profit.nil? && self.profit.y_attr3.to_f != 0
      @indicator.indicator_attr25 = self.profit.y_attr47.to_f / self.profit.y_attr3.to_f * 100
    end
    #26.资产净利率
    if !self.profit.nil? && !self.balance.blank? && (self.balance.start_attr66.to_f + self.balance.end_attr66.to_f) != 0
      @indicator.indicator_attr26 = self.profit.y_attr47.to_f / (self.balance.end_attr66.to_f + self.balance.start_attr66.to_f) * 2*100
    end
    #27.资本金净利率
    if !self.profit.nil? && !self.balance.blank? && (self.balance.start_attr107.to_f + self.balance.end_attr107.to_f) != 0
      @indicator.indicator_attr27 = self.profit.y_attr47.to_f / (self.balance.end_attr107.to_f + self.balance.start_attr107.to_f)*2*100
    end
    #28.净资产收益率
    if !self.profit.nil? && !self.balance.blank? && (self.balance.start_attr131.to_f + self.balance.end_attr131.to_f) != 0
      @indicator.indicator_attr28 = self.profit.y_attr47.to_f / (self.balance.end_attr131.to_f + self.balance.start_attr131.to_f)*2*100
    end
    #29.盈余现金保障倍数  ###################TODO    26 or 34
    if !self.profit.nil? && self.profit.y_attr47.to_f != 0 && !self.cash_flow.attr26.nil?
      @indicator.indicator_attr29 = self.cash_flow.attr34.to_f / self.profit.y_attr47.to_f
    end
    #30.资本保值增值率
    if !self.balance.blank? && self.balance.start_attr131.to_f != 0
      @indicator.indicator_attr30 = self.balance.end_attr131.to_f / self.balance.start_attr131.to_f
    end
    #TODO 31-37 分析未使用
    #31.经营现金流入比重
    if !self.cash_flow.nil? && (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f !=0)
      @indicator.indicator_attr31 =self.cash_flow.attr15.to_f / (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f)
    end
    #32.经营现金流出比重
    if !self.cash_flow.nil? && (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f !=0)
      @indicator.indicator_attr32 =self.cash_flow.attr25.to_f / (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f)
    end
    #33.投资现金流入比重
    if !self.cash_flow.nil? && (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f !=0)
      @indicator.indicator_attr33 =self.cash_flow.attr33.to_f / (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f)
    end
    #34.投资现金流出比重
    if !self.cash_flow.nil? && (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f !=0)
      @indicator.indicator_attr34 =self.cash_flow.attr39.to_f / (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f)
    end
    #35.筹资现金流入比重
    if !self.cash_flow.nil? && (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f !=0)
      @indicator.indicator_attr35 =self.cash_flow.attr47.to_f / (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f)
    end
    #36.筹资现金流出比重
    if !self.cash_flow.nil? && (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f !=0)
      @indicator.indicator_attr36 = self.cash_flow.attr52.to_f / (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f)
    end
    #37.流入流出比
    if !self.cash_flow.nil? && (self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f !=0)
      @indicator.indicator_attr37 = (self.cash_flow.attr15.to_f+self.cash_flow.attr33.to_f+self.cash_flow.attr47.to_f)/(self.cash_flow.attr25.to_f+self.cash_flow.attr39.to_f+self.cash_flow.attr52.to_f)
    end
    #38.现金到期债务比
    if !self.cash_flow.nil? && !self.balance.blank? && (self.balance.end_attr93.to_f + self.balance.end_attr73.to_f !=0)
      @indicator.indicator_attr38 = self.cash_flow.attr33.to_f / (self.balance.end_attr93.to_f + self.balance.end_attr73.to_f)*100
    end
    #39. 现金流动负债比
    if !self.cash_flow.nil? && !self.balance.blank? && self.balance.end_attr95.to_f != 0
      @indicator.indicator_attr39 = self.cash_flow.attr26.to_f / self.balance.end_attr95.to_f*100
    end
    #40.现金债务总额比
    if !self.cash_flow.nil? && !self.balance.blank? && self.balance.end_attr105.to_f != 0
      @indicator.indicator_attr40 = self.cash_flow.attr26.to_f / self.balance.end_attr105.to_f
    end
    #41.销售现金比率  TODO
    if !self.cash_flow.nil? && !self.profit.nil? && self.profit.y_attr3.to_f != 0
      @indicator.indicator_attr41 = self.cash_flow.attr75.to_f / self.profit.y_attr3.to_f
    end
    #42.全部资产现金回收率
    if !self.cash_flow.nil? && !self.balance.blank? && self.balance.end_attr66.to_f != 0
      @indicator.indicator_attr42 = self.cash_flow.attr26.to_f / self.balance.end_attr66.to_f
    end
    #资本积累率 #TODO 需要确认
    if !self.balance.blank? && self.balance.start_attr131.to_f != 0
      @indicator.indicator_attr43 = (self.balance.end_attr131.to_f-self.balance.start_attr131.to_f) / self.balance.start_attr131.to_f*100
    end
    @indicator.save
  end

  def self.more_search(params, page=nil, limit=nil)
    r = Aae::FinancialStatement
    if page
      r = r.paginate(:page => page)
    elsif limit
      r = r.limit(limit)
    else
      r = r
    end

    r
  end


  ####取同行业同期的fs
  def same_industry_ent
    ind = self.enterprise.ent_industry_code
    result = []
    Fdn::Enterprise.all.each do |e|
      arr = ind.split(',') + e.ent_industry_code.split(',')
      unless arr.uniq!.blank?
        fs = Aae::FinancialStatement.by_year(self.year).by_month(self.month).by_ent_id(e.id).first
        result << fs.indicator if !fs.indicator.blank?
      end
    end
    result
  end


end
