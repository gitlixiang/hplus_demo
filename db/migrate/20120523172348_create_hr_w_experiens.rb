class CreateHrWExperiens < ActiveRecord::Migration
  def change
    create_table :hr_w_experiens do |t|
      t.string :people_id #人员ID
      t.date :start_time #开始时间
      t.date :end_time #结束时间
      t.string :work_way #任职方式
      t.string :office_property #任职属性
      t.integer :job_level_id #职务层次
      t.integer :job_id #职务名称
      t.string :tenure_category #职务类别
      t.string :treatment_level #待遇级别
      t.string :work_unit_dept #工作单位及部门
      t.integer :worker_code #工作人员序号

      t.timestamps
    end
  end
end
