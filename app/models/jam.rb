class Jam < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :presentation_proposal
  
  validates_presence_of :title, :description
end
