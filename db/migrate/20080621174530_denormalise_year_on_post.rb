class DenormaliseYearOnPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :year, :integer
    
    Post.all.each do |post|
      post.update_attribute(:year, post.published_at.year)
    end
  end

  def self.down
    remove_column :posts, :year
  end
end
