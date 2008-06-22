class RsvpsController < ApplicationController
  before_filter :login_required

  def create
    @event = Event.find_by_tag(params[:event])
    raise NotFound unless @event
    if @event.full?
      redirect_to event_path(:id => @event, :event_full => true)
    end
    if current_user.rsvps.create(:event => @event)
      redirect_to event_path(@event)
    else
      redirect_to event_path(:id => @event, :already_rsvpd => true)
    end
  end
end
