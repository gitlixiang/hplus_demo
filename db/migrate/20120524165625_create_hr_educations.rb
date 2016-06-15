class CreateHrEducations < ActiveRecord::Migration
  def change
    create_table :hr_educations do |t|
      t.string :people_id #人员ID
      t.string :education_nature #教育培训性质
      t.string :education_mode #教育培训方式
      t.string :education_content #教育培训内容
      t.string :education_class #教育培训类别
      t.string :education_result #教育培训结果
      t.string :credit #学分
      t.date :start_time #起始时间
      t.date :end_time #终止时间
      t.string :unit_nature #办学单位性质
      t.integer :worker_code #工作人员序号
      t.timestamps
    end
  end
end
