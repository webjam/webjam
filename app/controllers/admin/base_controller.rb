class Admin::BaseController < ApplicationController
  before_filter :login_required
  before_filter :admin_user_required
  layout 'admin'
  
  rescue_from ActiveRecord::RecordInvalid do |_|
    render :action => 'new'
  end
  
  private
    def admin_user_required
      redirect_to home_path unless current_user.admin?
    end
end
