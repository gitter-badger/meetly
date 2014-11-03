class CreateParticipantNights < ActiveRecord::Migration
  def change
    create_table :participant_nights do |t|
      t.belongs_to :participant, index: true
      t.belongs_to :night, index: true

      t.timestamps
    end
  end
end
