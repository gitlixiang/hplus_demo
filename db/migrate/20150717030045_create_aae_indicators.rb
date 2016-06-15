class CreateAaeIndicators < ActiveRecord::Migration
  def change
    create_table :aae_indicators do |t|
      t.integer :fs_id
      t.decimal :indicator_attr1, :precision => 20, :scale => 2, :default => 0.00 #流动比率
      t.decimal :indicator_attr2, :precision => 20, :scale => 2, :default => 0.00 #速动比率
      t.decimal :indicator_attr3, :precision => 20, :scale => 2, :default => 0.00 #资产负债率
      t.decimal :indicator_attr4, :precision => 20, :scale => 2, :default => 0.00 #权益比率
      t.decimal :indicator_attr5, :precision => 20, :scale => 2, :default => 0.00 #权益乘数
      t.decimal :indicator_attr6, :precision => 20, :scale => 2, :default => 0.00 #产权比率
      t.decimal :indicator_attr7, :precision => 20, :scale => 2, :default => 0.00 #有形净值负债率
      t.decimal :indicator_attr8, :precision => 20, :scale => 2, :default => 0.00 #有形净值
      t.decimal :indicator_attr9, :precision => 20, :scale => 2, :default => 0.00 #利息保障倍数
      t.decimal :indicator_attr10, :precision => 20, :scale => 2, :default => 0.00 #息税前利润
      t.decimal :indicator_attr11, :precision => 20, :scale => 2, :default => 0.00 #应收账款周转率
      t.decimal :indicator_attr12, :precision => 20, :scale => 2, :default => 0.00 #账销净收入
      t.decimal :indicator_attr13, :precision => 20, :scale => 2, :default => 0.00 #应收账款平均余额
      t.decimal :indicator_attr14, :precision => 20, :scale => 2, :default => 0.00 #应收账款周转天数
      t.decimal :indicator_attr15, :precision => 20, :scale => 2, :default => 0.00 #存货周转率
      t.decimal :indicator_attr16, :precision => 20, :scale => 2, :default => 0.00 #销售成本
      t.decimal :indicator_attr17, :precision => 20, :scale => 2, :default => 0.00 #平均存货
      t.decimal :indicator_attr18, :precision => 20, :scale => 2, :default => 0.00 #存货周转天数
      t.decimal :indicator_attr19, :precision => 20, :scale => 2, :default => 0.00 #流动资产周转率
      t.decimal :indicator_attr20, :precision => 20, :scale => 2, :default => 0.00 #流动资产平均率
      t.decimal :indicator_attr21, :precision => 20, :scale => 2, :default => 0.00 #流动资产周转天数
      t.decimal :indicator_attr22, :precision => 20, :scale => 2, :default => 0.00 #固定资产收入率
      t.decimal :indicator_attr23, :precision => 20, :scale => 2, :default => 0.00 #总资产周转率
      t.decimal :indicator_attr24, :precision => 20, :scale => 2, :default => 0.00 #营业周期
      t.decimal :indicator_attr25, :precision => 20, :scale => 2, :default => 0.00 #销售净利率
      t.decimal :indicator_attr26, :precision => 20, :scale => 2, :default => 0.00 #资产净利率
      t.decimal :indicator_attr27, :precision => 20, :scale => 2, :default => 0.00 #资本金净利率
      t.decimal :indicator_attr28, :precision => 20, :scale => 2, :default => 0.00 #净资产收益率
      t.decimal :indicator_attr29, :precision => 20, :scale => 2, :default => 0.00 #盈余现金保障倍数
      t.decimal :indicator_attr30, :precision => 20, :scale => 2, :default => 0.00 #资本保值增值率
      t.decimal :indicator_attr31, :precision => 20, :scale => 2, :default => 0.00 #经营现金流入比重
      t.decimal :indicator_attr32, :precision => 20, :scale => 2, :default => 0.00 #经营现金流出比重
      t.decimal :indicator_attr33, :precision => 20, :scale => 2, :default => 0.00 #投资现金流入比重
      t.decimal :indicator_attr34, :precision => 20, :scale => 2, :default => 0.00 #投资现金流出比重
      t.decimal :indicator_attr35, :precision => 20, :scale => 2, :default => 0.00 #筹资现金流入比重
      t.decimal :indicator_attr36, :precision => 20, :scale => 2, :default => 0.00 #筹资现金流出比重
      t.decimal :indicator_attr37, :precision => 20, :scale => 2, :default => 0.00 #流入流出比
      t.decimal :indicator_attr38, :precision => 20, :scale => 2, :default => 0.00 #现金到期债务比
      t.decimal :indicator_attr39, :precision => 20, :scale => 2, :default => 0.00 #现金流动负债比
      t.decimal :indicator_attr40, :precision => 20, :scale => 2, :default => 0.00 #现金债务总额比
      t.decimal :indicator_attr41, :precision => 20, :scale => 2, :default => 0.00 #销售现金比率
      t.decimal :indicator_attr42, :precision => 20, :scale => 2, :default => 0.00 #全部资产现金回收率
      t.decimal :indicator_attr43, :precision => 20, :scale => 2, :default => 0.00 #资本积累率
      t.decimal :indicator_attr44, :precision => 20, :scale => 2, :default => 0.00 #资本积累率
      t.timestamps
    end
  end
end
