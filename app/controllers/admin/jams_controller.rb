class Admin::JamsController < Admin::BaseController
  before_filter :load_event
  
  def index
    @jams = @event.jams.find(:all, :order => 'created_at DESC')
  end
  
  def show
    @jam = @event.jams.find(params[:id])
    raise NotFound unless @jam
  end
  
  def new
    @proposal = @event.presentation_proposals.find(params[:proposal_id])
    raise NotFound unless @proposal
    @jam = @event.jams.build
    
    # I want to do this explicitly here (rather than via callback) so that it won't normally be used
    @jam.setup_from_proposal(@proposal)
  end
  
  def edit
    @jam = @event.jams.find(params[:id])
  end
  
  def create
    @jam = @event.jams.build(params[:jam])
    @jam.save!
    redirect_to [:admin,@event,@jam]
  end
  
  def update
    @jam = @event.jams.find(params[:id])
    raise NotFound unless @jam
    
    @jam.attributes = params[:jam]
    @jam.save!
    
    redirect_to [:admin, @event, @jam]
  end
  
  def destroy
    @event.jams.find(params[:id]).destroy
    redirect_to admin_event_jams_path(@event)
  end

  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
  end
end
