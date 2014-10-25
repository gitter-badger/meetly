class RemoveCommunityFromParticipants < ActiveRecord::Migration
  def up
    remove_column :participants, :community
  end

  def down
    add_column :participants, :community, :string
  end
end
