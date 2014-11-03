class CreateDinners < ActiveRecord::Migration
  def change
    create_table :dinners do |t|
      t.integer :number

      t.timestamps
    end
  end
end
