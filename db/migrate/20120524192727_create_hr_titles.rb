class CreateHrTitles < ActiveRecord::Migration
  def change
    create_table :hr_titles do |t|
      t.string :people_id #人员ID
      t.string :title_say #衔称
      t.date :give_title_day #授（晋）衔日期
      t.date :title_end_day #衔称终止日期
      t.integer :worker_code #工作人员序号
      t.timestamps
    end
  end
end
