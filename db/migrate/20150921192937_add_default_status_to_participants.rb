class AddDefaultStatusToParticipants < ActiveRecord::Migration
  def change
    change_column :participants, :status, :integer, default: 0
  end
end
