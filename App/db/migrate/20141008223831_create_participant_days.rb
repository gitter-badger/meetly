class CreateParticipantDays < ActiveRecord::Migration
  def change
    create_table :participant_days do |t|
    	t.belongs_to :participant, index: true
    	t.belongs_to :day, index: true

    	t.timestamps
    end
  end
end
