class CreateWfSimpleWorkflows < ActiveRecord::Migration
  def change
    create_table :wf_simple_workflows do |t|
      t.string :resource_type
      t.integer :resource_id
      t.integer :start_org_id
      t.integer :current_org_id
      t.string :status

      t.timestamps null: false
    end
  end
end
