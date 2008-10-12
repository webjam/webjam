class Jam < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users
  belongs_to :presentation_proposal
  belongs_to :proposing_user, :class_name => "User"
  has_many :viddler_videos
  has_many :flickr_photos
  
  validates_presence_of :title, :description, :number
  
  attr_accessor :proposing_user_id
  
  def setup_from_proposal(proposal)
    self.presentation_proposal = proposal
    self.title                 = proposal.title
    self.description           = proposal.description
    self.proposing_user        = proposal.user
    self.users << self.proposing_user
  end
  
  # if there has been a manual amount sent return it, otherwise it's the number of users.
  def number_of_presenters
    read_attribute(:number_of_presenters) ? read_attribute(:number_of_presenters) : users.count
  end

  def to_param
    self.number
  end
end
