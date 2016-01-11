class ChangeOtherInfoInParticipant < ActiveRecord::Migration
  def change
  	remove_column :participants, :other_info, :string
  	add_column :participants, :other_info, :text
  end
end
