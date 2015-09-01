class AddEventToRole < ActiveRecord::Migration
  def change
  	add_reference :roles, :event, index: true
  end
end
