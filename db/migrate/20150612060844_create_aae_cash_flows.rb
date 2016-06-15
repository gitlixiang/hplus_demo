class CreateAaeCashFlows < ActiveRecord::Migration
  def change
    create_table :aae_cash_flows do |t|
      t.integer :fs_id
      t.decimal :attr1, :precision => 20, :scale => 2 #经营活动产生的现金流量
      t.decimal :attr2, :precision => 20, :scale => 2 #销售商品、提供劳务收到的现金
      t.decimal :attr3, :precision => 20, :scale => 2 #△客户存款和同业存放款项净增加额
      t.decimal :attr4, :precision => 20, :scale => 2 #△向中央银行借款净增加额
      t.decimal :attr5, :precision => 20, :scale => 2 #向其他金融机构拆入资金净增加额
      t.decimal :attr6, :precision => 20, :scale => 2 #△收到原保险合同保费取得的现金
      t.decimal :attr7, :precision => 20, :scale => 2 #△收到再保险业务现金净额
      t.decimal :attr8, :precision => 20, :scale => 2 # 保户储金及投资款净增加额
      t.decimal :attr9, :precision => 20, :scale => 2 #处置交易性金融资产净增加额
      t.decimal :attr10, :precision => 20, :scale => 2 # 收取利息、手续费及佣金的现金
      t.decimal :attr11, :precision => 20, :scale => 2 #拆入资金净增加额
      t.decimal :attr12, :precision => 20, :scale => 2 #回购业务资金净增加额
      t.decimal :attr13, :precision => 20, :scale => 2 #收到的税费返还
      t.decimal :attr14, :precision => 20, :scale => 2 #收到的其他与经营活动有关的现金
      t.decimal :attr15, :precision => 20, :scale => 2 #现金流入小计
      t.decimal :attr16, :precision => 20, :scale => 2 #购买商品、接受劳务支付的现金
      t.decimal :attr17, :precision => 20, :scale => 2 #△客户贷款及垫款净增加额
      t.decimal :attr18, :precision => 20, :scale => 2 #△存放中央银行和同业款项净增加额
      t.decimal :attr19, :precision => 20, :scale => 2 #△支付原保险合同赔付款项的现金
      t.decimal :attr20, :precision => 20, :scale => 2 #△支付利息、手续费及佣金的现金
      t.decimal :attr21, :precision => 20, :scale => 2 #△支付保单红利的现金
      t.decimal :attr22, :precision => 20, :scale => 2 #支付给职工以及为职工支付的现金
      t.decimal :attr23, :precision => 20, :scale => 2 #支付的各项税费
      t.decimal :attr24, :precision => 20, :scale => 2 #支付的其他与经营活动有关的现金
      t.decimal :attr25, :precision => 20, :scale => 2 #现金流出小计
      t.decimal :attr26, :precision => 20, :scale => 2 #经营活动产生的现金流量净额
      t.decimal :attr27, :precision => 20, :scale => 2 #投资活动产生的现金流量：
      t.decimal :attr28, :precision => 20, :scale => 2 # 收回投资所收到的现金
      t.decimal :attr29, :precision => 20, :scale => 2 #取得投资收益所收到的现金
      t.decimal :attr30, :precision => 20, :scale => 2 # 处置固定资产、无形资产和其他长期资产所收回的现金净额
      t.decimal :attr31, :precision => 20, :scale => 2 #处置子公司及其他营业单位收回的现金净额
      t.decimal :attr32, :precision => 20, :scale => 2 #收到的其他与投资活动有关的现金
      t.decimal :attr33, :precision => 20, :scale => 2 #现金流入小计
      t.decimal :attr34, :precision => 20, :scale => 2 #购建固定资产、无形资产和其他长期资产所支付的现金
      t.decimal :attr35, :precision => 20, :scale => 2 #投资所支付的现金
      t.decimal :attr36, :precision => 20, :scale => 2 # △质押贷款净增加额
      t.decimal :attr37, :precision => 20, :scale => 2 #取得子公司及其他营业单位支付的现金净额
      t.decimal :attr38, :precision => 20, :scale => 2 #支付的其他与投资活动有关的现金
      t.decimal :attr39, :precision => 20, :scale => 2 #现金流出小计
      t.decimal :attr40, :precision => 20, :scale => 2 #投资活动产生的现金流量净额
      t.decimal :attr41, :precision => 20, :scale => 2 #筹资活动产生的现金流量：
      t.decimal :attr42, :precision => 20, :scale => 2 #吸收投资所收到的现金
      t.decimal :attr43, :precision => 20, :scale => 2 #其中：子公司吸收少数股东投资收到的现金
      t.decimal :attr44, :precision => 20, :scale => 2 #借款所收到的现金
      t.decimal :attr45, :precision => 20, :scale => 2 # △发行债券收到的现金
      t.decimal :attr46, :precision => 20, :scale => 2 # 收到的其他与筹资活动有关的现金
      t.decimal :attr47, :precision => 20, :scale => 2 # 现金流入小计
      t.decimal :attr48, :precision => 20, :scale => 2 #偿还债务所支付的现金
      t.decimal :attr49, :precision => 20, :scale => 2 # 分配股利、利润或偿付利息所支付的现金
      t.decimal :attr50, :precision => 20, :scale => 2 # 其中：子公司支付给少数股东的股利、利润
      t.decimal :attr51, :precision => 20, :scale => 2 # 支付的其他与筹资活动有关的现金
      t.decimal :attr52, :precision => 20, :scale => 2 # 现金流出小计
      t.decimal :attr53, :precision => 20, :scale => 2 # 筹资活动产生的现金流量净额
      t.decimal :attr54, :precision => 20, :scale => 2 # 汇率变动对现金的影响
      t.decimal :attr55, :precision => 20, :scale => 2 # 现金及现金等价物净增加额
      t.decimal :attr56, :precision => 20, :scale => 2 #将净利润调节为经营活动现金流量
      t.decimal :attr57, :precision => 20, :scale => 2 #净利润
      t.decimal :attr58, :precision => 20, :scale => 2 # 加：计提的资产减值准备
      t.decimal :attr59, :precision => 20, :scale => 2 #  固定资产折旧
      t.decimal :attr60, :precision => 20, :scale => 2 # 无形资产摊销
      t.decimal :attr61, :precision => 20, :scale => 2 # 长期待摊费用摊销
      t.decimal :attr64, :precision => 20, :scale => 2 #待摊费用减少（减：增加）
      t.decimal :attr65, :precision => 20, :scale => 2 #预提费用增加（减：减少）
      t.decimal :attr66, :precision => 20, :scale => 2 #处置固定资产、无形资产和其他长期资产的损失（减：收益）
      t.decimal :attr67, :precision => 20, :scale => 2 #   固定资产报废损失
      t.decimal :attr68, :precision => 20, :scale => 2 # 财务费用
      t.decimal :attr69, :precision => 20, :scale => 2 #投资损失（减：收益）
      t.decimal :attr70, :precision => 20, :scale => 2 #  递延税款贷项（减：借项）
      t.decimal :attr71, :precision => 20, :scale => 2 # 存货的减少（减：增加）
      t.decimal :attr72, :precision => 20, :scale => 2 #经营性应收项目的减少（减：增加）
      t.decimal :attr73, :precision => 20, :scale => 2 # 经营性应付项目的增加（减：减少）
      t.decimal :attr74, :precision => 20, :scale => 2 # 其他
      t.decimal :attr75, :precision => 20, :scale => 2 # 经营活动产生的现金流量净额
      t.decimal :attr76, :precision => 20, :scale => 2 # 债务转为资本
      t.decimal :attr77, :precision => 20, :scale => 2 # 一年内到期的可转换公司债券
      t.decimal :attr78, :precision => 20, :scale => 2 # 融资租入固定资产
      t.decimal :attr79, :precision => 20, :scale => 2 #现金及现金等价物净增加情况：
      t.decimal :attr80, :precision => 20, :scale => 2 #现金的期末余额
      t.decimal :attr81, :precision => 20, :scale => 2 #减：现金的期初余额
      t.decimal :attr82, :precision => 20, :scale => 2 #加：现金等价物的期末余额
      t.decimal :attr83, :precision => 20, :scale => 2 #减：现金等价物的期初余额
      t.decimal :attr84, :precision => 20, :scale => 2 #现金及现金等价物净增加额
      t.timestamps
    end
  end
end
