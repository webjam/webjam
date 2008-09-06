class SetBlogPostsYearIfNil < ActiveRecord::Migration
  class Post < ActiveRecord::Base
  end
  
  def self.up
    Post.find(:all, :conditions => {:year => nil}).each do |post|
      post.update_attribute(:year, post.published_at.year)
    end
  end

  def self.down
  end
end
