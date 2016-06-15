class CreateHrTitleSays < ActiveRecord::Migration
  def change
    create_table :hr_title_says do |t|
      t.string :major_class #大类
      t.string :title_code #代码
      t.string :minor_class #小类
      t.string :name #名称
      t.string :parent_id #父ID

      t.timestamps
    end
  end

end