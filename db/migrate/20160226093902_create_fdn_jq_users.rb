class CreateFdnJqUsers < ActiveRecord::Migration
  def change
    create_table :fdn_jq_users do |t|
      t.string :user_name
      t.string :resource_type
      t.integer :resource_id
      t.string :memo
      t.string :status
      t.timestamps null: false
    end
  end
end
