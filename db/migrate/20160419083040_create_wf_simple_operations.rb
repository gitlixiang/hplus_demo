class CreateWfSimpleOperations < ActiveRecord::Migration
  def change
    create_table :wf_simple_operations do |t|
      t.integer :workflow_id
      t.integer :org_id
      t.integer :parent_id
      t.integer :user_id
      t.string :message
      t.string :operate

      t.timestamps null: false
    end
  end
end
