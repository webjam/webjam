class AddExtendedFlickrPhotoInfo < ActiveRecord::Migration
  def self.up
    add_column :flickr_photos, :username, :string
    add_column :flickr_photos, :posted_at, :datetime
    add_column :flickr_photos, :taken_at, :datetime
    add_column :flickr_photos, :url, :string
    add_column :flickr_photos, :license_identifier, :integer
    add_column :flickr_photos, :license_text, :string
  end

  def self.down
    remove_column :flickr_photos, :username
    remove_column :flickr_photos, :posted_at
    remove_column :flickr_photos, :taken_at
    remove_column :flickr_photos, :url
    remove_column :flickr_photos, :license_identifier
    remove_column :flickr_photos, :license_text
  end
end
