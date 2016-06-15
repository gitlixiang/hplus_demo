class CreateFdnLegendMenhus < ActiveRecord::Migration
  def change
    create_table :fdn_legend_menhus do |t|
      t.string :position
      t.integer :legend_category_id
      t.string :memo
      t.string :title

      t.timestamps null: false
    end
  end
end
