class DropDinners < ActiveRecord::Migration
  def change
  	drop_table :dinners
  end
end
