class CreateClContents < ActiveRecord::Migration
  def change
    create_table :cl_contents do |t|
      t.string :name
      t.integer :row
      t.integer :col
      t.integer :rows
      t.integer :cols
      t.string :code
      t.integer :header_id

      t.timestamps null: false
    end
  end
end
