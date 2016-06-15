class CreateHrEntManagers < ActiveRecord::Migration
  def change
    create_table :hr_ent_managers do |t|
      t.integer :ent_id
      t.string :name
      t.integer :job_id

      t.timestamps null: false
    end
  end
end
