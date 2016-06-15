class CreateHrRetirements < ActiveRecord::Migration
  def change
    create_table :hr_retirements do |t|
      t.integer :user_id #用户ID
      t.integer :ent_id #企业ID
      t.string :name #员工名称
      t.string :sex #性别
      t.string :nationality_code #民族
      t.string :native_place_code #籍贯
      t.date :birthday #出生年月
      t.string :id_card_number #身份证号
      t.string :school_record_code #学历
      t.date :work_date #工作时间
      t.string :work_phase #工作时期
      t.date :party_date #入党时间
      t.string :pro_title_code #专业技术职务
      t.string :retire_status_code #离退情况
      t.date :legal_retire_date #法定离退休时间
      t.date :actual_retire_date #实际离退休时间
      t.string :ent_name #企业名称
      t.string :last_title_code #离退休职务
      t.date :date_of_office #任职时间
      t.string :benefit_standard_code #现享受待遇
      t.string :home_address #家庭住址
      t.integer :post_code #邮编
      t.string :home_phone #住宅电话
      t.string :cell_phone #手机
      t.string :mate_name #爱人姓名
      t.string :mate_status_code #配偶现状
      t.string :filial_phone #子女电话
      t.string :medical_code #特约医疗证号
      t.string :hospital_name #定点医院
      t.date :dead_date #去世时间
      t.text :resume #简历
      t.text :memo #备注
      t.string :ent_description
      t.date :start_date
      t.date :end_date

      t.timestamps
      t.tracer
    end
  end
end
