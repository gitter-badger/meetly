class RemoveArchivedAndArrivedFromParticipants < ActiveRecord::Migration
  def change
  	remove_column :participants, :archived, :boolean
  	remove_column :participants, :arrived, :boolean
  end
end
