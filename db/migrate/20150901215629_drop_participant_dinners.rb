class DropParticipantDinners < ActiveRecord::Migration
  def change
  	drop_table :participant_dinners 
  end
end
