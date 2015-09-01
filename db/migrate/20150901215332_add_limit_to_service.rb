class AddLimitToService < ActiveRecord::Migration
  def change
    add_column :services, :limit, :integer
  end
end
