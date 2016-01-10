class AddChurchAndDutyToParticipant < ActiveRecord::Migration
  def change
  	add_column :participants, :community, :string
  	add_column :participants, :duty, :string
  end
end
