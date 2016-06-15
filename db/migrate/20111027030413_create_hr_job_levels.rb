class CreateHrJobLevels < ActiveRecord::Migration
  def change
    create_table :hr_job_levels do |t|
      t.string :code #编码
      t.string :name #名称
      t.string :status #状态 Y/N
      t.string :major_class #大类
      t.string :minor_class #小类

      t.timestamps
    end
  end
end
