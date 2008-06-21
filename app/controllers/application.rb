class ApplicationController < ActionController::Base
  NotFoundError = StandardError
  
  include ExceptionNotifiable

  session :session_key => '_backjam_session_id'
  
  include AuthenticatedSystem
  before_filter :login_from_cookie

  helper :all
  
  rescue_from ActiveRecord::RecordNotFound, NotFoundError do
    render :file => File.join(RAILS_ROOT, "public", "404.html"), :status => :not_found
  end
  
  protected
    TLD_LENGTH = 2
    
    before_filter :remove_trailing_slashes
    def remove_trailing_slashes
      if (uri = request.request_uri).length > 1 and uri[-1,1] == '/'
        headers['Status'] = '301 Moved Permanently'
        redirect_to uri.chop
        return false
      end
    end
    
    before_filter :no_www
    def no_www
     if (bad_subdirs = ["ww", "www"]).any? {|s| [s]==request.subdomains(TLD_LENGTH)}
        headers['Status'] = '301 Moved Permanently'
        redirect_to :host => request.domain(TLD_LENGTH)
       return false
     end
    end
    
    def render_404
      render :file => "#{RAILS_ROOT}/public/404.html", :status => :not_found
    end
    
    def strip_permalinks
      params[:id] = params[:id].split('-').first if params[:id]
      true
    end
    
    def iphone_request?
      params[:no_iphone].nil? && request.headers['User-Agent'].include?("iPhone")
    end
end
