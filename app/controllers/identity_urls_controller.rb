class IdentityUrlsController < ApplicationController
  before_filter :login_required
  
  def destroy
    identity_url = current_user.identity_urls.find(params[:id])
    identity_url.destroy
    flash[:notice] = "Removed OpenID URL #{identity_url.url}"
    redirect_to edit_current_user_path
  end
  
  def create
    unless using_open_id?
      redirect_to edit_current_user_path
      return
    end
    
    authenticate_with_open_id(params[:openid_url]) do |result, identity_url|
      @identity_url = current_user.identity_urls.build(:url => normalize_url(identity_url))
      if !@identity_url.valid?
        render :action => 'new'
      elsif !result.successful?
        @verification_error = result.message
        render :action => 'new'
      else
        @identity_url.save!
        flash[:notice] = "OpenID URL #{@identity_url.url} is now associated with your account. Dig it."
        redirect_to edit_current_user_path
      end
    end
  end
end
