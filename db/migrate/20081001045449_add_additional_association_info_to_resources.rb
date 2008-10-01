class AddAdditionalAssociationInfoToResources < ActiveRecord::Migration
  def self.up
    remove_column :flickr_photos, :posted_before
  
    add_column :flickr_photos, :jam_id, :integer
    add_column :viddler_videos, :jam_id, :integer
  
    create_table "flickr_photos_users", :id => false do |t|
      t.column "flickr_photo_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
  
    create_table "users_viddler_videos", :id => false do |t|
      t.column "viddler_video_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
  
  end

  def self.down 
    remove_column :flickr_photos, :jam_id
    remove_column :viddler_videos, :jam_id
    drop_table :users_viddler_videos
    drop_table :flickr_photos_users
    remove_column :flickr_photos, :posted_before, :datetime
  end
end
