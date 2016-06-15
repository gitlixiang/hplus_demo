class CreateHrHolidays < ActiveRecord::Migration
  def change
    create_table :hr_holidays do |t|
      t.string :user_id
      t.string :dept_id
      t.text :reason
      t.string :phone
      t.date :start_date
      t.date :end_date
      t.text :main_work
      t.string :status

      t.timestamps
      t.tracer
    end
  end
end
