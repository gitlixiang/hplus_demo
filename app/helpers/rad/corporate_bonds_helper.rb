#coding: utf-8
module Rad::CorporateBondsHelper
  def corporate_bond_header
    result = []
    result << {w: 3, t: '企业名称'}
    result << {w: 1, t: '债券种类'}
    result << {w: 2, t: '债务总额(万元)'}
    result << {w: 2, t: '净资产(万元)'}
    result << {w: 2, t: '债务资金投向'}
    result << {w: 2, t: '操作'}
    result
  end

  def corporate_bond_fn_header
    result = []
    result << {w: 3, t: '企业名称'}
    result << {w: 2, t: '债务总额(万元)'}
    result << {w: 2, t: '还款总额(万元)'}
    result << {w: 2, t: '已还债务(万元)'}
    result << {w: 2, t: '操作'}
    result
  end

  def corporate_bond_search_header
    result = []
    result << {w: 3, t: '企业名称'}
    result << {w: 2, t: '债务总额(万元)'}
    result << {w: 2, t: '已还债务(万元)'}
    result << {w: 1, t: '债务分析'}
    result << {w: 2, t: '操作'}
    result
  end
end
