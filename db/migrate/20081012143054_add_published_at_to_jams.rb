class AddPublishedAtToJams < ActiveRecord::Migration
  def self.up
    add_column :jams, :published_at, :datetime
  end

  def self.down
    remove_column :jams, :published_at
  end
end
