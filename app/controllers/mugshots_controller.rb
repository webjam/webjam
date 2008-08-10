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
        redirect_to user_path(@user)
      else
        render :action => 'new'
      end
    end
  end

  def destroy    
    # If there's no mugshot to destroy
    unless current_user.mugshot?
      redirect_back_or_default user_path(current_user)
    end

    current_user.mugshot.delete
    
    if current_user.save
      flash[:notice] = "Mugshot deleted"
    end
    
    redirect_to edit_current_user_path
  end

  def crop
    if !(@mugshot = current_user.temporary_mugshots.find(params[:id]))
      redirect_to current_new_mugshot_path
      return
    end
    if request.post?
      # we got a post request, so first see if the cancel button was clicked
      if params[:crop_cancel] && params[:crop_cancel] == "true"
        # this means the cancel button was clicked. you might
        # want to implement a more-sophisticated cancel behavior
        # in your app -- for instance, if you store the previous
        # request in the session, you could redirect there instead
        # of to the app's root, as i'm doing here.
        flash[:notice] = "Cropping cancelled."
        redirect_to edit_current_user_path
        return
      end
      # cancel was not clicked, so crop the image
      @mugshot.crop! params
      if @mugshot.save
        current_user.update_attribute(:mugshot, @mugshot)
        flash[:notice] = "Mugshot cropped and saved successfully."
        redirect_to edit_current_user_path
        return
      end
    end
  rescue Mugshot::InvalidCropRect
    flash[:error] = "Sorry, could not crop the image."
  end
end
