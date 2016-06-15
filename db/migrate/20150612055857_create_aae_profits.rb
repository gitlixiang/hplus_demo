class CreateAaeProfits < ActiveRecord::Migration
  def change
    create_table :aae_profits do |t|

      t.integer :fs_id
      t.decimal :m_attr1, :precision => 20, :scale => 2 #营业总收入
      t.decimal :y_attr1, :precision => 20, :scale => 2 #
      t.decimal :m_attr2, :precision => 20, :scale => 2 #营业收入
      t.decimal :y_attr2, :precision => 20, :scale => 2 #
      t.decimal :m_attr3, :precision => 20, :scale => 2 #主营业务收入
      t.decimal :y_attr3, :precision => 20, :scale => 2 #
      t.decimal :m_attr4, :precision => 20, :scale => 2 #其他业务收入
      t.decimal :y_attr4, :precision => 20, :scale => 2 #
      t.decimal :m_attr5, :precision => 20, :scale => 2 #利息收入
      t.decimal :y_attr5, :precision => 20, :scale => 2 #
      t.decimal :m_attr6, :precision => 20, :scale => 2 #已赚保费
      t.decimal :y_attr6, :precision => 20, :scale => 2 #
      t.decimal :m_attr7, :precision => 20, :scale => 2 #手续费及佣金收入
      t.decimal :y_attr7, :precision => 20, :scale => 2 #
      t.decimal :m_attr8, :precision => 20, :scale => 2 #营业总成本
      t.decimal :y_attr8, :precision => 20, :scale => 2 #
      t.decimal :m_attr9, :precision => 20, :scale => 2 #营业成本
      t.decimal :y_attr9, :precision => 20, :scale => 2 #
      t.decimal :m_attr10, :precision => 20, :scale => 2 #主营业务成本
      t.decimal :y_attr10, :precision => 20, :scale => 2 #
      t.decimal :m_attr11, :precision => 20, :scale => 2 #其他业务成本
      t.decimal :y_attr11, :precision => 20, :scale => 2 #
      t.decimal :m_attr12, :precision => 20, :scale => 2 #利息支出
      t.decimal :y_attr12, :precision => 20, :scale => 2 #
      t.decimal :m_attr13, :precision => 20, :scale => 2 #手续费及佣金支出
      t.decimal :y_attr13, :precision => 20, :scale => 2 #
      t.decimal :m_attr14, :precision => 20, :scale => 2 #退保金
      t.decimal :y_attr14, :precision => 20, :scale => 2 #
      t.decimal :m_attr15, :precision => 20, :scale => 2 #赔付支出净额
      t.decimal :y_attr15, :precision => 20, :scale => 2 #
      t.decimal :m_attr16, :precision => 20, :scale => 2 #提取保险合同准备金净额
      t.decimal :y_attr16, :precision => 20, :scale => 2 #
      t.decimal :m_attr17, :precision => 20, :scale => 2 #保单红利支出
      t.decimal :y_attr17, :precision => 20, :scale => 2 #
      t.decimal :m_attr18, :precision => 20, :scale => 2 #分保费用
      t.decimal :y_attr18, :precision => 20, :scale => 2 #
      t.decimal :m_attr19, :precision => 20, :scale => 2 #营业税金及附加
      t.decimal :y_attr19, :precision => 20, :scale => 2 #
      t.decimal :m_attr20, :precision => 20, :scale => 2 #销售费用
      t.decimal :y_attr20, :precision => 20, :scale => 2 #
      t.decimal :m_attr21, :precision => 20, :scale => 2 #管理费用
      t.decimal :y_attr21, :precision => 20, :scale => 2 #
      t.decimal :m_attr22, :precision => 20, :scale => 2 #业务招待费
      t.decimal :y_attr22, :precision => 20, :scale => 2 #
      t.decimal :m_attr23, :precision => 20, :scale => 2 #研究与开发费
      t.decimal :y_attr23, :precision => 20, :scale => 2 #
      t.decimal :m_attr24, :precision => 20, :scale => 2 #财务费用
      t.decimal :y_attr24, :precision => 20, :scale => 2 #
      t.decimal :m_attr25, :precision => 20, :scale => 2 #利息支出
      t.decimal :y_attr25, :precision => 20, :scale => 2 #
      t.decimal :m_attr26, :precision => 20, :scale => 2 #利息收入
      t.decimal :y_attr26, :precision => 20, :scale => 2 #
      t.decimal :m_attr27, :precision => 20, :scale => 2 #汇兑净损失（净收益以“-”号填列）
      t.decimal :y_attr27, :precision => 20, :scale => 2 #
      t.decimal :m_attr28, :precision => 20, :scale => 2 #资产减值损失
      t.decimal :y_attr28, :precision => 20, :scale => 2 #
      t.decimal :m_attr29, :precision => 20, :scale => 2 #其他
      t.decimal :y_attr29, :precision => 20, :scale => 2 #
      t.decimal :m_attr30, :precision => 20, :scale => 2 #加：公允价值变动损益（损失以“-”填列）
      t.decimal :y_attr30, :precision => 20, :scale => 2 #
      t.decimal :m_attr31, :precision => 20, :scale => 2 #投资收益（损失以“-”填列）
      t.decimal :y_attr31, :precision => 20, :scale => 2 #
      t.decimal :m_attr32, :precision => 20, :scale => 2 #对联营企业和合营企业的投资收益
      t.decimal :y_attr32, :precision => 20, :scale => 2 #
      t.decimal :m_attr33, :precision => 20, :scale => 2 #对联营企业和合营企业的投资收益
      t.decimal :y_attr33, :precision => 20, :scale => 2 #
      t.decimal :m_attr34, :precision => 20, :scale => 2 #营业利润（亏损以“-”填列）
      t.decimal :y_attr34, :precision => 20, :scale => 2 #
      t.decimal :m_attr35, :precision => 20, :scale => 2 #营业外收入
      t.decimal :y_attr35, :precision => 20, :scale => 2 #
      t.decimal :m_attr36, :precision => 20, :scale => 2 #非流动性资产处置利得
      t.decimal :y_attr36, :precision => 20, :scale => 2 #
      t.decimal :m_attr37, :precision => 20, :scale => 2 #非货币性资产交换利得
      t.decimal :y_attr37, :precision => 20, :scale => 2 #
      t.decimal :m_attr38, :precision => 20, :scale => 2 #政府补助收入（补贴收入）
      t.decimal :y_attr38, :precision => 20, :scale => 2 #
      t.decimal :m_attr39, :precision => 20, :scale => 2 #债务重组利得
      t.decimal :y_attr39, :precision => 20, :scale => 2 #
      t.decimal :m_attr40, :precision => 20, :scale => 2 #减：营业外支出
      t.decimal :y_attr40, :precision => 20, :scale => 2 #
      t.decimal :m_attr41, :precision => 20, :scale => 2 #非流动性资产处置损失
      t.decimal :y_attr41, :precision => 20, :scale => 2 #
      t.decimal :m_attr42, :precision => 20, :scale => 2 #非货币性资产交换损失（非货币性交易损失）
      t.decimal :y_attr42, :precision => 20, :scale => 2 #
      t.decimal :m_attr43, :precision => 20, :scale => 2 #债务重组损失
      t.decimal :y_attr43, :precision => 20, :scale => 2 #
      t.decimal :m_attr44, :precision => 20, :scale => 2 #利润总额（亏损以“-”填列）
      t.decimal :y_attr44, :precision => 20, :scale => 2 #
      t.decimal :m_attr45, :precision => 20, :scale => 2 #所得税费用
      t.decimal :y_attr45, :precision => 20, :scale => 2 #
      t.decimal :m_attr46, :precision => 20, :scale => 2 # *#未确认的投资损失
      t.decimal :y_attr46, :precision => 20, :scale => 2 #
      t.decimal :m_attr47, :precision => 20, :scale => 2 #净利润（亏损以“-”填列）
      t.decimal :y_attr47, :precision => 20, :scale => 2 #
      t.decimal :m_attr48, :precision => 20, :scale => 2 #归属母公司净利润
      t.decimal :y_attr48, :precision => 20, :scale => 2 #
      t.decimal :m_attr49, :precision => 20, :scale => 2 #*少数股东权益
      t.decimal :y_attr49, :precision => 20, :scale => 2 #
      t.decimal :m_attr50, :precision => 20, :scale => 2 #每股收益
      t.decimal :y_attr50, :precision => 20, :scale => 2 #
      t.decimal :m_attr51, :precision => 20, :scale => 2 #基本每股收益
      t.decimal :y_attr51, :precision => 20, :scale => 2 #
      t.decimal :m_attr52, :precision => 20, :scale => 2 #稀释每股收益
      t.decimal :y_attr52, :precision => 20, :scale => 2 #
      t.decimal :m_attr53, :precision => 20, :scale => 2 #其他综合收益
      t.decimal :y_attr53, :precision => 20, :scale => 2 #
      t.decimal :m_attr54, :precision => 20, :scale => 2 #综合收益总额
      t.decimal :y_attr54, :precision => 20, :scale => 2 #
      t.decimal :m_attr55, :precision => 20, :scale => 2 #归属于母公司所有者的综合收益总额
      t.decimal :y_attr55, :precision => 20, :scale => 2 #
      t.decimal :m_attr56, :precision => 20, :scale => 2 # *归属于少数股东的综合收益总额
      t.decimal :y_attr56, :precision => 20, :scale => 2 #

      t.timestamps
    end
  end
end
