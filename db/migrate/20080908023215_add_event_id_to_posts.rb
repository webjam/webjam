class AddEventIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :event_id, :integer
  end

  def self.down
    remove_column :posts, :event_id
  end
end
