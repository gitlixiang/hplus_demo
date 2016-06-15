class CreateAaeFinancialStatements < ActiveRecord::Migration
  def change
    create_table :aae_financial_statements do |t|
      t.integer :ent_id
      t.integer :year
      t.integer :month

      t.timestamps null: false
    end
  end
end
