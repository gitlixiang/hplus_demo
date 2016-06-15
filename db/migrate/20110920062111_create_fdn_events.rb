class CreateFdnEvents < ActiveRecord::Migration
  def change
    create_table :fdn_events do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.string :resource_type
      t.integer :resource_id
      t.integer :template_id
      t.string :person_in_charge
      t.string :contact
      t.string :abstract
      t.date :event_date

      t.timestamps
      t.tracer
    end

    add_index :fdn_events, [:created_by, :start_at, :end_at], :name => 'fdn_events_ind1'
    add_index :fdn_events, [:resource_type, :resource_id], :name => 'fdn_events_ind2'
  end
end
