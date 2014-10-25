class AddPriceTableToRoles < ActiveRecord::Migration
  def change
    add_reference :roles, :price_table, index: true
  end
end
