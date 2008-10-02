class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.find(:all, :order => 'held_at DESC')
  end
  def new
    @event = Event.new
    @event.tag ||= 'webjam'
  end
  def create
    @event = Event.new(params[:event])
    @event.save!
    redirect_to [:admin, @event]
  end
  def edit
    @event = Event.find_by_tag(params[:id])
  end
  def update
    @event = Event.find_by_tag(params[:id])
    @event.attributes = params[:event]
    @event.save!
    redirect_to [:admin, @event]
  end
  def destroy
    Event.find_by_tag(params[:id]).destroy
    redirect_to admin_events_path
  end
  def show
    @event = Event.find_by_tag(params[:id])
    raise NotFound unless @event
  end
end
