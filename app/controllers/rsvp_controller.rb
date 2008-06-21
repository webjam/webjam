class RsvpController < ApplicationController
  before_filter :login_required

  def create
    if @rsvp = Rsvp.create(params[:rsvp])
      render :thank_you
    else
      render :new
    end
  end
end
