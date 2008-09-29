class Admin::UsersController < Admin::BaseController
  def index
    @users = User.find(:all, :order => "full_name ASC")
  end
end
