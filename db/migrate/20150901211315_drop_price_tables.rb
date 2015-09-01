class DropPriceTables < ActiveRecord::Migration
  def change
  	drop_table :price_tables
  end
end
