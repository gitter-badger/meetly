class AddPaymentDeadLineToParticipants < ActiveRecord::Migration
  def change
  	add_column :participants, :payment_deadline, :datetime
  end
end
