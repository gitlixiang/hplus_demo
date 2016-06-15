class CreateFdnAnnouncements < ActiveRecord::Migration
  def change
    create_table :fdn_announcements do |t|
      t.string :title
      t.text :content
      t.integer :seq
      t.boolean :useful

      t.timestamps
      t.tracer
    end
  end
end
