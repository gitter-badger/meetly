class AddGenderToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :gender, :bool
  end
end
