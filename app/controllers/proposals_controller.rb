class ProposalsController < ApplicationController
  before_filter :login_required
  def create
    @event = Event.find_by_tag(params[:event])
    if @proposal = PresentationProposal.new(params[:proposal])
      #render :thank_you
      render :text => "Danke. Arigato."
    else
      redirect_to 'http://www.disneyland.com'
    end
  end
end
