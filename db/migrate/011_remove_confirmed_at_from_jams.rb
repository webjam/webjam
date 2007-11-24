class RemoveConfirmedAtFromJams < ActiveRecord::Migration
  def self.up
    remove_column :jams, :confirmed_at
  end

  def self.down
    add_column :jams, :confirmed_at, :datetime
  end
end
