class CreatePmNodes < ActiveRecord::Migration
  def change
    create_table :pm_nodes do |t|
      t.integer :percent
      t.text :content
      t.string :name
      t.integer :plan_id
      t.integer :sort_seq
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
