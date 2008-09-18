class FlickrPhotosController < ApplicationController
  before_filter :find_event
  
  def index
    @photos = @event.flickr_photos.paginate :order => "created_at DESC", :page => params[:page], :per_page => 15
  end
  
  private
    def find_event
      @event = Event.find_by_tag(params[:event_id])
      raise NotFound unless @event
    end
end
