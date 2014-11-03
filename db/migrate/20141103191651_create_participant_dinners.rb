class CreateParticipantDinners < ActiveRecord::Migration
  def change
    create_table :participant_dinners do |t|
      t.belongs_to :participant, index: true
      t.belongs_to :dinner, index: true

      t.timestamps
    end
  end
end
