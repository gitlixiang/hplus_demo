class CreateHrQuaReports < ActiveRecord::Migration
  def change
    create_table :hr_qua_reports do |t|
      t.integer :ent_id
      t.date :sub_date
      t.string :qua_num
      t.text :content
      t.string :status

      t.tracer
      t.timestamps
    end
  end
end
