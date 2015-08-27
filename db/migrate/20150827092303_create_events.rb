class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :price
      t.integer :owner_id
      t.integer :location_id

      t.timestamps
    end

    add_index :events, :owner_id
    add_index :events, :location_id
  end
end
