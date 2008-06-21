class EventRsvpTracking < ActiveRecord::Migration
  def self.up
    add_column :events, :rsvp_limit, :integer
  end

  def self.down
    drop_column :events, :rsvp_limit
  end
end
