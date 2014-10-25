class CreatePriceTables < ActiveRecord::Migration
  def change
    create_table :price_tables do |t|
      t.string :name
      t.integer :days
      t.integer :day1
      t.integer :day2
      t.integer :day3
      t.integer :night
      t.integer :dinner
    end
  end
end
