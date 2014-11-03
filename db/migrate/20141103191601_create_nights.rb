class CreateNights < ActiveRecord::Migration
  def change
    create_table :nights do |t|
      t.integer :number

      t.timestamps
    end
  end
end
