class CreatePricingPeriods < ActiveRecord::Migration
  def change
    create_table :pricing_periods do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :event, index:true
    end
  end
end
