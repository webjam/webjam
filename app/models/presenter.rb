class Presenter < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :unless => :user
  attr_accessible :name, :url
  
  def name
    user ? user.full_name : super
  end
end
