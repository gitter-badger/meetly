class AddOtherInfoToParticipant < ActiveRecord::Migration
  def change
  	add_column :participants, :other_info, :string
  end
end
