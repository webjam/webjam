class Presenter < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :unless => :user
end
