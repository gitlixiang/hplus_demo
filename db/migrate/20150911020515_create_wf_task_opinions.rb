class CreateWfTaskOpinions < ActiveRecord::Migration
  def change
    create_table :wf_task_opinions do |t|
      t.integer :task_id
      t.string :opinion
      t.string :name

      t.timestamps null: false
    end
  end
end
