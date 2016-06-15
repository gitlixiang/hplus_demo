class CreateHrHospitals < ActiveRecord::Migration
  def change
    create_table :hr_hospitals, :id => false do |t|
      t.column :hr_retirement_id, :integer
      t.column :hospital_id, :integer
    end

    add_index :hr_hospitals, [:hr_retirement_id, :hospital_id], :unique => true, :name => 'hr_hospitals_ind1'
  end
end
