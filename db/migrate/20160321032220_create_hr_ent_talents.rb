class CreateHrEntTalents < ActiveRecord::Migration
  def change
    create_table :hr_ent_talents do |t|
      t.string :name
      t.string :sex
      t.date :birthday
      t.string :national_code
      t.string :native_place_code
      t.date :work_date
      t.string :phone
      t.string :education
      t.string :type_code
      t.string :pro_tech_qua
      t.integer :ent_id
      t.integer :seq
      t.string  :card_num
      t.string  :status , default: 'N'

      t.tracer
      t.timestamps null: false
    end
  end
end
