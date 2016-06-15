class CreateRadInvestments < ActiveRecord::Migration
  def change
    create_table :rad_investments do |t|
      t.integer :year #计划年份
      t.integer :ent_id #企业名称
      t.integer :project_type #项目类型(新建、续建)
      t.integer :start_year #项目起始年份
      t.integer :end_year #项目截止年份
      t.string :project_name #项目名称

      #acts_as_ordered_tree
      t.integer :parent_id #续建项目的上级
      t.integer :position #排序
      t.integer :depth #深度

      t.decimal :accounting, :precision => 20, :scale => 6 #总投资
      t.decimal :year_accounting, :precision => 20, :scale => 6 #本年计划投资数
      t.decimal :last_year_accounting, :precision => 20, :scale => 6 #上年投资数
      t.decimal :end_last_year_accounting, :precision => 20, :scale => 6 #截止上年总投资数
      t.text :reason #主要建设内容及规模
      t.date :before_date #决策前
      t.date :middle_date #决策中
      t.date :after_date #决策后
      t.text :memo #备注
      t.string :status #状态
      t.integer :person_begin_code #决策发起人
      t.integer :show_type_code #听取意见方式

      t.timestamps null: false
    end
  end
end
