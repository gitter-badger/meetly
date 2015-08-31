class CreateDayPrices < ActiveRecord::Migration
  def change
    create_table :day_prices do |t|
      t.decimal :price
      t.belongs_to :day, index:true
      t.belongs_to :role, index:true
      t.belongs_to :pricing_period, index:true
      t.timestamps
    end
  end
end
