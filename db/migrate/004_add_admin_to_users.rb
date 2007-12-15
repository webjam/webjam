class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false, :null => false
    execute "UPDATE users SET admin = 1"
  end

  def self.down
    remove_column :users, :admin
  end
end
