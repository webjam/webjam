class AddEventIdAndPostedBeforeToFlickrPhoto < ActiveRecord::Migration
  def self.up
    add_column :flickr_photos, :event_id, :integer
    add_column :flickr_photos, :posted_before, :datetime
  end

  def self.down
    remove_column :flickr_photos, :event_id
    remove_column :flickr_photos, :posted_before
  end
end
