class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable
  has_permalink :title

  validates_presence_of :title, :body

  def self.find_published(*options)
    with_scope(:find => {:conditions => 'published_at IS NOT NULL'}) { find(*options) }
  end
  def self.recently_published
    find_published(:all, :limit => 5, :order => 'published_at DESC')
  end
  def to_param
    "#{id}-#{permalink}"
  end
  def to_s
    title
  end
  def published?
    published_at
  end
  # def published_at
  #   
  # end
  # def published_at=(published_at)
  #   
  # end
end
