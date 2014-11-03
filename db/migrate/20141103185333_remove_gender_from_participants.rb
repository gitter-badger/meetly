class RemoveGenderFromParticipants < ActiveRecord::Migration
  def up
    remove_column :participants, :gender
  end

  def down
    add_column :participants, :gender, :bool
  end
end
