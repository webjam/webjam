class MugshotsController < ApplicationController
  before_filter :login_required

  def new
    @user = current_user
  end
  
  def show
    @user = current_user
  end
  
  def create
    User.transaction do
      @user = current_user
      
      @user.mugshot = params[:uploaded_mugshot_data]
      
      if @user.save
        redirect_to edit_current_user_path
      else
        render :action => 'new'
      end
    end
  end

  def destroy
    # If there's no mugshot to destroy
    unless current_user.mugshot?
      redirect_to user_path(current_user)
    end

    current_user.mugshot.delete
    
    if current_user.save
      flash[:notice] = "Mugshot deleted"
    end
    
    redirect_to edit_current_user_path
  end
end
