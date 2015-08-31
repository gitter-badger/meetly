class CreateServiceGroups < ActiveRecord::Migration
  def change
    create_table :service_groups do |t|
      t.string :name
    end
  end
end
