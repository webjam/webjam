class RemoveOldUserRsvpPrefs < ActiveRecord::Migration
  def self.up
    remove_column :users, :show_upcoming_rsvps
    remove_column :users, :show_past_rsvps
  end

  def self.down
    add_column :users, :show_upcoming_rsvps, :boolean, :default => true
    add_column :users, :show_past_rsvps, :boolean, :default => true
  end
end
