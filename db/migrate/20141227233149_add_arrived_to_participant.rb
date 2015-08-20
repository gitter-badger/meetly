class AddArrivedToParticipant < ActiveRecord::Migration
  def change
  	add_column :participants, :arrived, :boolean, :default => false
  end
end
