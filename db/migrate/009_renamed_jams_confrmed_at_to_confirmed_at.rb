class RenamedJamsConfrmedAtToConfirmedAt < ActiveRecord::Migration
  def self.up
    rename_column :jams, :confirmd_at, :confirmed_at
  end

  def self.down
    rename_column :jams, :confirmed_at, :confirmd_at
  end
end
