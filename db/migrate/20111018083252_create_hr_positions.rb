class CreateHrPositions < ActiveRecord::Migration
  def change
    create_table :hr_positions do |t|
      t.string :name  #名称
      t.string :code  #编码
      t.string :status   #状态
      t.date :start_date #开始日期
      t.date :end_date   #结束日期
      t.integer :parent_id

      t.timestamps
      t.tracer
    end
  end
end
