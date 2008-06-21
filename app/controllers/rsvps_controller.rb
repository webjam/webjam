class RsvpsController < ApplicationController
  before_filter :login_required

  def create
    if @rsvp = Rsvp.create({:event_id => Event.find_by_tag(params[:event]), :user_id => current_user})
      #render :thank_you
      render :text => 'hawt'
    else
      render :text => 'nawt'
      #render :new
    end
  end
end
