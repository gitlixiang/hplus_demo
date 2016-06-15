class CreateAaeBalances < ActiveRecord::Migration
  def change
    create_table :aae_balances do |t|

      t.integer :fs_id
      t.decimal :start_attr1, :precision => 20, :scale => 2 #货币资金初
      t.decimal :end_attr1, :precision => 20, :scale => 2 #货币资金末
      t.decimal :start_attr2, :precision => 20, :scale => 2 #结算备付金初
      t.decimal :end_attr2, :precision => 20, :scale => 2 #结算备付金末
      t.decimal :start_attr3, :precision => 20, :scale => 2 #拆出资金初
      t.decimal :end_attr3, :precision => 20, :scale => 2 #拆出资金末
      t.decimal :start_attr4, :precision => 20, :scale => 2 # 交易性金融资产初
      t.decimal :end_attr4, :precision => 20, :scale => 2 # 交易性金融资产末
      t.decimal :start_attr5, :precision => 20, :scale => 2 #买入返售金融资产初
      t.decimal :end_attr5, :precision => 20, :scale => 2 #买入返售金融资产末
      t.decimal :start_attr6, :precision => 20, :scale => 2 #短期投资初
      t.decimal :end_attr6, :precision => 20, :scale => 2 #短期投资末
      t.decimal :start_attr7, :precision => 20, :scale => 2 #应收票据初
      t.decimal :end_attr7, :precision => 20, :scale => 2 #应收票据末
      t.decimal :start_attr8, :precision => 20, :scale => 2 #应收帐款初
      t.decimal :end_attr8, :precision => 20, :scale => 2 #应收帐款末
      t.decimal :start_attr9, :precision => 20, :scale => 2 #预付款项初
      t.decimal :end_attr9, :precision => 20, :scale => 2 #预付款项末
      t.decimal :start_attr10, :precision => 20, :scale => 2 #应收股利初
      t.decimal :end_attr10, :precision => 20, :scale => 2 #应收股利末
      t.decimal :start_attr11, :precision => 20, :scale => 2 #应收利息初
      t.decimal :end_attr11, :precision => 20, :scale => 2 #应收利息末
      t.decimal :start_attr12, :precision => 20, :scale => 2 #应收保费初
      t.decimal :end_attr12, :precision => 20, :scale => 2 #应收保费末
      t.decimal :start_attr13, :precision => 20, :scale => 2 #应收分保账款初
      t.decimal :end_attr13, :precision => 20, :scale => 2 #应收分保账款末
      t.decimal :start_attr14, :precision => 20, :scale => 2 #应收分保合同准备金初
      t.decimal :end_attr14, :precision => 20, :scale => 2 #应收分保合同准备金末
      t.decimal :start_attr15, :precision => 20, :scale => 2 #其他应收款初
      t.decimal :end_attr15, :precision => 20, :scale => 2 #其他应收款末
      t.decimal :start_attr16, :precision => 20, :scale => 2 #应收补贴款初
      t.decimal :end_attr16, :precision => 20, :scale => 2 #应收补贴款末
      t.decimal :start_attr17, :precision => 20, :scale => 2 #存货初
      t.decimal :end_attr17, :precision => 20, :scale => 2 #存货末
      t.decimal :start_attr18, :precision => 20, :scale => 2 #△贵金属初
      t.decimal :end_attr18, :precision => 20, :scale => 2 #  △贵金属末
      t.decimal :start_attr19, :precision => 20, :scale => 2 #原材料初
      t.decimal :end_attr19, :precision => 20, :scale => 2 #原材料末
      t.decimal :start_attr20, :precision => 20, :scale => 2 # 库存商品初
      t.decimal :end_attr20, :precision => 20, :scale => 2 # 库存商品末
      t.decimal :start_attr21, :precision => 20, :scale => 2 #待摊费用初
      t.decimal :end_attr21, :precision => 20, :scale => 2 #  待摊费用末
      t.decimal :start_attr22, :precision => 20, :scale => 2 # 一年内到期的长期债券投资初
      t.decimal :end_attr22, :precision => 20, :scale => 2 # 一年内到期的长期债券投资末
      t.decimal :start_attr23, :precision => 20, :scale => 2 # 其他流动资产初
      t.decimal :end_attr23, :precision => 20, :scale => 2 # 其他流动资产末
      t.decimal :start_attr24, :precision => 20, :scale => 2 # 流动资产合计初
      t.decimal :end_attr24, :precision => 20, :scale => 2 # 流动资产合计末
      t.decimal :start_attr25, :precision => 20, :scale => 2 #△发放贷款及垫款初
      t.decimal :end_attr25, :precision => 20, :scale => 2 # △发放贷款及垫款末
      t.decimal :start_attr26, :precision => 20, :scale => 2 #可供出售金融资产初
      t.decimal :end_attr26, :precision => 20, :scale => 2 #可供出售金融资产末
      t.decimal :start_attr27, :precision => 20, :scale => 2 #持有至到期投资初
      t.decimal :end_attr27, :precision => 20, :scale => 2 #  持有至到期投资末
      t.decimal :start_attr28, :precision => 20, :scale => 2 #长期应收款初
      t.decimal :end_attr28, :precision => 20, :scale => 2 #   长期应收款末
      t.decimal :start_attr29, :precision => 20, :scale => 2 #长期股权投资初
      t.decimal :end_attr29, :precision => 20, :scale => 2 #  长期股权投资末
      t.decimal :start_attr30, :precision => 20, :scale => 2 #长期债权投资初
      t.decimal :end_attr30, :precision => 20, :scale => 2 # 长期债权投资末
      t.decimal :start_attr31, :precision => 20, :scale => 2 #投资性房地产初
      t.decimal :end_attr31, :precision => 20, :scale => 2 #  投资性房地产末
      t.decimal :start_attr32, :precision => 20, :scale => 2 #△存出保证金初
      t.decimal :end_attr32, :precision => 20, :scale => 2 #  △存出保证金末
      t.decimal :start_attr33, :precision => 20, :scale => 2 #固定资产原价初
      t.decimal :end_attr33, :precision => 20, :scale => 2 # 固定资产原价末
      t.decimal :start_attr34, :precision => 20, :scale => 2 #减：累计折旧初
      t.decimal :end_attr34, :precision => 20, :scale => 2 # 减：累计折旧末
      t.decimal :start_attr35, :precision => 20, :scale => 2 #固定资产净值初
      t.decimal :end_attr35, :precision => 20, :scale => 2 # 固定资产净值末
      t.decimal :start_attr36, :precision => 20, :scale => 2 #减：固定资产减值准备初
      t.decimal :end_attr36, :precision => 20, :scale => 2 #减：固定资产减值准备末
      t.decimal :start_attr37, :precision => 20, :scale => 2 #固定资产净额初
      t.decimal :end_attr37, :precision => 20, :scale => 2 # 固定资产净额末
      t.decimal :start_attr38, :precision => 20, :scale => 2 #工程物资初
      t.decimal :end_attr38, :precision => 20, :scale => 2 #工程物资末
      t.decimal :end_attr39, :precision => 20, :scale => 2 # 在建工程初
      t.decimal :start_attr39, :precision => 20, :scale => 2 # 在建工程初
      t.decimal :end_attr40, :precision => 20, :scale => 2 # 在建工程末
      t.decimal :start_attr40, :precision => 20, :scale => 2 # 固定资产清理初
      t.decimal :start_attr41, :precision => 20, :scale => 2 # 固定资产清理初
      t.decimal :end_attr41, :precision => 20, :scale => 2 #固定资产清理末
      t.decimal :start_attr42, :precision => 20, :scale => 2 # 生产性生物资产初
      t.decimal :end_attr42, :precision => 20, :scale => 2 # 生产性生物资产末
      t.decimal :start_attr43, :precision => 20, :scale => 2 # 油气资产初
      t.decimal :end_attr43, :precision => 20, :scale => 2 #  油气资产末
      t.decimal :start_attr44, :precision => 20, :scale => 2 # 无形资产初
      t.decimal :end_attr44, :precision => 20, :scale => 2 # 无形资产末
      t.decimal :start_attr45, :precision => 20, :scale => 2 #开发支出初
      t.decimal :end_attr45, :precision => 20, :scale => 2 #开发支出末
      t.decimal :start_attr46, :precision => 20, :scale => 2 #商誉初
      t.decimal :end_attr46, :precision => 20, :scale => 2 #商誉末
      t.decimal :start_attr47, :precision => 20, :scale => 2 #长期待摊费用初
      t.decimal :end_attr47, :precision => 20, :scale => 2 #  长期待摊费用末
      t.decimal :start_attr48, :precision => 20, :scale => 2 #　其他长期资产初
      t.decimal :end_attr48, :precision => 20, :scale => 2 #     其他长期资产末
      t.decimal :start_attr49, :precision => 20, :scale => 2 # 递延所得税资产初
      t.decimal :end_attr49, :precision => 20, :scale => 2 # 递延所得税资产末
      t.decimal :start_attr50, :precision => 20, :scale => 2 # 其他非流动资产初
      t.decimal :end_attr50, :precision => 20, :scale => 2 #    其他非流动资产末
      t.decimal :start_attr51, :precision => 20, :scale => 2 # 非流动资产合计初
      t.decimal :end_attr51, :precision => 20, :scale => 2 #  非流动资产合计末
      t.decimal :start_attr52, :precision => 20, :scale => 2 # 非流动资产合计初
      t.decimal :end_attr52, :precision => 20, :scale => 2 #  非流动资产合计末
      t.decimal :start_attr53, :precision => 20, :scale => 2 # 非流动资产合计初
      t.decimal :end_attr53, :precision => 20, :scale => 2 #  非流动资产合计末
      t.decimal :start_attr66, :precision => 20, :scale => 2 # 短期借款初
      t.decimal :end_attr66, :precision => 20, :scale => 2 # 短期借款末
      t.decimal :start_attr67, :precision => 20, :scale => 2 # △向中央银行借款初
      t.decimal :end_attr67, :precision => 20, :scale => 2 # △向中央银行借款末
      t.decimal :start_attr68, :precision => 20, :scale => 2 # △吸收存款及同业存放初
      t.decimal :end_attr68, :precision => 20, :scale => 2 # # △吸收存款及同业存放末
      t.decimal :start_attr69, :precision => 20, :scale => 2 #△拆入资金初
      t.decimal :end_attr69, :precision => 20, :scale => 2 #△拆入资金末
      t.decimal :start_attr70, :precision => 20, :scale => 2 # 交易性金融负债初
      t.decimal :end_attr70, :precision => 20, :scale => 2 # 交易性金融负债末
      t.decimal :start_attr71, :precision => 20, :scale => 2 # 应付票据初
      t.decimal :end_attr71, :precision => 20, :scale => 2 # 应付票据末
      t.decimal :start_attr72, :precision => 20, :scale => 2 # 应付帐款初
      t.decimal :end_attr72, :precision => 20, :scale => 2 # 应付帐款末
      t.decimal :start_attr73, :precision => 20, :scale => 2 # 预收帐款初
      t.decimal :end_attr73, :precision => 20, :scale => 2 # 预收帐款末
      t.decimal :start_attr74, :precision => 20, :scale => 2 #△卖出回购金融资产款初
      t.decimal :end_attr74, :precision => 20, :scale => 2 # #△卖出回购金融资产款末
      t.decimal :start_attr75, :precision => 20, :scale => 2 #△应付手续费及佣金初
      t.decimal :end_attr75, :precision => 20, :scale => 2 #△应付手续费及佣金末
      t.decimal :start_attr76, :precision => 20, :scale => 2 #应付职工薪酬初
      t.decimal :end_attr76, :precision => 20, :scale => 2 #应付职工薪酬末
      t.decimal :start_attr77, :precision => 20, :scale => 2 #应付工资初
      t.decimal :end_attr77, :precision => 20, :scale => 2 #应付工资末
      t.decimal :start_attr78, :precision => 20, :scale => 2 #应付福利费初
      t.decimal :end_attr78, :precision => 20, :scale => 2 #应付福利费末
      t.decimal :start_attr79, :precision => 20, :scale => 2 #职工奖励及福利基金初
      t.decimal :end_attr79, :precision => 20, :scale => 2 #职工奖励及福利基金末
      t.decimal :start_attr80, :precision => 20, :scale => 2 #应交税费初
      t.decimal :end_attr80, :precision => 20, :scale => 2 #应交税费末
      t.decimal :start_attr81, :precision => 20, :scale => 2 #应交税金初
      t.decimal :end_attr81, :precision => 20, :scale => 2 #  #应交税金末
      t.decimal :start_attr82, :precision => 20, :scale => 2 # 应付股利初
      t.decimal :end_attr82, :precision => 20, :scale => 2 # # 应付股利末
      t.decimal :start_attr83, :precision => 20, :scale => 2 #  应付利息初
      t.decimal :end_attr83, :precision => 20, :scale => 2 # #  应付利息末
      t.decimal :start_attr84, :precision => 20, :scale => 2 # 其他应交款初
      t.decimal :end_attr84, :precision => 20, :scale => 2 #  # 其他应交款末
      t.decimal :start_attr85, :precision => 20, :scale => 2 #其他应付款初
      t.decimal :end_attr85, :precision => 20, :scale => 2 #  #其他应付款末
      t.decimal :start_attr86, :precision => 20, :scale => 2 # △应付分保账款初
      t.decimal :end_attr86, :precision => 20, :scale => 2 # △应付分保账款末
      t.decimal :start_attr87, :precision => 20, :scale => 2 # △保险合同准备金初
      t.decimal :end_attr87, :precision => 20, :scale => 2 # △保险合同准备金末
      t.decimal :start_attr88, :precision => 20, :scale => 2 # △代理买卖证券款初
      t.decimal :end_attr88, :precision => 20, :scale => 2 # △代理买卖证券款末
      t.decimal :start_attr89, :precision => 20, :scale => 2 # △代理承销证券款初
      t.decimal :end_attr89, :precision => 20, :scale => 2 # △代理承销证券款末
      t.decimal :start_attr90, :precision => 20, :scale => 2 # 预提费用初
      t.decimal :end_attr90, :precision => 20, :scale => 2 # 预提费用末
      t.decimal :start_attr91, :precision => 20, :scale => 2 # 一年内到期的长期负债初
      t.decimal :end_attr91, :precision => 20, :scale => 2 # 一年内到期的长期负债末
      t.decimal :start_attr92, :precision => 20, :scale => 2 # 其他流动负债初c
      t.decimal :end_attr92, :precision => 20, :scale => 2 ## 其他流动负债末
      t.decimal :start_attr93, :precision => 20, :scale => 2 #  长期借款初
      t.decimal :end_attr93, :precision => 20, :scale => 2 #  长期借款末
      t.decimal :start_attr94, :precision => 20, :scale => 2 #  应付债券初
      t.decimal :end_attr94, :precision => 20, :scale => 2 #  应付债券末
      t.decimal :start_attr95, :precision => 20, :scale => 2 # 专项应付款初
      t.decimal :end_attr95, :precision => 20, :scale => 2 # 专项应付款末
      t.decimal :start_attr96, :precision => 20, :scale => 2 #预计负债初
      t.decimal :end_attr96, :precision => 20, :scale => 2 #预计负债末
      t.decimal :start_attr97, :precision => 20, :scale => 2 # 递延所得税负债初
      t.decimal :end_attr97, :precision => 20, :scale => 2 # 递延所得税负债末
      t.decimal :start_attr98, :precision => 20, :scale => 2 #其他非流动负债初
      t.decimal :end_attr98, :precision => 20, :scale => 2 #其他非流动负债末
      t.decimal :start_attr99, :precision => 20, :scale => 2 #特准储备基金
      t.decimal :end_attr99, :precision => 20, :scale => 2 #特准储备基金
      t.decimal :start_attr100, :precision => 20, :scale => 2 # 非流动负债合计初
      t.decimal :end_attr100, :precision => 20, :scale => 2 # 非流动负债合计末
      t.decimal :start_attr101, :precision => 20, :scale => 2 #负债合计初
      t.decimal :end_attr101, :precision => 20, :scale => 2 #负债合计末
      t.decimal :start_attr102, :precision => 20, :scale => 2 # 所有者权益(或股东权益)初
      t.decimal :end_attr102, :precision => 20, :scale => 2 # 所有者权益(或股东权益)末
      t.decimal :start_attr103, :precision => 20, :scale => 2 # 实收资本(或股本)初
      t.decimal :end_attr103, :precision => 20, :scale => 2 # 实收资本(或股本)末
      t.decimal :start_attr104, :precision => 20, :scale => 2 #国家资本初
      t.decimal :end_attr104, :precision => 20, :scale => 2 #国家资本末
      t.decimal :start_attr105, :precision => 20, :scale => 2 #法人资本初
      t.decimal :end_attr105, :precision => 20, :scale => 2 #法人资本末
      t.decimal :start_attr106, :precision => 20, :scale => 2 #国有法人资本初
      t.decimal :end_attr106, :precision => 20, :scale => 2 #国有法人资本末
      t.decimal :start_attr107, :precision => 20, :scale => 2 #集体法人资本初
      t.decimal :end_attr107, :precision => 20, :scale => 2 #集体法人资本末
      t.decimal :start_attr108, :precision => 20, :scale => 2 #个人资本初
      t.decimal :end_attr108, :precision => 20, :scale => 2 #个人资本末
      t.decimal :start_attr109, :precision => 20, :scale => 2 #外商资本初
      t.decimal :end_attr109, :precision => 20, :scale => 2 #外商资本末
      t.decimal :start_attr110, :precision => 20, :scale => 2 #减：已归还投资初
      t.decimal :end_attr110, :precision => 20, :scale => 2 #减：已归还投资末
      t.decimal :start_attr111, :precision => 20, :scale => 2 #实收资本(或股本)净额初
      t.decimal :end_attr111, :precision => 20, :scale => 2 #实收资本(或股本)净额末
      t.decimal :start_attr112, :precision => 20, :scale => 2 #资本公积初
      t.decimal :end_attr112, :precision => 20, :scale => 2 #资本公积末
      t.decimal :start_attr113, :precision => 20, :scale => 2 #减：库存股初
      t.decimal :end_attr113, :precision => 20, :scale => 2 #减：库存股末
      t.decimal :start_attr114, :precision => 20, :scale => 2 #专项储备初
      t.decimal :end_attr114, :precision => 20, :scale => 2 #专项储备末
      t.decimal :start_attr115, :precision => 20, :scale => 2 # 盈余公积初
      t.decimal :end_attr115, :precision => 20, :scale => 2 # 盈余公积末
      t.decimal :start_attr116, :precision => 20, :scale => 2 # 法定公益金初
      t.decimal :end_attr116, :precision => 20, :scale => 2 # 法定公益金末
      t.decimal :start_attr117, :precision => 20, :scale => 2 #法定公积金初
      t.decimal :end_attr117, :precision => 20, :scale => 2 #法定公积金末
      t.decimal :start_attr118, :precision => 20, :scale => 2 #任意公积金初
      t.decimal :end_attr118, :precision => 20, :scale => 2 #任意公积金末
      t.decimal :start_attr119, :precision => 20, :scale => 2 #储备基金初
      t.decimal :end_attr119, :precision => 20, :scale => 2 #储备基金末
      t.decimal :start_attr120, :precision => 20, :scale => 2 #企业发展基金初
      t.decimal :end_attr120, :precision => 20, :scale => 2 #企业发展基金末
      t.decimal :start_attr121, :precision => 20, :scale => 2 #利润归还投资初
      t.decimal :end_attr121, :precision => 20, :scale => 2 #利润归还投资末
      t.decimal :start_attr122, :precision => 20, :scale => 2 #△一般风险准备初
      t.decimal :end_attr122, :precision => 20, :scale => 2 #△一般风险准备末
      t.decimal :start_attr123, :precision => 20, :scale => 2 # 未分配利润初
      t.decimal :end_attr123, :precision => 20, :scale => 2 # 未分配利润末
      t.decimal :start_attr124, :precision => 20, :scale => 2 #*外币报表折算差额初
      t.decimal :end_attr124, :precision => 20, :scale => 2 #*外币报表折算差额末
      t.decimal :start_attr125, :precision => 20, :scale => 2 #*归属于母公司所有者权益合计初
      t.decimal :end_attr125, :precision => 20, :scale => 2 #*归属于母公司所有者权益合计末
      t.decimal :start_attr126, :precision => 20, :scale => 2 #*少数股东权益初
      t.decimal :end_attr126, :precision => 20, :scale => 2 #*少数股东权益末
      t.decimal :start_attr127, :precision => 20, :scale => 2 #所有者权益(或股东权益)合计初
      t.decimal :end_attr127, :precision => 20, :scale => 2 #所有者权益(或股东权益)合计末
      t.decimal :start_attr128, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计初
      t.decimal :end_attr128, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :start_attr129, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :end_attr129, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :start_attr130, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :end_attr130, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :start_attr131, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :end_attr131, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :start_attr132, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末
      t.decimal :end_attr132, :precision => 20, :scale => 2 #负债及所有者权益(或股东权益)总计末

    end
  end
end
