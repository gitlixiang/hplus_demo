class CreateRadJwOpinions < ActiveRecord::Migration
  def change
    create_table :rad_jw_opinions do |t|
      t.date :opinion_date
      t.string :resource_type
      t.integer :resource_id
      t.string :opinion
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
