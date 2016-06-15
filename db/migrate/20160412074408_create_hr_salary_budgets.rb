class CreateHrSalaryBudgets < ActiveRecord::Migration
  def change
    create_table :hr_salary_budgets do |t|
      t.integer :org_id
      t.integer :year
      t.string :status
      t.string :remark
      t.decimal :basic_salary, :precision => 20, :scale => 2
      t.decimal :pay_for_performance, :precision => 20, :scale => 2
      t.decimal :total_overtime_pay, :precision => 20, :scale => 2
      t.decimal :gross_salary, :precision => 20, :scale => 2
      t.decimal :social_insurance, :precision => 20, :scale => 2
      t.decimal :housing_fund, :precision => 20, :scale => 2
      t.decimal :personal_income_tax, :precision => 20, :scale => 2
      t.decimal :total_deduction, :precision => 20, :scale => 2
      t.decimal :net_salary, :precision => 20, :scale => 2

      t.tracer
      t.timestamps null: false
    end
  end
end
