class CreateHrSalaries < ActiveRecord::Migration
  def change
    create_table :hr_salaries do |t|
      t.integer :person_id
      t.integer :year
      t.integer :month
      t.string :status
      t.string :remark

      t.decimal :post_salary, :precision => 20, :scale => 2
      t.decimal :full_attendance_bonus, :precision => 20, :scale => 2
      t.decimal :allowance, :precision => 20, :scale => 2
      t.decimal :basic_salary, :precision => 20, :scale => 2
      t.decimal :performance_standards, :precision => 20, :scale => 2
      t.decimal :performance_percent, :precision => 20, :scale => 2
      t.decimal :pay_for_performance, :precision => 20, :scale => 2
      t.decimal :overtime_hours, :precision => 20, :scale => 2
      t.decimal :overtime_pay, :precision => 20, :scale => 2
      t.decimal :holiday_overtime_hours, :precision => 20, :scale => 2
      t.decimal :holiday_overtime_pay, :precision => 20, :scale => 2
      t.decimal :total_overtime_pay, :precision => 20, :scale => 2
      t.decimal :gross_salary, :precision => 20, :scale => 2
      t.decimal :social_insurance, :precision => 20, :scale => 2
      t.decimal :housing_fund, :precision => 20, :scale => 2
      t.decimal :personal_income_tax, :precision => 20, :scale => 2
      t.decimal :leave_days, :precision => 20, :scale => 2
      t.decimal :leave, :precision => 20, :scale => 2
      t.decimal :late_times, :precision => 20, :scale => 2
      t.decimal :late, :precision => 20, :scale => 2
      t.decimal :other_deduction, :precision => 20, :scale => 2
      t.decimal :total_deduction, :precision => 20, :scale => 2
      t.decimal :net_salary, :precision => 20, :scale => 2

      t.tracer
      t.timestamps null: false
    end
  end
end
