class EventsController < ApplicationController
  def show
    @event = Event.published.find_by_tag(params[:id])
    raise NotFound unless @event
    @total_tweets = @event.tweets.count
    @latest_tweets = @event.tweets.latest(5).all
    @more_tweets = @event.tweets.count > @latest_tweets.length
    respond_to do |wants|
      wants.html do
        render :action => (@event.upcoming? ? "show_upcoming" : "show")
      end
      wants.mobile do
        if @event.upcoming?
          @previous_event = @event.previous
          @photos = @event.flickr_photos.latest.all :order => "created_at DESC", :limit => 10
          @latest_photo = @photos.first
          if @photos.empty? && @previous_event
            @photos_from_previous_event = true
            @photos = @previous_event.flickr_photos.featured.paginate :page => 1, :order => "created_at DESC"
            @latest_photo = @photos.first
          end
          render :action => "show_upcoming"
        else
          @photos = @event.flickr_photos.latest.all :order => "created_at DESC", :limit => 10
          @latest_photo = @photos.first
          render :action => "show"
        end
      end
    end
  end
  def past
    @past_events = Event.published.past
    @upcoming_events = Event.published.upcoming
  end
end