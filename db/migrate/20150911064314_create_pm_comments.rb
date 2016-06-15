class CreatePmComments < ActiveRecord::Migration
  def change
    create_table :pm_comments do |t|
      t.text :content
      t.datetime :comment_time
      t.integer :user_id
      t.references :resource, polymorphic: true #, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
