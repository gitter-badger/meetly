class RemoveEncryptedPasswordAndSaltFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :salt, :string
    remove_column :users, :encrypted_password, :string
  end
end
