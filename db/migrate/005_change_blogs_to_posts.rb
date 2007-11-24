class ChangeBlogsToPosts < ActiveRecord::Migration
  def self.up
    rename_table :blogs, :posts
  end

  def self.down
    rename_table :posts, :blogs
  end
end
