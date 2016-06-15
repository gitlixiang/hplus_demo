class CreateHrWeekNums < ActiveRecord::Migration
  def change
    create_table :hr_week_nums do |t|
      t.string :seq

      t.timestamps
    end
  end
end
