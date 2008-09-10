class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :comments, :as => :commentable

  validates_presence_of :title, :body, :permalink
  
  named_scope :published, :conditions => ["published_at < ?", Time.now.utc]

  before_save :set_year

  def self.find_all_for_archive
    find(:all,
      :select => %(
        posts.*,
        (SELECT COUNT(*)
          FROM comments
          WHERE comments.commentable_id = posts.id AND
                comments.commentable_type = 'Post') as comments_count
        ),
      :order => "posts.published_at")
  end
  
  def self.find_all_for_archive_by_year(year)
    find(:all,
      :conditions => {:year => year},
      :select => %(
        posts.*,
        (SELECT COUNT(*)
          FROM comments
          WHERE comments.commentable_id = posts.id AND
                comments.commentable_type = 'Post') as comments_count
        ),
      :order => "posts.published_at")
  end
 
  def self.latest(limit = 1)
    posts = all(:order => "published_at DESC", :conditions => ["published_at < ?", Time.now.utc], :include => :comments, :limit => limit)
    limit == 1 ? posts.first : posts
  end 

  def self.find_legacy(permalink)
    find_by_permalink(permalink) || raise(ActiveRecord::RecordNotFound, "No legacy post with permalink #{permalink} found")
  end
  
  def to_s
    title
  end

  def published?
    published_at
  end
  
  def <=>(other)
    self.published_at <=> other.published_at
  end
  
  def set_year
    self.year = published_at.year if published_at
  end
end