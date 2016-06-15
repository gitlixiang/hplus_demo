class CreatePmPlans < ActiveRecord::Migration
  def change
    create_table :pm_plans do |t|
      t.string :name
      t.string :contact
      t.string :phone
      t.text :content
      t.integer :org_id
      t.integer :stage
      t.string :state
      t.references :resource, polymorphic: true

      t.timestamps null: false
    end
  end
end
