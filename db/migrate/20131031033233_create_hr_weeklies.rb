class CreateHrWeeklies < ActiveRecord::Migration
  def change
    create_table :hr_weeklies do |t|
      t.integer :ent_id
      t.date :sub_date
      t.string :seq
      t.text :content
      t.string :status
      t.date :f_date
      t.date :l_date
      t.timestamps
      t.tracer
    end
  end
end
