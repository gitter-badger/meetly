class DropNights < ActiveRecord::Migration
  def change
  	drop_table :nights
  end
end
