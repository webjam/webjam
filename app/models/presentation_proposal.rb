class PresentationProposal < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  validates_presence_of :title, :description
end
