class AddStatusToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :status, :integer, deafult: :created
  end
end
