class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable

  validates_presence_of :title, :body
  
  named_scope :published, :conditions => 'published_at IS NOT NULL'
  named_scope :recently_published, 
              :conditions => 'published_at IS NOT NULL',
              :limit => 5,
              :order => 'published_at DESC'

  def self.find_all_for_archive
    find_by_sql %(
      SELECT posts.*,
             (SELECT COUNT(*)
              FROM comments
              WHERE comments.commentable_id = posts.id AND
                    comments.commentable_type = 'Post') as comments_count
      FROM   posts
      WHERE  posts.published_at IS NOT NULL
      ORDER BY posts.published_at
    )
  end
  
  def self.find_for_year(year)
    start_year = Time.utc(year)
    published.all :conditions => {:published_at => (start_year..(start_year + 1.year))}
  end
  
  def self.find_legacy(permalink)
    find_by_permalink(permalink) || raise(ActiveRecord::RecordNotFound, "No legacy post with permalink #{permalink} found")
  end
  def to_param
    permalink
  end
  
  def to_s
    title
  end
  def published?
    published_at
  end
end
