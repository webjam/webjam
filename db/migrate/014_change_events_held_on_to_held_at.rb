class ChangeEventsHeldOnToHeldAt < ActiveRecord::Migration
  def self.up
    rename_column :events, :held_on, :held_at
    change_column :events, :held_at, :timestamp
  end

  def self.down
    change_column :events, :held_at, :date
    rename_column :events, :held_at, :held_on
  end
end
