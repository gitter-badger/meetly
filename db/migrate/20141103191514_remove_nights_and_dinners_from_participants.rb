class RemoveNightsAndDinnersFromParticipants < ActiveRecord::Migration
  def up
    remove_column :participants, :dinners
    remove_column :participants, :nights
  end

  def down
    add_column :participants, :dinners, :integer
    add_column :participants, :nights, :integer
  end
end
