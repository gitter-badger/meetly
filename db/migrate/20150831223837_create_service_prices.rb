class CreateServicePrices < ActiveRecord::Migration
  def change
    create_table :service_prices do |t|
      t.decimal :price
      t.belongs_to :pricing_period, index:true
      t.belongs_to :service, index:true
      t.belongs_to :role, index:true
      t.timestamps
    end
  end
end
