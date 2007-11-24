class RenameUsersNicknameToNickName < ActiveRecord::Migration
  def self.up
    rename_column :users, :nickname, :nick_name
  end

  def self.down
    rename_column :users, :nick_name, :nickname
  end
end
