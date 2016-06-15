class CreateHrDemobilizeds < ActiveRecord::Migration
  def change
    create_table :hr_demobilizeds do |t|
      t.string :people_id          #人员ID
      t.date :demobilized_year     #转业年份
      t.string :retired_Post       #退出现役时职务（级别）
      t.integer :worker_code       #工作人员序号

      t.timestamps
    end
  end
end
