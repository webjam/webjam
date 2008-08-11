class Jam < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :presentation_proposal
  
  validates_presence_of :title, :description
  
  def setup_from_proposal(proposal)
    self.presentation_proposal = proposal
    self.title                 = proposal.title
    self.description           = proposal.description
    self.user                  = proposal.user

  end
end
