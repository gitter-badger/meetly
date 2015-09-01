class DropParticipantNights < ActiveRecord::Migration
  def change
  	drop_table :participant_nights 
  end
end
