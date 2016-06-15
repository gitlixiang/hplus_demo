class CreateClHeaders < ActiveRecord::Migration
  def change
    create_table :cl_headers do |t|
      t.string :name
      t.string :resource_type
      t.string :code
      t.integer :order
      t.text :data
      t.text :merges
      t.text :aligns
      t.text :comments

      t.timestamps null: false
    end
  end
end
