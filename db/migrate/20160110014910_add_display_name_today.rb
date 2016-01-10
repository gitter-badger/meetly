class AddDisplayNameToday < ActiveRecord::Migration
  def change
  	add_column :days, :display_name, :string
  end
end
