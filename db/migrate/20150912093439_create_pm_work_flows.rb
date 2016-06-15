class CreatePmWorkFlows < ActiveRecord::Migration
  def change
    create_table :pm_work_flows do |t|
      t.string :name
      t.string :state
      t.references :wfable, polymorphic: true

      t.timestamps null: false
      t.tracer
    end
  end
end
