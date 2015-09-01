class RemovePriceTablesFromRoles < ActiveRecord::Migration
  def change
  	remove_column :roles, :price_table_id, :integer
  end
end
