class CreateHrJobs < ActiveRecord::Migration
  def change
    create_table :hr_jobs do |t|
      t.string :name #名称
      t.string :code #代码
      t.string :type_code #类型代码
      t.string :status

      t.timestamps
    end
  end
end
