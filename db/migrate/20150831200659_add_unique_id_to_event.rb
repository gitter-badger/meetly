class AddUniqueIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :unique_id, :string
    add_index :events, :unique_id
  end
end
