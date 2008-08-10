class PagesController < ApplicationController
  def home
    @upcoming_events = Event.published.upcoming(:order => "held_at DESC")
    @past_events = Event.published.past(:order => "held_at DESC")
    @latest_post = Post.published.first(:order => "published_at DESC", :include => :comments) 
    if iphone_request?
      render :action => "home_iphone", :layout => "iphone"
    end
  end
  def statichome
  end
  def contact
  end
  def openid
  end
end
