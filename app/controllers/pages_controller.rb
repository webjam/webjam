class PagesController < ApplicationController
  def home
    if redirect_to_mobile?
      redirect_to formatted_home_path(:mobile)
      return
    end
    respond_to do |wants|
      wants.html do
        @upcoming_events = Event.published.upcoming.all
        @past_events = Event.published.past.all
      end
      wants.mobile do
        @upcoming_events = Event.published.upcoming.all
        @last_event = Event.published.past.first(:order => "published_at DESC")
        @last_post = Post.published.first(:order => "published_at DESC", :include => :comments)
      end
    end
  end
  def contact
  end
  def openid
  end
  def contributors
  end
  def about
    respond_to do |wants|
      wants.html { redirect_to home_path, :status => 301 }
      wants.mobile do
        @upcoming_events = Event.published.upcoming.all
        @past_events = Event.published.past.all
      end
    end
  end
  
  protected
    def redirect_to_mobile?
      mobile_request? && request.format != "mobile" && params["redirect-to-mobile"] != "no"
    end
end
