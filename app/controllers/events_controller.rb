class EventsController < ApplicationController
  def show
    @event = Event.find_by_tag(params[:id])
    raise NotFoundError unless @event
    render :action => (@event.upcoming? ? "show_upcoming" : "show")
  end
end
