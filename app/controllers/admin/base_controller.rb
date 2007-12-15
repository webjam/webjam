class Admin::BaseController < ApplicationController
  before_filter :login_required
  before_filter :admin_user_required
  layout 'admin'
  
  private
    def admin_user_required
      redirect_to home_path unless current_user.admin?
    end
end
