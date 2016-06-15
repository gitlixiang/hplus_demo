class CreatePmTasks < ActiveRecord::Migration
  def change
    create_table :pm_tasks do |t|
      t.string :name
      t.string :content
      t.integer :org_id
      t.references :resource, polymorphic: true #, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
