#coding: utf-8
module Aae::FinancialStatementsHelper


  def aae_view_link(fs)
    [
        {value: '查看', url: url_for(:controller => 'aae/financial_statements', :action => :show, :id => fs.id)},
        {value: '编辑', url: url_for(:controller => 'aae/financial_statements', :action => :edit, :id => fs.id)}
    ]
  end

  def table_analysis_header
    first = [{w: '', t: '企业名称', rowspan: 2},
             {w: '', t: '月份', rowspan: 2},
             {w: '1', t: '短期偿债能力', colspan: 2},
             {w: '1', t: '长期偿债能力', colspan: 6},
             {w: '1', t: '经营业绩考核', colspan: 9},
             {w: '1', t: '发展能力', colspan: 1},
             {w: '1', t: '现金流量结构分析', colspan: 5},
             {w: '1', t: '经济情况分析', colspan: 6},
    ]
    second =[
        #{w: '1', t: ''},
        {w: '1', t: '流动比率*'},
        {w: '1', t: '速动比率'},
        {w: '1', t: '资产负债率*(%)'},
        {w: '1', t: '权益比率*'},
        {w: '1', t: '权益乘数*'},
        {w: '1', t: '产权比率*(%)'},
        {w: '1', t: '有形净值负债率(%)'},
        {w: '1', t: '利息保障倍数'},
        {w: '1', t: '应收账款周转率'},
        {w: '1', t: '应收账款周转天数'},
        {w: '1', t: '存货周转率'},
        {w: '1', t: '存货周转天数'},
        {w: '1', t: '流动资产周转率'},
        {w: '1', t: '流动资产周转天数'},
        {w: '1', t: '固定资产收入率'},
        {w: '1', t: '总资产周转率'},
        {w: '1', t: '营业周期'},
        {w: '1', t: '资本积累率'},
        {w: '1', t: '现金到期债务比'},
        {w: '1', t: '现金流动负债比'},
        {w: '1', t: '现金债务总额比'},
        {w: '1', t: '销售现金比率'},
        {w: '1', t: '全部资产现金回收率'},
        {w: '1', t: '销售净利率'},
        {w: '1', t: '资产净利率'},
        {w: '1', t: '资本金净利率'},
        {w: '1', t: ' 净资收益率'},
        {w: '1', t: '盈余现金保障倍数'},
        {w: '1', t: ' 资本保值增值率'}
    ]
    return [first, second]
  end

  def financial_analysis_data_header(x_axis)
    value = []
    x_axis.each do |x|
      value << {w: '', t: x, style: "width:100px"}
    end
    (6-x_axis.size).times do
      value << {w: '', t: '', style: "width:100px"}
    end
    return value
  end

  def financial_analysis_header(x_axis)
    value = []
    value << {w: '', t: '财报日期', style: "width:200px"}
    x_axis.each do |x|
      value << {w: '', t: x, style: "width:100px"}
    end
    (6-x_axis.size).times do
      value << {w: '', t: '', style: "width:100px"}
    end
    return value
  end

  def financial_analysis_name_header
    value = []
    value << {w: '', t: '财报日期'}
    return value
  end

end
