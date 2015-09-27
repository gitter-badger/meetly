class AddDefaultPaidValueToParticipants < ActiveRecord::Migration
  def change
    change_column :participants, :paid, :float, default: 0.0
  end
end
