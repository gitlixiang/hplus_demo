class CreateRadRepayments < ActiveRecord::Migration
  def change
    create_table :rad_repayments do |t|
      t.date :repay_date                                      #还款日期
      t.decimal :repayments , :precision => 20, :scale => 2   #还款（本金）
      t.decimal :debt_radio , :precision => 20, :scale => 2   #资产负债率
      t.decimal :repay_rate , :precision => 20, :scale => 2   #利率
      t.decimal :interest   , :precision => 20, :scale => 2   #利息
      t.integer :cor_bond_id                                  #发债id

      t.timestamps null: false
    end
  end
end
