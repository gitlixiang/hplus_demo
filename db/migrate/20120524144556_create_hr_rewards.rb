class CreateHrRewards < ActiveRecord::Migration
  def change
    create_table :hr_rewards do |t|
      t.string :people_id #人员ID
      t.string :reward_name #奖励名称
      t.string :honor_title #荣誉称号名称
      t.string :reward_category #奖励类别
      t.string :reward_reasons #奖励原因
      t.date :reward_time #奖励时间
      t.string :reward_unit #奖励批准单位
      t.string :honor_title_level #授予荣誉称号级别
      t.integer :worker_code #工作人员序号
      t.timestamps
    end
  end
end
