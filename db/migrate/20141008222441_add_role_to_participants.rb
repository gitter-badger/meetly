class AddRoleToParticipants < ActiveRecord::Migration
  def change
    add_reference :participants, :role, index: true
  end
end
