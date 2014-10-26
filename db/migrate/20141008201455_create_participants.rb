class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :city
      t.string :community
      t.string :email
      t.string :phone
      t.integer :cost
      t.float :paid

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end

end
