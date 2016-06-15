class CreateHrTrainingInfos < ActiveRecord::Migration
  def change
    create_table :hr_training_infos do |t|
      t.integer :tc_id #培训班id
      t.string :name #课程名称
      t.date :date #培训日期
      t.text :people #参与人员
      t.string :charge_man #负责人
      t.integer :org_id #企业id
      t.string :lecturer #培训人
      t.string :charge_contact #负责人联系方式

      t.timestamps null: false
    end
  end
end
