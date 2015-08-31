class AddServicesToParticipants < ActiveRecord::Migration
  def change
  	create_table :participant_services do |t|
  		t.belongs_to :participant, index: true
  		t.belongs_to :service, index: true
  	end
  end
end
