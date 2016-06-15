class CreateFdnLegends < ActiveRecord::Migration
  def change
    create_table :fdn_legends do |t|
      t.integer :org_id
      t.string :type_code
      t.string :title
      t.text :content

      t.timestamps
      t.tracer
    end
  end
end
