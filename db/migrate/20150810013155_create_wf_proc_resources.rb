class CreateWfProcResources < ActiveRecord::Migration
  def change
    create_table :wf_proc_resources do |t|
      t.integer :inst_id
      t.string :deployment_name
      t.text :variables
      t.references :resource, polymorphic: true

      t.timestamps null: false
    end
  end
end
