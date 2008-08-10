class CreateFlickrPhotos < ActiveRecord::Migration
  def self.up
    create_table :flickr_photos do |t|
      # these are all strings in case flickr changes
      # their mind, and because it doesnt really 
      # matter here.
      t.string "flickrid"
      t.string "server"
      t.string "farm"
      t.string "secret"
      t.string "title"
      t.string "owner"
      t.timestamps
    end
  end

  def self.down
    drop_table :flickr_photos
  end
end
