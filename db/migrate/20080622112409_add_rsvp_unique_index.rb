class AddRsvpUniqueIndex < ActiveRecord::Migration
  def self.up
    add_index :rsvps, [:event_id, :user_id], :unique => true
  end

  def self.down
    remove_index :rsvps, :column => [:event_id, :user_id]
  end
end
