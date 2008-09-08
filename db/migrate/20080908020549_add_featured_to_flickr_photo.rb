class AddFeaturedToFlickrPhoto < ActiveRecord::Migration
  def self.up
    add_column :flickr_photos, :featured, :boolean, :default => false
  end

  def self.down
    remove_column :flickr_photos, :featured
  end
end
