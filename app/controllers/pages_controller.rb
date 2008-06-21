class PagesController < ApplicationController
  def home
    if iphone_request?
      render :action => "home_iphone", :layout => "iphone"
    else
      
    end
  end
  def about
  end
  def contact
  end
  def openid
  end
end
