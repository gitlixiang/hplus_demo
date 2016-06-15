class CreateHrQuarters < ActiveRecord::Migration
  def change
    create_table :hr_quarters do |t|
      t.string :qua_num

      t.timestamps
    end
  end
end
