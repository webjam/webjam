class RenameUserFieldsToMatchOpenidSregFields < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :full_name
    rename_column :users, :login, :nickname
  end

  def self.down
    rename_column :users, :full_name, :name
    rename_column :users, :nickname, :login
  end
end
