class Jam < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users
  belongs_to :presentation_proposal
  
  validates_presence_of :title, :description
  
  def setup_from_proposal(proposal)
    self.presentation_proposal = proposal
    self.title                 = proposal.title
    self.description           = proposal.description
    self.users                 << proposal.user

  end
  
  # if there has been a manual amount sent return it, otherwise it's the number of users.
  def number_of_presenters
    read_attribute(:number_of_presenters) ? read_attribute(:number_of_presenters) : users.count
  end
  
end
