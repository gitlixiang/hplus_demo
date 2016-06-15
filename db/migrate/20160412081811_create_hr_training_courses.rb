class CreateHrTrainingCourses < ActiveRecord::Migration
  def change
    create_table :hr_training_courses do |t|
      t.integer :org_id
      t.string :name
      t.string :content
      t.date :set_date
      t.string :memo

      t.timestamps null: false
    end
  end
end
