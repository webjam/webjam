class Admin::RsvpsController < Admin::BaseController
  before_filter :load_event
  def index
    @rsvps = @event.rsvps.find(:all, :order => 'created_at DESC')
  end
  def destroy
    Rsvp.find(params[:id]).destroy
    redirect_to admin_event_rsvps_path(@event)
  end
  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
  end
end
