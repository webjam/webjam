class PagesController < ApplicationController
  def home
    if iphone_request?
      render :action => "home_iphone", :layout => "iphone"
    else
      @past_events = Event.find_past(:all, :order => 'held_at ASC', :limit => 5)
      @posts = Post.find_published(:all, :order => 'published_at DESC', :limit => 1)
    end
  end
  def statichome
  end
  def contact
  end
  def openid
  end
end
