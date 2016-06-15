class CreateHrAssesses < ActiveRecord::Migration
  def change
    create_table :hr_assesses do |t|
      t.string :people_id #人员ID
      t.string :assess_class #考核类别
      t.string :assess_unit #考核单位
      t.date :assess_start_time #考核起始日期
      t.date :assess_end_time #考核终止日期
      t.string :assess_result #考核结果
      t.string :help_attach #是否扶贫援藏援疆挂职人员
      t.text :explain #说明
      t.integer :worker_code #工作人员序号
      t.timestamps
    end
  end
end
