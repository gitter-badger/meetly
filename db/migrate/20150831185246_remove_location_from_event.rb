class RemoveLocationFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :location_id, :integer
  end
end
