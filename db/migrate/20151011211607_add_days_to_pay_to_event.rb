class AddDaysToPayToEvent < ActiveRecord::Migration
  def change
    add_column :events, :days_to_pay, :integer
  end
end
