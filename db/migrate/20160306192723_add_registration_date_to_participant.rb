class AddRegistrationDateToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :registration_date, :datetime
  end
end
