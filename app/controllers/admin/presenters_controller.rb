class Admin::PresentersController < Admin::BaseController
  before_filter :load_event
  before_filter :load_jam

  def create
    @presenter = @jam.presenters.build(params[:presenter])
    @presenter.user = params[:presenter][:user_id].not.blank? ? User.find(params[:presenter][:user_id]) : nil
    @presenter.save!
    flash[:notice] = "Presenter created"
    redirect_to admin_event_jam_path(@event, @jam)
  end

  before_filter :load_presenter, :only => %w(edit update destroy)

  def edit
  end

  def update
    @presenter.attributes = params[:presenter]
    @presenter.user = params[:presenter][:user_id].not.blank? ? User.find(params[:presenter][:user_id]) : nil
    @presenter.save!
    flash[:notice] = "Presenter updated"
    redirect_to admin_event_jam_path(@event, @jam)
  end

  def destroy
    @presenter.destroy
    flash[:notice] = "Presenter deleted"
    redirect_to admin_event_jam_path(@event, @jam)
  end

  private
    def load_event
      @event = Event.find_by_tag(params[:event_id])
      raise NotFound unless @event
    end
    def load_jam
      @jam = @event.jams.find_by_number(params[:jam_id])
      raise NotFound unless @jam
    end
    def load_presenter
      @presenter = @jam.presenters.find(params[:id])
    end
end