class Admin::JamsController < Admin::BaseController
  before_filter :load_event
  
  def index
    @jams = @event.jams.find(:all, :order => 'created_at DESC')
  end
  
  def new
    @proposal = @event.presentation_proposals.find(params[:proposal_id])
    raise NotFound unless @proposal
    @jam = @event.jams.build
    
    # I want to do this explicitly here so that it won't incur overhead normally
    # @jam.setup_from_proposal(@proposal))
  end
  
  def edit
    @jam = @event.jams.find(params[:id])
  end

  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
  end
end
