class CreateHrTreatments < ActiveRecord::Migration
  def change
    create_table :hr_treatments do |t|
      t.integer :ent_id
      t.integer :manager_id
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
