class CreateRadCorporateBonds < ActiveRecord::Migration
  def change
    create_table :rad_corporate_bonds do |t|
      t.integer :ent_id #企业名称
      t.string :bond_name #债务人
      t.string :bond_type #债务类型
      t.date :bond_date #借债日期
      t.decimal :bond_total, :precision => 20, :scale => 2 #债务总额
      t.integer :distribute_num #发行数量
      t.date :distribute_deadline #发行期限
      t.decimal :distribute_price, :precision => 20, :scale => 2 #发行价格
      t.string :used #债务资金投向
      t.decimal :repayments_rate, :precision => 20, :scale => 2 #还款利率
      t.date :repayments_date #还款期限
      t.decimal :repayments_total, :precision => 20, :scale => 2 #还款总额
      t.string :cooperation_agency #承销机构
      t.string :guarantee_info #担保情况

      t.decimal :et_assets, :precision => 20, :scale => 2 #企业净资产
      t.string :status

      t.tracer
      t.timestamps null: false
    end
  end
end
