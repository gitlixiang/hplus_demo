class CreateFdnLegendCategories < ActiveRecord::Migration
  def change
    create_table :fdn_legend_categories do |t|
      t.string :name                       #信息分类
      t.string :code                       #编码
      t.integer :parent_id                 #上级分类
      #t.integer :seq                       #排序
      t.string  :status  , default: 'Y'    #状态

      t.integer :children_count            #子菜单的数量
      t.integer :position                  #排序
      t.integer :depth                     #深度

      t.timestamps null: false
      t.tracer
    end
  end
end
