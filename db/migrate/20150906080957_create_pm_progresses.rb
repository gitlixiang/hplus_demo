class CreatePmProgresses < ActiveRecord::Migration
  def change
    create_table :pm_progresses do |t|
      t.integer :sort_seq
      t.integer :status
      t.integer :percent
      t.string :content
      t.string :node
      t.integer :node_id
      t.integer :plan_id
      t.string :state
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
