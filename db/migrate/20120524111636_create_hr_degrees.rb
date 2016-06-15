class CreateHrDegrees < ActiveRecord::Migration
  def change
    create_table :hr_degrees do |t|
      t.string :people_id #人员ID
      t.string :form_learn #学习形式
      t.string :e_experience #教育经历
      t.string :degree_two_code #学历
      t.string :major #所学专业
      t.date :admission_time #入学时间
      t.date :graduation_time #毕（肄）业时间
      t.string :g_school_unit #毕业学校及单位
      t.string :degree #学位
      t.date :degree_time #学位受予时间
      t.string :degree_unit #学位受予单位
      t.integer :worker_code #工作人员序号
      t.timestamps
    end
  end
end
