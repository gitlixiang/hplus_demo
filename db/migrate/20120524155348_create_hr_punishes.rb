class CreateHrPunishes < ActiveRecord::Migration
  def change
    create_table :hr_punishes do |t|
      t.string :people_id         #人员ID
      t.string :punish_name       #处分名称
      t.string :punish_category   #处分类别
      t.string :punish_reasons    #处分原因
      t.date :punish_time         #处分时间
      t.string :punish_unit       #处分给予单位
      t.string :punish_organ      #监察机关直接给予的处分标识
      t.date :punish_revoca       #撤销处分时间
      t.date :punish_remove       #解除处分时间
      t.integer :worker_code      #工作人员序号
      t.timestamps
    end
  end
end
