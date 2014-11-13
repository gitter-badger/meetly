class AddArchivedToParticipants < ActiveRecord::Migration
  def change
  	add_column :participants, :archived, :boolean, :default => false
  end
end
