class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.decimal :price
      t.belongs_to :service_group, index:true
      t.belongs_to :event, index:true
    end
  end
end
