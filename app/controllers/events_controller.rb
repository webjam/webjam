class EventsController < ApplicationController
  def show
    @event = Event.find_by_tag(params[:id])
    raise NotFound unless @event
  end
end
