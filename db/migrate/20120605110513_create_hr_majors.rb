class CreateHrMajors < ActiveRecord::Migration
  def change
    create_table :hr_majors do |t|
      t.string :sort        #分类
      t.string :major_code  #代码
      t.string :category    #类别
      t.string :name        #名称
      t.string :parent_id   #父ID

      t.timestamps
    end
  end

end