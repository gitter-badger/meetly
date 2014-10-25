class AddNightsAndDinnersToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :nights, :integer
    add_column :participants, :dinners, :integer
  end
end
