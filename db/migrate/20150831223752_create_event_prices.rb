class CreateEventPrices < ActiveRecord::Migration
  def change
    create_table :event_prices do |t|
      t.decimal :price
      t.belongs_to :pricing_period, index:true
      t.belongs_to :event, index:true
      t.belongs_to :role, index:true
      t.timestamps
    end
  end
end
