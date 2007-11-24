class RemoveOldPasswordishColumnsFromUsersTable < ActiveRecord::Migration
  def self.up
    remove_column :users, :crypted_password
    remove_column :users, :salt
  end

  def self.down
  end
end
