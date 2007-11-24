class RemotePublishedAtFromJams < ActiveRecord::Migration
  def self.up
#    remove_column :jams, :published_at
  end

  def self.down
#    add_column :jams, :published_at, :datetime
  end
end
