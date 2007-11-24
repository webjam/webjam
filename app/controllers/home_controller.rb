class HomeController < ApplicationController
  def index
    @past_events = Event.find_past(:all, :order => 'held_at ASC', :limit => 5)
    @posts = Post.find_published(:all, :order => 'published_at DESC')
  end
  def about
    
  end
  def contact
    
  end
end
