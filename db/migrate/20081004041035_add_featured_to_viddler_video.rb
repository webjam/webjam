class AddFeaturedToViddlerVideo < ActiveRecord::Migration
  def self.up
    add_column :viddler_videos, :featured, :boolean
  end

  def self.down
    remove_column :viddler_videos, :featured
  end
end
