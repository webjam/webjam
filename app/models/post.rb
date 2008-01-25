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
  def self.find_legacy(permalink)
    find_by_permalink(permalink) || raise(ActiveRecord::RecordNotFound, "No legacy post with permalink #{permalink} found")
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
end
