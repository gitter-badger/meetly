class RenameNameAndSurnameColumns < ActiveRecord::Migration
  def change
    rename_column :participants, :name, :first_name
    rename_column :participants, :surname, :last_name
  end
end
