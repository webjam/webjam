class PresentationsController < ApplicationController
  def index
    event = Event.find_by_tag(params[:event_id])
    raise NotFound unless event
    redirect_to event_path(event)
  end
  def show
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @jam = @event.jams.find_by_number(params[:id])
    raise NotFound unless @jam
  end
end
