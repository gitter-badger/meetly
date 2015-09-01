class ChangeGenderInParticipants < ActiveRecord::Migration
  def change
  	remove_column :participants, :gender, :string
  	add_column :participants, :gender, :integer
  end
end
