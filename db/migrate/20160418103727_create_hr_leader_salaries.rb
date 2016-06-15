class CreateHrLeaderSalaries < ActiveRecord::Migration
  def change
    create_table :hr_leader_salaries do |t|
      t.integer :person_id
      t.integer :year
      t.integer :month
      t.string :status
      t.string :remark

      t.decimal :basic_annual_salary, :precision => 20, :scale => 2 #基本年薪
      t.decimal :performance_annual_salary, :precision => 20, :scale => 2 #绩效年薪
      t.decimal :coefficient, :precision => 20, :scale => 2 #系数
      t.decimal :cash_amount, :precision => 20, :scale => 2 #当年兑现金额
      t.decimal :other_income, :precision => 20, :scale => 2 #其他金额
      t.decimal :total, :precision => 20, :scale => 2 #年薪合计

      t.tracer
      t.timestamps null: false
    end
  end
end
