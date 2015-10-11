class RemovePriceFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :price, :decimal
  end
end
