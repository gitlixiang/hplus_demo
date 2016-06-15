class CreateHrEntCars < ActiveRecord::Migration
  def change
    create_table :hr_ent_cars do |t|
      t.integer :ent_id
      t.string :id_code #车牌号
      t.string :car_status #状态
      t.integer :is_rent #购买/租用
      t.string :rent_price, :precision => 20, :scale => 2 #租用价
      t.string :total_price, :precision => 20, :scale => 2 #总价
      t.date :buy_date #购买日期
      t.decimal :displacement, :precision => 20, :scale => 2 #排量
      t.text :memo #备注

      t.timestamps null: false
    end
  end
end
