class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable
  has_permalink :title
  def self.find_published(*options)
    with_scope(:find => {:conditions => 'published_at IS NOT NULL'}) { find(*options) }
  end
  def self.recently_published
    find_published(:all, :limit => 5, :order => 'published_at DESC')
  end
  def to_param
    "#{id}-#{permalink}"
  end
end
