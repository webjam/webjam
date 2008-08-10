class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :title, :body, :permalink, :published_at
  
  named_scope :published, :conditions => 'published_at IS NOT NULL'

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
    posts = all(:order => "published_at DESC", :include => :comments, :limit => limit)
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
  
  def before_save
    self.year = published_at.year
  end
end
