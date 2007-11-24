class AddConfirmedAtToJams < ActiveRecord::Migration
  def self.up
    add_column :jams, :confirmd_at, :timestamp
  end

  def self.down
    remove_column :jams, :confirmd_at
  end
end
