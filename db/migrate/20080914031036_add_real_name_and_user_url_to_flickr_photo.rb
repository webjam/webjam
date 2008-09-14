class AddRealNameAndUserUrlToFlickrPhoto < ActiveRecord::Migration
  def self.up
    add_column :flickr_photos, :realname, :string
    add_column :flickr_photos, :profile_url, :string
  end

  def self.down
    remove_column :flickr_photos, :realname
    remove_column :flickr_photos, :profile_url
  end
end
