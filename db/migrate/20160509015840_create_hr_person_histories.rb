class CreateHrPersonHistories < ActiveRecord::Migration
  def change
    create_table :hr_person_histories do |t|
      t.integer :hr_person_id

      t.string :full_name #全名
      t.string :sex #性别
      t.date :birth_date #出生日期
                          # t.string :unit_name #单位名称
                          # t.integer :supervisor_id #直接上级id
      t.string :org_id
      t.string :id_card_number, :limit => 40 #身份证号
      t.string :nationality_code, :limit => 20 #民族
      t.string :native_place_code, :limit => 20 #籍贯
      t.string :place_of_birth, :limit => 100 #出生地
      t.string :political_landscape_code, :limit => 100 #政治面貌
      t.date :participate_work_time #参加工作时间
      t.date :party_date #入党时间
      t.string :state_of_health #健康状况
      t.integer :job_level_id #职务层次
      t.string :job_id #职务名称
      t.string :preparation_class, :limit => 20 #编制类别
      t.string :myself_status #本人身份
      t.string :degree_code, :limit => 20 #全日制学历
      t.string :job_status_code #状态
      t.string :people_category_code, :limit => 100 #人员类别
      t.string :cadres_category_code, :limit => 20 # 干部类别
      t.integer :dept_id # 所在部门
      t.string :entry_ways_code, :limit => 20 #增加减少途径
      t.date :entry_ways_date #增加减少时间
      t.date :into_unit_date #进单位时间
      t.string :demob_class_code, :limit => 20 #退出现役军人（武警标识）
      t.integer :pf_area_flag #公务员录用跨地域标识
      t.integer :pf_sp_exam_flag #公务员特殊考试标识
      t.string :organ_letter, :limit => 100 #批准机关及函件号
      t.string :medical_insurance_code, :limit => 20 #医疗保险状况
      t.string :endowment_insurance_code, :limit => 20 #养老保险状况
      t.string :pf_category_code, :limit => 20 #列入公务员法实施范围管理类别标识
      t.integer :financial_position_flag #财政供养状况
      t.integer :payrol_flag #统发工资状况
      t.text :memo #备注
      t.text :resume #简历
      t.string :assesses_class #考核人员类型
      t.integer :worker_code #工作人员序号
      t.string :now_title #现工作单位及职务
      t.string :now_com_title #现工作单位及职务
      t.text :work_resume #工作简历

      t.timestamps
      t.tracer
    end
  end
end
