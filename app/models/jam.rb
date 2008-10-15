class Jam < ActiveRecord::Base
  belongs_to :event
  belongs_to :presentation_proposal
  belongs_to :proposing_user, :class_name => "User"
  has_many :viddler_videos
  has_many :flickr_photos
  has_many :presenters
  
  named_scope :published, :conditions => "published_at IS NOT NULL"
  
  validates_presence_of :title, :description, :number
  
  attr_accessor :proposing_user_id
  
  def setup_from_proposal(proposal)
    self.presentation_proposal = proposal
    self.title                 = proposal.title
    self.description           = proposal.description
    self.proposing_user        = proposal.user
    self.users << self.proposing_user
  end
  
  def number_of_presenters
    presenters.length
  end

  def to_param
    self.number
  end
end
